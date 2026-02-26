import { SignUp } from "@clerk/nextjs";
import { auth } from "@clerk/nextjs/server";
import { redirect } from "next/navigation";

export default async function StudentSignUpPage() {
  const { userId } = await auth();
  if (userId) redirect("/dashboard");

  return (
    <main className="signup-page">

      {/* Background blobs */}
      <div className="blob blob-1" />
      <div className="blob blob-2" />

      <div className="signup-wrapper">

        {/* Top branding */}
        <div className="signup-top">
          <a href="/" className="signup-logo">Nurse <span>Rocky</span></a>
          <h1 className="signup-headline">Create your student account</h1>
          <p className="signup-sub">
            Your payment is confirmed. Set up your account to unlock your course.
          </p>
        </div>

        {/* Perks row */}
        <div className="signup-perks">
          {[
            { icon: "📚", label: "6 online modules" },
            { icon: "📝", label: "Exam quizzes" },
            { icon: "🏥", label: "Clinical tracking" },
            { icon: "🎓", label: "Career support" },
          ].map(p => (
            <div key={p.label} className="perk-item">
              <span className="perk-icon">{p.icon}</span>
              <span>{p.label}</span>
            </div>
          ))}
        </div>

        {/* Clerk form — centered with plenty of space */}
        <div className="signup-form-box">
          <p className="form-label">Already have an account? <a href="/sign-in">Sign in</a></p>
          <SignUp
            forceRedirectUrl="/dashboard"
            unsafeMetadata={{ source: "enrollment" }}
            appearance={{
              elements: {
                rootBox: {
                  width: "100%",
                },
                card: {
                  boxShadow: "none",
                  border: "none",
                  padding: "0",
                  width: "100%",
                  margin: "0",
                  backgroundColor: "transparent",
                },
                headerTitle: { display: "none" },
                headerSubtitle: { display: "none" },
                socialButtonsBlockButton: {
                  border: "1px solid #e2e8f0",
                  borderRadius: "8px",
                  backgroundColor: "#fff",
                  fontSize: ".875rem",
                  fontWeight: "500",
                },
                formFieldLabel: {
                  fontSize: ".85rem",
                  fontWeight: "600",
                  color: "#374151",
                },
                formFieldInput: {
                  borderRadius: "8px",
                  border: "1px solid #e2e8f0",
                  fontSize: ".9rem",
                  padding: ".65rem .85rem",
                  backgroundColor: "#fff",
                },
                formButtonPrimary: {
                  background: "#0c7ab8",
                  borderRadius: "8px",
                  fontSize: ".9rem",
                  fontWeight: "700",
                  padding: ".75rem",
                },
                footerAction: { display: "none" },
                dividerLine: { backgroundColor: "#e2e8f0" },
                dividerText: { color: "#94a3b8", fontSize: ".8rem" },
              },
            }}
          />
        </div>

        <a href="/" className="signup-back">← Back to site</a>
      </div>

      <style>{`
        *, *::before, *::after { box-sizing: border-box; margin: 0; padding: 0; }

        .signup-page {
          min-height: 100vh;
          background: #f0f9ff;
          display: flex;
          align-items: center;
          justify-content: center;
          padding: 2rem 1rem;
          font-family: "DM Sans", system-ui, sans-serif;
          position: relative;
          overflow: hidden;
        }
        .blob {
          position: absolute;
          border-radius: 50%;
          pointer-events: none;
          filter: blur(60px);
          opacity: .4;
        }
        .blob-1 {
          width: 500px; height: 500px;
          background: #bae6fd;
          top: -150px; right: -100px;
        }
        .blob-2 {
          width: 400px; height: 400px;
          background: #c7d2fe;
          bottom: -100px; left: -100px;
        }

        .signup-wrapper {
          position: relative;
          z-index: 1;
          width: 100%;
          max-width: 520px;
          display: flex;
          flex-direction: column;
          align-items: center;
          gap: 1.5rem;
        }

        /* Branding */
        .signup-top { text-align: center; }
        .signup-logo {
          font-family: "Fraunces", serif;
          font-size: 1.3rem;
          font-weight: 700;
          color: #0f172a;
          text-decoration: none;
          letter-spacing: -.02em;
          display: block;
          margin-bottom: 1rem;
        }
        .signup-logo span { color: #0c7ab8; }
        .signup-headline {
          font-family: "Fraunces", serif;
          font-size: 1.6rem;
          font-weight: 700;
          color: #0f172a;
          letter-spacing: -.02em;
          margin-bottom: .4rem;
        }
        .signup-sub {
          color: #64748b;
          font-size: .9rem;
          line-height: 1.5;
        }

        /* Perks */
        .signup-perks {
          display: flex;
          gap: .5rem;
          flex-wrap: wrap;
          justify-content: center;
        }
        .perk-item {
          display: flex;
          align-items: center;
          gap: .4rem;
          background: #fff;
          border: 1px solid #e0f2fe;
          border-radius: 99px;
          padding: .3rem .85rem;
          font-size: .8rem;
          color: #374151;
          font-weight: 500;
          white-space: nowrap;
        }
        .perk-icon { font-size: .85rem; }

        /* Form box */
        .signup-form-box {
          background: #fff;
          border: 1px solid #e2e8f0;
          border-radius: 16px;
          padding: 2rem;
          width: 100%;
          box-shadow: 0 4px 24px rgba(0,0,0,.07);
        }
        .form-label {
          font-size: .85rem;
          color: #64748b;
          margin-bottom: 1.25rem;
          text-align: center;
        }
        .form-label a {
          color: #0c7ab8;
          font-weight: 600;
          text-decoration: none;
        }
        .form-label a:hover { text-decoration: underline; }

        .signup-back {
          color: #94a3b8;
          font-size: .82rem;
          text-decoration: none;
        }
        .signup-back:hover { color: #64748b; }

        @media (max-width: 560px) {
          .signup-form-box { padding: 1.5rem 1.25rem; }
          .signup-headline { font-size: 1.35rem; }
          .signup-perks { gap: .4rem; }
        }
      `}</style>
    </main>
  );
}
