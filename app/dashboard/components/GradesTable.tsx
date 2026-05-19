import Link from "next/link";
import type { StudentDashboardData } from "@/lib/server/student-dashboard";

export function GradesTable({ grades }: { grades: StudentDashboardData["allGrades"] }) {
  if (grades.length === 0) {
    return <p className="sp-empty">No assignments yet. Open a module to get started.</p>;
  }

  return (
    <div className="sp-table-wrap">
      <table className="sp-table">
        <thead>
          <tr>
            <th>Module</th>
            <th>Assignment</th>
            <th>Best score</th>
            <th>Status</th>
            <th>Attempts</th>
          </tr>
        </thead>
        <tbody>
          {grades.map((g) => (
            <tr key={g.quiz_id}>
              <td>{g.moduleTitle}</td>
              <td>
                <Link href={`/dashboard/modules/${g.moduleId}/quiz/${g.quiz_id}`}>{g.title}</Link>
              </td>
              <td>{g.attempts > 0 ? `${g.best_score}%` : "—"}</td>
              <td>
                <span className={`sp-badge ${g.passed ? "pass" : g.attempts > 0 ? "fail" : "pending"}`}>
                  {g.passed ? "Passed" : g.attempts > 0 ? "Not passed" : "Not started"}
                </span>
              </td>
              <td>{g.attempts}</td>
            </tr>
          ))}
        </tbody>
      </table>
    </div>
  );
}
