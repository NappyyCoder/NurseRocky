import { auth } from "@clerk/nextjs/server";
import { currentUser } from "@clerk/nextjs/server";
import { NextRequest, NextResponse } from "next/server";
import { supabaseAdmin } from "@/lib/supabase";
import { resolveStudentId } from "@/lib/server/resolve-student";
import { sendAdminEmail } from "@/lib/send-email";

export async function POST(req: NextRequest) {
  try {
    const { userId } = await auth();
    if (!userId) return NextResponse.json({ error: "Unauthorized" }, { status: 401 });

    const studentId = await resolveStudentId(userId);
    if (!studentId) return NextResponse.json({ error: "Student not found" }, { status: 404 });

    const { subject, message } = await req.json();
    if (!subject?.trim() || !message?.trim()) {
      return NextResponse.json({ error: "subject and message required" }, { status: 400 });
    }

    await supabaseAdmin.from("support_messages").insert({
      student_id: studentId,
      subject: subject.trim(),
      message: message.trim(),
    });

    const user = await currentUser();
    const email = user?.primaryEmailAddress?.emailAddress;
    if (process.env.RESEND_API_KEY && process.env.ADMIN_NOTIFY_EMAIL) {
      try {
        await sendAdminEmail({
          to: process.env.ADMIN_NOTIFY_EMAIL,
          subject: `[Student Support] ${subject.trim()}`,
          html: `<p>From: ${email ?? studentId}</p><p>${message.trim().replace(/\n/g, "<br>")}</p>`,
        });
      } catch {
        /* stored in DB even if email fails */
      }
    }

    return NextResponse.json({ success: true });
  } catch (e: unknown) {
    return NextResponse.json({ error: e instanceof Error ? e.message : "Error" }, { status: 500 });
  }
}
