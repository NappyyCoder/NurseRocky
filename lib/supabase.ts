import { createClient } from "@supabase/supabase-js";
import { stripSurroundingQuotes } from "@/lib/env-strip";

const supabaseUrlRaw = stripSurroundingQuotes(process.env.NEXT_PUBLIC_SUPABASE_URL);
const supabaseUrl =
  supabaseUrlRaw || "https://placeholder.supabase.co";
const supabaseAnonKey = stripSurroundingQuotes(
  process.env.NEXT_PUBLIC_SUPABASE_ANON_KEY
) || "placeholder";
const supabaseServiceKey = stripSurroundingQuotes(
  process.env.SUPABASE_SERVICE_ROLE_KEY
) || "placeholder";

/** Browser-safe client — still needs valid NEXT_PUBLIC_* in production. */
export const supabase = createClient(supabaseUrl, supabaseAnonKey);

/**
 * Service-role server client. Needs real URL + SUPABASE_SERVICE_ROLE_KEY.
 * Keeps cookie/session churn off edge requests (recommended for APIs / webhooks).
 */
export const supabaseAdmin = createClient(supabaseUrl, supabaseServiceKey, {
  auth: {
    persistSession: false,
    autoRefreshToken: false,
    detectSessionInUrl: false,
  },
});
