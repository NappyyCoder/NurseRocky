"use client";

import { useState } from "react";
import type { StudentDashboardData } from "@/lib/server/student-dashboard";

export function ClinicalPanel({
  clinical,
  checklist: initial,
  studyMinutes,
}: {
  clinical: StudentDashboardData["clinical"];
  checklist: StudentDashboardData["checklist"];
  studyMinutes: number;
}) {
  const [checklist, setChecklist] = useState(initial);

  async function toggle(key: string, completed: boolean) {
    setChecklist((prev) => prev.map((c) => (c.key === key ? { ...c, completed } : c)));
    await fetch("/api/student/checklist", {
      method: "POST",
      headers: { "Content-Type": "application/json" },
      body: JSON.stringify({ item_key: key, completed }),
    });
  }

  const pct = Math.min(100, Math.round((clinical.total / clinical.required) * 100));

  return (
    <>
      <div className="sp-card" style={{ marginBottom: "1.25rem" }}>
        <div className="sp-clinical-hours">
          {clinical.total} <span style={{ fontSize: "1rem", color: "#64748b" }}>/ {clinical.required} hrs</span>
        </div>
        <div className="sp-clinical-meta">
          Clinical hours logged
          {studyMinutes > 0 && ` · ${studyMinutes} min online study time`}
        </div>
        <div className="sp-progress-bar" style={{ maxWidth: "100%", marginTop: "1rem" }}>
          <div style={{ width: `${pct}%` }} />
        </div>
      </div>

      {clinical.entries.length > 0 && (
        <section className="sp-section">
          <h2 className="sp-section-title">Recent log entries</h2>
          <div className="sp-table-wrap">
            <table className="sp-table">
              <thead>
                <tr>
                  <th>Date</th>
                  <th>Hours</th>
                  <th>Notes</th>
                </tr>
              </thead>
              <tbody>
                {clinical.entries.map((e, i) => (
                  <tr key={i}>
                    <td>{e.date}</td>
                    <td>{e.hours}</td>
                    <td>{e.notes ?? "—"}</td>
                  </tr>
                ))}
              </tbody>
            </table>
          </div>
        </section>
      )}

      <section className="sp-section">
        <h2 className="sp-section-title">Pre-clinical checklist</h2>
        <div className="sp-card">
          <ul className="sp-checklist">
            {checklist.map((item) => (
              <li key={item.key}>
                <label>
                  <input
                    type="checkbox"
                    checked={item.completed}
                    onChange={(e) => toggle(item.key, e.target.checked)}
                  />
                  {item.label}
                </label>
              </li>
            ))}
          </ul>
        </div>
      </section>
    </>
  );
}
