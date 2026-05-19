/**
 * Clerk RBAC: `role` must live in User **public metadata** (Dashboard → Users → …).
 * JWT must expose it via **Sessions → Customize session token**, e.g. add claim:
 *   "metadata": {{user.public_metadata}}
 * Otherwise `sessionClaims.metadata` stays empty in middleware / server code.
 */

type MetadataShape = { role?: unknown };

export function clerkAdminRole(sessionClaims: unknown): string | undefined {
  if (!sessionClaims || typeof sessionClaims !== "object") return undefined;
  const c = sessionClaims as Record<string, unknown>;

  const from = (blob: unknown): string | undefined => {
    if (!blob || typeof blob !== "object") return undefined;
    const r = (blob as MetadataShape).role;
    return typeof r === "string" ? r.trim() : undefined;
  };

  return (
    from(c.metadata) ??
    from(c.public_metadata) ??
    from(c.publicMetadata) ??
    undefined
  );
}

export function clerkIsAdmin(sessionClaims: unknown): boolean {
  return clerkAdminRole(sessionClaims) === "admin";
}
