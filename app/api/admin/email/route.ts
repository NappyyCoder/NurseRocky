import { NextRequest, NextResponse } from "next/server";
import { supabaseAdmin } from "@/lib/supabase";
import { adminErrorResponse, requireAdminSession } from "@/lib/admin-auth";
import { sendAdminEmail } from "@/lib/send-email";

function escapeHtml(text: string) {
  return text
    .replace(/&/g, "&amp;")
    .replace(/</g, "&lt;")
    .replace(/>/g, "&gt;")
    .replace(/"/g, "&quot;");
}

export async function POST(req: NextRequest) {
  try {
    await requireAdminSession();
    const body = await req.json();
    const { student_id, student_ids, all_enrolled, subject, message } = body as {
      student_id?: string;
      student_ids?: string[];
      all_enrolled?: boolean;
      subject?: string;
      message?: string;
    };

    if (!subject?.trim() || !message?.trim()) {
      return NextResponse.json({ error: "subject and message required" }, { status: 400 });
    }

    let emails: string[] = [];

    if (all_enrolled) {
      const { data, error } = await supabaseAdmin
        .from("students")
        .select("email")
        .eq("enrolled", true);
      if (error) throw error;
      emails = (data ?? []).map((s) => s.email).filter(Boolean);
    } else if (student_ids?.length) {
      const { data, error } = await supabaseAdmin
        .from("students")
        .select("email")
        .in("id", student_ids);
      if (error) throw error;
      emails = (data ?? []).map((s) => s.email).filter(Boolean);
    } else if (student_id) {
      const { data, error } = await supabaseAdmin
        .from("students")
        .select("email")
        .eq("id", student_id)
        .single();
      if (error) throw error;
      if (data?.email) emails = [data.email];
    } else {
      return NextResponse.json(
        { error: "Provide student_id, student_ids, or all_enrolled" },
        { status: 400 }
      );
    }

    if (!emails.length) {
      return NextResponse.json({ error: "No recipients found" }, { status: 400 });
    }

    const html = `
      <div style="font-family: system-ui, sans-serif; max-width: 560px; line-height: 1.6; color: #0f1a17;">
        <p style="margin: 0 0 1rem;">${escapeHtml(message).replace(/\n/g, "<br>")}</p>
        <hr style="border: none; border-top: 1px solid #d8e4df; margin: 1.5rem 0;" />
        <p style="font-size: 0.85rem; color: #5c6b66; margin: 0;">Nurse Rocky CNA Training Program</p>
      </div>
    `;

    const unique = [...new Set(emails)];
    await sendAdminEmail({ to: unique, subject: subject.trim(), html });

    return NextResponse.json({ success: true, sent: unique.length });
  } catch (e: unknown) {
    const { error, status } = adminErrorResponse(e);
    return NextResponse.json({ error }, { status });
  }
}
