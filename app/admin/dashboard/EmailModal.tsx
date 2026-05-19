"use client";

import { useState } from "react";

interface EmailTarget {
  student_id?: string;
  student_ids?: string[];
  all_enrolled?: boolean;
  label: string;
}

export function EmailModal({
  target,
  onClose,
}: {
  target: EmailTarget;
  onClose: () => void;
}) {
  const [subject, setSubject] = useState("");
  const [message, setMessage] = useState("");
  const [sending, setSending] = useState(false);
  const [result, setResult] = useState<{ ok: boolean; text: string } | null>(null);

  async function send() {
    setSending(true);
    setResult(null);
    const res = await fetch("/api/admin/email", {
      method: "POST",
      headers: { "Content-Type": "application/json" },
      body: JSON.stringify({
        student_id: target.student_id,
        student_ids: target.student_ids,
        all_enrolled: target.all_enrolled,
        subject,
        message,
      }),
    });
    const data = await res.json();
    setSending(false);
    if (res.ok) {
      setResult({ ok: true, text: `Sent to ${data.sent} recipient${data.sent === 1 ? "" : "s"}.` });
    } else {
      setResult({ ok: false, text: data.error ?? "Failed to send" });
    }
  }

  return (
    <div className="modal-backdrop" onClick={onClose} role="presentation">
      <div className="modal-card" onClick={(e) => e.stopPropagation()} role="dialog" aria-modal="true">
        <h3 className="modal-title">Email {target.label}</h3>
        <label className="form-label">Subject
          <input className="form-input" value={subject} onChange={(e) => setSubject(e.target.value)} placeholder="Module 1 reminder" />
        </label>
        <label className="form-label" style={{ marginTop: "1rem" }}>Message
          <textarea className="form-input" rows={6} value={message} onChange={(e) => setMessage(e.target.value)} placeholder="Write your message to students…" />
        </label>
        {result && (
          <p className={`modal-result ${result.ok ? "ok" : "err"}`}>{result.text}</p>
        )}
        <div className="form-actions">
          <button type="button" className="admin-btn" onClick={send} disabled={sending || !subject.trim() || !message.trim()}>
            {sending ? "Sending…" : "Send email"}
          </button>
          <button type="button" className="row-btn" onClick={onClose}>Close</button>
        </div>
        <p className="modal-note">Requires RESEND_API_KEY in .env.local. Use a verified sender domain in production.</p>
      </div>
      <style>{`
        .modal-backdrop { position: fixed; inset: 0; background: rgba(15,23,42,.45); display: flex; align-items: center; justify-content: center; z-index: 100; padding: 1rem; }
        .modal-card { background: #fff; border-radius: 10px; padding: 1.5rem; width: 100%; max-width: 520px; box-shadow: 0 20px 50px rgba(0,0,0,.15); }
        .modal-title { font-family: "Fraunces", serif; font-size: 1.15rem; font-weight: 700; color: #0f172a; margin-bottom: 1.25rem; }
        .modal-result { margin-top: .75rem; font-size: .9rem; font-weight: 600; }
        .modal-result.ok { color: #16a34a; } .modal-result.err { color: #dc2626; }
        .modal-note { margin-top: 1rem; font-size: .78rem; color: #94a3b8; line-height: 1.4; }
      `}</style>
    </div>
  );
}
