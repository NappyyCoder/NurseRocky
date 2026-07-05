import { auth } from "@clerk/nextjs/server";
import { NextRequest, NextResponse } from "next/server";
import { formatDbError } from "@/lib/server/format-db-error";
import { studentNeedsPolicyAck } from "@/lib/server/policy-ack-status";
import { resolveStudentId } from "@/lib/server/resolve-student";
import { REQUIRED_POLICY_SLUGS } from "@/lib/student-portal/constants";
import { supabaseAdmin } from "@/lib/supabase";

async function upsertPolicyAck(studentId: string, slug: string) {
  const now = new Date().toISOString();

  const { data: existing, error: lookupErr } = await supabaseAdmin
    .from("student_policy_acknowledgments")
    .select("id")
    .eq("student_id", studentId)
    .eq("policy_slug", slug)
    .maybeSingle();

  if (lookupErr) return lookupErr;

  if (existing?.id) {
    const { error } = await supabaseAdmin
      .from("student_policy_acknowledgments")
      .update({ acknowledged_at: now })
      .eq("id", existing.id);
    return error;
  }

  const { error } = await supabaseAdmin.from("student_policy_acknowledgments").insert({
    student_id: studentId,
    policy_slug: slug,
    acknowledged_at: now,
  });
  return error;
}

export async function POST(req: NextRequest) {
  try {
    const { userId } = await auth();
    if (!userId) return NextResponse.json({ error: "Unauthorized" }, { status: 401 });

    const studentId = await resolveStudentId(userId);
    if (!studentId) return NextResponse.json({ error: "Student not found" }, { status: 404 });

    const { slugs } = (await req.json()) as { slugs?: string[] };
    const toAck = slugs?.length ? slugs : [...REQUIRED_POLICY_SLUGS];

    for (const slug of toAck) {
      const err = await upsertPolicyAck(studentId, slug);
      if (err) {
        console.error("[policy-ack] save failed:", formatDbError(err));
        return NextResponse.json({ error: formatDbError(err) }, { status: 500 });
      }
    }

    const { data: ackRows, error: ackErr } = await supabaseAdmin
      .from("student_policy_acknowledgments")
      .select("policy_slug")
      .eq("student_id", studentId);

    if (ackErr) {
      return NextResponse.json({ error: formatDbError(ackErr) }, { status: 500 });
    }

    const ackedSlugs = (ackRows ?? []).map((row) => row.policy_slug as string);
    const allDone = !studentNeedsPolicyAck(null, ackedSlugs);

    if (allDone) {
      const { error: studentErr } = await supabaseAdmin
        .from("students")
        .update({ policies_acknowledged_at: new Date().toISOString() })
        .eq("id", studentId);

      if (studentErr) {
        console.warn("[policy-ack] student timestamp:", formatDbError(studentErr));
      }
    }

    return NextResponse.json({ success: true, allDone });
  } catch (e: unknown) {
    const msg = formatDbError(e);
    console.error("[policy-ack] unexpected:", msg, e);
    return NextResponse.json({ error: msg }, { status: 500 });
  }
}
