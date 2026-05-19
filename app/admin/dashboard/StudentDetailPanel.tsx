"use client";

import { useCallback, useEffect, useState } from "react";

type StudentSummary = {
  modules_finished: number;
  modules_total: number;
  quizzes_passed: number;
  quizzes_total: number;
  clinical_hours: number;
};

type ModuleProgress = {
  id: number;
  title: string;
  order_num: number;
  lessons_total: number;
  lessons_done: number;
  quizzes_passed: number;
  quizzes_total: number;
  lessons: {
    id: string;
    title: string;
    order_num: number;
    completed: boolean;
    completed_at: string | null;
  }[];
  quizzes: {
    quiz_id: string;
    title: string;
    passing_score: number;
    best_score: number;
    latest_score: number;
    passed: boolean;
    attempts: number;
    last_attempt_at: string | null;
  }[];
};

export function StudentDetailPanel({
  studentId,
  onBack,
  onEmail,
  onUpdated,
}: {
  studentId: string;
  onBack: () => void;
  onEmail: (label: string) => void;
  onUpdated: () => void;
}) {
  const [student, setStudent] = useState<{
    id: string;
    email: string;
    first_name: string | null;
    last_name: string | null;
    enrolled: boolean;
    enrolled_at: string | null;
  } | null>(null);
  const [summary, setSummary] = useState<StudentSummary | null>(null);
  const [modules, setModules] = useState<ModuleProgress[]>([]);
  const [loading, setLoading] = useState(true);
  const [msg, setMsg] = useState("");
  const [openModule, setOpenModule] = useState<number | null>(null);
  const [busy, setBusy] = useState(false);

  const load = useCallback(async () => {
    setLoading(true);
    const res = await fetch(`/api/admin/students/${studentId}`);
    if (res.ok) {
      const data = await res.json();
      setStudent(data.student);
      setSummary(data.summary);
      setModules(data.modules);
    }
    setLoading(false);
  }, [studentId]);

  useEffect(() => {
    load();
  }, [load]);

  useEffect(() => {
    if (modules.length && openModule == null) {
      setOpenModule(modules[0].id);
    }
  }, [modules, openModule]);

  function flash(text: string) {
    setMsg(text);
    setTimeout(() => setMsg(""), 4000);
  }

  async function runAction(payload: Record<string, unknown>) {
    setBusy(true);
    const res = await fetch("/api/admin/student-actions", {
      method: "POST",
      headers: { "Content-Type": "application/json" },
      body: JSON.stringify({ student_id: studentId, ...payload }),
    });
    const data = await res.json();
    setBusy(false);
    if (res.ok) {
      flash(data.message ?? "Updated");
      onUpdated();
      load();
    } else {
      flash(data.error ?? "Action failed");
    }
  }

  async function toggleEnrollment() {
    if (!student) return;
    setBusy(true);
    const res = await fetch(`/api/admin/students/${studentId}`, {
      method: "PUT",
      headers: { "Content-Type": "application/json" },
      body: JSON.stringify({ enrolled: !student.enrolled }),
    });
    setBusy(false);
    if (res.ok) {
      flash(student.enrolled ? "Student unenrolled" : "Student enrolled");
      onUpdated();
      load();
    }
  }

  if (loading && !student) {
    return <div className="loading">Loading student…</div>;
  }

  if (!student || !summary) {
    return <div className="loading">Student not found.</div>;
  }

  const displayName =
    [student.first_name, student.last_name].filter(Boolean).join(" ") || student.email;

  return (
    <div className="student-detail">
      <div className="detail-top">
        <button type="button" className="row-btn" onClick={onBack}>← Back to students</button>
        {msg && <span className="flash-msg">{msg}</span>}
      </div>

      <div className="form-card">
        <div className="student-head">
          <div>
            <h3 className="form-title">{displayName}</h3>
            <p className="student-email">{student.email}</p>
            <span className={`status-badge ${student.enrolled ? "active" : "pending"}`}>
              {student.enrolled ? "Enrolled" : "Not enrolled"}
            </span>
          </div>
          <div className="student-head-actions">
            <button type="button" className="admin-btn" onClick={() => onEmail(displayName)} disabled={!student.email}>
              Email
            </button>
            <button type="button" className="row-btn" onClick={toggleEnrollment} disabled={busy}>
              {student.enrolled ? "Unenroll" : "Enroll"}
            </button>
          </div>
        </div>

        <div className="summary-grid">
          <div className="summary-pill">
            <strong>{summary.modules_finished}/{summary.modules_total}</strong>
            <span>Modules complete</span>
          </div>
          <div className="summary-pill">
            <strong>{summary.quizzes_passed}/{summary.quizzes_total}</strong>
            <span>Quizzes passed</span>
          </div>
          <div className="summary-pill">
            <strong>{summary.clinical_hours} / 16</strong>
            <span>Clinical hours</span>
          </div>
        </div>
      </div>

      <p className="section-hint">
        Reset a quiz to let the student retake it. Lesson and module resets sync immediately on their dashboard.
      </p>

      {modules.map((mod) => (
        <div className="module-progress-card" key={mod.id}>
          <button
            type="button"
            className="module-progress-head"
            onClick={() => setOpenModule(openModule === mod.id ? null : mod.id)}
          >
            <div>
              <strong>Module {mod.order_num}: {mod.title}</strong>
              <span className="detail-row-meta">
                {mod.lessons_done}/{mod.lessons_total} lessons · {mod.quizzes_passed}/{mod.quizzes_total} quizzes passed
              </span>
            </div>
            <span>{openModule === mod.id ? "▾" : "▸"}</span>
          </button>

          {openModule === mod.id && (
            <div className="module-progress-body">
              <div className="progress-actions">
                <button
                  type="button"
                  className="row-btn danger"
                  disabled={busy}
                  onClick={() => {
                    if (confirm(`Reset ALL progress in Module ${mod.order_num} for this student?`)) {
                      runAction({ action: "reset_module_progress", module_id: mod.id });
                    }
                  }}
                >
                  Reset entire module
                </button>
                <button
                  type="button"
                  className="row-btn"
                  disabled={busy}
                  onClick={() => runAction({ action: "reset_module_quizzes", module_id: mod.id })}
                >
                  Reset all quizzes
                </button>
                <button
                  type="button"
                  className="row-btn"
                  disabled={busy}
                  onClick={() => runAction({ action: "reset_module_lessons", module_id: mod.id })}
                >
                  Reset all lessons
                </button>
              </div>

              <h4 className="form-subtitle">Lessons</h4>
              <ul className="progress-list">
                {mod.lessons.map((l) => (
                  <li key={l.id}>
                    <span className={l.completed ? "done" : ""}>
                      {l.completed ? "✓" : "○"} {l.order_num}. {l.title}
                    </span>
                    {l.completed && (
                      <button
                        type="button"
                        className="row-btn"
                        disabled={busy}
                        onClick={() => runAction({ action: "reset_lesson", lesson_id: l.id })}
                      >
                        Mark incomplete
                      </button>
                    )}
                  </li>
                ))}
              </ul>

              <h4 className="form-subtitle">Quizzes &amp; tests</h4>
              <ul className="progress-list">
                {mod.quizzes.map((q) => (
                  <li key={q.quiz_id}>
                    <div className="quiz-progress-line">
                      <span className={q.passed ? "done" : ""}>
                        {q.title}
                      </span>
                      <span className="detail-row-meta">
                        {q.attempts > 0
                          ? `Best ${q.best_score}% · ${q.passed ? "Passed" : "Not passing"} · ${q.attempts} attempt${q.attempts === 1 ? "" : "s"}`
                          : "Not started"}
                      </span>
                    </div>
                    {q.attempts > 0 && (
                      <button
                        type="button"
                        className="row-btn"
                        disabled={busy}
                        onClick={() => {
                          if (confirm(`Clear attempts so ${displayName} can retake "${q.title}"?`)) {
                            runAction({ action: "reset_quiz", quiz_id: q.quiz_id });
                          }
                        }}
                      >
                        Allow retake
                      </button>
                    )}
                  </li>
                ))}
                {mod.quizzes.length === 0 && <li className="empty-inline">No quizzes in this module.</li>}
              </ul>
            </div>
          )}
        </div>
      ))}

      <style>{`
        .student-detail { display: flex; flex-direction: column; gap: 1rem; }
        .student-head { display: flex; justify-content: space-between; align-items: flex-start; gap: 1rem; flex-wrap: wrap; margin-bottom: 1.25rem; }
        .student-email { color: #64748b; font-size: .9rem; margin: .25rem 0 .5rem; }
        .student-head-actions { display: flex; gap: .5rem; }
        .summary-grid { display: grid; grid-template-columns: repeat(3, 1fr); gap: .75rem; }
        .summary-pill { background: #f8fafc; border: 1px solid #e2e8f0; border-radius: 8px; padding: .85rem 1rem; text-align: center; }
        .summary-pill strong { display: block; font-family: "Fraunces", serif; font-size: 1.1rem; color: #0f172a; }
        .summary-pill span { font-size: .75rem; color: #64748b; }
        .module-progress-card { background: #fff; border: 1px solid #e2e8f0; border-radius: 8px; overflow: hidden; }
        .module-progress-head { width: 100%; display: flex; justify-content: space-between; align-items: center; gap: 1rem; padding: 1rem 1.25rem; background: none; border: none; cursor: pointer; text-align: left; font: inherit; }
        .module-progress-head:hover { background: #f8fafc; }
        .module-progress-body { padding: 0 1.25rem 1.25rem; border-top: 1px solid #f1f5f9; }
        .progress-actions { display: flex; flex-wrap: wrap; gap: .5rem; margin: 1rem 0; }
        .progress-list { list-style: none; margin: 0 0 1.25rem; padding: 0; }
        .progress-list li { display: flex; justify-content: space-between; align-items: center; gap: .75rem; padding: .5rem 0; border-bottom: 1px solid #f8fafc; font-size: .875rem; }
        .progress-list .done { color: #15803d; font-weight: 600; }
        .quiz-progress-line { display: flex; flex-direction: column; gap: .1rem; }
        @media (max-width: 600px) { .summary-grid { grid-template-columns: 1fr; } }
      `}</style>
    </div>
  );
}
