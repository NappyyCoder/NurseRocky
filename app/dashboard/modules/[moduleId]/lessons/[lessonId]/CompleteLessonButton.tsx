"use client";

import { useRouter } from "next/navigation";
import { useState } from "react";

export function CompleteLessonButton({
  lessonId,
  initialDone,
}: {
  lessonId: string;
  initialDone?: boolean;
}) {
  const router = useRouter();
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
        credentials: "same-origin",
        body: JSON.stringify({ lesson_id: lessonId }),
      });
      const j = (await res.json().catch(() => ({}))) as { error?: string };
      if (!res.ok) {
        throw new Error(j.error ?? "Unable to save progress");
      }
      setDoneLabel("Marked complete ✓");
      setLocked(true);
      router.refresh();
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
          background: locked ? "#e8f2ef" : "#93b7a9",
          color: locked ? "#6b9e8e" : "#ffffff",
          border: locked ? "1px solid #c3d9d2" : "none",
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
        <span style={{ color: "#8a9691", fontSize: "0.82rem" }}>
          Mark lessons complete before moving on—they track your readiness.
        </span>
      )}
    </div>
  );
}
