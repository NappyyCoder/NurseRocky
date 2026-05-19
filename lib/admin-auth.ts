import { auth } from "@clerk/nextjs/server";
import { clerkIsAdmin } from "@/lib/clerk-admin";
import { assertSupabaseConfigured } from "@/lib/assert-supabase";

export async function requireAdminSession() {
  assertSupabaseConfigured();
  const { sessionClaims } = await auth();
  if (!clerkIsAdmin(sessionClaims)) {
    throw new Error("Unauthorized");
  }
}

export function adminErrorResponse(e: unknown) {
  const msg = e instanceof Error ? e.message : "Error";
  return { error: msg, status: msg === "Unauthorized" ? 401 : 500 };
}
