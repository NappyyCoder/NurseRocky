import { SignUp } from "@clerk/nextjs";

export default function StudentSignUpPage() {
  return (
    <main className="auth-page">
      <div className="auth-brand">
        <a href="/" className="auth-logo">Nurse <span>Rocky</span></a>
        <p>Create Student Account</p>
      </div>
      <div className="auth-card">
        <SignUp
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
          background: linear-gradient(135deg, #f0f9ff 0%, #e0f2fe 60%, #bae6fd 100%);
          display: flex;
          flex-direction: column;
          align-items: center;
          justify-content: center;
          padding: 2rem 1rem;
          font-family: "DM Sans", system-ui, sans-serif;
        }
        .auth-brand {
          text-align: center;
          margin-bottom: 1.5rem;
        }
        .auth-logo {
          font-family: "Fraunces", serif;
          font-size: 1.75rem;
          font-weight: 700;
          color: #0c7ab8;
          text-decoration: none;
          letter-spacing: -.02em;
        }
        .auth-logo span { color: #0f172a; }
        .auth-brand p {
          font-size: .85rem;
          color: #64748b;
          margin-top: .25rem;
          font-weight: 500;
          text-transform: uppercase;
          letter-spacing: .06em;
        }
      `}</style>
    </main>
  );
}
