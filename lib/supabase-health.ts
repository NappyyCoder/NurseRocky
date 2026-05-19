import { stripSurroundingQuotes } from "@/lib/env-strip";
import { getServerSupabaseConfigError } from "@/lib/supabase-env";

export type SupabaseReachability = {
  ok: boolean;
  url: string;
  projectRef: string | null;
  httpStatus: number | null;
  schemaReady: boolean;
  error: string | null;
  hint: string | null;
};

/** Extract project ref from https://REF.supabase.co */
export function supabaseProjectRef(url: string): string | null {
  const m = url.match(/^https:\/\/([a-z0-9-]+)\.supabase\.co\/?$/i);
  return m?.[1] ?? null;
}

/**
 * Lightweight ping — confirms DNS + HTTPS before enrollment writes.
 * Uses anon key only (safe to expose in dev health responses).
 */
export async function checkSupabaseReachability(): Promise<SupabaseReachability> {
  const configErr = getServerSupabaseConfigError();
  const url = stripSurroundingQuotes(process.env.NEXT_PUBLIC_SUPABASE_URL);
  const anonKey = stripSurroundingQuotes(process.env.NEXT_PUBLIC_SUPABASE_ANON_KEY);
  const projectRef = supabaseProjectRef(url);

  if (configErr) {
    return {
      ok: false,
      url: url || "(unset)",
      projectRef,
      httpStatus: null,
      schemaReady: false,
      error: configErr,
      hint: "Fix .env.local and restart npm run dev.",
    };
  }

  try {
    const base = url.replace(/\/$/, "");
    const res = await fetch(`${base}/rest/v1/`, {
      method: "GET",
      headers: {
        apikey: anonKey,
        Authorization: `Bearer ${anonKey}`,
      },
      signal: AbortSignal.timeout(12_000),
    });

    const serviceKey = stripSurroundingQuotes(process.env.SUPABASE_SERVICE_ROLE_KEY);
    let schemaReady = false;
    if (serviceKey) {
      const tableProbe = await fetch(`${base}/rest/v1/students?select=id&limit=1`, {
        headers: {
          apikey: serviceKey,
          Authorization: `Bearer ${serviceKey}`,
        },
        signal: AbortSignal.timeout(12_000),
      });
      const body = await tableProbe.text();
      schemaReady = tableProbe.ok && !body.includes("PGRST205");
    }

    // 200/401/404 on root still mean the host exists and REST is up
    const reachable = res.status > 0 && res.status < 600;
    if (reachable) {
      if (!schemaReady) {
        return {
          ok: false,
          url,
          projectRef,
          httpStatus: res.status,
          schemaReady: false,
          error: "Supabase is online but the students table is missing.",
          hint:
            "In Supabase → SQL Editor, run supabase/schema.sql, then supabase/patches/001-clerk-user-id-nullable.sql, then supabase/seed.sql from this repo.",
        };
      }
      return {
        ok: true,
        url,
        projectRef,
        httpStatus: res.status,
        schemaReady: true,
        error: null,
        hint: null,
      };
    }

    return {
      ok: false,
      url,
      projectRef,
      httpStatus: res.status,
      schemaReady: false,
      error: `Unexpected HTTP ${res.status}`,
      hint: "Check Supabase project status in the dashboard.",
    };
  } catch (e: unknown) {
    const err = e instanceof Error ? e : new Error(String(e));
    const cause =
      err.cause instanceof Error
        ? err.cause.message
        : typeof err.cause === "string"
          ? err.cause
          : null;

    const isDns =
      /ENOTFOUND|ECONNREFUSED|fetch failed|getaddrinfo|NXDOMAIN/i.test(
        `${err.message} ${cause ?? ""}`
      );

    return {
      ok: false,
      url,
      projectRef,
      httpStatus: null,
      schemaReady: false,
      error: cause ? `${err.message} (${cause})` : err.message,
      hint: isDns
        ? [
            `DNS cannot resolve ${projectRef ? `"${projectRef}.supabase.co"` : "your Supabase URL"}.`,
            "The project was deleted, paused indefinitely, or the URL in .env.local is wrong.",
            "Open https://supabase.com/dashboard → confirm the project exists → copy Project URL + API keys again.",
            "If you created a new project, run supabase/schema.sql and supabase/patches/001-clerk-user-id-nullable.sql in SQL Editor.",
          ].join(" ")
        : "Check network/VPN/firewall, then verify Supabase dashboard shows the project as Active.",
    };
  }
}
