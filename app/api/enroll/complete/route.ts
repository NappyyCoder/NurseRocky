import { NextRequest, NextResponse } from "next/server";
import { auth } from "@clerk/nextjs/server";
import { stripe } from "@/lib/stripe";
import { supabaseAdmin } from "@/lib/supabase";
import {
  canonicalStudentEmail,
  upsertEnrollmentFromPaidSession,
} from "@/lib/stripe-enrollment";
import {
  CHECKOUT_SESSION_COOKIE,
  attachClerkToStudent,
} from "@/lib/server/enrollment-link";

function siteOrigin(req: NextRequest) {
  return (
    process.env.NEXT_PUBLIC_SITE_URL ??
    (process.env.VERCEL_URL ? `https://${process.env.VERCEL_URL}` : req.nextUrl.origin)
  );
}

/** Stripe success redirect — verify payment, save enrollment, set link cookie. */
export async function GET(req: NextRequest) {
  const sessionId = req.nextUrl.searchParams.get("session_id");
  const origin = siteOrigin(req);

  if (!sessionId) {
    return NextResponse.redirect(
      new URL("/enroll/success?error=missing_session", origin)
    );
  }

  let enrolledEmail: string | null = null;
  let enrollmentSaved = false;
  let enrollmentError: string | null = null;

  try {
    const session = await stripe.checkout.sessions.retrieve(sessionId);

    if (session.payment_status === "paid") {
      const email = canonicalStudentEmail(
        session.customer_details?.email ?? session.customer_email ?? ""
      );

      if (email) {
        enrolledEmail = email;
        const { ok, error } = await upsertEnrollmentFromPaidSession({
          email,
          stripe_customer_id: (session.customer as string) ?? null,
          stripe_payment_intent: (session.payment_intent as string) ?? null,
        });
        enrollmentSaved = ok;
        if (!ok) enrollmentError = error ?? "Could not save enrollment";
      } else {
        enrollmentError = "No email on payment — contact support with your receipt.";
      }
    } else {
      enrollmentError = "Payment was not completed. Please try checkout again.";
    }
  } catch (e) {
    console.error("Could not verify Stripe session:", e);
    enrollmentError =
      "Could not verify payment. Sign in after creating your account and we will retry automatically.";
  }

  const { userId } = await auth();
  if (userId && enrolledEmail && enrollmentSaved) {
    const { data: student } = await supabaseAdmin
      .from("students")
      .select("id")
      .eq("email", enrolledEmail)
      .maybeSingle();

    if (student?.id) {
      await attachClerkToStudent(userId, student.id as string);
    }
  }

  const redirectUrl = new URL("/enroll/success", origin);
  if (enrollmentSaved) {
    redirectUrl.searchParams.set("enrolled", "1");
  } else if (enrollmentError) {
    redirectUrl.searchParams.set("error", enrollmentError);
  }

  const response = NextResponse.redirect(redirectUrl);

  if (sessionId && enrollmentSaved) {
    response.cookies.set(CHECKOUT_SESSION_COOKIE, sessionId, {
      httpOnly: true,
      secure: process.env.NODE_ENV === "production",
      sameSite: "lax",
      path: "/",
      maxAge: 60 * 60 * 24 * 7,
    });
  }

  return response;
}
