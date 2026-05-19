import { NextResponse } from "next/server";
import { adminErrorResponse, requireAdminSession } from "@/lib/admin-auth";
import { checkSupabaseReachability } from "@/lib/supabase-health";
import { getServerSupabaseConfigError } from "@/lib/supabase-env";
import { supabaseAdmin } from "@/lib/supabase";

/** Admin dashboard: Supabase connectivity + auth + write probe. */
export async function GET() {
  const configError = getServerSupabaseConfigError();
  const reachability = await checkSupabaseReachability();

  let admin = false;
  let adminError: string | null = null;
  try {
    await requireAdminSession();
    admin = true;
  } catch (e: unknown) {
    adminError = e instanceof Error ? e.message : "Not signed in as admin";
  }

  let canWrite = false;
  let writeError: string | null = null;
  if (admin && reachability.ok && !configError) {
    const { error } = await supabaseAdmin
      .from("modules")
      .select("id")
      .limit(1);
    if (error) {
      writeError = error.message;
    } else {
      canWrite = true;
    }
  }

  return NextResponse.json({
    supabase: {
      configured: !configError,
      configError,
      reachable: reachability.ok,
      schemaReady: reachability.schemaReady,
      url: reachability.url,
      hint: reachability.hint,
    },
    admin,
    adminError,
    canWrite,
    writeError,
    ready: !configError && reachability.ok && reachability.schemaReady && admin && canWrite,
  });
}
