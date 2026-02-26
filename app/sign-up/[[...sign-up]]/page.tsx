import { SignUp } from "@clerk/nextjs";
import { auth } from "@clerk/nextjs/server";
import { redirect } from "next/navigation";

export default async function StudentSignUpPage() {
  const { userId } = await auth();
  if (userId) redirect("/dashboard");

  return (
    <main className="signup-page">
      {/* ── Left dark panel ── */}
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
        <div className="signup-form-inner">
          <div className="signup-form-header">
            <h2>Create your account</h2>
            <p>Already have one? <a href="/sign-in">Sign in</a></p>
          </div>
          <SignUp
            forceRedirectUrl="/dashboard"
            unsafeMetadata={{ source: "enrollment" }}
            appearance={{
              variables: {
                colorPrimary: "#0c7ab8",
                borderRadius: "8px",
                fontFamily: "DM Sans, system-ui, sans-serif",
              },
              elements: {
                rootBox: {
                  width: "100%",
                  display: "block",
                },
                card: {
                  boxShadow: "none",
                  border: "none",
                  padding: "0",
                  margin: "0",
                  width: "100%",
                  maxWidth: "100%",
                  backgroundColor: "transparent",
                },
                headerTitle: { display: "none" },
                headerSubtitle: { display: "none" },
                main: { width: "100%" },
                form: { width: "100%" },
                socialButtonsBlockButton: {
                  border: "1px solid #e2e8f0",
                  borderRadius: "8px",
                  backgroundColor: "#fff",
                  fontSize: ".875rem",
                  padding: ".6rem 1rem",
                  height: "42px",
                },
                formFieldLabel: {
                  fontSize: ".85rem",
                  fontWeight: "600",
                  color: "#374151",
                  marginBottom: ".35rem",
                  display: "block",
                },
                formFieldRow: {
                  marginBottom: ".85rem",
                },
                formFieldInput: {
                  borderRadius: "8px",
                  border: "1px solid #d1d5db",
                  fontSize: ".9rem",
                  backgroundColor: "#fff",
                  width: "100%",
                  padding: ".65rem .85rem",
                  height: "42px",
                  lineHeight: "1.5",
                },
                formFieldInputShowPasswordButton: {
                  padding: "0 .75rem",
                },
                formButtonPrimary: {
                  backgroundColor: "#0c7ab8",
                  borderRadius: "8px",
                  fontSize: ".9rem",
                  fontWeight: "700",
                  width: "100%",
                  padding: ".75rem 1rem",
                  height: "44px",
                },
                footerAction: { display: "none" },
                dividerLine: { backgroundColor: "#e2e8f0" },
                dividerText: { color: "#94a3b8", fontSize: ".8rem" },
              },
            }}
          />
        </div>
      </div>

      <style>{`
        *, *::before, *::after { box-sizing: border-box; margin: 0; padding: 0; }

        .signup-page {
          min-height: 100vh;
          display: grid;
          grid-template-columns: 1fr 1fr;
          font-family: "DM Sans", system-ui, sans-serif;
        }

        /* Dark left panel */
        .signup-left {
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
          width: 300px; height: 300px;
          border-radius: 50%;
          background: rgba(12,122,184,.2);
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
          max-width: 34ch;
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

        /* Right form panel */
        .signup-right {
          background: #f8fafc;
          overflow-y: auto;
          display: flex;
          align-items: flex-start;
          justify-content: center;
          padding: 3rem 2rem;
        }
        .signup-form-inner {
          width: 100%;
          max-width: 440px;
          padding-top: 1rem;
        }
        .signup-form-header {
          margin-bottom: 1.75rem;
        }
        .signup-form-header h2 {
          font-family: "Fraunces", serif;
          font-size: 1.5rem;
          font-weight: 700;
          color: #0f172a;
          letter-spacing: -.02em;
          margin-bottom: .3rem;
        }
        .signup-form-header p {
          font-size: .85rem;
          color: #64748b;
        }
        .signup-form-header a {
          color: #0c7ab8;
          font-weight: 600;
          text-decoration: none;
        }
        .signup-form-header a:hover { text-decoration: underline; }

        /* Responsive */
        @media (max-width: 860px) {
          .signup-page { grid-template-columns: 1fr; }
          .signup-left {
            position: static;
            height: auto;
            padding: 2.5rem 1.75rem;
          }
          .signup-right { padding: 2rem 1.5rem; }
          .signup-form-inner { max-width: 100%; padding-top: 0; }
        }
      `}</style>
    </main>
  );
}
