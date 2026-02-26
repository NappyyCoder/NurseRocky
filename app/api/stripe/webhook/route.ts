import { NextRequest, NextResponse } from "next/server";
import { stripe } from "@/lib/stripe";
import { supabaseAdmin } from "@/lib/supabase";
import Stripe from "stripe";

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

    const email =
      session.customer_details?.email ??
      session.customer_email ??
      "";

    if (!email) {
      console.error("No email found in Stripe session:", session.id);
      return NextResponse.json({ error: "No email" }, { status: 400 });
    }

    // Create or update a student record by email.
    // clerk_user_id is null until the student creates their account.
    const { error } = await supabaseAdmin
      .from("students")
      .upsert(
        {
          email,
          enrolled: true,
          enrolled_at: new Date().toISOString(),
          stripe_customer_id: (session.customer as string) ?? null,
          stripe_payment_intent: (session.payment_intent as string) ?? null,
          // clerk_user_id intentionally omitted — linked on first sign-in
        },
        { onConflict: "email" }
      );

    if (error) {
      console.error("Supabase upsert error:", error);
      return NextResponse.json({ error: "DB error" }, { status: 500 });
    }

    console.log(`Student enrolled via Stripe: ${email}`);
  }

  return NextResponse.json({ received: true });
}
