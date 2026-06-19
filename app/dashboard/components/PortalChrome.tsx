"use client";

import { useRouter } from "next/navigation";
import { useState } from "react";

export function PageHeader({ title, description }: { title: string; description?: string }) {
  return (
    <header className="sp-page-header">
      <h1>{title}</h1>
      {description && <p>{description}</p>}
    </header>
  );
}

export function NotEnrolledBanner() {
  const router = useRouter();
  const [busy, setBusy] = useState(false);
  const [message, setMessage] = useState<string | null>(null);
  const [hint, setHint] = useState<string | null>(null);

  async function retryLink() {
    setBusy(true);
    setMessage(null);
    setHint(null);
    try {
      const res = await fetch("/api/student/sync-enrollment", { method: "POST" });
      const data = await res.json();
      if (!res.ok) {
        setMessage(data.error ?? "Could not link payment yet.");
        if (data.hint) setHint(data.hint);
        return;
      }
      if (data.enrolled) {
        router.refresh();
        return;
      }
      setMessage("Account linked, but enrollment is still pending.");
      if (data.hint) setHint(data.hint);
    } catch {
      setMessage("Network error — try again in a moment.");
    } finally {
      setBusy(false);
    }
  }

  return (
    <div className="sp-banner warn">
      <div>
        <strong>Your course is not unlocked yet.</strong>
        <br />
        <span style={{ color: "#c2410c", fontSize: "0.88rem" }}>
          Already paid? Link your payment to this account below. Use the same email
          at checkout and sign-up when possible.
        </span>
        {message && (
          <p style={{ color: "#9a3412", fontSize: "0.82rem", marginTop: "0.5rem" }}>
            {message}
          </p>
        )}
        {hint && (
          <p style={{ color: "#7c2d12", fontSize: "0.78rem", marginTop: "0.35rem", lineHeight: 1.5 }}>
            {hint}
          </p>
        )}
      </div>
      <div style={{ display: "flex", flexDirection: "column", gap: "0.45rem" }}>
        <button
          type="button"
          className="sp-btn-secondary"
          style={{ background: "#0c7ab8", color: "#fff", border: "none", cursor: "pointer" }}
          onClick={retryLink}
          disabled={busy}
        >
          {busy ? "Linking…" : "I already paid — link my course"}
        </button>
        <a href="/enroll" className="sp-btn-secondary" style={{ background: "#f97316" }}>
          Enroll now
        </a>
      </div>
    </div>
  );
}
