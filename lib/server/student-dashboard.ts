import { supabaseAdmin } from "@/lib/supabase";
import { getAllStudentQuizGradesByModule } from "@/lib/server/module-completion";
import type { QuizGradeRow } from "@/lib/server/student-quiz-grades";
import { studentNeedsPolicyAck } from "@/lib/server/policy-ack-status";
import {
  CLINICAL_CHECKLIST_ITEMS,
  computeMilestones,
} from "@/lib/student-portal/constants";
import type { Module } from "@/lib/types";

export type ModuleProgressRow = {
  module: Module;
  lessonsDone: number;
  lessonsTotal: number;
  quizzesPassed: number;
  quizzesTotal: number;
  lessonsComplete: boolean;
  quizzesComplete: boolean;
  fullyComplete: boolean;
  available: boolean;
  grades: QuizGradeRow[];
};

export type ContinueTarget = {
  kind: "lesson" | "quiz";
  href: string;
  label: string;
  moduleId: number;
  moduleTitle: string;
};

export type StudentDashboardData = {
  student: {
    id: string;
    firstName: string;
    enrolled: boolean;
    lastLessonId: string | null;
    lastModuleId: number | null;
    policiesAcknowledgedAt: string | null;
  };
  modules: ModuleProgressRow[];
  allGrades: (QuizGradeRow & { moduleId: number; moduleTitle: string })[];
  clinical: { total: number; required: number; entries: { date: string; hours: number; notes: string | null }[] };
  announcements: { id: string; title: string; body: string }[];
  resources: { id: string; title: string; url: string; description: string | null; moduleId: number | null }[];
  checklist: { key: string; label: string; completed: boolean }[];
  policiesAcked: string[];
  needsPolicyAck: boolean;
  continueTarget: ContinueTarget | null;
  milestones: { id: string; label: string; earned: boolean }[];
  stats: {
    modulesFullyComplete: number;
    modulesTotal: number;
    quizzesPassed: number;
    quizzesTotal: number;
    lessonsCompleted: number;
    lessonsTotal: number;
    overallPct: number;
    clinicalHours: number;
    totalStudyMinutes: number;
    isProgramComplete: boolean;
  };
};

