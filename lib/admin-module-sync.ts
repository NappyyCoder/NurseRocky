import { supabaseAdmin } from "@/lib/supabase";

export async function syncModuleCounts(moduleId: number) {
  const { data: lessons } = await supabaseAdmin
    .from("lessons")
    .select("duration_min")
    .eq("module_id", moduleId);

  const lessonsCount = lessons?.length ?? 0;
  const durationMin = (lessons ?? []).reduce((sum, l) => sum + (l.duration_min ?? 0), 0);

  await supabaseAdmin
    .from("modules")
    .update({ lessons_count: lessonsCount, duration_min: durationMin })
    .eq("id", moduleId);
}
