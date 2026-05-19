import { cache } from "react";
import { supabaseAdmin } from "@/lib/supabase";
import type { QuizGradeRow } from "@/lib/server/student-quiz-grades";

/** Passed/total quiz counts per module (2 queries total). */
export async function moduleQuizPassMap(studentId: string) {
  const [{ data: attempts }, { data: quizzes }] = await Promise.all([
    supabaseAdmin
      .from("quiz_attempts")
      .select("quiz_id, passed")
      .eq("student_id", studentId)
      .eq("passed", true),
    supabaseAdmin.from("quizzes").select("id, module_id"),
  ]);

  const passedQuizIds = new Set((attempts ?? []).map((a) => a.quiz_id as string));
  const byModule = new Map<number, { total: number; passed: number }>();

  for (const q of quizzes ?? []) {
    const mid = q.module_id as number;
    const cur = byModule.get(mid) ?? { total: 0, passed: 0 };
    cur.total++;
    if (passedQuizIds.has(q.id as string)) cur.passed++;
    byModule.set(mid, cur);
  }
  return byModule;
}

/** All quiz grades for a student in 2 queries (not one round-trip per module). */
export async function getAllStudentQuizGradesByModule(
  studentId: string
): Promise<Map<number, QuizGradeRow[]>> {
  const [{ data: quizzes }, { data: attempts }] = await Promise.all([
    supabaseAdmin
      .from("quizzes")
      .select("id, title, passing_score, module_id")
      .order("created_at"),
    supabaseAdmin
      .from("quiz_attempts")
      .select("quiz_id, score, passed, attempted_at")
      .eq("student_id", studentId)
      .order("attempted_at", { ascending: false }),
  ]);

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

  const byModule = new Map<number, QuizGradeRow[]>();
  for (const q of quizzes ?? []) {
    const mid = q.module_id as number;
    const stats = byQuiz.get(q.id as string);
    const row: QuizGradeRow = {
      quiz_id: q.id as string,
      title: q.title as string,
      passing_score: (q.passing_score as number) ?? 70,
      best_score: stats?.best ?? 0,
      latest_score: stats?.latest ?? 0,
      passed: stats?.passed ?? false,
      attempts: stats?.count ?? 0,
      last_attempt_at: stats?.last ?? null,
    };
    const arr = byModule.get(mid) ?? [];
    arr.push(row);
    byModule.set(mid, arr);
  }
  return byModule;
}

/** Lightweight: which modules have all lessons done + all quizzes passed. */
export const computeFinishedModuleIds = cache(async (studentId: string | null): Promise<Set<number>> => {
  if (!studentId) return new Set();

  const [{ data: modules }, { data: allLessons }, { data: progress }, quizByModule] =
    await Promise.all([
      supabaseAdmin
        .from("modules")
        .select("id")
        .eq("is_published", true)
        .order("order_num"),
      supabaseAdmin.from("lessons").select("id, module_id"),
      supabaseAdmin
        .from("student_progress")
        .select("lesson_id")
        .eq("student_id", studentId)
        .eq("completed", true),
      moduleQuizPassMap(studentId),
    ]);

  const doneLessons = new Set((progress ?? []).map((p) => p.lesson_id as string));
  const lessonsByModule = new Map<number, string[]>();
  for (const l of allLessons ?? []) {
    const mid = l.module_id as number;
    const arr = lessonsByModule.get(mid) ?? [];
    arr.push(l.id as string);
    lessonsByModule.set(mid, arr);
  }

  const finished = new Set<number>();
  for (const mod of modules ?? []) {
    const mid = mod.id as number;
    const lessonIds = lessonsByModule.get(mid) ?? [];
    const qStats = quizByModule.get(mid) ?? { total: 0, passed: 0 };
    const lessonsComplete =
      lessonIds.length > 0 && lessonIds.every((id) => doneLessons.has(id));
    const quizzesComplete = qStats.total === 0 || qStats.passed >= qStats.total;
    if (lessonsComplete && quizzesComplete) finished.add(mid);
  }
  return finished;
});
