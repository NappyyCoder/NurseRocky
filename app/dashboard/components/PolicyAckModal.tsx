"use client";

import { useState } from "react";
import Link from "next/link";
import { POLICY_BY_SLUG } from "@/lib/policies/content";
import { REQUIRED_POLICY_SLUGS } from "@/lib/student-portal/constants";

const POLICIES = REQUIRED_POLICY_SLUGS.map((slug) => ({
  slug,
  label: POLICY_BY_SLUG[slug]?.title ?? slug,
}));

export function PolicyAckModal({ onDone }: { onDone: () => void }) {
  const [checked, setChecked] = useState<Record<string, boolean>>({});
  const [busy, setBusy] = useState(false);

  const allChecked = POLICIES.every((p) => checked[p.slug]);

  async function submit() {
    if (!allChecked || busy) return;
    setBusy(true);
    try {
      const res = await fetch("/api/student/policy-ack", {
        method: "POST",
        headers: { "Content-Type": "application/json" },
        body: JSON.stringify({ slugs: POLICIES.map((p) => p.slug) }),
      });
      if (!res.ok) {
        const d = await res.json();
        throw new Error(d.error ?? "Could not save");
      }
      onDone();
    } catch (e: unknown) {
      alert(e instanceof Error ? e.message : "Error");
    } finally {
      setBusy(false);
    }
  }

  return (
    <div className="policy-ack-overlay" role="dialog" aria-modal="true" aria-labelledby="policy-ack-title">
      <div className="policy-ack-modal">
        <h2 id="policy-ack-title">Program policies</h2>
        <p className="policy-ack-intro">
          Before continuing, please read each policy (opens in a new tab), then check the box to confirm.
        </p>
        <ul className="policy-ack-list">
          {POLICIES.map((p) => {
            const inputId = `policy-ack-${p.slug}`;
            return (
              <li key={p.slug} className="policy-ack-item">
                <input
                  id={inputId}
                  type="checkbox"
                  checked={!!checked[p.slug]}
                  onChange={(e) => setChecked((c) => ({ ...c, [p.slug]: e.target.checked }))}
                />
                <div className="policy-ack-row">
                  <label htmlFor={inputId}>I have read the</label>{" "}
                  <Link
                    href={`/policies/${p.slug}`}
                    target="_blank"
                    rel="noopener noreferrer"
                    className="policy-ack-link"
                    onClick={(e) => e.stopPropagation()}
                  >
                    {p.label}
                  </Link>
                </div>
              </li>
            );
          })}
        </ul>
        <button type="button" className="policy-ack-btn" disabled={!allChecked || busy} onClick={submit}>
          {busy ? "Saving…" : "Continue to dashboard"}
        </button>
      </div>
    </div>
  );
}
