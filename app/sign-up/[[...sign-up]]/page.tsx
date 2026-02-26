import { SignUp } from "@clerk/nextjs";
import { auth } from "@clerk/nextjs/server";
import { redirect } from "next/navigation";

export default async function StudentSignUpPage() {
  const { userId } = await auth();

  // Already signed in — go straight to dashboard
  if (userId) redirect("/dashboard");

  return (
    <main className="signup-page">
      <div className="signup-left">
        <a href="/" className="signup-logo">Nurse <span>Rocky</span></a>
        <h1 className="signup-headline">Your CNA journey starts here.</h1>
        <p className="signup-desc">
          Create your student account to unlock your course, track your progress,
          and complete your certification in 30–45 days.
        </p>
        <ul className="signup-perks">
          {[
            "Instant access to all 6 modules",
            "State exam quizzes included",
            "Clinical hours tracking",
            "Career support after graduation",
          ].map(p => (
            <li key={p}>
              <svg viewBox="0 0 20 20" fill="currentColor" width="16" height="16">
                <path fillRule="evenodd" d="M16.707 5.293a1 1 0 010 1.414l-8 8a1 1 0 01-1.414 0l-4-4a1 1 0 011.414-1.414L8 12.586l7.293-7.293a1 1 0 011.414 0z" clipRule="evenodd"/>
              </svg>
              {p}
            </li>
          ))}
        </ul>
        <div className="signup-badge">
          <svg viewBox="0 0 20 20" fill="currentColor" width="14" height="14">
            <path fillRule="evenodd" d="M5 9V7a5 5 0 0110 0v2a2 2 0 012 2v5a2 2 0 01-2 2H5a2 2 0 01-2-2v-5a2 2 0 012-2zm8-2v2H7V7a3 3 0 016 0z" clipRule="evenodd"/>
          </svg>
          Your payment is confirmed. This account is free.
        </div>
      </div>

      <div className="signup-right">
        <div className="signup-card-header">
          <h2>Create your account</h2>
          <p>Already have one? <a href="/sign-in">Sign in</a></p>
        </div>
        <SignUp
          forceRedirectUrl="/dashboard"
          unsafeMetadata={{ source: "enrollment" }}
          appearance={{
            elements: {
              rootBox: { width: "100%" },
              card: {
                boxShadow: "none",
                padding: "0",
                border: "none",
                width: "100%",
              },
              headerTitle: { display: "none" },
              headerSubtitle: { display: "none" },
              socialButtonsBlockButton: {
                border: "1px solid #e2e8f0",
                borderRadius: "8px",
                fontSize: ".875rem",
              },
              formFieldInput: {
                borderRadius: "8px",
                border: "1px solid #e2e8f0",
                fontSize: ".9rem",
              },
              formButtonPrimary: {
                background: "#0c7ab8",
                borderRadius: "8px",
                fontSize: ".9rem",
                fontWeight: "700",
              },
              footerAction: { display: "none" },
            },
          }}
        />
      </div>

      <style>{`
        * { box-sizing: border-box; margin: 0; padding: 0; }
        .signup-page {
          min-height: 100vh;
          display: grid;
          grid-template-columns: 1fr 1fr;
          font-family: "DM Sans", system-ui, sans-serif;
        }

        /* Left panel */
        .signup-left {
          background: linear-gradient(160deg, #0f172a 0%, #0c7ab8 100%);
          padding: 3.5rem;
          display: flex;
          flex-direction: column;
          justify-content: center;
          position: relative;
          overflow: hidden;
        }
        .signup-left::before {
          content: "";
          position: absolute;
          top: -100px; right: -100px;
          width: 400px; height: 400px;
          border-radius: 50%;
          background: rgba(255,255,255,.04);
          pointer-events: none;
        }
        .signup-logo {
          font-family: "Fraunces", serif;
          font-size: 1.3rem;
          font-weight: 700;
          color: #bae6fd;
          text-decoration: none;
          letter-spacing: -.02em;
          margin-bottom: 3rem;
          display: block;
          position: relative;
        }
        .signup-logo span { color: #fff; }
        .signup-headline {
          font-family: "Fraunces", serif;
          font-size: clamp(1.6rem, 2.5vw, 2.2rem);
          font-weight: 700;
          color: #fff;
          letter-spacing: -.02em;
          line-height: 1.2;
          margin-bottom: 1rem;
          position: relative;
        }
        .signup-desc {
          color: rgba(255,255,255,.7);
          font-size: .95rem;
          line-height: 1.7;
          margin-bottom: 2rem;
          max-width: 38ch;
          position: relative;
        }
        .signup-perks {
          list-style: none;
          display: flex;
          flex-direction: column;
          gap: .75rem;
          margin-bottom: 2.5rem;
          position: relative;
        }
        .signup-perks li {
          display: flex;
          align-items: center;
          gap: .65rem;
          color: rgba(255,255,255,.88);
          font-size: .9rem;
        }
        .signup-perks svg { color: #4ade80; flex-shrink: 0; }
        .signup-badge {
          display: inline-flex;
          align-items: center;
          gap: .5rem;
          background: rgba(255,255,255,.1);
          border: 1px solid rgba(255,255,255,.15);
          border-radius: 99px;
          padding: .45rem .9rem;
          font-size: .78rem;
          color: #bae6fd;
          font-weight: 500;
          position: relative;
        }

        /* Right panel */
        .signup-right {
          background: #f8fafc;
          display: flex;
          flex-direction: column;
          justify-content: center;
          padding: 3.5rem;
        }
        .signup-card-header {
          margin-bottom: 1.75rem;
        }
        .signup-card-header h2 {
          font-family: "Fraunces", serif;
          font-size: 1.5rem;
          font-weight: 700;
          color: #0f172a;
          letter-spacing: -.02em;
          margin-bottom: .35rem;
        }
        .signup-card-header p {
          font-size: .875rem;
          color: #64748b;
        }
        .signup-card-header a {
          color: #0c7ab8;
          font-weight: 600;
          text-decoration: none;
        }
        .signup-card-header a:hover { text-decoration: underline; }

        /* Responsive */
        @media (max-width: 768px) {
          .signup-page { grid-template-columns: 1fr; }
          .signup-left { padding: 2.5rem 1.5rem; }
          .signup-right { padding: 2rem 1.5rem; }
          .signup-logo { margin-bottom: 1.75rem; }
          .signup-headline { font-size: 1.5rem; }
        }
      `}</style>
    </main>
  );
}
