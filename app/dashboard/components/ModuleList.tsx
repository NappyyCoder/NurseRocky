import Link from "next/link";
import type { ModuleProgressRow } from "@/lib/server/student-dashboard";

export function ModuleList({
  modules,
  isEnrolled,
}: {
  modules: ModuleProgressRow[];
  isEnrolled: boolean;
}) {
  if (modules.length === 0) {
    return <p className="sp-empty">No modules published yet. Check back soon.</p>;
  }

  return (
    <div className="sp-module-list">
      {modules.map((row) => {
        const mod = row.module;
        const pctLessons = row.lessonsTotal
          ? Math.round((row.lessonsDone / row.lessonsTotal) * 100)
          : 0;
        const pctQuizzes = row.quizzesTotal
          ? Math.round((row.quizzesPassed / row.quizzesTotal) * 100)
          : 100;

        return (
          <div
            key={mod.id}
            className={`sp-module-card ${row.available && isEnrolled ? "available" : "locked"}`}
          >
            <div className="sp-module-num">{String(mod.order_num).padStart(2, "0")}</div>
            <div className="sp-module-body">
              <div className="sp-module-title">{mod.title}</div>
              <div className="sp-module-meta">
                {row.lessonsDone}/{row.lessonsTotal} lessons · {row.quizzesPassed}/{row.quizzesTotal} assignments
              </div>
              <div className="sp-progress-rows">
                <div className="sp-progress-row">
                  <span>Lessons</span>
                  <div className="sp-progress-bar">
                    <div style={{ width: `${pctLessons}%` }} />
                  </div>
                </div>
                <div className="sp-progress-row">
                  <span>Quizzes</span>
                  <div className="sp-progress-bar">
                    <div style={{ width: `${pctQuizzes}%` }} />
                  </div>
                </div>
              </div>
              {mod.description && <p className="sp-module-desc">{mod.description}</p>}
            </div>
            <div className="sp-module-action">
              {row.fullyComplete ? (
                <span className="sp-status-done">Complete</span>
              ) : row.available && isEnrolled ? (
                <Link href={`/dashboard/modules/${mod.id}`} className="sp-btn-secondary">
                  Open
                </Link>
              ) : (
                <span className="sp-status-locked">Locked</span>
              )}
            </div>
          </div>
        );
      })}
    </div>
  );
}
