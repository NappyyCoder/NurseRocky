import { SignIn } from "@clerk/nextjs";
import { auth } from "@clerk/nextjs/server";
import { redirect } from "next/navigation";

export default async function StudentSignInPage() {
  const { userId } = await auth();

  // Already signed in — go straight to dashboard
  if (userId) redirect("/dashboard");

  return (
    <main className="signin-page">
      <div className="signin-left">
        <a href="/" className="signin-logo">Nurse <span>Rocky</span></a>
        <h1 className="signin-headline">Welcome back.</h1>
        <p className="signin-desc">
          Sign in to continue your CNA certification. Your progress is saved and ready to pick up where you left off.
        </p>
        <div className="signin-badge">
          <svg viewBox="0 0 20 20" fill="currentColor" width="14" height="14">
            <path fillRule="evenodd" d="M5 9V7a5 5 0 0110 0v2a2 2 0 012 2v5a2 2 0 01-2 2H5a2 2 0 01-2-2v-5a2 2 0 012-2zm8-2v2H7V7a3 3 0 016 0z" clipRule="evenodd"/>
          </svg>
          Student Portal
        </div>
      </div>

      <div className="signin-right">
        <div className="signin-form-wrap">
        <div className="signin-card-header">
          <h2>Sign in to your account</h2>
          <p>New student? <a href="/enroll">Enroll first</a></p>
        </div>
        <SignIn
          forceRedirectUrl="/dashboard"
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
      </div>

      <style>{`
        * { box-sizing: border-box; margin: 0; padding: 0; }
        .signin-page {
          min-height: 100vh;
          display: grid;
          grid-template-columns: 5fr 6fr;
          font-family: "DM Sans", system-ui, sans-serif;
        }
        .signin-left {
          background: linear-gradient(160deg, #0f172a 0%, #0c7ab8 100%);
          padding: 3.5rem;
          display: flex;
          flex-direction: column;
          justify-content: center;
          position: relative;
          overflow: hidden;
          min-width: 0;
        }
        .signin-left::before {
          content: "";
          position: absolute;
          top: -100px; right: -100px;
          width: 400px; height: 400px;
          border-radius: 50%;
          background: rgba(255,255,255,.04);
          pointer-events: none;
        }
        .signin-logo {
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
        .signin-logo span { color: #fff; }
        .signin-headline {
          font-family: "Fraunces", serif;
          font-size: clamp(1.75rem, 2.5vw, 2.5rem);
          font-weight: 700;
          color: #fff;
          letter-spacing: -.02em;
          line-height: 1.2;
          margin-bottom: 1rem;
          position: relative;
        }
        .signin-desc {
          color: rgba(255,255,255,.7);
          font-size: .95rem;
          line-height: 1.7;
          margin-bottom: 2.5rem;
          max-width: 36ch;
          position: relative;
        }
        .signin-badge {
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
        .signin-right {
          background: #f8fafc;
          display: flex;
          flex-direction: column;
          justify-content: center;
          padding: 3rem 2.5rem;
          min-width: 0;
          overflow-y: auto;
        }
        .signin-form-wrap {
          width: 100%;
          max-width: 420px;
          margin: 0 auto;
        }
        .signin-card-header {
          margin-bottom: 1.75rem;
        }
        .signin-card-header h2 {
          font-family: "Fraunces", serif;
          font-size: 1.5rem;
          font-weight: 700;
          color: #0f172a;
          letter-spacing: -.02em;
          margin-bottom: .35rem;
        }
        .signin-card-header p {
          font-size: .875rem;
          color: #64748b;
        }
        .signin-card-header a {
          color: #0c7ab8;
          font-weight: 600;
          text-decoration: none;
        }
        .signin-card-header a:hover { text-decoration: underline; }
        @media (max-width: 768px) {
          .signin-page { grid-template-columns: 1fr; }
          .signin-left { padding: 2.5rem 1.5rem; }
          .signin-right { padding: 2rem 1.5rem; }
          .signin-logo { margin-bottom: 1.75rem; }
        }
      `}</style>
    </main>
  );
}
