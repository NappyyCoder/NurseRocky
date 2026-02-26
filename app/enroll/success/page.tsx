import Link from "next/link";

export default function EnrollSuccessPage() {
  return (
    <main style={{
      minHeight: "100vh",
      display: "flex",
      alignItems: "center",
      justifyContent: "center",
      background: "linear-gradient(135deg, #f0fdf4 0%, #dcfce7 100%)",
      fontFamily: "DM Sans, system-ui, sans-serif",
      padding: "2rem 1rem",
      textAlign: "center",
    }}>
      <div style={{ maxWidth: 480 }}>
        <div style={{ fontSize: "3.5rem", marginBottom: "1rem" }}>🎉</div>
        <h1 style={{ fontFamily: "Fraunces, serif", fontSize: "2rem", fontWeight: 700, color: "#0f172a", letterSpacing: "-.02em", marginBottom: ".75rem" }}>
          You&apos;re enrolled!
        </h1>
        <p style={{ color: "#64748b", fontSize: "1rem", lineHeight: 1.6, marginBottom: "2rem" }}>
          Payment confirmed. Your CNA course is now unlocked and ready to go.
          Head to your dashboard to start Module 1.
        </p>
        <Link href="/dashboard" style={{
          display: "inline-block",
          background: "#0c7ab8",
          color: "#fff",
          borderRadius: "10px",
          padding: ".9rem 2rem",
          fontWeight: 700,
          fontSize: "1rem",
          textDecoration: "none",
          transition: "background .15s",
        }}>
          Go to my dashboard →
        </Link>
        <div style={{ marginTop: "1.25rem" }}>
          <Link href="/" style={{ color: "#94a3b8", fontSize: ".85rem", textDecoration: "none" }}>
            ← Back to site
          </Link>
        </div>
      </div>
    </main>
  );
}
