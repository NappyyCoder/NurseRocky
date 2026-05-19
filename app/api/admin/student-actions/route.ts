import { NextRequest, NextResponse } from "next/server";
import { supabaseAdmin } from "@/lib/supabase";
import { adminErrorResponse, requireAdminSession } from "@/lib/admin-auth";

type Body = {
  action: string;
  student_id: string;
  quiz_id?: string;
  lesson_id?: string;
  module_id?: number;
};

export async function POST(req: NextRequest) {
  try {
    await requireAdminSession();
    const body = (await req.json()) as Body;
    const { action, student_id, quiz_id, lesson_id, module_id } = body;

    if (!student_id) {
      return NextResponse.json({ error: "student_id required" }, { status: 400 });
    }

    switch (action) {
      case "reset_quiz": {
        if (!quiz_id) {
          return NextResponse.json({ error: "quiz_id required" }, { status: 400 });
        }
        const { error } = await supabaseAdmin
          .from("quiz_attempts")
          .delete()
          .eq("student_id", student_id)
          .eq("quiz_id", quiz_id);
        if (error) throw error;
        return NextResponse.json({ success: true, message: "Quiz attempts cleared — student can retake." });
      }

      case "reset_module_quizzes": {
        if (!module_id) {
          return NextResponse.json({ error: "module_id required" }, { status: 400 });
        }
        const { data: quizzes } = await supabaseAdmin
          .from("quizzes")
          .select("id")
          .eq("module_id", module_id);
        const ids = (quizzes ?? []).map((q) => q.id as string);
        if (ids.length) {
          const { error } = await supabaseAdmin
            .from("quiz_attempts")
            .delete()
            .eq("student_id", student_id)
            .in("quiz_id", ids);
          if (error) throw error;
        }
        return NextResponse.json({ success: true, message: "All quiz attempts cleared for this module." });
      }

      case "reset_lesson": {
        if (!lesson_id) {
          return NextResponse.json({ error: "lesson_id required" }, { status: 400 });
        }
        const { error } = await supabaseAdmin
          .from("student_progress")
          .delete()
          .eq("student_id", student_id)
          .eq("lesson_id", lesson_id);
        if (error) throw error;
        return NextResponse.json({ success: true, message: "Lesson marked incomplete." });
      }

      case "reset_module_lessons": {
        if (!module_id) {
          return NextResponse.json({ error: "module_id required" }, { status: 400 });
        }
        const { data: lessons } = await supabaseAdmin
          .from("lessons")
          .select("id")
          .eq("module_id", module_id);
        const lessonIds = (lessons ?? []).map((l) => l.id as string);
        if (lessonIds.length) {
          const { error } = await supabaseAdmin
            .from("student_progress")
            .delete()
            .eq("student_id", student_id)
            .in("lesson_id", lessonIds);
          if (error) throw error;
        }
        return NextResponse.json({ success: true, message: "All lesson progress cleared for this module." });
      }

      case "reset_module_progress": {
        if (!module_id) {
          return NextResponse.json({ error: "module_id required" }, { status: 400 });
        }
        const { data: lessons } = await supabaseAdmin
          .from("lessons")
          .select("id")
          .eq("module_id", module_id);
        const lessonIds = (lessons ?? []).map((l) => l.id as string);
        if (lessonIds.length) {
          await supabaseAdmin
            .from("student_progress")
            .delete()
            .eq("student_id", student_id)
            .in("lesson_id", lessonIds);
        }
        const { data: quizzes } = await supabaseAdmin
          .from("quizzes")
          .select("id")
          .eq("module_id", module_id);
        const quizIds = (quizzes ?? []).map((q) => q.id as string);
        if (quizIds.length) {
          await supabaseAdmin
            .from("quiz_attempts")
            .delete()
            .eq("student_id", student_id)
            .in("quiz_id", quizIds);
        }
        return NextResponse.json({ success: true, message: "Module progress and quiz attempts reset." });
      }

      default:
        return NextResponse.json({ error: "Unknown action" }, { status: 400 });
    }
  } catch (e: unknown) {
    const { error, status } = adminErrorResponse(e);
    return NextResponse.json({ error }, { status });
  }
}
