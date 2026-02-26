"use client";

import { useState } from "react";
import { useUser } from "@clerk/nextjs";
import { useRouter } from "next/navigation";

export default function EnrollButton() {
  const { isSignedIn, isLoaded } = useUser();
  const router = useRouter();
  const [loading, setLoading] = useState(false);

  async function handleEnroll() {
    if (!isSignedIn) {
      router.push("/sign-up?redirect=/enroll");
      return;
    }
    setLoading(true);
    try {
      const res = await fetch("/api/stripe/checkout", { method: "POST" });
      const data = await res.json();
      if (data.url) {
        window.location.href = data.url;
      } else {
        alert("Something went wrong. Please try again.");
        setLoading(false);
      }
    } catch {
      alert("Something went wrong. Please try again.");
      setLoading(false);
    }
  }

  const label = !isLoaded
    ? "Loading…"
    : loading
    ? "Redirecting to payment…"
    : isSignedIn
    ? "Enroll Now — $1,499"
    : "Create Account & Enroll";

  return (
    <button className="enroll-btn" onClick={handleEnroll} disabled={!isLoaded || loading}>
      {label}
    </button>
  );
}
