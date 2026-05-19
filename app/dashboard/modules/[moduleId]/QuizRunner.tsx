"use client";

import { useMemo, useState } from "react";
import Link from "next/link";

type Question = {
  question: string;
  options: string[];
};

type BreakdownItem = {
  index: number;
  question: string;
  your_answer: number;
  correct_answer: number;
  is_correct: boolean;
  rationale: string | null;
};

export function QuizRunner({
  quizId,
  moduleId,
  title,
  passingScore,
  questions,
  priorBest,
}: {
  quizId: string;
  moduleId: number;
  title: string;
  passingScore: number;
  questions: Question[];
  priorBest?: { score: number; passed: boolean; attempts: number } | null;
}) {
  const [selections, setSelections] = useState<number[]>(() =>
    questions.map(() => -1)
  );
  const [busy, setBusy] = useState(false);
  const [result, setResult] = useState<{
    score: number;
    passed: boolean;
    correct: number;
    total: number;
    passing_score: number;
    breakdown: BreakdownItem[];
  } | null>(null);

  const answeredCount = useMemo(
    () => selections.filter((s) => s >= 0).length,
    [selections]
  );
  const allAnswered = answeredCount === questions.length;
  const progressPct = Math.round((answeredCount / questions.length) * 100);

  function resetAttempt() {
    setSelections(questions.map(() => -1));
    setResult(null);
    window.scrollTo({ top: 0, behavior: "smooth" });
  }

  async function submit() {
    if (!allAnswered || busy) return;
    setBusy(true);
    try {
      const res = await fetch("/api/student/quiz-submit", {
        method: "POST",
        headers: { "Content-Type": "application/json" },
        body: JSON.stringify({ quiz_id: quizId, answers: selections }),
      });
      const data = await res.json();
      if (!res.ok) throw new Error(data.error ?? "Submission failed");
      setResult({
        score: data.score,
        passed: data.passed,
        correct: data.correct,
        total: data.total,
        passing_score: data.passing_score,
        breakdown: data.breakdown ?? [],
      });
      window.scrollTo({ top: 0, behavior: "smooth" });
    } catch (e: unknown) {
      alert(e instanceof Error ? e.message : "Could not submit assignment");
    } finally {
      setBusy(false);
    }
  }

  const assessmentKind = title.toLowerCase().includes("true/false") ? "Quiz" : "Test";

  if (result) {
    return (
      <div className="quiz-shell">
        <div className={`grade-banner ${result.passed ? "pass" : "fail"}`}>
          <div className="grade-score-ring">
            <span className="grade-pct">{result.score}%</span>
            <span className="grade-label">Your grade</span>
          </div>
          <div className="grade-copy">
            <h2>{result.passed ? `${assessmentKind} passed` : "Keep studying — retake allowed"}</h2>
            <p>
              {result.correct} of {result.total} correct · Passing score is{" "}
              {result.passing_score}%
            </p>
            {!result.passed && (
              <p className="grade-tip">
                Review the rationales below, revisit the lessons, then submit again.
              </p>
            )}
          </div>
        </div>

        <section className="review-section">
          <h3>Answer review</h3>
          <ol className="review-list">
            {result.breakdown.map((item) => (
              <li
                key={item.index}
                className={`review-item ${item.is_correct ? "ok" : "miss"}`}
              >
                <div className="review-head">
                  <span className="review-badge">
                    {item.is_correct ? "Correct" : "Incorrect"}
                  </span>
                  <span className="review-qnum">Q{item.index}</span>
                </div>
                <p className="review-q">{item.question}</p>
                {!item.is_correct && questions[item.index - 1] && (
                  <p className="review-ans">
                    Your answer:{" "}
                    <strong>
                      {questions[item.index - 1].options[item.your_answer] ?? "—"}
                    </strong>
                    <br />
                    Correct answer:{" "}
                    <strong>
                      {questions[item.index - 1].options[item.correct_answer] ?? "—"}
                    </strong>
                  </p>
                )}
                {item.rationale && (
                  <p className="review-rationale">
                    <strong>Rationale:</strong> {item.rationale}
                  </p>
                )}
              </li>
            ))}
          </ol>
        </section>

        <div className="grade-actions">
          {!result.passed && (
            <button type="button" className="btn-primary" onClick={resetAttempt}>
              Retake {assessmentKind.toLowerCase()}
            </button>
          )}
          <Link href={`/dashboard/modules/${moduleId}#grades`} className="btn-secondary">
            View all grades
          </Link>
          <Link href={`/dashboard/modules/${moduleId}`} className="btn-link">
            Back to module
          </Link>
        </div>

        <style jsx>{quizStyles}</style>
      </div>
    );
  }

  return (
    <div className="quiz-shell">
      <div className="quiz-head">
        <span className="assignment-tag">{assessmentKind}</span>
        <h2 className="quiz-title">{title}</h2>
        <p className="quiz-pass">
          {questions.length} questions · {passingScore}% required to pass
        </p>
        {priorBest && priorBest.attempts > 0 && (
          <p className="prior-best">
            Previous best: <strong>{priorBest.score}%</strong>
            {priorBest.passed ? " (passed)" : " (not passing yet)"}
          </p>
        )}
      </div>

      <div className="progress-track" aria-label="Questions answered">
        <div className="progress-meta">
          <span>
            {answeredCount} / {questions.length} answered
          </span>
          <span>{progressPct}%</span>
        </div>
        <div className="progress-bar">
          <div className="progress-fill" style={{ width: `${progressPct}%` }} />
        </div>
      </div>

      <ol className="quiz-qlist">
        {questions.map((q, qi) => (
          <li key={`q-${qi}`} className="quiz-qwrap">
            <p className="quiz-q">
              <span className="q-num">{qi + 1}.</span> {q.question}
            </p>
            <div className="quiz-opts">
              {q.options.map((opt, oi) => (
                <label
                  key={`${qi}-${oi}`}
                  className={`quiz-optlab ${selections[qi] === oi ? "selected" : ""}`}
                >
                  <input
                    type="radio"
                    name={`quiz-q-${qi}`}
                    checked={selections[qi] === oi}
                    onChange={() => {
                      const next = [...selections];
                      next[qi] = oi;
                      setSelections(next);
                    }}
                  />
                  <span>{opt}</span>
                </label>
              ))}
            </div>
          </li>
        ))}
      </ol>

      <div className="submit-bar">
        <div className="submit-inner">
          <span className="submit-status">
            {allAnswered
              ? "Ready to submit"
              : `${questions.length - answeredCount} question(s) remaining`}
          </span>
          <button
            type="button"
            className="btn-primary"
            disabled={!allAnswered || busy}
            onClick={submit}
          >
            {busy ? "Submitting…" : "Submit assignment"}
          </button>
        </div>
      </div>

      <style jsx>{quizStyles}</style>
    </div>
  );
}

