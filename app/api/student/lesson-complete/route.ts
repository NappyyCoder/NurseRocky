import { auth } from "@clerk/nextjs/server";
import { NextRequest, NextResponse } from "next/server";
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

    const { data: lesson, error: le } = await supabaseAdmin
      .from("lessons")
      .select("id, module_id")
      .eq("id", lesson_id)
      .maybeSingle();

    if (le || !lesson) {
      return NextResponse.json({ error: "Lesson not found" }, { status: 404 });
    }

    const { error: upErr } = await supabaseAdmin.from("student_progress").upsert(
      {
        student_id: studentId,
        module_id: lesson.module_id,
        lesson_id: lesson.id,
        completed: true,
        completed_at: new Date().toISOString(),
        last_accessed_at: new Date().toISOString(),
      },
      { onConflict: "student_id,lesson_id" }
    );

    if (upErr) throw upErr;

    await supabaseAdmin
      .from("students")
      .update({ last_lesson_id: lesson.id, last_module_id: lesson.module_id })
      .eq("id", studentId);

    return NextResponse.json({ ok: true });
  } catch (e: unknown) {
    const msg = e instanceof Error ? e.message : "Error";
    return NextResponse.json({ error: msg }, { status: 500 });
  }
}
