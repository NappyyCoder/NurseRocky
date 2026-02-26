import Link from "next/link";
import { auth } from "@clerk/nextjs/server";

export default async function EnrollSuccessPage() {
  const { userId } = await auth();

  return (
    <main className="success-page">
      <div className="success-bg-circle" />

      <div className="success-container">

        {/* Logo */}
        <Link href="/" className="success-logo">
          Nurse <span>Rocky</span>
        </Link>

        {/* Icon */}
        <div className="success-icon-wrap">
          <div className="success-icon-ring" />
          <div className="success-icon">
            <svg viewBox="0 0 24 24" fill="none" stroke="currentColor" strokeWidth="2.5" strokeLinecap="round" strokeLinejoin="round" width="28" height="28">
              <polyline points="20 6 9 17 4 12"/>
            </svg>
          </div>
        </div>

        <h1 className="success-title">Payment Confirmed</h1>
        <p className="success-sub">
          {userId
            ? "Your enrollment is saved. Head to your dashboard to start your course."
            : "Your spot is secured. Create your student account below to unlock your course."}
        </p>

        {/* Steps tracker */}
        <div className="success-steps-track">
          <div className="steps-row">
            <div className="step-dot done">
              <svg viewBox="0 0 20 20" fill="currentColor" width="12" height="12">
                <path fillRule="evenodd" d="M16.707 5.293a1 1 0 010 1.414l-8 8a1 1 0 01-1.414 0l-4-4a1 1 0 011.414-1.414L8 12.586l7.293-7.293a1 1 0 011.414 0z" clipRule="evenodd"/>
              </svg>
            </div>
            <div className={`step-line ${userId ? "done" : ""}`} />
            <div className={`step-dot ${userId ? "done" : "active"}`}>
              {userId
                ? <svg viewBox="0 0 20 20" fill="currentColor" width="12" height="12"><path fillRule="evenodd" d="M16.707 5.293a1 1 0 010 1.414l-8 8a1 1 0 01-1.414 0l-4-4a1 1 0 011.414-1.414L8 12.586l7.293-7.293a1 1 0 011.414 0z" clipRule="evenodd"/></svg>
                : "2"}
            </div>
            <div className={`step-line ${userId ? "done" : ""}`} />
            <div className={`step-dot ${userId ? "active" : ""}`}>3</div>
          </div>
          <div className="steps-labels">
            <div className="step-label-block done">
              <span className="step-num">Step 1</span>
              <span className="step-name">Payment</span>
            </div>
            <div className="step-label-spacer" />
            <div className={`step-label-block ${userId ? "done" : "active"}`}>
              <span className="step-num">Step 2</span>
              <span className="step-name">Account</span>
            </div>
            <div className="step-label-spacer" />
            <div className={`step-label-block ${userId ? "active" : ""}`}>
              <span className="step-num">Step 3</span>
              <span className="step-name">Start course</span>
            </div>
          </div>
        </div>

        {/* CTA — changes based on auth state */}
        {userId ? (
          <Link href="/dashboard" className="success-cta">
            Go to my dashboard
            <svg viewBox="0 0 20 20" fill="currentColor" width="18" height="18">
              <path fillRule="evenodd" d="M10.293 3.293a1 1 0 011.414 0l6 6a1 1 0 010 1.414l-6 6a1 1 0 01-1.414-1.414L14.586 11H3a1 1 0 110-2h11.586l-4.293-4.293a1 1 0 010-1.414z" clipRule="evenodd"/>
            </svg>
          </Link>
        ) : (
          <>
            <Link href="/sign-up" className="success-cta">
              Create My Student Account
              <svg viewBox="0 0 20 20" fill="currentColor" width="18" height="18">
                <path fillRule="evenodd" d="M10.293 3.293a1 1 0 011.414 0l6 6a1 1 0 010 1.414l-6 6a1 1 0 01-1.414-1.414L14.586 11H3a1 1 0 110-2h11.586l-4.293-4.293a1 1 0 010-1.414z" clipRule="evenodd"/>
              </svg>
            </Link>

            <div className="success-divider">
              <span>Already have an account?</span>
            </div>

            <Link href="/sign-in" className="success-signin">
              Sign in — enrollment applies automatically
            </Link>
          </>
        )}

        <Link href="/" className="success-back">← Back to site</Link>
      </div>

      <style>{`
        * { box-sizing: border-box; margin: 0; padding: 0; }
        .success-page {
          min-height: 100vh;
          background: #f8fafc;
          display: flex;
          align-items: center;
          justify-content: center;
          padding: 2rem 1rem;
          font-family: "DM Sans", system-ui, sans-serif;
          position: relative;
          overflow: hidden;
        }
        .success-bg-circle {
          position: absolute;
          top: -200px; right: -200px;
          width: 600px; height: 600px;
          border-radius: 50%;
          background: radial-gradient(circle, #e0f2fe 0%, transparent 70%);
          pointer-events: none;
        }
        .success-container {
          background: #fff;
          border: 1px solid #e2e8f0;
          border-radius: 20px;
          padding: 3rem 2.5rem;
          max-width: 480px;
          width: 100%;
          text-align: center;
          box-shadow: 0 4px 24px rgba(0,0,0,.07);
          position: relative;
          z-index: 1;
          display: flex;
          flex-direction: column;
          align-items: center;
        }
        .success-logo {
          font-family: "Fraunces", serif;
          font-size: 1.1rem;
          font-weight: 700;
          color: #0f172a;
          text-decoration: none;
          letter-spacing: -.02em;
          margin-bottom: 2rem;
          display: block;
        }
        .success-logo span { color: #0c7ab8; }

        .success-icon-wrap {
          position: relative;
          width: 72px; height: 72px;
          margin-bottom: 1.5rem;
          display: flex;
          align-items: center;
          justify-content: center;
        }
        .success-icon-ring {
          position: absolute;
          inset: 0;
          border-radius: 50%;
          border: 2px solid #bbf7d0;
          animation: pulse-ring 2s ease-out infinite;
        }
        .success-icon {
          width: 60px; height: 60px;
          background: linear-gradient(135deg, #16a34a, #22c55e);
          border-radius: 50%;
          display: flex;
          align-items: center;
          justify-content: center;
          color: #fff;
          box-shadow: 0 4px 16px rgba(22,163,74,.3);
        }
        @keyframes pulse-ring {
          0% { transform: scale(1); opacity: 1; }
          80%, 100% { transform: scale(1.35); opacity: 0; }
        }

        .success-title {
          font-family: "Fraunces", serif;
          font-size: 1.65rem;
          font-weight: 700;
          color: #0f172a;
          letter-spacing: -.02em;
          margin-bottom: .6rem;
        }
        .success-sub {
          color: #64748b;
          font-size: .9rem;
          line-height: 1.65;
          max-width: 36ch;
          margin: 0 auto 2rem;
        }

        /* Steps */
        .success-steps-track {
          width: 100%;
          background: #f8fafc;
          border: 1px solid #e2e8f0;
          border-radius: 12px;
          padding: 1.25rem 1.5rem 1rem;
          margin-bottom: 2rem;
        }
        .steps-row {
          display: flex;
          align-items: center;
          width: 100%;
          margin-bottom: .65rem;
        }
        .step-dot {
          width: 32px; height: 32px;
          border-radius: 50%;
          background: #e2e8f0;
          color: #94a3b8;
          display: flex;
          align-items: center;
          justify-content: center;
          font-size: .78rem;
          font-weight: 700;
          flex-shrink: 0;
        }
        .step-dot.done { background: #dcfce7; color: #16a34a; }
        .step-dot.active {
          background: #0c7ab8;
          color: #fff;
          box-shadow: 0 0 0 4px rgba(12,122,184,.15);
        }
        .step-line {
          flex: 1;
          height: 2px;
          background: #e2e8f0;
          border-radius: 99px;
        }
        .step-line.done { background: #bbf7d0; }
        .steps-labels {
          display: flex;
          align-items: flex-start;
          width: 100%;
        }
        .step-label-block {
          width: 32px;
          flex-shrink: 0;
          display: flex;
          flex-direction: column;
          align-items: center;
          gap: .1rem;
        }
        .step-label-spacer { flex: 1; }
        .step-num {
          font-size: .6rem;
          color: #94a3b8;
          text-transform: uppercase;
          letter-spacing: .06em;
          font-weight: 600;
          white-space: nowrap;
        }
        .step-name {
          font-size: .75rem;
          font-weight: 600;
          color: #94a3b8;
          white-space: nowrap;
        }
        .step-label-block.done .step-name,
        .step-label-block.done .step-num { color: #16a34a; }
        .step-label-block.active .step-name,
        .step-label-block.active .step-num { color: #0c7ab8; }

        /* CTA */
        .success-cta {
          display: flex;
          align-items: center;
          justify-content: center;
          gap: .5rem;
          width: 100%;
          background: #0c7ab8;
          color: #fff;
          border-radius: 10px;
          padding: .95rem 1.5rem;
          font-weight: 700;
          font-size: .95rem;
          text-decoration: none;
          transition: background .15s, transform .1s, box-shadow .15s;
          box-shadow: 0 4px 14px rgba(12,122,184,.3);
          margin-bottom: 1.25rem;
        }
        .success-cta:hover {
          background: #085d8c;
          transform: translateY(-1px);
          box-shadow: 0 6px 20px rgba(12,122,184,.35);
        }
        .success-divider {
          display: flex;
          align-items: center;
          gap: .75rem;
          width: 100%;
          margin-bottom: .9rem;
        }
        .success-divider::before,
        .success-divider::after {
          content: "";
          flex: 1;
          height: 1px;
          background: #e2e8f0;
        }
        .success-divider span {
          font-size: .78rem;
          color: #94a3b8;
          white-space: nowrap;
          font-weight: 500;
        }
        .success-signin {
          display: block;
          width: 100%;
          border: 1px solid #e2e8f0;
          border-radius: 10px;
          padding: .8rem 1.5rem;
          font-size: .88rem;
          font-weight: 600;
          color: #374151;
          text-decoration: none;
          transition: border-color .15s, color .15s;
          margin-bottom: 1.5rem;
        }
        .success-signin:hover { border-color: #0c7ab8; color: #0c7ab8; }
        .success-back {
          display: inline-block;
          color: #94a3b8;
          font-size: .82rem;
          text-decoration: none;
          transition: color .15s;
        }
        .success-back:hover { color: #64748b; }

        @media (max-width: 500px) {
          .success-container { padding: 2rem 1.5rem; }
          .success-steps-track { padding: .9rem 1rem; }
          .step-name { font-size: .72rem; }
        }
      `}</style>
    </main>
  );
}
