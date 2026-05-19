export type AdminRequestResult<T> =
  | { ok: true; data: T }
  | { ok: false; error: string };

/** Client-side admin API helper — surfaces Supabase/auth errors instead of silent failure. */
export async function adminRequest<T = unknown>(
  url: string,
  init?: RequestInit
): Promise<AdminRequestResult<T>> {
  try {
    const res = await fetch(url, {
      ...init,
      headers: {
        "Content-Type": "application/json",
        ...(init?.headers ?? {}),
      },
    });
    const data = (await res.json().catch(() => ({}))) as { error?: string };
    if (!res.ok) {
      if (res.status === 401) {
        return {
          ok: false,
          error:
            data.error === "Unauthorized"
              ? "Admin access denied. Sign in with an account that has role: admin in Clerk public metadata, then sign out and back in."
              : data.error ?? "Unauthorized",
        };
      }
      return {
        ok: false,
        error: data.error ?? `Request failed (${res.status})`,
      };
    }
    return { ok: true, data: data as T };
  } catch (e: unknown) {
    return {
      ok: false,
      error: e instanceof Error ? e.message : "Network error — is the dev server running?",
    };
  }
}
