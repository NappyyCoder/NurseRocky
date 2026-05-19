import { supabaseAdmin } from "@/lib/supabase";
import { getServerSupabaseConfigError } from "@/lib/supabase-env";
import { checkSupabaseReachability } from "@/lib/supabase-health";

/** Single canonical form for email matching (Stripe + Clerk). */
export function canonicalStudentEmail(email: string | undefined | null): string {
  return (email ?? "").trim().toLowerCase();
}

function friendlyFetchError(operation: string, raw?: string): string {
  const base = raw?.trim();
  const isFetch =
    base === "TypeError: fetch failed" ||
    /^fetch failed$/i.test(base ?? "") ||
    base?.includes("fetch failed");

  if (isFetch) {
    const reachHint = getServerSupabaseConfigError();
    return [
      `Supabase ${operation}: cannot reach your database (fetch failed).`,
      reachHint ??
        "Open http://localhost:3000/api/health/supabase after restarting dev for details.",
    ].join(" ");
  }
  return `${operation}: ${base ?? "unknown error"}`;
}

/** Mark a student paid + enrolled without touching Clerk linkage on updates. */
export async function upsertEnrollmentFromPaidSession(opts: {
  email: string;
  stripe_customer_id?: string | null;
  stripe_payment_intent?: string | null;
}): Promise<{ ok: boolean; error?: string }> {
  const envErr = getServerSupabaseConfigError();
  if (envErr) {
    console.error("[enrollment]", envErr);
    return { ok: false, error: envErr };
  }

  const reach = await checkSupabaseReachability();
  if (!reach.ok) {
    console.error("[enrollment] Supabase unreachable:", reach.error, reach.hint);
    return {
      ok: false,
      error: reach.hint ?? reach.error ?? "Supabase unreachable",
    };
  }

  const email = canonicalStudentEmail(opts.email);
  if (!email) {
    return { ok: false, error: "Missing email" };
  }

  const stripePatch = {
    enrolled: true,
    enrolled_at: new Date().toISOString(),
    stripe_customer_id: opts.stripe_customer_id ?? null,
    stripe_payment_intent: opts.stripe_payment_intent ?? null,
  };

  try {
    const { data: existing, error: findErr } = await supabaseAdmin
      .from("students")
      .select("id")
      .eq("email", email)
      .maybeSingle();

    if (findErr) {
      const detail = `${findErr.message}${findErr.hint ? ` (${findErr.hint})` : ""}`;
      console.error("[enrollment] lookup student:", detail, findErr);
      return { ok: false, error: friendlyFetchError("lookup", detail) };
    }

    if (existing?.id) {
      const { error } = await supabaseAdmin.from("students").update(stripePatch).eq("id", existing.id);
      if (error) {
        console.error("[enrollment] update student:", error);
        return {
          ok: false,
          error: friendlyFetchError("update enrollment", `${error.message}${error.details ? `: ${error.details}` : ""}`),
        };
      }
      return { ok: true };
    }

    const { error } = await supabaseAdmin.from("students").insert({
      email,
      clerk_user_id: null,
      first_name: null,
      last_name: null,
      ...stripePatch,
    });

    if (error) {
      console.error("[enrollment] insert student:", error);
      return {
        ok: false,
        error: friendlyFetchError("insert", `${error.message}${error.details ? `: ${error.details}` : ""}`),
      };
    }
    return { ok: true };
  } catch (e: unknown) {
    const msg = e instanceof Error ? e.message : String(e);
    console.error("[enrollment] unexpected:", e);
    return {
      ok: false,
      error: friendlyFetchError("request", msg),
    };
  }
}
