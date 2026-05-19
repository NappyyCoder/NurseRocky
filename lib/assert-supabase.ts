import { getServerSupabaseConfigError } from "@/lib/supabase-env";

/** Throws with a clear message if Supabase env is missing (before any DB write). */
export function assertSupabaseConfigured() {
  const err = getServerSupabaseConfigError();
  if (err) throw new Error(err);
}
