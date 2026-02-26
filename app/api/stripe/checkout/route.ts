import { auth } from "@clerk/nextjs/server";
import { NextResponse } from "next/server";
import { stripe, COURSE_PRICE_CENTS, COURSE_NAME } from "@/lib/stripe";

export async function POST() {
  const { userId } = await auth();
  if (!userId) {
    return NextResponse.json({ error: "Not signed in" }, { status: 401 });
  }

  const session = await stripe.checkout.sessions.create({
    payment_method_types: ["card"],
    mode: "payment",
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
    metadata: {
      clerk_user_id: userId,
    },
    success_url: `${process.env.NEXT_PUBLIC_SITE_URL ?? "http://localhost:3000"}/enroll/success`,
    cancel_url: `${process.env.NEXT_PUBLIC_SITE_URL ?? "http://localhost:3000"}/enroll`,
  });

  return NextResponse.json({ url: session.url });
}
