import { supabaseAdmin } from "@/lib/supabase";

export type QuizGradeRow = {
  quiz_id: string;
  title: string;
  passing_score: number;
  best_score: number;
  latest_score: number;
  passed: boolean;
  attempts: number;
  last_attempt_at: string | null;
};

/** Latest + best attempt per quiz for one module. */
export async function getModuleQuizGrades(
  studentId: string,
  moduleId: number
): Promise<QuizGradeRow[]> {
  const { data: quizzes } = await supabaseAdmin
    .from("quizzes")
    .select("id, title, passing_score")
    .eq("module_id", moduleId)
    .order("created_at");

  if (!quizzes?.length) return [];

  const quizIds = quizzes.map((q) => q.id as string);
  const { data: attempts } = await supabaseAdmin
    .from("quiz_attempts")
    .select("quiz_id, score, passed, attempted_at")
    .eq("student_id", studentId)
    .in("quiz_id", quizIds)
    .order("attempted_at", { ascending: false });

  const byQuiz = new Map<
    string,
    { best: number; latest: number; passed: boolean; count: number; last: string | null }
  >();

  for (const att of attempts ?? []) {
    const qid = att.quiz_id as string;
    const score = att.score as number;
    const prev = byQuiz.get(qid);
    if (!prev) {
      byQuiz.set(qid, {
        best: score,
        latest: score,
        passed: att.passed === true,
        count: 1,
        last: att.attempted_at as string,
      });
    } else {
      prev.count++;
      prev.best = Math.max(prev.best, score);
      prev.passed = prev.passed || att.passed === true;
    }
  }

  return quizzes.map((q) => {
    const stats = byQuiz.get(q.id as string);
    return {
      quiz_id: q.id as string,
      title: q.title as string,
      passing_score: (q.passing_score as number) ?? 70,
      best_score: stats?.best ?? 0,
      latest_score: stats?.latest ?? 0,
      passed: stats?.passed ?? false,
      attempts: stats?.count ?? 0,
      last_attempt_at: stats?.last ?? null,
    };
  });
}

export async function countPassedQuizzes(studentId: string): Promise<number> {
  const { data } = await supabaseAdmin
    .from("quiz_attempts")
    .select("quiz_id, passed")
    .eq("student_id", studentId)
    .eq("passed", true);

  return new Set((data ?? []).map((r) => r.quiz_id as string)).size;
}

export async function countTotalPublishedQuizzes(): Promise<number> {
  const { count } = await supabaseAdmin
    .from("quizzes")
    .select("id", { count: "exact", head: true });
  return count ?? 0;
}
