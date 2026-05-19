"use client";

import { useState } from "react";

export function CompleteLessonButton({
  lessonId,
  initialDone,
}: {
  lessonId: string;
  initialDone?: boolean;
}) {
  const [busy, setBusy] = useState(false);
  const [locked, setLocked] = useState(!!initialDone);
  const [doneLabel, setDoneLabel] = useState(
    initialDone ? "Marked complete ✓" : "Mark lesson complete"
  );

  async function onClick() {
    if (busy || locked) return;
    setBusy(true);
    try {
      const res = await fetch("/api/student/lesson-complete", {
        method: "POST",
        headers: { "Content-Type": "application/json" },
        body: JSON.stringify({ lesson_id: lessonId }),
      });
      if (!res.ok) {
        const j = await res.json();
        throw new Error(j.error ?? "Unable to save");
      }
      setDoneLabel("Marked complete ✓");
      setLocked(true);
    } catch (e: unknown) {
      alert(e instanceof Error ? e.message : "Save failed");
    } finally {
      setBusy(false);
    }
  }

  return (
    <div style={{ display: "flex", flexWrap: "wrap", alignItems: "center", gap: "0.75rem" }}>
      <button
        type="button"
        disabled={busy || locked}
        onClick={onClick}
        style={{
          background: locked ? "#dcfce7" : "#0c7ab8",
          color: locked ? "#15803d" : "#ffffff",
          border: locked ? "1px solid #bbf7d0" : "none",
          fontWeight: 700,
          fontSize: "0.88rem",
          padding: "0.62rem 1.25rem",
          borderRadius: 8,
          cursor: locked ? "default" : "pointer",
          opacity: busy ? 0.65 : 1,
        }}
      >
        {busy ? "Saving…" : doneLabel}
      </button>
      {!locked && (
        <span style={{ color: "#94a3b8", fontSize: "0.82rem" }}>
          Mark lessons complete before moving on—they track your readiness.
        </span>
      )}
    </div>
  );
}
