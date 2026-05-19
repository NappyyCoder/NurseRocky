export const dynamic = "force-dynamic";

import { auth } from "@clerk/nextjs/server";
import { redirect } from "next/navigation";
import { resolveStudentId } from "@/lib/server/resolve-student";
import { getStudentDashboardData } from "@/lib/server/student-dashboard";
import { ReportHeader } from "./ReportHeader";

const reportStyles = `
.report-page {
  min-height: 100vh;
  background: #f8fafc;
  padding: 2rem;
  font-family: "DM Sans", system-ui, sans-serif;
  color: #0f172a;
}
.report-body {
  max-width: 800px;
  margin: 0 auto;
  background: #fff;
  border: 1px solid #e2e8f0;
  border-radius: 8px;
  padding: 2rem;
}
.report-body h1 {
  font-family: "Fraunces", serif;
  font-size: 1.5rem;
  margin-bottom: 0.25rem;
}
.report-body .meta { color: #64748b; font-size: 0.9rem; margin-bottom: 2rem; }
.report-body section { margin-bottom: 2rem; }
.report-body h2 { font-size: 1.1rem; margin-bottom: 0.75rem; }
.report-body ul { padding-left: 1.25rem; line-height: 1.8; }
.report-body table { width: 100%; border-collapse: collapse; font-size: 0.875rem; }
.report-body th, .report-body td {
  padding: 0.5rem 0.75rem;
  text-align: left;
  border-bottom: 1px solid #e2e8f0;
}
.report-body th { background: #f8fafc; }
@media print {
  .no-print { display: none !important; }
  .report-page { background: #fff; padding: 0; }
  .report-body { border: none; box-shadow: none; }
}
`;

export default async function ProgressReportPage() {
  const { userId } = await auth();
  if (!userId) redirect("/sign-in");

  const studentId = await resolveStudentId(userId);
  if (!studentId) redirect("/dashboard");

  const data = await getStudentDashboardData(studentId);
  if (!data.student.enrolled) redirect("/dashboard");

  const date = new Date().toLocaleDateString("en-US", {
    year: "numeric",
    month: "long",
    day: "numeric",
  });

  return (
    <>
      <style dangerouslySetInnerHTML={{ __html: reportStyles }} />
      <div className="report-page">
        <ReportHeader />

        <article className="report-body">
          <h1>Student Progress Report</h1>
          <p className="meta">
            {data.student.firstName} · Generated {date}
          </p>

          <section>
            <h2>Summary</h2>
            <ul>
              <li>Modules complete: {data.stats.modulesFullyComplete} / {data.stats.modulesTotal}</li>
              <li>Lessons complete: {data.stats.lessonsCompleted} / {data.stats.lessonsTotal}</li>
              <li>Assignments passed: {data.stats.quizzesPassed} / {data.stats.quizzesTotal}</li>
              <li>Clinical hours: {data.stats.clinicalHours} / 16</li>
              <li>Study time: {data.stats.totalStudyMinutes} minutes</li>
              <li>Overall progress: {data.stats.overallPct}%</li>
            </ul>
          </section>

          <section>
            <h2>Module progress</h2>
            <table>
              <thead>
                <tr>
                  <th>Module</th>
                  <th>Lessons</th>
                  <th>Assignments</th>
                  <th>Status</th>
                </tr>
              </thead>
              <tbody>
                {data.modules.map((m) => (
                  <tr key={m.module.id}>
                    <td>{m.module.title}</td>
                    <td>{m.lessonsDone}/{m.lessonsTotal}</td>
                    <td>{m.quizzesPassed}/{m.quizzesTotal}</td>
                    <td>{m.fullyComplete ? "Complete" : m.available ? "In progress" : "Locked"}</td>
                  </tr>
                ))}
              </tbody>
            </table>
          </section>

          {data.allGrades.length > 0 && (
            <section>
              <h2>Grades</h2>
              <table>
                <thead>
                  <tr>
                    <th>Module</th>
                    <th>Assignment</th>
                    <th>Best score</th>
                    <th>Status</th>
                  </tr>
                </thead>
                <tbody>
                  {data.allGrades.map((g) => (
                    <tr key={g.quiz_id}>
                      <td>{g.moduleTitle}</td>
                      <td>{g.title}</td>
                      <td>{g.best_score != null ? `${g.best_score}%` : "—"}</td>
                      <td>{g.passed ? "Passed" : "Not passed"}</td>
                    </tr>
                  ))}
                </tbody>
              </table>
            </section>
          )}
        </article>
      </div>
    </>
  );
}
