"use client";

import { useState } from "react";

export function SupportForm() {
  const [subject, setSubject] = useState("");
  const [message, setMessage] = useState("");
  const [sent, setSent] = useState(false);
  const [busy, setBusy] = useState(false);

  async function submit(e: React.FormEvent) {
    e.preventDefault();
    setBusy(true);
    const res = await fetch("/api/student/support", {
      method: "POST",
      headers: { "Content-Type": "application/json" },
      body: JSON.stringify({ subject, message }),
    });
    setBusy(false);
    if (res.ok) {
      setSent(true);
      setSubject("");
      setMessage("");
    } else {
      const d = await res.json();
      alert(d.error ?? "Could not send message");
    }
  }

  if (sent) {
    return (
      <div className="sp-banner success">
        <span>Message sent — we will respond to the email on your account.</span>
        <button type="button" className="sp-btn-ghost" onClick={() => setSent(false)}>
          Send another
        </button>
      </div>
    );
  }

  return (
    <div className="sp-card">
      <form className="sp-form" onSubmit={submit}>
        <label>
          Subject
          <input
            type="text"
            value={subject}
            onChange={(e) => setSubject(e.target.value)}
            placeholder="e.g. Question about Module 2"
            required
          />
        </label>
        <label>
          Message
          <textarea
            rows={5}
            value={message}
            onChange={(e) => setMessage(e.target.value)}
            placeholder="Describe your question or issue…"
            required
          />
        </label>
        <button type="submit" className="sp-btn-secondary" disabled={busy}>
          {busy ? "Sending…" : "Send message"}
        </button>
      </form>
    </div>
  );
}
