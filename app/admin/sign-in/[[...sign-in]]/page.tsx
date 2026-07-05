import { SignIn } from "@clerk/nextjs";
import { auth } from "@clerk/nextjs/server";
import { redirect } from "next/navigation";
import { clerkIsAdmin } from "@/lib/clerk-admin";

export default async function AdminSignInPage() {
  const { userId, sessionClaims } = await auth();

  // Already signed in as admin — go straight to dashboard
  if (userId && clerkIsAdmin(sessionClaims)) {
    redirect("/admin/dashboard");
  }

  return (
    <main className="auth-page admin">
      <div className="auth-brand">
        <a href="/" className="auth-logo">Nurse <span>Rocky</span></a>
        <p className="admin-badge">Administrator Access</p>
      </div>

      {userId ? (
        // Signed in but NOT an admin — show a clear message
        <div className="already-card">
          <p className="already-text">
            You&apos;re currently signed in, but this account does not have admin access.
          </p>
          <p className="already-sub">
            Sign out and sign back in with your admin account. Or use a separate
            browser / incognito window to stay logged into both accounts at once.
          </p>
          <a href="/sign-out?redirect=/admin/sign-in" className="signout-btn">
            Sign out and switch account
          </a>
          <a href="/" className="back-link">← Back to site</a>
        </div>
      ) : (
        <div className="auth-card">
          <SignIn fallbackRedirectUrl="/admin/dashboard" />
        </div>
      )}

      <style>{`
        .auth-page {
          min-height: 100vh;
          display: flex;
          flex-direction: column;
          align-items: center;
          justify-content: center;
          padding: 2rem 1rem;
          font-family: "DM Sans", system-ui, sans-serif;
          background: linear-gradient(135deg, #0f172a 0%, #1e293b 60%, #93b7a9 100%);
        }
        .auth-brand { text-align: center; margin-bottom: 1.5rem; }
        .auth-logo {
          font-family: "Fraunces", serif;
          font-size: 1.75rem;
          font-weight: 700;
          color: #c3d9d2;
          text-decoration: none;
          letter-spacing: -.02em;
        }
        .auth-logo span { color: #fff; }
        .admin-badge {
          display: inline-block;
          font-size: .75rem;
          color: #c3d9d2;
          margin-top: .4rem;
          font-weight: 600;
          text-transform: uppercase;
          letter-spacing: .1em;
          border: 1px solid rgba(186,230,253,.3);
          padding: .2rem .75rem;
          border-radius: 99px;
        }
        .auth-card { width: 100%; max-width: 420px; }
        .already-card {
          background: rgba(255,255,255,.08);
          border: 1px solid rgba(255,255,255,.15);
          border-radius: 12px;
          padding: 2rem;
          max-width: 420px;
          width: 100%;
          text-align: center;
          color: #e2e8f0;
        }
        .already-text { font-size: .95rem; margin-bottom: .5rem; line-height: 1.5; }
        .already-text strong { color: #c3d9d2; }
        .already-sub { font-size: .85rem; color: #94a3b8; margin-bottom: 1.5rem; line-height: 1.5; }
        .signout-btn {
          display: block;
          background: linear-gradient(180deg, #c0d9d2 0%, #93b7a9 100%);
          color: #fff;
          border: none;
          border-radius: 8px;
          padding: .75rem 1.5rem;
          font-size: .9rem;
          font-weight: 600;
          cursor: pointer;
          text-decoration: none;
          margin-bottom: .75rem;
          transition: background .15s;
        }
        .signout-btn:hover { background: linear-gradient(180deg, #aaccc4 0%, #7aab9b 100%); }
        .back-link { display: block; color: #c3d9d2; font-size: .85rem; text-decoration: none; opacity: .8; }
        .back-link:hover { opacity: 1; }
      `}</style>
    </main>
  );
}
