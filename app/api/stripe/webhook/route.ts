import { NextRequest, NextResponse } from "next/server";
import { stripe } from "@/lib/stripe";
import { supabaseAdmin } from "@/lib/supabase";
import Stripe from "stripe";

// Disable body parsing — Stripe needs the raw body to verify the signature
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
    const session = event.data.object as Stripe.CheckoutSession;
    const clerkUserId = session.metadata?.clerk_user_id;

    if (!clerkUserId) {
      console.error("No clerk_user_id in session metadata");
      return NextResponse.json({ error: "Missing metadata" }, { status: 400 });
    }

    // Mark the student as enrolled
    // Upsert the student record and mark enrolled in one operation
    await supabaseAdmin
      .from("students")
      .upsert(
        {
          clerk_user_id: clerkUserId,
          email: session.customer_details?.email ?? session.customer_email ?? "",
          enrolled: true,
          enrolled_at: new Date().toISOString(),
          stripe_customer_id: (session.customer as string) ?? null,
          stripe_payment_intent: (session.payment_intent as string) ?? null,
        },
        { onConflict: "clerk_user_id" }
      );

    console.log(`Student ${clerkUserId} enrolled after successful payment.`);
  }

  return NextResponse.json({ received: true });
}
