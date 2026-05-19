import type { StudentDashboardData } from "@/lib/server/student-dashboard";

export function ProgressStatsGrid({ stats }: { stats: StudentDashboardData["stats"] }) {
  return (
    <div className="sp-stats-grid">
      <div className="sp-stat-card">
        <div className="sp-stat-icon blue">
          <svg viewBox="0 0 24 24" fill="none" stroke="currentColor" strokeWidth="2" strokeLinecap="round">
            <path d="M4 19.5A2.5 2.5 0 0 1 6.5 17H20" /><path d="M6.5 2H20v20H6.5A2.5 2.5 0 0 1 4 19.5v-15A2.5 2.5 0 0 1 6.5 2z" />
          </svg>
        </div>
        <div>
          <div className="sp-stat-num">{stats.modulesFullyComplete} / {stats.modulesTotal}</div>
          <div className="sp-stat-label">Modules complete</div>
        </div>
      </div>
      <div className="sp-stat-card">
        <div className="sp-stat-icon green">
          <svg viewBox="0 0 24 24" fill="none" stroke="currentColor" strokeWidth="2" strokeLinecap="round">
            <path d="M9 11l3 3L22 4" /><path d="M21 12v7a2 2 0 0 1-2 2H5a2 2 0 0 1-2-2V5a2 2 0 0 1 2-2h11" />
          </svg>
        </div>
        <div>
          <div className="sp-stat-num">{stats.quizzesPassed} / {stats.quizzesTotal}</div>
          <div className="sp-stat-label">Assignments passed</div>
        </div>
      </div>
      <div className="sp-stat-card">
        <div className="sp-stat-icon orange">
          <svg viewBox="0 0 24 24" fill="none" stroke="currentColor" strokeWidth="2" strokeLinecap="round">
            <path d="M22 12h-4l-3 9L9 3l-3 9H2" />
          </svg>
        </div>
        <div>
          <div className="sp-stat-num">{stats.clinicalHours} / 16</div>
          <div className="sp-stat-label">Clinical hours</div>
        </div>
      </div>
      <div className="sp-stat-card">
        <div className="sp-stat-icon purple">
          <svg viewBox="0 0 24 24" fill="none" stroke="currentColor" strokeWidth="2" strokeLinecap="round">
            <circle cx="12" cy="8" r="6" /><path d="M15.477 12.89L17 22l-5-3-5 3 1.523-9.11" />
          </svg>
        </div>
        <div>
          <div className="sp-stat-num">{stats.overallPct}%</div>
          <div className="sp-stat-label">Overall progress</div>
        </div>
      </div>
    </div>
  );
}
