import { SignIn } from "@clerk/nextjs";
import { auth } from "@clerk/nextjs/server";
import { redirect } from "next/navigation";

export default async function StudentSignInPage() {
  const { userId } = await auth();
  if (userId) redirect("/dashboard");

  return (
    <main className="signin-page">

      {/* ── Dark left panel ── */}
      <div className="signin-left">
        <a href="/" className="signin-logo">Nurse <span>Rocky</span></a>
        <h1 className="signin-headline">Welcome back.</h1>
        <p className="signin-desc">
          Sign in to continue your CNA certification. Your progress is saved
          and ready to pick up where you left off.
        </p>
        <div className="signin-badge">
          <svg viewBox="0 0 20 20" fill="currentColor" width="14" height="14">
            <path fillRule="evenodd" d="M5 9V7a5 5 0 0110 0v2a2 2 0 012 2v5a2 2 0 01-2 2H5a2 2 0 01-2-2v-5a2 2 0 012-2zm8-2v2H7V7a3 3 0 016 0z" clipRule="evenodd"/>
          </svg>
          Student Portal
        </div>
      </div>

      {/* ── Right form panel ── */}
      <div className="signin-right">
        <p className="signin-switch">New student? <a href="/enroll">Enroll first</a></p>
        <SignIn
          forceRedirectUrl="/dashboard"
          afterSignInUrl="/dashboard"
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

        .signin-page {
          min-height: 100vh;
          display: flex;
          font-family: "DM Sans", system-ui, sans-serif;
        }

        /* Left panel */
        .signin-left {
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
        .signin-left::after {
          content: "";
          position: absolute;
          bottom: -80px; right: -80px;
          width: 320px; height: 320px;
          border-radius: 50%;
          background: rgba(12,122,184,.18);
          pointer-events: none;
        }
        .signin-logo {
          font-family: "Fraunces", serif;
          font-size: 1.3rem;
          font-weight: 700;
          color: #bae6fd;
          text-decoration: none;
          letter-spacing: -.02em;
          margin-bottom: 2.5rem;
          display: block;
        }
        .signin-logo span { color: #fff; }
        .signin-headline {
          font-family: "Fraunces", serif;
          font-size: 2.2rem;
          font-weight: 700;
          color: #fff;
          letter-spacing: -.02em;
          line-height: 1.2;
          margin-bottom: .9rem;
        }
        .signin-desc {
          color: rgba(255,255,255,.65);
          font-size: .9rem;
          line-height: 1.7;
          margin-bottom: 2.5rem;
        }
        .signin-badge {
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

        /* Right panel — centers Clerk's natural card */
        .signin-right {
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
        .signin-switch {
          font-size: .875rem;
          color: #64748b;
          text-align: center;
        }
        .signin-switch a {
          color: #0c7ab8;
          font-weight: 600;
          text-decoration: none;
        }
        .signin-switch a:hover { text-decoration: underline; }

        /* Responsive */
        @media (max-width: 860px) {
          .signin-page { flex-direction: column; }
          .signin-left {
            width: 100%;
            position: static;
            height: auto;
            padding: 2.5rem 1.75rem;
          }
          .signin-right { padding: 2rem 1rem; }
        }
      `}</style>
    </main>
  );
}
