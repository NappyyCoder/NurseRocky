export const dynamic = "force-dynamic";
export const revalidate = 0;

import { redirect } from "next/navigation";
import Link from "next/link";
import { enrolledStudentCanVisitModule } from "@/lib/server/course-completion";
import { requireEnrolledStudentId } from "@/lib/server/student-portal-session";
import { supabaseAdmin } from "@/lib/supabase";
import { QuizRunner } from "../../QuizRunner";
import { getModuleQuizGrades } from "@/lib/server/student-quiz-grades";

export default async function ModuleQuizPage(props: {
  params: Promise<{ moduleId: string; quizId: string }>;
}) {
  const params = await props.params;
  const moduleIdNum = Number.parseInt(params.moduleId, 10);
  if (!Number.isFinite(moduleIdNum)) redirect("/dashboard");

  const studentId = await requireEnrolledStudentId();

  const allowed = await enrolledStudentCanVisitModule({
    studentId,
    moduleId: moduleIdNum,
  });
  if (!allowed) redirect("/dashboard");

  const [{ data: quizMeta }, { data: rawQs }] = await Promise.all([
    supabaseAdmin
      .from("quizzes")
      .select("id, module_id, title, passing_score")
      .eq("id", params.quizId)
      .maybeSingle(),
    supabaseAdmin
      .from("quiz_questions")
      .select("question, options, order_num")
      .eq("quiz_id", params.quizId)
      .order("order_num"),
  ]);

  const quizMetaRow = quizMeta as {
    module_id?: number;
    title?: string;
    passing_score?: number;
  } | null;

  if (
    !quizMetaRow ||
    !rawQs?.length ||
    quizMetaRow.module_id !== moduleIdNum
  ) {
    redirect("/dashboard");
  }

  const sanitized = rawQs.map((r) => {
    const qq = r as {
      question: string;
      options?: unknown;
    };
    let opts: unknown = qq.options;
    if (!Array.isArray(opts) && qq.options !== undefined) {
      try {
        opts = JSON.parse(String(qq.options)) as string[];
      } catch {
        opts = [];
      }
    }
    const list = Array.isArray(opts) ? (opts as string[]) : [];
    return {
      question: qq.question,
      options: list,
    };
  });

  const grades = await getModuleQuizGrades(studentId, moduleIdNum);
  const thisGrade = grades.find((g) => g.quiz_id === params.quizId);
  const priorBest = thisGrade?.attempts
    ? {
        score: thisGrade.best_score,
        passed: thisGrade.passed,
        attempts: thisGrade.attempts,
      }
    : null;

  return (
    <div className="quiz-page">
      <div className="quiz-page-inner">
        <nav className="quiz-bc">
          <Link href="/dashboard">Dashboard</Link>
          <span>/</span>
          <Link href={`/dashboard/modules/${moduleIdNum}`}>Module</Link>
          <span>/</span>
          <span>Quiz</span>
        </nav>

        <QuizRunner
          quizId={params.quizId}
          moduleId={moduleIdNum}
          title={quizMetaRow.title ?? "Quiz"}
          passingScore={quizMetaRow.passing_score ?? 70}
          questions={sanitized}
          priorBest={priorBest}
        />

        <p className="quiz-foot">
          Answers are graded immediately yet you should review missed items in your
          notes before clinical practice.
        </p>
      </div>

      <style>{`
        .quiz-page {
          background: #f8fafc;
          min-height: 100vh;
          padding: 2rem 1.25rem 3rem;
        }
        .quiz-page-inner {
          max-width: 760px;
          margin: 0 auto;
          background: #fff;
          border-radius: 10px;
          border: 1px solid #e2e8f0;
          padding: 1.85rem 1.75rem 2.25rem;
          box-shadow: 0 1px 4px rgba(0, 0, 0, 0.05);
        }
        .quiz-bc {
          font-family: "DM Sans", system-ui, sans-serif;
          font-size: 0.8rem;
          color: #64748b;
          margin-bottom: 1.5rem;
          display: flex;
          flex-wrap: wrap;
          gap: 0.35rem;
          align-items: center;
        }
        .quiz-bc a {
          color: #93b7a9;
          font-weight: 600;
          text-decoration: none;
        }
        .quiz-bc a:hover {
          text-decoration: underline;
        }
        .quiz-foot {
          margin-top: 2.25rem;
          font-family: "DM Sans", system-ui;
          font-size: 0.82rem;
          color: #94a3b8;
          line-height: 1.55;
        }
      `}</style>
    </div>
  );
}
