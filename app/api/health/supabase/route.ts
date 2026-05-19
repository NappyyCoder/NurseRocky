import { NextResponse } from "next/server";
import { checkSupabaseReachability } from "@/lib/supabase-health";

/** Dev/troubleshooting: GET /api/health/supabase */
export async function GET() {
  const result = await checkSupabaseReachability();
  return NextResponse.json(result, { status: result.ok ? 200 : 503 });
}
