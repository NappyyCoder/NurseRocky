import { auth } from "@clerk/nextjs/server";
import { NextRequest, NextResponse } from "next/server";
import { supabaseAdmin } from "@/lib/supabase";
import { resolveStudentId } from "@/lib/server/resolve-student";

export async function POST(req: NextRequest) {
  try {
    const { userId } = await auth();
    if (!userId) return NextResponse.json({ error: "Unauthorized" }, { status: 401 });

    const studentId = await resolveStudentId(userId);
    if (!studentId) return NextResponse.json({ error: "Student not found" }, { status: 404 });

    const { lesson_id, module_id, seconds } = await req.json();
    if (!lesson_id || !module_id) {
      return NextResponse.json({ error: "lesson_id and module_id required" }, { status: 400 });
    }

    const addSec = Math.min(Math.max(Number(seconds) || 30, 1), 300);

    const { data: existing } = await supabaseAdmin
      .from("student_progress")
      .select("id, time_spent_sec")
      .eq("student_id", studentId)
      .eq("lesson_id", lesson_id)
      .maybeSingle();

    if (existing?.id) {
      await supabaseAdmin
        .from("student_progress")
        .update({
          time_spent_sec: (Number(existing.time_spent_sec) || 0) + addSec,
          last_accessed_at: new Date().toISOString(),
        })
        .eq("id", existing.id);
    } else {
      await supabaseAdmin.from("student_progress").insert({
        student_id: studentId,
        module_id,
        lesson_id,
        completed: false,
        time_spent_sec: addSec,
        last_accessed_at: new Date().toISOString(),
      });
    }

    await supabaseAdmin
      .from("students")
      .update({ last_lesson_id: lesson_id, last_module_id: module_id })
      .eq("id", studentId);

    return NextResponse.json({ success: true });
  } catch (e: unknown) {
    return NextResponse.json({ error: e instanceof Error ? e.message : "Error" }, { status: 500 });
  }
}
