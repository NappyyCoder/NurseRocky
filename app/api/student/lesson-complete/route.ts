import { auth } from "@clerk/nextjs/server";
import { NextRequest, NextResponse } from "next/server";
import { formatDbError } from "@/lib/server/format-db-error";
import { supabaseAdmin } from "@/lib/supabase";
import { requireEnrolledStudent } from "@/lib/server/resolve-student";

export async function POST(req: NextRequest) {
  try {
    const { userId } = await auth();
    if (!userId) {
      return NextResponse.json({ error: "Unauthorized" }, { status: 401 });
    }

    const { lesson_id } = (await req.json()) as { lesson_id?: string };
    if (!lesson_id) {
      return NextResponse.json({ error: "lesson_id required" }, { status: 400 });
    }

    const studentId = await requireEnrolledStudent(userId);
    if (!studentId) {
      return NextResponse.json({ error: "Enrollment required" }, { status: 403 });
    }

    const { data: lesson, error: lessonErr } = await supabaseAdmin
      .from("lessons")
      .select("id, module_id")
      .eq("id", lesson_id)
      .maybeSingle();

    if (lessonErr) {
      console.error("[lesson-complete] lesson lookup:", formatDbError(lessonErr));
      return NextResponse.json({ error: formatDbError(lessonErr) }, { status: 500 });
    }

    if (!lesson) {
      return NextResponse.json({ error: "Lesson not found" }, { status: 404 });
    }

    const now = new Date().toISOString();

    const { data: existing, error: existingErr } = await supabaseAdmin
      .from("student_progress")
      .select("id")
      .eq("student_id", studentId)
      .eq("lesson_id", lesson.id)
      .maybeSingle();

    if (existingErr) {
      console.error("[lesson-complete] progress lookup:", formatDbError(existingErr));
      return NextResponse.json({ error: formatDbError(existingErr) }, { status: 500 });
    }

    if (existing?.id) {
      const { error: updateErr } = await supabaseAdmin
        .from("student_progress")
        .update({
          module_id: lesson.module_id,
          completed: true,
          completed_at: now,
          last_accessed_at: now,
        })
        .eq("id", existing.id);

      if (updateErr) {
        console.error("[lesson-complete] progress update:", formatDbError(updateErr));
        return NextResponse.json({ error: formatDbError(updateErr) }, { status: 500 });
      }
    } else {
      const { error: insertErr } = await supabaseAdmin.from("student_progress").insert({
        student_id: studentId,
        module_id: lesson.module_id,
        lesson_id: lesson.id,
        completed: true,
        completed_at: now,
        last_accessed_at: now,
      });

      if (insertErr) {
        console.error("[lesson-complete] progress insert:", formatDbError(insertErr));
        return NextResponse.json({ error: formatDbError(insertErr) }, { status: 500 });
      }
    }

    // Best-effort bookmark — same pattern as lesson-time (non-blocking).
    const { error: studentErr } = await supabaseAdmin
      .from("students")
      .update({ last_lesson_id: lesson.id, last_module_id: lesson.module_id })
      .eq("id", studentId);

    if (studentErr) {
      console.warn("[lesson-complete] student bookmark:", formatDbError(studentErr));
    }

    return NextResponse.json({ ok: true });
  } catch (e: unknown) {
    const msg = formatDbError(e);
    console.error("[lesson-complete] unexpected:", msg, e);
    return NextResponse.json({ error: msg }, { status: 500 });
  }
}
