import { supabaseAdmin } from "@/lib/supabase";

/**
 * A module counts as finished when every lesson row for that module is marked complete.
 */
export async function computeFinishedModuleIds(
  studentId: string | null
): Promise<Set<number>> {
  const finished = new Set<number>();
  if (!studentId) return finished;

  const [{ data: allLessons }, { data: progress }] = await Promise.all([
    supabaseAdmin.from("lessons").select("id, module_id"),
    supabaseAdmin
      .from("student_progress")
      .select("lesson_id, completed")
      .eq("student_id", studentId),
  ]);

  const doneLessons = new Set(
    (progress ?? [])
      .filter((p) => p.completed)
      .map((p) => p.lesson_id as string)
  );

  const byModule = new Map<number, string[]>();
  for (const row of allLessons ?? []) {
    const mid = row.module_id as number;
    const arr = byModule.get(mid) ?? [];
    arr.push(row.id as string);
    byModule.set(mid, arr);
  }

  for (const [mid, ids] of byModule) {
    if (ids.length > 0 && ids.every((id) => doneLessons.has(id))) {
      finished.add(mid);
    }
  }

  return finished;
}

export async function enrolledStudentCanVisitModule(opts: {
  studentId: string | null;
  moduleId: number;
}): Promise<boolean> {
  const { studentId, moduleId } = opts;
  if (!studentId) return false;

  const { data: ordered } = await supabaseAdmin
    .from("modules")
    .select("id")
    .eq("is_published", true)
    .order("order_num");

  const list = ordered ?? [];
  const idx = list.findIndex((m) => m.id === moduleId);
  if (idx < 0) return false;
  if (idx === 0) return true;

  const prevId = list[idx - 1]?.id as number | undefined;
  if (prevId == null) return true;

  const finished = await computeFinishedModuleIds(studentId);
  return finished.has(prevId);
}
