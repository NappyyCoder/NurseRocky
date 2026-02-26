import { NextResponse } from "next/server";
import { stripe, COURSE_PRICE_CENTS, COURSE_NAME } from "@/lib/stripe";

// No auth required — anyone can start checkout
export async function POST() {
  const session = await stripe.checkout.sessions.create({
    payment_method_types: ["card"],
    mode: "payment",
    billing_address_collection: "auto",
    customer_creation: "always",
    line_items: [
      {
        price_data: {
          currency: "usd",
          product_data: {
            name: COURSE_NAME,
            description: "Online modules, clinical prep, and state exam preparation.",
          },
          unit_amount: COURSE_PRICE_CENTS,
        },
        quantity: 1,
      },
    ],
    success_url: `${process.env.NEXT_PUBLIC_SITE_URL ?? "http://localhost:3000"}/enroll/success?session_id={CHECKOUT_SESSION_ID}`,
    cancel_url: `${process.env.NEXT_PUBLIC_SITE_URL ?? "http://localhost:3000"}/enroll`,
  });

  return NextResponse.json({ url: session.url });
}
