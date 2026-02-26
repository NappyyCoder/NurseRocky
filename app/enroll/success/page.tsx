import Link from "next/link";

export default function EnrollSuccessPage() {
  return (
    <main className="success-page">
      <div className="success-container">

        {/* Check mark */}
        <div className="success-icon">
          <svg viewBox="0 0 24 24" fill="none" stroke="currentColor" strokeWidth="2.5" strokeLinecap="round" strokeLinejoin="round">
            <polyline points="20 6 9 17 4 12"/>
          </svg>
        </div>

        <h1 className="success-title">Payment Confirmed!</h1>
        <p className="success-sub">
          Your spot in the Nurse Rocky CNA program is secured.
          Now create your student account to access your course.
        </p>

        {/* Steps */}
        <div className="success-steps">
          <div className="success-step done">
            <div className="step-circle done">
              <svg viewBox="0 0 20 20" fill="currentColor" width="14" height="14"><path fillRule="evenodd" d="M16.707 5.293a1 1 0 010 1.414l-8 8a1 1 0 01-1.414 0l-4-4a1 1 0 011.414-1.414L8 12.586l7.293-7.293a1 1 0 011.414 0z" clipRule="evenodd"/></svg>
            </div>
            <div className="step-text">
              <div className="step-label">Step 1</div>
              <div className="step-name">Payment complete</div>
            </div>
          </div>
          <div className="step-connector" />
          <div className="success-step active">
            <div className="step-circle active">2</div>
            <div className="step-text">
              <div className="step-label">Step 2</div>
              <div className="step-name">Create your account</div>
            </div>
          </div>
          <div className="step-connector" />
          <div className="success-step">
            <div className="step-circle">3</div>
            <div className="step-text">
              <div className="step-label">Step 3</div>
              <div className="step-name">Start your course</div>
            </div>
          </div>
        </div>

        <Link href="/sign-up" className="success-cta">
          Create My Student Account →
        </Link>

        <p className="success-note">
          Already have an account?{" "}
          <Link href="/sign-in" className="success-link">Sign in here</Link>
          {" "}and your enrollment will be applied automatically.
        </p>

        <Link href="/" className="success-back">← Back to site</Link>
      </div>

      <style>{`
        .success-page {
          min-height: 100vh;
          background: linear-gradient(135deg, #f0fdf4 0%, #dcfce7 60%, #e0f2fe 100%);
          display: flex;
          align-items: center;
          justify-content: center;
          padding: 2rem 1rem;
          font-family: "DM Sans", system-ui, sans-serif;
        }
        .success-container {
          background: #fff;
          border-radius: 20px;
          padding: 3rem 2.5rem;
          max-width: 500px;
          width: 100%;
          text-align: center;
          box-shadow: 0 4px 32px rgba(0,0,0,.1);
        }
        .success-icon {
          width: 64px;
          height: 64px;
          background: #dcfce7;
          border-radius: 50%;
          display: flex;
          align-items: center;
          justify-content: center;
          margin: 0 auto 1.5rem;
          color: #16a34a;
        }
        .success-icon svg { width: 32px; height: 32px; }
        .success-title {
          font-family: "Fraunces", serif;
          font-size: 1.75rem;
          font-weight: 700;
          color: #0f172a;
          letter-spacing: -.02em;
          margin-bottom: .75rem;
        }
        .success-sub {
          color: #64748b;
          font-size: .95rem;
          line-height: 1.6;
          margin-bottom: 2rem;
        }

        /* Steps */
        .success-steps {
          display: flex;
          align-items: center;
          justify-content: center;
          gap: 0;
          margin-bottom: 2rem;
          padding: 1.25rem 1rem;
          background: #f8fafc;
          border-radius: 12px;
        }
        .success-step {
          display: flex;
          align-items: center;
          gap: .6rem;
          flex-shrink: 0;
        }
        .step-circle {
          width: 32px;
          height: 32px;
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
        .step-circle.done { background: #dcfce7; color: #16a34a; }
        .step-circle.active { background: #0c7ab8; color: #fff; }
        .step-text { text-align: left; }
        .step-label { font-size: .65rem; color: #94a3b8; text-transform: uppercase; letter-spacing: .06em; font-weight: 600; }
        .step-name { font-size: .8rem; font-weight: 600; color: #0f172a; white-space: nowrap; }
        .success-step.done .step-name { color: #16a34a; }
        .success-step.active .step-name { color: #0c7ab8; }
        .step-connector {
          flex: 1;
          height: 2px;
          background: #e2e8f0;
          margin: 0 .5rem;
          min-width: 20px;
        }

        .success-cta {
          display: block;
          background: #0c7ab8;
          color: #fff;
          border-radius: 10px;
          padding: 1rem;
          font-weight: 700;
          font-size: 1rem;
          text-decoration: none;
          transition: background .15s, transform .1s;
          margin-bottom: 1rem;
        }
        .success-cta:hover { background: #085d8c; transform: translateY(-1px); }
        .success-note {
          color: #64748b;
          font-size: .85rem;
          line-height: 1.5;
          margin-bottom: 1.25rem;
        }
        .success-link { color: #0c7ab8; font-weight: 600; text-decoration: none; }
        .success-link:hover { text-decoration: underline; }
        .success-back { display: inline-block; color: #94a3b8; font-size: .85rem; text-decoration: none; }
        .success-back:hover { color: #64748b; }
      `}</style>
    </main>
  );
}
