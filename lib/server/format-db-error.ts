/** Extract a readable message from Supabase/PostgREST errors. */
export function formatDbError(err: unknown): string {
  if (err && typeof err === "object") {
    const o = err as Record<string, unknown>;
    const parts = [o.message, o.details, o.hint, o.code].filter(
      (v) => typeof v === "string" && v.trim().length > 0
    ) as string[];
    if (parts.length) return parts.join(" — ");
  }
  if (err instanceof Error && err.message.trim()) return err.message;
  return "Could not save lesson progress";
}