export async function getStudentDashboardData(studentId: string): Promise<StudentDashboardData> {
  const [
    { data: studentRow },
    { data: modulesRaw },
    { data: allLessons },
    { data: progressRows },
    { data: clinicalRows },
    { data: announcements },
    { data: resources },
    { data: checklistRows },
    { data: policyAcks },
    gradesByModule,
  ] = await Promise.all([
    supabaseAdmin.from("students").select("*").eq("id", studentId).single(),
    supabaseAdmin.from("modules").select("*").eq("is_published", true).order("order_num"),
    supabaseAdmin.from("lessons").select("id, module_id, order_num, title"),
    supabaseAdmin.from("student_progress").select("*").eq("student_id", studentId),
    supabaseAdmin.from("clinical_hours").select("*").eq("student_id", studentId).order("date", { ascending: false }),
    supabaseAdmin
      .from("announcements")
      .select("id, title, body")
      .eq("is_active", true)
      .or(`expires_at.is.null,expires_at.gt.${new Date().toISOString()}`)
      .order("created_at", { ascending: false })
      .limit(5),
    supabaseAdmin.from("course_resources").select("*").order("order_num"),
    supabaseAdmin.from("student_checklist").select("*").eq("student_id", studentId),
    supabaseAdmin.from("student_policy_acknowledgments").select("policy_slug").eq("student_id", studentId),
    getAllStudentQuizGradesByModule(studentId),
  ]);

  const modules = (modulesRaw ?? []) as Module[];
  const doneLessons = new Set(
    (progressRows ?? []).filter((p) => p.completed).map((p) => p.lesson_id as string)
  );

  const lessonsByModule = new Map<number, { id: string; order_num: number; title: string }[]>();
  for (const l of allLessons ?? []) {
    const mid = l.module_id as number;
    const arr = lessonsByModule.get(mid) ?? [];
    arr.push({ id: l.id as string, order_num: l.order_num as number, title: l.title as string });
    arr.sort((a, b) => a.order_num - b.order_num);
    lessonsByModule.set(mid, arr);
  }

  const moduleRows: ModuleProgressRow[] = [];
  let prevFullyComplete = true;

  for (let i = 0; i < modules.length; i++) {
    const mod = modules[i];
    const lessonList = lessonsByModule.get(mod.id) ?? [];
    const lessonsDone = lessonList.filter((l) => doneLessons.has(l.id)).length;
    const lessonsTotal = lessonList.length;
    const grades = gradesByModule.get(mod.id) ?? [];
    const qStats = {
      total: grades.length,
      passed: grades.filter((g) => g.passed).length,
    };
    const lessonsComplete = lessonsTotal > 0 && lessonsDone >= lessonsTotal;
    const quizzesComplete = qStats.total === 0 || qStats.passed >= qStats.total;
    const fullyComplete = lessonsComplete && quizzesComplete;
    const available = true; // all modules open for preview

    moduleRows.push({
      module: mod,
      lessonsDone,
      lessonsTotal,
      quizzesPassed: qStats.passed,
      quizzesTotal: qStats.total,
      lessonsComplete,
      quizzesComplete,
      fullyComplete,
      available,
      grades,
    });

    prevFullyComplete = fullyComplete;
  }

  const allGrades = moduleRows.flatMap((m) =>
    m.grades.map((g) => ({
      ...g,
      moduleId: m.module.id,
      moduleTitle: m.module.title,
    }))
  );

  const clinicalHours = (clinicalRows ?? []).reduce((s, r) => s + Number(r.hours), 0);
  const modulesFullyComplete = moduleRows.filter((m) => m.fullyComplete).length;
  const lessonsCompleted = (progressRows ?? []).filter((p) => p.completed).length;
  const lessonsTotal = (allLessons ?? []).length;
  const quizzesPassed = allGrades.filter((g) => g.passed).length;
  const quizzesTotal = allGrades.length;
  const overallPct = modules.length
    ? Math.round((modulesFullyComplete / modules.length) * 100)
    : 0;
  const totalStudyMinutes = Math.round(
    (progressRows ?? []).reduce((s, p) => s + (Number(p.time_spent_sec) || 0), 0) / 60
  );

  const isProgramComplete =
    modules.length > 0 &&
    modulesFullyComplete >= modules.length &&
    clinicalHours >= 16;

  const checklistDone = new Map(
    (checklistRows ?? []).map((c) => [c.item_key as string, c.completed === true])
  );

  const policiesAcked = (policyAcks ?? []).map((p) => p.policy_slug as string);
  const needsPolicyAck = studentNeedsPolicyAck(
    studentRow?.policies_acknowledged_at as string | null | undefined,
    policiesAcked
  );

  let continueTarget: ContinueTarget | null = null;
  const activeMod = moduleRows.find((m) => m.available && !m.fullyComplete);
  if (activeMod) {
    const lessonList = lessonsByModule.get(activeMod.module.id) ?? [];
    const nextLesson = lessonList.find((l) => !doneLessons.has(l.id));
    if (nextLesson) {
      continueTarget = {
        kind: "lesson",
        href: `/dashboard/modules/${activeMod.module.id}/lessons/${nextLesson.id}`,
        label: `Lesson ${nextLesson.order_num}: ${nextLesson.title}`,
        moduleId: activeMod.module.id,
        moduleTitle: activeMod.module.title,
      };
    } else {
      const nextQuiz = activeMod.grades.find((g) => !g.passed);
      if (nextQuiz) {
        continueTarget = {
          kind: "quiz",
          href: `/dashboard/modules/${activeMod.module.id}/quiz/${nextQuiz.quiz_id}`,
          label: nextQuiz.title,
          moduleId: activeMod.module.id,
          moduleTitle: activeMod.module.title,
        };
      }
    }
  }

  if (!continueTarget && studentRow?.last_lesson_id && studentRow?.last_module_id) {
    const mod = modules.find((m) => m.id === studentRow.last_module_id);
    if (mod) {
      continueTarget = {
        kind: "lesson",
        href: `/dashboard/modules/${mod.id}/lessons/${studentRow.last_lesson_id}`,
        label: "Resume where you left off",
        moduleId: mod.id,
        moduleTitle: mod.title,
      };
    }
  }

  return {
    student: {
      id: studentId,
      firstName: studentRow?.first_name?.trim() || "Student",
      enrolled: studentRow?.enrolled === true,
      lastLessonId: studentRow?.last_lesson_id ?? null,
      lastModuleId: studentRow?.last_module_id ?? null,
      policiesAcknowledgedAt: studentRow?.policies_acknowledged_at ?? null,
    },
    modules: moduleRows,
    allGrades,
    clinical: {
      total: clinicalHours,
      required: 16,
      entries: (clinicalRows ?? []).map((r) => ({
        date: r.date as string,
        hours: Number(r.hours),
        notes: r.notes as string | null,
      })),
    },
    announcements: announcements ?? [],
    resources: (resources ?? []).map((r) => ({
      id: r.id as string,
      title: r.title as string,
      url: r.url as string,
      description: r.description as string | null,
      moduleId: r.module_id as number | null,
    })),
    checklist: CLINICAL_CHECKLIST_ITEMS.map((item) => ({
      key: item.key,
      label: item.label,
      completed: checklistDone.get(item.key) ?? false,
    })),
    policiesAcked,
    needsPolicyAck,
    continueTarget,
    milestones: computeMilestones({
      lessonsCompleted,
      quizzesPassed,
      modulesFullyComplete,
      overallPct,
      clinicalHours,
      isProgramComplete,
    }),
    stats: {
      modulesFullyComplete,
      modulesTotal: modules.length,
      quizzesPassed,
      quizzesTotal,
      lessonsCompleted,
      lessonsTotal,
      overallPct,
      clinicalHours,
      totalStudyMinutes,
      isProgramComplete,
    },
  };
}

export { computeFinishedModuleIds } from "@/lib/server/module-completion";

export async function searchStudentContent(query: string) {
  const q = query.trim().toLowerCase();
  if (q.length < 2) return [];

  const [{ data: lessons }, { data: modules }] = await Promise.all([
    supabaseAdmin.from("lessons").select("id, title, module_id, order_num"),
    supabaseAdmin.from("modules").select("id, title").eq("is_published", true),
  ]);

  const modTitle = new Map((modules ?? []).map((m) => [m.id as number, m.title as string]));

  return (lessons ?? [])
    .filter((l) => (l.title as string).toLowerCase().includes(q))
    .slice(0, 12)
    .map((l) => ({
      lessonId: l.id as string,
      lessonTitle: l.title as string,
      moduleId: l.module_id as number,
      moduleTitle: modTitle.get(l.module_id as number) ?? "Module",
      orderNum: l.order_num as number,
      href: `/dashboard/modules/${l.module_id}/lessons/${l.id}`,
    }));
}
