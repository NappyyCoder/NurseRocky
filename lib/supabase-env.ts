import { stripSurroundingQuotes } from "@/lib/env-strip";

/** Default used in code before env is set — avoids undefined but breaks real requests. */
const PLACEHOLDER_URL = "https://placeholder.supabase.co";

/**
 * Prefer calling this before any server-side Supabase request (webhooks, enrollment,
 * APIs). Eliminates vague `TypeError: fetch failed` when env is unset.
 */
export function getServerSupabaseConfigError(): string | null {
  const url = stripSurroundingQuotes(process.env.NEXT_PUBLIC_SUPABASE_URL);
  const key = stripSurroundingQuotes(process.env.SUPABASE_SERVICE_ROLE_KEY);

  if (!url || url === PLACEHOLDER_URL) {
    return [
      'Supabase is not configured: NEXT_PUBLIC_SUPABASE_URL is missing or still the placeholder.',
      "Fix: Supabase Dashboard → Project Settings → API → copy Project URL into .env.local as NEXT_PUBLIC_SUPABASE_URL=yours",
      "Then restart Next.js (npm run dev).",
    ].join(" ");
  }

  if (!/^https:\/\//i.test(url)) {
    return "NEXT_PUBLIC_SUPABASE_URL must be a full https URL.";
  }

  if (!key || key === "placeholder") {
    return [
      'Supabase service key missing: SUPABASE_SERVICE_ROLE_KEY is not set.',
      'Fix: Same API page → service_role secret → SUPABASE_SERVICE_ROLE_KEY in .env.local (never prefix with NEXT_PUBLIC).',
      "Restart Next.js after saving.",
    ].join(" ");
  }

  return null;
}