const quizStyles = `
  .quiz-shell { max-width: 720px; margin: 0 auto; padding-bottom: 5rem; }
  .assignment-tag {
    display: inline-block;
    background: #e0f4ff;
    color: #0c7ab8;
    font-size: 0.72rem;
    font-weight: 700;
    text-transform: uppercase;
    letter-spacing: 0.06em;
    padding: 0.25rem 0.6rem;
    border-radius: 99px;
    margin-bottom: 0.5rem;
  }
  .quiz-head { margin-bottom: 1.25rem; }
  .quiz-title {
    font-family: Fraunces, serif;
    font-size: 1.35rem;
    color: #0f172a;
    letter-spacing: -0.02em;
  }
  .quiz-pass { color: #64748b; font-size: 0.9rem; margin-top: 0.35rem; }
  .prior-best {
    margin-top: 0.5rem;
    font-size: 0.85rem;
    color: #475569;
    background: #f8fafc;
    border: 1px solid #e2e8f0;
    padding: 0.45rem 0.75rem;
    border-radius: 6px;
    display: inline-block;
  }
  .progress-track { margin-bottom: 2rem; }
  .progress-meta {
    display: flex;
    justify-content: space-between;
    font-size: 0.8rem;
    color: #64748b;
    font-weight: 600;
    margin-bottom: 0.35rem;
  }
  .progress-bar {
    height: 8px;
    background: #e2e8f0;
    border-radius: 99px;
    overflow: hidden;
  }
  .progress-fill {
    height: 100%;
    background: linear-gradient(90deg, #0c7ab8, #38bdf8);
    border-radius: 99px;
    transition: width 0.2s ease;
  }
  .quiz-qlist {
    margin: 0;
    padding: 0;
    list-style: none;
    display: flex;
    flex-direction: column;
    gap: 1.75rem;
  }
  .quiz-qwrap {
    background: #fff;
    border: 1px solid #e2e8f0;
    border-radius: 10px;
    padding: 1.15rem 1.25rem;
  }
  .quiz-q {
    font-weight: 600;
    color: #0f172a;
    margin-bottom: 0.85rem;
    line-height: 1.5;
    font-size: 0.95rem;
  }
  .q-num { color: #0c7ab8; font-family: Fraunces, serif; }
  .quiz-opts { display: flex; flex-direction: column; gap: 0.5rem; }
  .quiz-optlab {
    display: flex;
    gap: 0.6rem;
    align-items: flex-start;
    font-size: 0.92rem;
    color: #334155;
    cursor: pointer;
    line-height: 1.45;
    padding: 0.55rem 0.65rem;
    border-radius: 8px;
    border: 1px solid transparent;
    transition: background 0.12s, border-color 0.12s;
  }
  .quiz-optlab:hover { background: #f8fafc; }
  .quiz-optlab.selected {
    background: #f0f9ff;
    border-color: #bae6fd;
  }
  .quiz-optlab input { margin-top: 0.2rem; accent-color: #0c7ab8; }
  .submit-bar {
    position: fixed;
    bottom: 0;
    left: 0;
    right: 0;
    background: rgba(255,255,255,0.95);
    border-top: 1px solid #e2e8f0;
    backdrop-filter: blur(8px);
    padding: 0.85rem 1.25rem;
    z-index: 40;
  }
  .submit-inner {
    max-width: 720px;
    margin: 0 auto;
    display: flex;
    align-items: center;
    justify-content: space-between;
    gap: 1rem;
    flex-wrap: wrap;
  }
  .submit-status { font-size: 0.85rem; color: #64748b; font-weight: 500; }
  .btn-primary {
    background: #0c7ab8;
    border: none;
    color: #fff;
    font-weight: 700;
    font-size: 0.9rem;
    padding: 0.65rem 1.35rem;
    border-radius: 8px;
    cursor: pointer;
  }
  .btn-primary:disabled { opacity: 0.45; cursor: not-allowed; }
  .btn-primary:not(:disabled):hover { background: #085d8c; }
  .btn-secondary {
    display: inline-block;
    background: #fff;
    border: 1px solid #0c7ab8;
    color: #0c7ab8;
    font-weight: 600;
    font-size: 0.88rem;
    padding: 0.55rem 1.1rem;
    border-radius: 8px;
    text-decoration: none;
  }
  .btn-link {
    color: #64748b;
    font-weight: 600;
    font-size: 0.88rem;
    text-decoration: none;
  }
  .btn-link:hover { color: #0c7ab8; }
  .grade-banner {
    display: flex;
    gap: 1.25rem;
    align-items: center;
    padding: 1.35rem 1.5rem;
    border-radius: 12px;
    margin-bottom: 2rem;
    flex-wrap: wrap;
  }
  .grade-banner.pass {
    background: linear-gradient(135deg, #f0fdf4, #dcfce7);
    border: 1px solid #bbf7d0;
  }
  .grade-banner.fail {
    background: linear-gradient(135deg, #fff7ed, #ffedd5);
    border: 1px solid #fed7aa;
  }
  .grade-score-ring {
    width: 88px;
    height: 88px;
    border-radius: 50%;
    background: #fff;
    display: flex;
    flex-direction: column;
    align-items: center;
    justify-content: center;
    box-shadow: 0 2px 12px rgba(0,0,0,0.06);
    flex-shrink: 0;
  }
  .grade-pct {
    font-family: Fraunces, serif;
    font-size: 1.5rem;
    font-weight: 700;
    color: #0f172a;
    line-height: 1;
  }
  .grade-label { font-size: 0.65rem; color: #64748b; margin-top: 0.15rem; }
  .grade-copy h2 {
    font-family: Fraunces, serif;
    font-size: 1.15rem;
    color: #0f172a;
    margin-bottom: 0.35rem;
  }
  .grade-copy p { font-size: 0.9rem; color: #475569; margin: 0; }
  .grade-tip { margin-top: 0.5rem !important; font-size: 0.85rem !important; }
  .review-section h3 {
    font-family: Fraunces, serif;
    font-size: 1.05rem;
    margin-bottom: 1rem;
    color: #0f172a;
  }
  .review-list {
    margin: 0;
    padding: 0;
    list-style: none;
    display: flex;
    flex-direction: column;
    gap: 0.75rem;
  }
  .review-item {
    border-radius: 8px;
    padding: 1rem 1.1rem;
    border: 1px solid #e2e8f0;
  }
  .review-item.ok { background: #fafffe; border-left: 3px solid #22c55e; }
  .review-item.miss { background: #fffbf7; border-left: 3px solid #f97316; }
  .review-head {
    display: flex;
    align-items: center;
    gap: 0.5rem;
    margin-bottom: 0.45rem;
  }
  .review-badge {
    font-size: 0.7rem;
    font-weight: 700;
    text-transform: uppercase;
    letter-spacing: 0.04em;
    padding: 0.15rem 0.45rem;
    border-radius: 4px;
  }
  .ok .review-badge { background: #dcfce7; color: #15803d; }
  .miss .review-badge { background: #ffedd5; color: #c2410c; }
  .review-qnum { font-size: 0.75rem; color: #94a3b8; }
  .review-q { font-weight: 600; font-size: 0.92rem; color: #0f172a; margin-bottom: 0.5rem; }
  .review-ans { font-size: 0.85rem; color: #475569; line-height: 1.55; margin-bottom: 0.45rem; }
  .review-rationale {
    font-size: 0.85rem;
    color: #334155;
    background: #f8fafc;
    padding: 0.55rem 0.7rem;
    border-radius: 6px;
    line-height: 1.5;
    margin: 0;
  }
  .grade-actions {
    display: flex;
    flex-wrap: wrap;
    gap: 0.75rem;
    margin-top: 2rem;
    align-items: center;
  }
`;
