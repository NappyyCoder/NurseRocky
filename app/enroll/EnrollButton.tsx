"use client";

import { useState } from "react";

export default function EnrollButton() {
  const [loading, setLoading] = useState(false);

  async function handleEnroll() {
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

  return (
    <button className="enroll-btn" onClick={handleEnroll} disabled={loading}>
      {loading ? "Redirecting to payment…" : "Enroll Now — $1,499"}
    </button>
  );
}
