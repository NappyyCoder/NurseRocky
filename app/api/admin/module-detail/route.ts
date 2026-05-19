import { NextRequest, NextResponse } from "next/server";
import { supabaseAdmin } from "@/lib/supabase";
import { adminErrorResponse, requireAdminSession } from "@/lib/admin-auth";

export async function GET(req: NextRequest) {
  try {
    await requireAdminSession();
    const moduleId = Number(req.nextUrl.searchParams.get("moduleId"));
    if (!Number.isFinite(moduleId) || moduleId < 1) {
      return NextResponse.json({ error: "moduleId required" }, { status: 400 });
    }

    const [{ data: module, error: modErr }, { data: lessons, error: lesErr }, { data: quizzes, error: quizErr }] =
      await Promise.all([
        supabaseAdmin.from("modules").select("*").eq("id", moduleId).single(),
        supabaseAdmin.from("lessons").select("*").eq("module_id", moduleId).order("order_num"),
        supabaseAdmin.from("quizzes").select("*").eq("module_id", moduleId).order("created_at"),
      ]);

    if (modErr) throw modErr;
    if (lesErr) throw lesErr;
    if (quizErr) throw quizErr;

    const quizIds = (quizzes ?? []).map((q) => q.id);
    let questions: { id: string; quiz_id: string; question: string; options: string[]; correct_answer: number; order_num: number; rationale: string | null }[] = [];

    if (quizIds.length) {
      const { data: qRows, error: qErr } = await supabaseAdmin
        .from("quiz_questions")
        .select("*")
        .in("quiz_id", quizIds)
        .order("order_num");
      if (qErr) throw qErr;
      questions = (qRows ?? []).map((q) => ({
        ...q,
        options: Array.isArray(q.options) ? q.options : [],
        rationale: q.rationale ?? null,
      }));
    }

    const quizzesWithQuestions = (quizzes ?? []).map((quiz) => ({
      ...quiz,
      questions: questions.filter((q) => q.quiz_id === quiz.id),
    }));

    return NextResponse.json({ module, lessons: lessons ?? [], quizzes: quizzesWithQuestions });
  } catch (e: unknown) {
    const { error, status } = adminErrorResponse(e);
    return NextResponse.json({ error }, { status });
  }
}
