import { supabaseAdmin } from "@/lib/supabase";
import { computeFinishedModuleIds } from "@/lib/server/module-completion";

export { computeFinishedModuleIds };

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
