import { stripSurroundingQuotes } from "@/lib/env-strip";

type SendEmailInput = {
  to: string | string[];
  subject: string;
  html: string;
};

export async function sendAdminEmail({ to, subject, html }: SendEmailInput) {
  const apiKey = stripSurroundingQuotes(process.env.RESEND_API_KEY);
  const from =
    stripSurroundingQuotes(process.env.ADMIN_EMAIL_FROM) ||
    "Nurse Rocky <onboarding@resend.dev>";

  if (!apiKey) {
    throw new Error(
      "Email is not configured. Add RESEND_API_KEY and ADMIN_EMAIL_FROM to .env.local"
    );
  }

  const res = await fetch("https://api.resend.com/emails", {
    method: "POST",
    headers: {
      Authorization: `Bearer ${apiKey}`,
      "Content-Type": "application/json",
    },
    body: JSON.stringify({ from, to, subject, html }),
  });

  if (!res.ok) {
    const body = await res.text();
    throw new Error(`Email failed (${res.status}): ${body}`);
  }

  return res.json();
}
