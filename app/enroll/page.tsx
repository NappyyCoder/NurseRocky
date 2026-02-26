"use client";

import { useState } from "react";
import { useUser } from "@clerk/nextjs";
import { useRouter } from "next/navigation";

export default function EnrollPage() {
  const { isSignedIn, isLoaded } = useUser();
  const router = useRouter();
  const [loading, setLoading] = useState(false);

  async function handleEnroll() {
    if (!isSignedIn) {
      router.push("/sign-up?redirect=/enroll");
      return;
    }
    setLoading(true);
    const res = await fetch("/api/stripe/checkout", { method: "POST" });
    const data = await res.json();
    if (data.url) {
      window.location.href = data.url;
    } else {
      alert("Something went wrong. Please try again.");
      setLoading(false);
    }
  }

  return (
    <main className="enroll-page">
      <div className="enroll-container">

        {/* Header */}
        <div className="enroll-header">
          <a href="/" className="enroll-logo">Nurse <span>Rocky</span></a>
          <p className="enroll-tagline">CNA Certification Program</p>
        </div>

        {/* Pricing card */}
        <div className="pricing-card">
          <div className="pricing-badge">One-Time Payment</div>
          <div className="pricing-price">
            <span className="price-dollar">$</span>1,499
          </div>
          <p className="pricing-desc">Everything you need to become a Certified Nursing Assistant in 30–45 days.</p>

          <ul className="pricing-features">
            {[
              "6 online learning modules",
              "State exam prep and mock quizzes",
              "16 hours of supervised clinical practice",
              "Career support and job placement guidance",
              "Certificate of completion",
              "Lifetime access to course materials",
            ].map(f => (
              <li key={f} className="pricing-feature">
                <svg viewBox="0 0 20 20" fill="currentColor" className="check-icon"><path fillRule="evenodd" d="M16.707 5.293a1 1 0 010 1.414l-8 8a1 1 0 01-1.414 0l-4-4a1 1 0 011.414-1.414L8 12.586l7.293-7.293a1 1 0 011.414 0z" clipRule="evenodd"/></svg>
                {f}
              </li>
            ))}
          </ul>

          <button
            className="enroll-btn"
            onClick={handleEnroll}
            disabled={!isLoaded || loading}
          >
            {loading ? "Redirecting to payment…" : isSignedIn ? "Enroll Now — $1,499" : "Create Account & Enroll"}
          </button>

          <p className="enroll-secure">
            <svg viewBox="0 0 20 20" fill="currentColor" width="14" height="14"><path fillRule="evenodd" d="M5 9V7a5 5 0 0110 0v2a2 2 0 012 2v5a2 2 0 01-2 2H5a2 2 0 01-2-2v-5a2 2 0 012-2zm8-2v2H7V7a3 3 0 016 0z" clipRule="evenodd"/></svg>
            Secured by Stripe. We never store your card details.
          </p>
        </div>

        {/* Already enrolled */}
        {isSignedIn && (
          <p className="enroll-existing">
            Already enrolled? <a href="/dashboard">Go to your dashboard →</a>
          </p>
        )}

        <a href="/" className="enroll-back">← Back to site</a>
      </div>

      <style>{`
        .enroll-page {
          min-height: 100vh;
          background: linear-gradient(135deg, #f0f9ff 0%, #e0f2fe 100%);
          display: flex;
          align-items: center;
          justify-content: center;
          padding: 2rem 1rem;
          font-family: "DM Sans", system-ui, sans-serif;
        }
        .enroll-container {
          width: 100%;
          max-width: 480px;
          text-align: center;
        }
        .enroll-header { margin-bottom: 2rem; }
        .enroll-logo {
          font-family: "Fraunces", serif;
          font-size: 1.75rem;
          font-weight: 700;
          color: #0f172a;
          text-decoration: none;
          letter-spacing: -.02em;
        }
        .enroll-logo span { color: #0c7ab8; }
        .enroll-tagline { color: #64748b; font-size: .9rem; margin-top: .3rem; }
        .pricing-card {
          background: #fff;
          border-radius: 16px;
          padding: 2.5rem 2rem;
          box-shadow: 0 4px 24px rgba(0,0,0,.1);
          border: 1px solid #e0f2fe;
          margin-bottom: 1.25rem;
        }
        .pricing-badge {
          display: inline-block;
          background: #e0f2fe;
          color: #0369a1;
          font-size: .72rem;
          font-weight: 700;
          text-transform: uppercase;
          letter-spacing: .08em;
          padding: .25rem .75rem;
          border-radius: 99px;
          margin-bottom: 1.25rem;
        }
        .pricing-price {
          font-family: "Fraunces", serif;
          font-size: 4rem;
          font-weight: 700;
          color: #0f172a;
          line-height: 1;
          margin-bottom: .75rem;
          display: flex;
          align-items: flex-start;
          justify-content: center;
          gap: .1rem;
        }
        .price-dollar { font-size: 1.75rem; margin-top: .6rem; color: #64748b; }
        .pricing-desc { color: #64748b; font-size: .9rem; margin-bottom: 1.75rem; line-height: 1.5; }
        .pricing-features { list-style: none; text-align: left; margin-bottom: 2rem; display: flex; flex-direction: column; gap: .65rem; }
        .pricing-feature { display: flex; align-items: center; gap: .65rem; font-size: .9rem; color: #374151; }
        .check-icon { width: 18px; height: 18px; color: #16a34a; flex-shrink: 0; }
        .enroll-btn {
          width: 100%;
          background: #0c7ab8;
          color: #fff;
          border: none;
          border-radius: 10px;
          padding: 1rem;
          font-size: 1rem;
          font-weight: 700;
          cursor: pointer;
          transition: background .15s, transform .1s;
          margin-bottom: .75rem;
        }
        .enroll-btn:hover:not(:disabled) { background: #085d8c; transform: translateY(-1px); }
        .enroll-btn:disabled { opacity: .6; cursor: not-allowed; }
        .enroll-secure {
          display: flex;
          align-items: center;
          justify-content: center;
          gap: .35rem;
          color: #94a3b8;
          font-size: .78rem;
        }
        .enroll-existing { color: #64748b; font-size: .88rem; margin-bottom: .75rem; }
        .enroll-existing a { color: #0c7ab8; font-weight: 600; text-decoration: none; }
        .enroll-existing a:hover { text-decoration: underline; }
        .enroll-back { display: inline-block; color: #94a3b8; font-size: .85rem; text-decoration: none; }
        .enroll-back:hover { color: #64748b; }
      `}</style>
    </main>
  );
}
