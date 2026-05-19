import { NextRequest, NextResponse } from "next/server";
import { supabaseAdmin } from "@/lib/supabase";
import { adminErrorResponse, requireAdminSession } from "@/lib/admin-auth";
import { sendAdminEmail } from "@/lib/send-email";

/** Send reminder emails to enrolled students inactive 7+ days (admin triggered). */
export async function POST(req: NextRequest) {
  try {
    await requireAdminSession();
    const body = await req.json().catch(() => ({}));
    const days = Number(body.days) || 7;

    const cutoff = new Date();
    cutoff.setDate(cutoff.getDate() - days);

    const { data: students } = await supabaseAdmin
      .from("students")
      .select("id, email, first_name")
      .eq("enrolled", true);

    if (!students?.length) {
      return NextResponse.json({ sent: 0, message: "No enrolled students" });
    }

    let sent = 0;
    const errors: string[] = [];

    for (const s of students) {
      const { data: progress } = await supabaseAdmin
        .from("student_progress")
        .select("last_accessed_at, completed_at")
        .eq("student_id", s.id)
        .order("last_accessed_at", { ascending: false })
        .limit(1);

      const last =
        progress?.[0]?.last_accessed_at ??
        progress?.[0]?.completed_at ??
        null;

      if (last && new Date(last) > cutoff) continue;

      if (!process.env.RESEND_API_KEY) {
        return NextResponse.json(
          { error: "RESEND_API_KEY not configured", wouldSend: students.length },
          { status: 400 }
        );
      }

      try {
        await sendAdminEmail({
          to: s.email as string,
          subject: "Continue your CNA training — Nurse Rocky",
          html: `<p>Hi ${s.first_name ?? "there"},</p><p>We noticed you haven't been on the Nurse Rocky student portal recently. Log in to continue your modules and stay on track for certification.</p><p><a href="${process.env.NEXT_PUBLIC_SITE_URL ?? "http://localhost:3000"}/dashboard">Go to your dashboard</a></p>`,
        });
        sent++;
      } catch (e: unknown) {
        errors.push(`${s.email}: ${e instanceof Error ? e.message : "failed"}`);
      }
    }

    return NextResponse.json({ sent, errors: errors.slice(0, 5) });
  } catch (e: unknown) {
    const { error, status } = adminErrorResponse(e);
    return NextResponse.json({ error }, { status });
  }
}
