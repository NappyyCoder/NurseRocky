import { auth } from "@clerk/nextjs/server";
import { NextRequest, NextResponse } from "next/server";
import { supabaseAdmin } from "@/lib/supabase";
import { requireEnrolledStudent } from "@/lib/server/resolve-student";
import { rationaleForQuestion } from "@/lib/course/module1-quiz-rationales";
import type { QuizQuestion } from "@/lib/types";

export async function POST(req: NextRequest) {
  try {
    const { userId } = await auth();
    if (!userId) {
      return NextResponse.json({ error: "Unauthorized" }, { status: 401 });
    }

    const body = (await req.json()) as { quiz_id?: string; answers?: number[] };
    const { quiz_id, answers } = body;
    if (!quiz_id || !Array.isArray(answers)) {
      return NextResponse.json({ error: "quiz_id and answers[] required" }, { status: 400 });
    }

    const studentId = await requireEnrolledStudent(userId);
    if (!studentId) {
      return NextResponse.json({ error: "Enrollment required" }, { status: 403 });
    }

    const [{ data: quiz }, { data: questionsRaw }] = await Promise.all([
      supabaseAdmin.from("quizzes").select("*").eq("id", quiz_id).maybeSingle(),
      supabaseAdmin
        .from("quiz_questions")
        .select("*")
        .eq("quiz_id", quiz_id)
        .order("order_num"),
    ]);

    if (!quiz || !questionsRaw?.length) {
      return NextResponse.json({ error: "Quiz not found" }, { status: 404 });
    }

    const questions = questionsRaw as QuizQuestion[];
    if (answers.length !== questions.length) {
      return NextResponse.json(
        { error: `Expected ${questions.length} answers` },
        { status: 400 }
      );
    }

    let correct = 0;
    const breakdown: {
      index: number;
      question: string;
      your_answer: number;
      correct_answer: number;
      is_correct: boolean;
      rationale: string | null;
    }[] = [];

    for (let i = 0; i < questions.length; i++) {
      const q = questions[i];
      const guess = answers[i];
      const idx = typeof guess === "number" && Number.isFinite(guess) ? Math.floor(guess) : -1;
      const isCorrect = idx === q.correct_answer;
      if (isCorrect) correct++;
      breakdown.push({
        index: i + 1,
        question: q.question,
        your_answer: idx,
        correct_answer: q.correct_answer,
        is_correct: isCorrect,
        rationale:
          (q as { rationale?: string | null }).rationale?.trim() ||
          rationaleForQuestion(q.question),
      });
    }

    const score = Math.round((correct / questions.length) * 100);
    const passed = score >= (quiz.passing_score ?? 70);

    const { error: attErr } = await supabaseAdmin.from("quiz_attempts").insert({
      student_id: studentId,
      quiz_id: quiz.id,
      score,
      passed,
      answers: answers as unknown as Record<string, unknown>,
    });

    if (attErr) throw attErr;

    return NextResponse.json({
      score,
      passed,
      passing_score: quiz.passing_score ?? 70,
      correct,
      total: questions.length,
      breakdown,
    });
  } catch (e: unknown) {
    const msg = e instanceof Error ? e.message : "Error";
    return NextResponse.json({ error: msg }, { status: 500 });
  }
}
