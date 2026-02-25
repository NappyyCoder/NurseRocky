import { SignIn } from "@clerk/nextjs";

export default function AdminSignInPage() {
  return (
    <main className="auth-page admin">
      <div className="auth-brand">
        <a href="/" className="auth-logo">Nurse <span>Rocky</span></a>
        <p className="admin-badge">Administrator Access</p>
      </div>
      <div className="auth-card">
        <SignIn
          fallbackRedirectUrl="/admin/dashboard"
          appearance={{
            elements: {
              rootBox: "clerk-root",
              card: "clerk-card",
            },
          }}
        />
      </div>
      <style>{`
        .auth-page {
          min-height: 100vh;
          display: flex;
          flex-direction: column;
          align-items: center;
          justify-content: center;
          padding: 2rem 1rem;
          font-family: "DM Sans", system-ui, sans-serif;
        }
        .auth-page.admin {
          background: linear-gradient(135deg, #0f172a 0%, #1e293b 60%, #0c7ab8 100%);
        }
        .auth-brand {
          text-align: center;
          margin-bottom: 1.5rem;
        }
        .auth-logo {
          font-family: "Fraunces", serif;
          font-size: 1.75rem;
          font-weight: 700;
          color: #bae6fd;
          text-decoration: none;
          letter-spacing: -.02em;
        }
        .auth-logo span { color: #ffffff; }
        .admin-badge {
          display: inline-block;
          font-size: .75rem;
          color: #bae6fd;
          margin-top: .4rem;
          font-weight: 600;
          text-transform: uppercase;
          letter-spacing: .1em;
          border: 1px solid rgba(186,230,253,.3);
          padding: .2rem .75rem;
          border-radius: 99px;
        }
      `}</style>
    </main>
  );
}
