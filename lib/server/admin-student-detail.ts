import { supabaseAdmin } from "@/lib/supabase";
import { computeFinishedModuleIds } from "@/lib/server/course-completion";
import { getModuleQuizGrades } from "@/lib/server/student-quiz-grades";

export type AdminStudentLessonRow = {
  id: string;
  title: string;
  order_num: number;
  completed: boolean;
  completed_at: string | null;
};

export type AdminStudentQuizRow = {
  quiz_id: string;
  title: string;
  passing_score: number;
  best_score: number;
  latest_score: number;
  passed: boolean;
  attempts: number;
  last_attempt_at: string | null;
};

export type AdminStudentModuleRow = {
  id: number;
  title: string;
  order_num: number;
  lessons_total: number;
  lessons_done: number;
  quizzes_passed: number;
  quizzes_total: number;
  lessons: AdminStudentLessonRow[];
  quizzes: AdminStudentQuizRow[];
};

export async function getAdminStudentDetail(studentId: string) {
  const { data: student, error: stErr } = await supabaseAdmin
    .from("students")
    .select("*")
    .eq("id", studentId)
    .single();

  if (stErr || !student) throw new Error("Student not found");

  const [{ data: modules }, { data: progressRows }, { data: clinical }] =
    await Promise.all([
      supabaseAdmin.from("modules").select("*").order("order_num"),
      supabaseAdmin
        .from("student_progress")
        .select("lesson_id, completed, completed_at")
        .eq("student_id", studentId),
      supabaseAdmin.from("clinical_hours").select("hours").eq("student_id", studentId),
    ]);

  const progressByLesson = new Map(
    (progressRows ?? []).map((p) => [
      p.lesson_id as string,
      { completed: p.completed === true, completed_at: p.completed_at as string | null },
    ])
  );

  const finishedModules = await computeFinishedModuleIds(studentId);
  const clinicalHours = (clinical ?? []).reduce((s, r) => s + Number(r.hours), 0);

  const moduleRows: AdminStudentModuleRow[] = [];

  for (const mod of modules ?? []) {
    const moduleId = mod.id as number;
    const [{ data: lessons }, grades] = await Promise.all([
      supabaseAdmin
        .from("lessons")
        .select("id, title, order_num")
        .eq("module_id", moduleId)
        .order("order_num"),
      getModuleQuizGrades(studentId, moduleId),
    ]);

    const lessonRows: AdminStudentLessonRow[] = (lessons ?? []).map((l) => {
      const prog = progressByLesson.get(l.id as string);
      return {
        id: l.id as string,
        title: l.title as string,
        order_num: l.order_num as number,
        completed: prog?.completed ?? false,
        completed_at: prog?.completed_at ?? null,
      };
    });

    moduleRows.push({
      id: moduleId,
      title: mod.title as string,
      order_num: mod.order_num as number,
      lessons_total: lessonRows.length,
      lessons_done: lessonRows.filter((l) => l.completed).length,
      quizzes_passed: grades.filter((g) => g.passed).length,
      quizzes_total: grades.length,
      lessons: lessonRows,
      quizzes: grades,
    });
  }

  const quizzesPassedTotal = moduleRows.reduce((s, m) => s + m.quizzes_passed, 0);
  const quizzesTotal = moduleRows.reduce((s, m) => s + m.quizzes_total, 0);

  return {
    student,
    summary: {
      modules_finished: finishedModules.size,
      modules_total: modules?.length ?? 0,
      quizzes_passed: quizzesPassedTotal,
      quizzes_total: quizzesTotal,
      clinical_hours: clinicalHours,
    },
    modules: moduleRows,
  };
}
