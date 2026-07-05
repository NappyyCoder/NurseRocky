import { supabaseAdmin } from "@/lib/supabase";
import { computeFinishedModuleIds } from "@/lib/server/module-completion";

export { computeFinishedModuleIds };

export async function enrolledStudentCanVisitModule(opts: {
  studentId: string | null;
  moduleId: number;
}): Promise<boolean> {
  const { studentId } = opts;
  if (!studentId) return false;
  return true; // all modules open
}
