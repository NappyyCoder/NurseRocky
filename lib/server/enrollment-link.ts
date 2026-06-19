import { cookies } from "next/headers";
import { currentUser } from "@clerk/nextjs/server";
import { stripe } from "@/lib/stripe";
import { supabaseAdmin } from "@/lib/supabase";
import {
  canonicalStudentEmail,
  upsertEnrollmentFromPaidSession,
} from "@/lib/stripe-enrollment";

export const CHECKOUT_SESSION_COOKIE = "nr_checkout_session";

type ClerkProfile = {
  firstName?: string | null;
  lastName?: string | null;
};

/** Attach Clerk user to the paid student row; clears stale clerk links first. */
export async function attachClerkToStudent(
  userId: string,
  studentId: string,
  profile?: ClerkProfile,
  staleStudentId?: string
) {
  if (staleStudentId && staleStudentId !== studentId) {
    await supabaseAdmin
      .from("students")
      .update({ clerk_user_id: null })
      .eq("id", staleStudentId);
  }

  const { data: holder } = await supabaseAdmin
    .from("students")
    .select("id")
    .eq("clerk_user_id", userId)
    .neq("id", studentId)
    .maybeSingle();

  if (holder?.id) {
    await supabaseAdmin
      .from("students")
      .update({ clerk_user_id: null })
      .eq("id", holder.id);
  }

  await supabaseAdmin
    .from("students")
    .update({
      clerk_user_id: userId,
      first_name: profile?.firstName ?? null,
      last_name: profile?.lastName ?? null,
    })
    .eq("id", studentId);
}

/** Verify Stripe checkout session is paid and return payer email. */
export async function verifyPaidCheckoutSession(sessionId: string) {
  const session = await stripe.checkout.sessions.retrieve(sessionId);
  if (session.payment_status !== "paid") {
    return { ok: false as const, reason: "not_paid" as const };
  }

  const email = canonicalStudentEmail(
    session.customer_details?.email ?? session.customer_email ?? ""
  );
  if (!email) {
    return { ok: false as const, reason: "no_email" as const };
  }

  return {
    ok: true as const,
    email,
    stripe_customer_id: (session.customer as string) ?? null,
    stripe_payment_intent: (session.payment_intent as string) ?? null,
  };
}

/** Save enrollment from a paid Stripe session and link to the signed-in Clerk user. */
export async function enrollAndLinkCheckoutSession(
  sessionId: string,
  userId: string,
  profile?: ClerkProfile
) {
  const verified = await verifyPaidCheckoutSession(sessionId);
  if (!verified.ok) return verified;

  const saved = await upsertEnrollmentFromPaidSession({
    email: verified.email,
    stripe_customer_id: verified.stripe_customer_id,
    stripe_payment_intent: verified.stripe_payment_intent,
  });
  if (!saved.ok) return { ok: false as const, reason: "db_error" as const, error: saved.error };

  const { data: student } = await supabaseAdmin
    .from("students")
    .select("id")
    .eq("email", verified.email)
    .maybeSingle();

  if (!student?.id) {
    return { ok: false as const, reason: "student_missing" as const };
  }

  await attachClerkToStudent(userId, student.id as string, profile);
  return { ok: true as const, studentId: student.id as string };
}

/** Find a recent paid checkout for this email via Stripe customer records. */
async function findPaidCheckoutSessionForEmail(email: string) {
  const customers = await stripe.customers.list({ email, limit: 5 });
  for (const customer of customers.data) {
    const sessions = await stripe.checkout.sessions.list({
      customer: customer.id,
      limit: 10,
    });
    const paid = sessions.data.find((s) => s.payment_status === "paid");
    if (paid?.id) return paid.id;
  }
  return null;
}

/**
 * After sign-in / sign-up, try to connect payment to this Clerk account:
 * 1) checkout session cookie from /enroll/success
 * 2) Stripe lookup by Clerk email
 */
export async function syncEnrollmentForClerkUser(userId: string) {
  const user = await currentUser();
  const profile: ClerkProfile = {
    firstName: user?.firstName,
    lastName: user?.lastName,
  };

  const cookieStore = await cookies();
  const sessionId = cookieStore.get(CHECKOUT_SESSION_COOKIE)?.value;

  if (sessionId) {
    try {
      const result = await enrollAndLinkCheckoutSession(sessionId, userId, profile);
      if (result.ok) {
        cookieStore.delete(CHECKOUT_SESSION_COOKIE);
        return result;
      }
    } catch (e) {
      console.error("[enrollment-link] cookie session sync failed:", e);
    }
  }

  const clerkEmail = canonicalStudentEmail(
    user?.primaryEmailAddress?.emailAddress ?? ""
  );
  if (!clerkEmail) return { ok: false as const, reason: "no_clerk_email" as const };

  try {
    const checkoutSessionId = await findPaidCheckoutSessionForEmail(clerkEmail);
    if (!checkoutSessionId) {
      return { ok: false as const, reason: "no_paid_session" as const };
    }

    return await enrollAndLinkCheckoutSession(checkoutSessionId, userId, profile);
  } catch (e) {
    console.error("[enrollment-link] stripe email sync failed:", e);
    return { ok: false as const, reason: "stripe_lookup_failed" as const };
  }
}
