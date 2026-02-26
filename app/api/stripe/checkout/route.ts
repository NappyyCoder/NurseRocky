import { auth, currentUser } from "@clerk/nextjs/server";
import { NextResponse } from "next/server";
import { stripe, COURSE_PRICE_CENTS, COURSE_NAME } from "@/lib/stripe";
import { supabaseAdmin } from "@/lib/supabase";

export async function POST() {
  const { userId } = await auth();
  if (!userId) {
    return NextResponse.json({ error: "Not signed in" }, { status: 401 });
  }

  const user = await currentUser();
  const email = user?.primaryEmailAddress?.emailAddress;

  // Upsert student record so we have them in Supabase before payment
  const { data: student } = await supabaseAdmin
    .from("students")
    .upsert(
      {
        clerk_user_id: userId,
        email: email ?? "",
        first_name: user?.firstName ?? null,
        last_name: user?.lastName ?? null,
        enrolled: false,
      },
      { onConflict: "clerk_user_id" }
    )
    .select()
    .single();

  const session = await stripe.checkout.sessions.create({
    payment_method_types: ["card"],
    mode: "payment",
    customer_email: email,
    line_items: [
      {
        price_data: {
          currency: "usd",
          product_data: {
            name: COURSE_NAME,
            description: "Full CNA certification course — online modules, clinical prep, and state exam preparation.",
          },
          unit_amount: COURSE_PRICE_CENTS,
        },
        quantity: 1,
      },
    ],
    metadata: {
      clerk_user_id: userId,
      student_id: student?.id ?? "",
    },
    success_url: `${process.env.NEXT_PUBLIC_SITE_URL ?? "http://localhost:3000"}/enroll/success`,
    cancel_url: `${process.env.NEXT_PUBLIC_SITE_URL ?? "http://localhost:3000"}/enroll`,
  });

  return NextResponse.json({ url: session.url });
}
