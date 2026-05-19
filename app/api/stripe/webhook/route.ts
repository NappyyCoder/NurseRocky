import { NextRequest, NextResponse } from "next/server";
import { stripe } from "@/lib/stripe";
import Stripe from "stripe";
import {
  canonicalStudentEmail,
  upsertEnrollmentFromPaidSession,
} from "@/lib/stripe-enrollment";

export const runtime = "nodejs";

export async function POST(req: NextRequest) {
  const body = await req.text();
  const sig = req.headers.get("stripe-signature");

  if (!sig) {
    return NextResponse.json({ error: "Missing stripe-signature header" }, { status: 400 });
  }

  let event: Stripe.Event;
  try {
    event = stripe.webhooks.constructEvent(body, sig, process.env.STRIPE_WEBHOOK_SECRET!);
  } catch (err) {
    console.error("Webhook signature verification failed:", err);
    return NextResponse.json({ error: "Invalid signature" }, { status: 400 });
  }

  if (event.type === "checkout.session.completed") {
    const session = event.data.object as Stripe.Checkout.Session;

    const rawEmail =
      session.customer_details?.email ?? session.customer_email ?? "";
    const email = canonicalStudentEmail(rawEmail);

    if (!email) {
      console.error("No email found in Stripe session:", session.id);
      return NextResponse.json({ error: "No email" }, { status: 400 });
    }

    const { ok, error: enrollErr } = await upsertEnrollmentFromPaidSession({
      email,
      stripe_customer_id: (session.customer as string) ?? null,
      stripe_payment_intent: (session.payment_intent as string) ?? null,
    });

    if (!ok) {
      console.error("Supabase enrollment error:", enrollErr);
      return NextResponse.json({ error: enrollErr ?? "DB error" }, { status: 500 });
    }

    console.log(`Student enrolled via Stripe: ${email}`);
  }

  return NextResponse.json({ received: true });
}
