import { auth } from "@clerk/nextjs/server";
import { NextRequest, NextResponse } from "next/server";
import { supabaseAdmin } from "@/lib/supabase";
import { resolveStudentId } from "@/lib/server/resolve-student";
import { REQUIRED_POLICY_SLUGS } from "@/lib/student-portal/constants";

export async function POST(req: NextRequest) {
  try {
    const { userId } = await auth();
    if (!userId) return NextResponse.json({ error: "Unauthorized" }, { status: 401 });

    const studentId = await resolveStudentId(userId);
    if (!studentId) return NextResponse.json({ error: "Student not found" }, { status: 404 });

    const { slugs } = (await req.json()) as { slugs?: string[] };
    const toAck = slugs?.length ? slugs : [...REQUIRED_POLICY_SLUGS];

    for (const slug of toAck) {
      await supabaseAdmin.from("student_policy_acknowledgments").upsert(
        { student_id: studentId, policy_slug: slug, acknowledged_at: new Date().toISOString() },
        { onConflict: "student_id,policy_slug" }
      );
    }

    const acked = new Set(toAck);
    const allDone = REQUIRED_POLICY_SLUGS.every((s) => acked.has(s));
    if (allDone) {
      await supabaseAdmin
        .from("students")
        .update({ policies_acknowledged_at: new Date().toISOString() })
        .eq("id", studentId);
    }

    return NextResponse.json({ success: true });
  } catch (e: unknown) {
    return NextResponse.json({ error: e instanceof Error ? e.message : "Error" }, { status: 500 });
  }
}
