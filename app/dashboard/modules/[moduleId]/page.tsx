export const dynamic = "force-dynamic";
export const revalidate = 0;

import { redirect } from "next/navigation";
import Link from "next/link";
import { enrolledStudentCanVisitModule } from "@/lib/server/course-completion";
import { requireEnrolledStudentId } from "@/lib/server/student-portal-session";
import { supabaseAdmin } from "@/lib/supabase";
import type { Lesson, Module as CourseModule } from "@/lib/types";
import { getModuleQuizGrades } from "@/lib/server/student-quiz-grades";

function parseModuleId(raw: string) {
  const n = Number.parseInt(raw, 10);
  return Number.isFinite(n) ? n : null;
}

export default async function ModuleOverviewPage(props: {
  params: Promise<{ moduleId: string }>;
}) {
  const params = await props.params;
  const moduleIdNum = parseModuleId(params.moduleId);
  if (moduleIdNum == null) redirect("/dashboard");

  const studentId = await requireEnrolledStudentId();

  const canVisit = await enrolledStudentCanVisitModule({
    studentId,
    moduleId: moduleIdNum,
  });
  if (!canVisit) {
    redirect("/dashboard");
  }

  const [{ data: mod }, { data: lessonsRaw }, { data: quizzesRaw }] =
    await Promise.all([
      supabaseAdmin.from("modules").select("*").eq("id", moduleIdNum).maybeSingle(),
      supabaseAdmin
        .from("lessons")
        .select("*")
        .eq("module_id", moduleIdNum)
        .order("order_num"),
      supabaseAdmin
        .from("quizzes")
        .select("id, title, passing_score")
        .eq("module_id", moduleIdNum)
        .order("created_at"),
    ]);

  const courseModule = mod as CourseModule | null;
  const lessons = (lessonsRaw ?? []) as Lesson[];
  const quizzes = quizzesRaw ?? [];

  if (!courseModule) {
    redirect("/dashboard");
  }

  const lessonIds = lessons.map((l) => l.id);

  let completedLessons = new Set<string>();
  if (lessonIds.length) {
    const { data: progressRows } = await supabaseAdmin
      .from("student_progress")
      .select("lesson_id, completed")
      .eq("student_id", studentId)
      .in("lesson_id", lessonIds);

    completedLessons = new Set(
      (progressRows ?? [])
        .filter((r) => r.completed)
        .map((r) => r.lesson_id as string)
    );
  }

  const grades = await getModuleQuizGrades(studentId, moduleIdNum);
  const lessonsDone = completedLessons.size;
  const lessonsTotal = lessons.length;
  const quizzesPassed = grades.filter((g) => g.passed).length;
  const quizzesTotal = grades.length;
  const lessonPct = lessonsTotal
    ? Math.round((lessonsDone / lessonsTotal) * 100)
    : 0;
  const allLessonsDone = lessonsTotal > 0 && lessonsDone >= lessonsTotal;

  const firstOpenLesson = lessons.find((l) => !completedLessons.has(l.id));
  const firstOpenQuiz = grades.find((g) => !g.passed);
  const continueHref = firstOpenLesson
    ? `/dashboard/modules/${moduleIdNum}/lessons/${firstOpenLesson.id}`
    : firstOpenQuiz
      ? `/dashboard/modules/${moduleIdNum}/quiz/${firstOpenQuiz.quiz_id}`
      : `/dashboard/modules/${moduleIdNum}/lessons/${lessons[0]?.id ?? ""}`;

  const continueLabel = firstOpenLesson
    ? `Continue: Lesson ${firstOpenLesson.order_num}`
    : firstOpenQuiz
      ? `Take assignment: ${firstOpenQuiz.title.replace(/^CNA True\/False Quiz: /, "Quiz — ").replace(/^CNA Mini Exam: /, "Test — ")}`
      : "Review module";

  return (
    <div className="module-view">
      <div className="module-view-inner">
        <nav className="module-crumbs">
          <Link href="/dashboard">Overview</Link>
          <span className="slash">/</span>
          <Link href="/dashboard/modules">Modules</Link>
          <span className="slash">/</span>
          <span>{courseModule.title}</span>
        </nav>

        <header className="module-h">
          <h1>{courseModule.title}</h1>
          <p className="module-meta">
            {lessonsTotal} lesson{lessonsTotal === 1 ? "" : "s"}
            {quizzesTotal > 0
              ? ` · ${quizzesTotal} assessment${quizzesTotal === 1 ? "" : "s"}`
              : ""}
          </p>
          {courseModule.description && (
            <p className="module-desc">{courseModule.description}</p>
          )}

          <div className="module-progress-cards">
            <div className="mpc">
              <span className="mpc-label">Lessons</span>
              <span className="mpc-val">{lessonsDone}/{lessonsTotal}</span>
              <div className="mpc-bar"><div className="mpc-fill blue" style={{ width: `${lessonPct}%` }} /></div>
            </div>
            <div className="mpc">
              <span className="mpc-label">Assessments passed</span>
              <span className="mpc-val">{quizzesPassed}/{quizzesTotal}</span>
              <div className="mpc-bar"><div className="mpc-fill green" style={{ width: `${quizzesTotal ? Math.round((quizzesPassed / quizzesTotal) * 100) : 0}%` }} /></div>
            </div>
          </div>

          {lessons.length > 0 && (
            <Link href={continueHref} className="continue-cta">
              {continueLabel} →
            </Link>
          )}
        </header>

        {(lessonsTotal > 0 || quizzesTotal > 0) && (
          <section className="module-section flow-section">
            <h2>Recommended flow</h2>
            <ol className="flow-steps">
              {lessonsTotal > 0 && (
                <li
                  className={
                    allLessonsDone ? "done" : lessonsDone > 0 ? "active" : "active"
                  }
                >
                  <span className="flow-num">{allLessonsDone ? "✓" : "1"}</span>
                  <div>
                    <strong>
                      Study all {lessonsTotal} lesson{lessonsTotal === 1 ? "" : "s"}
                    </strong>
                    <span>
                      Work through each lesson in order, then mark it complete
                      ({lessonsDone}/{lessonsTotal} done)
                    </span>
                  </div>
                </li>
              )}
              {grades.map((g, idx) => {
                const prevPassed =
                  idx === 0 ? allLessonsDone : grades[idx - 1]?.passed;
                const label = g.title
                  .replace(/^CNA True\/False Quiz:.*/i, "True/False Quiz")
                  .replace(/^True\/False Quiz.*/i, "True/False Quiz")
                  .replace(/^CNA Mini Exam.*/i, "Mini Exam")
                  .replace(/^Mini Exam.*/i, "Mini Exam");
                return (
                  <li
                    key={g.quiz_id}
                    className={g.passed ? "done" : prevPassed ? "active" : ""}
                  >
                    <span className="flow-num">
                      {g.passed ? "✓" : (lessonsTotal > 0 ? idx + 2 : idx + 1)}
                    </span>
                    <div>
                      <strong>{label}</strong>
                      <span>
                        {label === "Mini Exam"
                          ? "Multiple-choice test · pass to continue"
                          : "Quick check of the key concepts in this module"}
                      </span>
                    </div>
                  </li>
                );
              })}
            </ol>
          </section>
        )}

        <section className="module-section">
          <h2>Lessons</h2>
          <ol className="lesson-rows">
            {lessons.map((lesson) => {
              const done = completedLessons.has(lesson.id);
              return (
                <li key={lesson.id}>
                  <Link
                    href={`/dashboard/modules/${moduleIdNum}/lessons/${lesson.id}`}
                    className={`lesson-row-link ${done ? "done-row" : ""}`}
                  >
                    <span className="lesson-ord">{lesson.order_num}.</span>
                    <span className="lesson-name">{lesson.title}</span>
                    <span className={`lesson-done ${done ? "is-done" : ""}`}>
                      {done ? "✓ Complete" : "Start"}
                    </span>
                  </Link>
                </li>
              );
            })}
          </ol>
          {lessons.length === 0 && (
            <p className="empty">Lessons coming soon.</p>
          )}
        </section>

        <section className="module-section">
          <h2>Assessment</h2>
          <p className="section-hint">Quiz and Test — submit when ready. Retake until you pass. Grades appear instantly.</p>
          <div className="quiz-rows">
            {quizzes.map((q) => {
              const grade = grades.find((g) => g.quiz_id === q.id);
              return (
                <Link
                  key={q.id}
                  href={`/dashboard/modules/${moduleIdNum}/quiz/${q.id}`}
                  className={`quiz-card ${grade?.passed ? "passed" : ""}`}
                >
                  <div className="quiz-card-main">
                    <strong>{q.title}</strong>
                    <span className="quiz-card-sub">{q.passing_score}% to pass</span>
                  </div>
                  <div className="quiz-card-right">
                    {grade && grade.attempts > 0 ? (
                      <span className={`grade-pill ${grade.passed ? "pass" : "fail"}`}>
                        {grade.best_score}% {grade.passed ? "Passed" : "Retake"}
                      </span>
                    ) : (
                      <span className="grade-pill open">Not started</span>
                    )}
                    <span className="quiz-arrow">→</span>
                  </div>
                </Link>
              );
            })}
          </div>
          {quizzes.length === 0 && (
            <p className="empty">No assessments for this module.</p>
          )}
        </section>

        <section id="grades" className="module-section grades-section">
          <h2>Grade report</h2>
          <p className="section-hint">Your best score on each quiz and test. Retakes keep your highest grade.</p>
          {grades.some((g) => g.attempts > 0) ? (
            <table className="grades-table">
              <thead>
                <tr>
                  <th>Assessment</th>
                  <th>Best score</th>
                  <th>Latest</th>
                  <th>Status</th>
                  <th>Attempts</th>
                </tr>
              </thead>
              <tbody>
                {grades.map((g) => (
                  <tr key={g.quiz_id}>
                    <td>
                      <Link href={`/dashboard/modules/${moduleIdNum}/quiz/${g.quiz_id}`}>
                        {g.title.replace(/^CNA True\/False Quiz: /, "Quiz — ").replace(/^CNA Mini Exam: /, "Test — ")}
                      </Link>
                    </td>
                    <td><strong>{g.attempts ? `${g.best_score}%` : "—"}</strong></td>
                    <td>{g.attempts ? `${g.latest_score}%` : "—"}</td>
                    <td>
                      <span className={`status-chip ${g.passed ? "pass" : g.attempts ? "fail" : "none"}`}>
                        {!g.attempts ? "Not taken" : g.passed ? "Passed" : "Not passing"}
                      </span>
                    </td>
                    <td>{g.attempts || "—"}</td>
                  </tr>
                ))}
              </tbody>
            </table>
          ) : (
            <p className="empty">Complete an assignment to see grades here.</p>
          )}
        </section>
      </div>

      <style>{`
        .module-view {
          background: transparent;
          padding: 0;
        }
        .module-view-inner {
          max-width: 100%;
          margin: 0;
          font-family: "DM Sans", system-ui, sans-serif;
        }
        .module-crumbs {
          font-size: 0.82rem;
          color: #64748b;
          margin-bottom: 1.35rem;
        }
        .module-crumbs a {
          color: #0c7ab8;
          text-decoration: none;
          font-weight: 600;
        }
        .module-crumbs a:hover {
          text-decoration: underline;
        }
        .slash {
          margin: 0 0.4rem;
        }
        .module-h h1 {
          font-family: "Fraunces", serif;
          font-size: 1.85rem;
          font-weight: 700;
          color: #0f172a;
          letter-spacing: -0.025em;
        }
        .module-meta {
          color: #94a3b8;
          font-size: 0.85rem;
          margin-top: 0.35rem;
        }
        .module-desc {
          margin-top: 1rem;
          color: #475569;
          line-height: 1.65;
          font-size: 0.93rem;
        }
        .module-section {
          margin-top: 2.5rem;
          background: #fff;
          border-radius: 10px;
          border: 1px solid #e2e8f0;
          padding: 1.35rem 1.5rem 1.5rem;
          box-shadow: 0 1px 3px rgba(0, 0, 0, 0.05);
        }
        .module-section h2 {
          font-family: "Fraunces", serif;
          font-size: 1.1rem;
          color: #0f172a;
          margin-bottom: 1rem;
        }
        .lesson-rows {
          margin: 0;
          padding: 0;
          list-style: none;
          display: flex;
          flex-direction: column;
          gap: 0.45rem;
        }
        .lesson-row-link {
          display: flex;
          gap: 0.75rem;
          align-items: center;
          justify-content: space-between;
          padding: 0.75rem 0.95rem;
          border-radius: 8px;
          border: 1px solid #e2e8f0;
          text-decoration: none;
          color: #0f172a;
          transition: box-shadow 0.15s, border-color 0.15s;
        }
        .lesson-row-link:hover {
          border-color: #bae6fd;
          box-shadow: 0 2px 8px rgba(12, 122, 184, 0.12);
        }
        .lesson-ord {
          color: #0c7ab8;
          font-family: "Fraunces", serif;
          font-weight: 700;
          flex-shrink: 0;
          width: 1.75rem;
        }
        .lesson-name {
          flex: 1;
          font-size: 0.92rem;
          font-weight: 500;
        }
        .lesson-done {
          font-size: 0.75rem;
          font-weight: 600;
          color: #64748b;
          flex-shrink: 0;
        }
        .quiz-rows {
          display: flex;
          flex-direction: column;
          gap: 0.6rem;
        }
        .quiz-card {
          display: flex;
          justify-content: space-between;
          align-items: center;
          gap: 1rem;
          padding: 0.85rem 1rem;
          border-radius: 8px;
          border: 1px solid #e2e8f0;
          text-decoration: none;
          font-size: 0.85rem;
          color: #0f172a;
          transition: border-color 0.15s, box-shadow 0.15s;
        }
        .quiz-card:hover {
          border-color: #0c7ab8;
          box-shadow: 0 2px 8px rgba(12, 122, 184, 0.12);
        }
        .empty {
          color: #94a3b8;
          font-size: 0.9rem;
        }
        .module-progress-cards {
          display: grid;
          grid-template-columns: 1fr 1fr;
          gap: 1rem;
          margin-top: 1.25rem;
        }
        .mpc {
          background: #f8fafc;
          border: 1px solid #e2e8f0;
          border-radius: 8px;
          padding: 0.85rem 1rem;
        }
        .mpc-label { font-size: 0.75rem; color: #64748b; font-weight: 600; display: block; }
        .mpc-val { font-family: "Fraunces", serif; font-size: 1.2rem; font-weight: 700; color: #0f172a; }
        .mpc-bar {
          height: 6px; background: #e2e8f0; border-radius: 99px; margin-top: 0.5rem; overflow: hidden;
        }
        .mpc-fill { height: 100%; border-radius: 99px; }
        .mpc-fill.blue { background: #0c7ab8; }
        .mpc-fill.green { background: #16a34a; }
        .continue-cta {
          display: inline-block;
          margin-top: 1.25rem;
          background: #0c7ab8;
          color: #fff;
          font-weight: 700;
          font-size: 0.9rem;
          padding: 0.7rem 1.25rem;
          border-radius: 8px;
          text-decoration: none;
        }
        .continue-cta:hover { background: #085d8c; }
        .flow-section { margin-top: 1.5rem; }
        .flow-steps {
          margin: 0; padding: 0; list-style: none;
          display: flex; flex-direction: column; gap: 0.65rem;
        }
        .flow-steps li {
          display: flex; gap: 0.85rem; align-items: flex-start;
          padding: 0.75rem 0.9rem; border-radius: 8px; border: 1px solid #e2e8f0;
          background: #fff;
        }
        .flow-steps li.done { border-color: #bbf7d0; background: #fafffe; }
        .flow-steps li.active { border-color: #bae6fd; background: #f0f9ff; }
        .flow-num {
          width: 28px; height: 28px; border-radius: 50%;
          background: #e2e8f0; color: #64748b;
          display: flex; align-items: center; justify-content: center;
          font-size: 0.8rem; font-weight: 700; flex-shrink: 0;
        }
        .flow-steps li.done .flow-num { background: #dcfce7; color: #15803d; }
        .flow-steps li.active .flow-num { background: #0c7ab8; color: #fff; }
        .flow-steps strong { display: block; font-size: 0.9rem; color: #0f172a; }
        .flow-steps span { font-size: 0.8rem; color: #64748b; }
        .section-hint { font-size: 0.85rem; color: #64748b; margin: -0.5rem 0 1rem; }
        .done-row { border-left: 3px solid #22c55e; }
        .lesson-done.is-done { color: #16a34a; }
        .quiz-card.passed { border-color: #bbf7d0; }
        .quiz-card-main { flex: 1; }
        .quiz-card-sub { display: block; font-size: 0.78rem; color: #94a3b8; font-weight: 400; margin-top: 0.15rem; }
        .quiz-card-right { display: flex; align-items: center; gap: 0.5rem; }
        .grade-pill {
          font-size: 0.72rem; font-weight: 700; padding: 0.25rem 0.55rem; border-radius: 99px;
        }
        .grade-pill.pass { background: #dcfce7; color: #15803d; }
        .grade-pill.fail { background: #ffedd5; color: #c2410c; }
        .grade-pill.open { background: #f1f5f9; color: #64748b; }
        .quiz-arrow { color: #0c7ab8; font-weight: 600; }
        .grades-table {
          width: 100%; border-collapse: collapse; font-size: 0.85rem;
        }
        .grades-table th {
          text-align: left; padding: 0.6rem 0.75rem;
          border-bottom: 2px solid #e2e8f0; color: #64748b; font-weight: 600; font-size: 0.75rem;
          text-transform: uppercase; letter-spacing: 0.04em;
        }
        .grades-table td {
          padding: 0.75rem; border-bottom: 1px solid #f1f5f9; color: #334155;
        }
        .grades-table a { color: #0c7ab8; font-weight: 600; text-decoration: none; }
        .grades-table a:hover { text-decoration: underline; }
        .status-chip {
          font-size: 0.72rem; font-weight: 700; padding: 0.2rem 0.5rem; border-radius: 99px;
        }
        .status-chip.pass { background: #dcfce7; color: #15803d; }
        .status-chip.fail { background: #ffedd5; color: #c2410c; }
        .status-chip.none { background: #f1f5f9; color: #94a3b8; }
        @media (max-width: 600px) {
          .module-progress-cards { grid-template-columns: 1fr; }
          .grades-table { font-size: 0.78rem; }
          .grades-table th, .grades-table td { padding: 0.5rem 0.35rem; }
        }
      `}</style>
    </div>
  );
}
