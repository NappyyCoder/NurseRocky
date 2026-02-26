import Stripe from "stripe";

export const stripe = new Stripe(process.env.STRIPE_SECRET_KEY!, {
  apiVersion: "2026-02-25.clover",
});

export const COURSE_PRICE_CENTS = 149900; // $1,499.00 — update to your actual price
export const COURSE_NAME = "Nurse Rocky CNA Certification Program";
