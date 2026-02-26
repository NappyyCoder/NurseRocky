import { SignUp } from "@clerk/nextjs";
import { auth } from "@clerk/nextjs/server";
import { redirect } from "next/navigation";

export default async function StudentSignUpPage() {
  const { userId } = await auth();
  if (userId) redirect("/dashboard");

  return (
    <main className="signup-page">

      {/* ── Dark left panel ── */}
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
          Payment confirmed — this account is free.
        </div>
      </div>

      {/* ── Right form panel ── */}
      <div className="signup-right">
        <p className="signup-switch">Already have one? <a href="/sign-in">Sign in</a></p>
          <SignUp
            forceRedirectUrl="/dashboard"
            afterSignUpUrl="/dashboard"
            unsafeMetadata={{ source: "enrollment" }}
          appearance={{
            variables: {
              colorPrimary: "#0c7ab8",
              borderRadius: "8px",
              fontFamily: "DM Sans, system-ui, sans-serif",
              fontSize: "15px",
            },
            elements: {
              headerTitle: { display: "none" },
              headerSubtitle: { display: "none" },
              card: { boxShadow: "0 4px 24px rgba(0,0,0,.08)", borderRadius: "12px" },
              formButtonPrimary: { backgroundColor: "#0c7ab8", fontWeight: "700" },
              footerAction: { display: "none" },
            },
          }}
        />
      </div>

      <style>{`
        *, *::before, *::after { box-sizing: border-box; margin: 0; padding: 0; }

        .signup-page {
          min-height: 100vh;
          display: flex;
          font-family: "DM Sans", system-ui, sans-serif;
        }

        /* Left panel — fixed 45% */
        .signup-left {
          width: 45%;
          flex-shrink: 0;
          background: linear-gradient(160deg, #0f172a 0%, #0c4a6e 100%);
          padding: 3.5rem 3rem;
          display: flex;
          flex-direction: column;
          justify-content: center;
          position: sticky;
          top: 0;
          height: 100vh;
          overflow: hidden;
        }
        .signup-left::after {
          content: "";
          position: absolute;
          bottom: -80px; right: -80px;
          width: 320px; height: 320px;
          border-radius: 50%;
          background: rgba(12,122,184,.18);
          pointer-events: none;
        }
        .signup-logo {
          font-family: "Fraunces", serif;
          font-size: 1.3rem;
          font-weight: 700;
          color: #bae6fd;
          text-decoration: none;
          letter-spacing: -.02em;
          margin-bottom: 2.5rem;
          display: block;
        }
        .signup-logo span { color: #fff; }
        .signup-headline {
          font-family: "Fraunces", serif;
          font-size: 1.85rem;
          font-weight: 700;
          color: #fff;
          letter-spacing: -.02em;
          line-height: 1.25;
          margin-bottom: .9rem;
        }
        .signup-desc {
          color: rgba(255,255,255,.65);
          font-size: .9rem;
          line-height: 1.7;
          margin-bottom: 2rem;
        }
        .signup-perks {
          list-style: none;
          display: flex;
          flex-direction: column;
          gap: .7rem;
          margin-bottom: 2.5rem;
        }
        .signup-perks li {
          display: flex;
          align-items: center;
          gap: .6rem;
          color: rgba(255,255,255,.85);
          font-size: .875rem;
        }
        .signup-perks svg { color: #4ade80; flex-shrink: 0; }
        .signup-badge {
          display: inline-flex;
          align-items: center;
          gap: .45rem;
          background: rgba(255,255,255,.08);
          border: 1px solid rgba(255,255,255,.15);
          border-radius: 99px;
          padding: .4rem .85rem;
          font-size: .775rem;
          color: #bae6fd;
          font-weight: 500;
        }

        /* Right panel — takes the rest, centers the Clerk form */
        .signup-right {
          flex: 1;
          background: #f1f5f9;
          display: flex;
          flex-direction: column;
          align-items: center;
          justify-content: center;
          padding: 3rem 2rem;
          overflow-y: auto;
          gap: 1.25rem;
        }
        .signup-switch {
          font-size: .875rem;
          color: #64748b;
          text-align: center;
        }
        .signup-switch a {
          color: #0c7ab8;
          font-weight: 600;
          text-decoration: none;
        }
        .signup-switch a:hover { text-decoration: underline; }

        /* ── Tablet (≤ 860px) — stack panels */
        @media (max-width: 860px) {
          .signup-page { flex-direction: column; }
          .signup-left {
            width: 100%;
            position: static;
            height: auto;
            padding: 2.5rem 1.75rem;
          }
          .signup-right { padding: 2rem 1.25rem; }
        }

        /* ── Mobile (≤ 640px) — compact left panel */
        @media (max-width: 640px) {
          .signup-left { padding: 1.75rem 1.25rem; }
          .signup-logo { margin-bottom: 1rem; font-size: 1.1rem; }
          .signup-headline { font-size: 1.4rem; margin-bottom: .5rem; }
          .signup-desc { font-size: .825rem; margin-bottom: 1.25rem; }
          .signup-perks { display: none; }
          .signup-badge { font-size: .72rem; }
          .signup-right { padding: 1.75rem 1rem; }
        }

        /* ── Small mobile (≤ 400px) */
        @media (max-width: 400px) {
          .signup-left { padding: 1.25rem 1rem; }
          .signup-right { padding: 1.25rem .75rem; }
        }
      `}</style>
    </main>
  );
}
