"use client";

import { useCallback, useEffect, useState } from "react";
import { adminRequest } from "@/lib/admin-fetch";

interface Module {
  id: number;
  title: string;
  description: string | null;
  order_num: number;
  lessons_count: number;
  duration_min: number;
  is_published: boolean;
}

interface Lesson {
  id: string;
  module_id: number;
  title: string;
  content: string | null;
  video_url: string | null;
  duration_min: number;
  order_num: number;
}

interface QuizQuestion {
  id: string;
  quiz_id: string;
  question: string;
  options: string[];
  correct_answer: number;
  order_num: number;
  rationale: string | null;
}

interface Quiz {
  id: string;
  module_id: number;
  title: string;
  passing_score: number;
  questions: QuizQuestion[];
}

export function ModuleDetailPanel({
  moduleId,
  onBack,
  onSaved,
}: {
  moduleId: number;
  onBack: () => void;
  onSaved: () => void;
}) {
  const [module, setModule] = useState<Module | null>(null);
  const [lessons, setLessons] = useState<Lesson[]>([]);
  const [quizzes, setQuizzes] = useState<Quiz[]>([]);
  const [loading, setLoading] = useState(true);
  const [saving, setSaving] = useState(false);
  const [msg, setMsg] = useState("");
  const [msgError, setMsgError] = useState(false);

  const [modForm, setModForm] = useState({
    title: "",
    description: "",
    order_num: 1,
    is_published: true,
  });

  const [editingLesson, setEditingLesson] = useState<Lesson | "new" | null>(null);
  const [lessonForm, setLessonForm] = useState({
    title: "",
    content: "",
    video_url: "",
    duration_min: 45,
    order_num: 1,
  });

  const [editingQuiz, setEditingQuiz] = useState<Quiz | "new" | null>(null);
  const [quizForm, setQuizForm] = useState({ title: "", passing_score: 70 });

  const [editingQuestion, setEditingQuestion] = useState<QuizQuestion | "new" | null>(null);
  const [activeQuizId, setActiveQuizId] = useState<string | null>(null);
  const [questionForm, setQuestionForm] = useState({
    question: "",
    options: ["", "", "", ""],
    correct_answer: 0,
    order_num: 1,
    rationale: "",
  });

  const load = useCallback(async () => {
    setLoading(true);
    const res = await fetch(`/api/admin/module-detail?moduleId=${moduleId}`);
    if (res.ok) {
      const data = await res.json();
      setModule(data.module);
      setLessons(data.lessons);
      setQuizzes(data.quizzes);
      setModForm({
        title: data.module.title,
        description: data.module.description ?? "",
        order_num: data.module.order_num,
        is_published: data.module.is_published,
      });
    }
    setLoading(false);
  }, [moduleId]);

  useEffect(() => {
    load();
  }, [load]);

  function flash(text: string, isError = false) {
    setMsg(text);
    setMsgError(isError);
    setTimeout(() => {
      setMsg("");
      setMsgError(false);
    }, isError ? 8000 : 3000);
  }

  async function saveModule() {
    setSaving(true);
    const result = await adminRequest("/api/admin/modules", {
      method: "PUT",
      body: JSON.stringify({ id: moduleId, ...modForm }),
    });
    setSaving(false);
    if (result.ok === false) {
      flash(result.error, true);
      return;
    }
    flash("Module saved — live for all students");
    onSaved();
    load();
  }

  function startNewLesson() {
    setEditingLesson("new");
    setLessonForm({
      title: "",
      content: "",
      video_url: "",
      duration_min: 45,
      order_num: lessons.length + 1,
    });
  }

  async function loadLessonPreview(lessonId?: string) {
    const res = await fetch(
      `/api/admin/lesson-preview?moduleId=${moduleId}&orderNum=${lessonForm.order_num}${lessonId ? `&lessonId=${lessonId}` : ""}`
    );
    if (res.ok) {
      const data = await res.json();
      setLessonForm((f) => ({ ...f, content: data.liveHtml || data.curriculumDefault || "" }));
      flash(data.source === "database" ? "Loaded saved content" : "Loaded curriculum default");
    }
  }

  function startEditLesson(lesson: Lesson) {
    setEditingLesson(lesson);
    setLessonForm({
      title: lesson.title,
      content: lesson.content ?? "",
      video_url: lesson.video_url ?? "",
      duration_min: lesson.duration_min,
      order_num: lesson.order_num,
    });
  }

  async function saveLesson() {
    setSaving(true);
    const payload =
      editingLesson === "new"
        ? { module_id: moduleId, ...lessonForm }
        : { id: editingLesson!.id, module_id: moduleId, ...lessonForm };
    const result = await adminRequest("/api/admin/lessons", {
      method: editingLesson === "new" ? "POST" : "PUT",
      body: JSON.stringify(payload),
    });
    setSaving(false);
    if (result.ok === false) {
      flash(result.error, true);
      return;
    }
    setEditingLesson(null);
    flash("Lesson saved to Supabase — students will see it on refresh");
    onSaved();
    load();
  }

  async function deleteLesson(id: string) {
    if (!confirm("Delete this lesson?")) return;
    const result = await adminRequest("/api/admin/lessons", {
      method: "DELETE",
      body: JSON.stringify({ id, module_id: moduleId }),
    });
    if (result.ok === false) {
      flash(result.error, true);
      return;
    }
    flash("Lesson deleted");
    onSaved();
    load();
  }

  function startNewQuiz() {
    setEditingQuiz("new");
    setQuizForm({ title: "", passing_score: 70 });
  }

  function startEditQuiz(quiz: Quiz) {
    setEditingQuiz(quiz);
    setQuizForm({ title: quiz.title, passing_score: quiz.passing_score });
    setActiveQuizId(quiz.id);
  }

  async function saveQuiz() {
    setSaving(true);
    const result = await adminRequest("/api/admin/quizzes", {
      method: editingQuiz === "new" ? "POST" : "PUT",
      body: JSON.stringify(
        editingQuiz === "new"
          ? { module_id: moduleId, ...quizForm }
          : { id: editingQuiz!.id, ...quizForm }
      ),
    });
    setSaving(false);
    if (result.ok === false) {
      flash(result.error, true);
      return;
    }
    setEditingQuiz(null);
    flash("Quiz saved to Supabase");
    load();
  }

  async function deleteQuiz(id: string) {
    if (!confirm("Delete this quiz and all its questions?")) return;
    const result = await adminRequest("/api/admin/quizzes", {
      method: "DELETE",
      body: JSON.stringify({ id }),
    });
    if (result.ok === false) {
      flash(result.error, true);
      return;
    }
    flash("Quiz deleted");
    load();
  }

  function startNewQuestion(quizId: string, orderNum: number) {
    setActiveQuizId(quizId);
    setEditingQuestion("new");
    setQuestionForm({
      question: "",
      options: ["", "", "", ""],
      correct_answer: 0,
      order_num: orderNum,
      rationale: "",
    });
  }

  function startEditQuestion(q: QuizQuestion) {
    setActiveQuizId(q.quiz_id);
    setEditingQuestion(q);
    const opts = [...q.options];
    while (opts.length < 4) opts.push("");
    setQuestionForm({
      question: q.question,
      options: opts.slice(0, 4),
      correct_answer: q.correct_answer,
      order_num: q.order_num,
      rationale: q.rationale ?? "",
    });
  }

  async function saveQuestion() {
    if (!activeQuizId) return;
    setSaving(true);
    const options = questionForm.options.map((o) => o.trim()).filter(Boolean);
    const payload = {
      quiz_id: activeQuizId,
      question: questionForm.question,
      options,
      correct_answer: questionForm.correct_answer,
      order_num: questionForm.order_num,
      rationale: questionForm.rationale || null,
    };

    const result = await adminRequest("/api/admin/quiz-questions", {
      method: editingQuestion === "new" ? "POST" : "PUT",
      body: JSON.stringify(
        editingQuestion === "new"
          ? payload
          : { id: editingQuestion!.id, ...payload }
      ),
    });
    setSaving(false);
    if (result.ok === false) {
      flash(result.error, true);
      return;
    }
    setEditingQuestion(null);
    flash("Question saved to Supabase");
    load();
  }

  async function deleteQuestion(id: string) {
    if (!confirm("Delete this question?")) return;
    const result = await adminRequest("/api/admin/quiz-questions", {
      method: "DELETE",
      body: JSON.stringify({ id }),
    });
    if (result.ok === false) {
      flash(result.error, true);
      return;
    }
    flash("Question deleted");
    load();
  }

  if (loading) return <div className="loading">Loading module…</div>;

  return (
    <div className="module-detail">
      <div className="detail-top">
        <button type="button" className="row-btn" onClick={onBack}>← Back to modules</button>
        {msg && <span className={`flash-msg ${msgError ? "err" : ""}`}>{msg}</span>}
      </div>

      <p className="section-hint sync-notice">
        Changes save to the live course — all enrolled students see updates on their next page load.
      </p>

      <div className="form-card">
        <h3 className="form-title">Module settings</h3>
        <div className="form-grid">
          <label className="form-label">Title
            <input className="form-input" value={modForm.title} onChange={(e) => setModForm((f) => ({ ...f, title: e.target.value }))} />
          </label>
          <label className="form-label">Order #
            <input className="form-input" type="number" value={modForm.order_num} onChange={(e) => setModForm((f) => ({ ...f, order_num: +e.target.value }))} />
          </label>
          <label className="form-label" style={{ gridColumn: "1 / -1" }}>Description
            <textarea className="form-input" rows={3} value={modForm.description} onChange={(e) => setModForm((f) => ({ ...f, description: e.target.value }))} placeholder="Learning objectives, topics, assessment info…" />
          </label>
          <label className="form-label" style={{ display: "flex", alignItems: "center", gap: ".5rem", flexDirection: "row" }}>
            <input type="checkbox" checked={modForm.is_published} onChange={(e) => setModForm((f) => ({ ...f, is_published: e.target.checked }))} />
            Published (visible to students)
          </label>
        </div>
        <div className="form-actions">
          <button type="button" className="admin-btn" onClick={saveModule} disabled={saving || !modForm.title}>
            {saving ? "Saving…" : "Save module"}
          </button>
          {module && (
            <span className="detail-meta">{lessons.length} lessons · {module.duration_min} min total</span>
          )}
        </div>
      </div>

      <section className="detail-section">
        <div className="section-head">
          <h3 className="form-title">Lessons</h3>
          <button type="button" className="admin-btn" onClick={startNewLesson}>+ Add lesson</button>
        </div>
        {moduleId === 1 && (
          <p className="section-hint">Module 1 uses built-in curriculum text by default. Saving lesson content here overrides it for students.</p>
        )}

        {editingLesson && (
          <div className="form-card nested">
            <h4 className="form-subtitle">{editingLesson === "new" ? "New lesson" : "Edit lesson"}</h4>
            <div className="form-grid">
              <label className="form-label">Title
                <input className="form-input" value={lessonForm.title} onChange={(e) => setLessonForm((f) => ({ ...f, title: e.target.value }))} />
              </label>
              <label className="form-label">Order #
                <input className="form-input" type="number" value={lessonForm.order_num} onChange={(e) => setLessonForm((f) => ({ ...f, order_num: +e.target.value }))} />
              </label>
              <label className="form-label">Duration (min)
                <input className="form-input" type="number" value={lessonForm.duration_min} onChange={(e) => setLessonForm((f) => ({ ...f, duration_min: +e.target.value }))} />
              </label>
              <label className="form-label">Video URL (optional)
                <input className="form-input" value={lessonForm.video_url} onChange={(e) => setLessonForm((f) => ({ ...f, video_url: e.target.value }))} placeholder="https://…" />
              </label>
              <label className="form-label" style={{ gridColumn: "1 / -1" }}>Content (HTML)
                <textarea className="form-input mono" rows={8} value={lessonForm.content} onChange={(e) => setLessonForm((f) => ({ ...f, content: e.target.value }))} placeholder="<section>…</section>" />
              </label>
            </div>
            <div className="form-actions">
              {moduleId === 1 && (
                <button
                  type="button"
                  className="row-btn"
                  onClick={() =>
                    loadLessonPreview(editingLesson !== "new" && editingLesson ? editingLesson.id : undefined)
                  }
                >
                  Load what students see
                </button>
              )}
              <button type="button" className="admin-btn" onClick={saveLesson} disabled={saving || !lessonForm.title}>{saving ? "Saving…" : "Save lesson"}</button>
              <button type="button" className="row-btn" onClick={() => setEditingLesson(null)}>Cancel</button>
            </div>
          </div>
        )}

        <div className="detail-list">
          {lessons.map((lesson) => (
            <div className="detail-row" key={lesson.id}>
              <div>
                <strong>{lesson.order_num}. {lesson.title}</strong>
                <span className="detail-row-meta">{lesson.duration_min} min{lesson.content ? " · custom content" : ""}</span>
              </div>
              <div className="detail-row-actions">
                <button type="button" className="row-btn" onClick={() => startEditLesson(lesson)}>Edit</button>
                <button type="button" className="row-btn danger" onClick={() => deleteLesson(lesson.id)}>Delete</button>
              </div>
            </div>
          ))}
          {lessons.length === 0 && <p className="empty-inline">No lessons yet.</p>}
        </div>
      </section>

      <section className="detail-section">
        <div className="section-head">
          <h3 className="form-title">Quizzes &amp; tests</h3>
          <button type="button" className="admin-btn" onClick={startNewQuiz}>+ Add quiz</button>
        </div>

        {editingQuiz && (
          <div className="form-card nested">
            <h4 className="form-subtitle">{editingQuiz === "new" ? "New quiz" : "Edit quiz"}</h4>
            <div className="form-grid">
              <label className="form-label">Title
                <input className="form-input" value={quizForm.title} onChange={(e) => setQuizForm((f) => ({ ...f, title: e.target.value }))} />
              </label>
              <label className="form-label">Passing score (%)
                <input className="form-input" type="number" min={0} max={100} value={quizForm.passing_score} onChange={(e) => setQuizForm((f) => ({ ...f, passing_score: +e.target.value }))} />
              </label>
            </div>
            <div className="form-actions">
              <button type="button" className="admin-btn" onClick={saveQuiz} disabled={saving || !quizForm.title}>{saving ? "Saving…" : "Save quiz"}</button>
              <button type="button" className="row-btn" onClick={() => setEditingQuiz(null)}>Cancel</button>
            </div>
          </div>
        )}

        {quizzes.map((quiz) => (
          <div className="quiz-block" key={quiz.id}>
            <div className="detail-row">
              <div>
                <strong>{quiz.title}</strong>
                <span className="detail-row-meta">{quiz.questions.length} questions · {quiz.passing_score}% to pass</span>
              </div>
              <div className="detail-row-actions">
                <button type="button" className="row-btn" onClick={() => startEditQuiz(quiz)}>Edit</button>
                <button type="button" className="row-btn" onClick={() => { setActiveQuizId(quiz.id); startNewQuestion(quiz.id, quiz.questions.length + 1); }}>+ Question</button>
                <button type="button" className="row-btn danger" onClick={() => deleteQuiz(quiz.id)}>Delete</button>
              </div>
            </div>

            {activeQuizId === quiz.id && editingQuestion && (
              <div className="form-card nested">
                <h4 className="form-subtitle">{editingQuestion === "new" ? "New question" : "Edit question"}</h4>
                <label className="form-label" style={{ display: "block", marginBottom: "1rem" }}>Question
                  <textarea className="form-input" rows={2} value={questionForm.question} onChange={(e) => setQuestionForm((f) => ({ ...f, question: e.target.value }))} />
                </label>
                <div className="options-grid">
                  {questionForm.options.map((opt, i) => (
                    <label className="form-label" key={i}>
                      <span className="opt-label">
                        <input type="radio" name="correct" checked={questionForm.correct_answer === i} onChange={() => setQuestionForm((f) => ({ ...f, correct_answer: i }))} />
                        Option {i + 1} {questionForm.correct_answer === i && <em>(correct)</em>}
                      </span>
                      <input className="form-input" value={opt} onChange={(e) => setQuestionForm((f) => ({ ...f, options: f.options.map((o, j) => (j === i ? e.target.value : o)) }))} />
                    </label>
                  ))}
                </div>
                <label className="form-label" style={{ display: "block", marginTop: "1rem" }}>Rationale (shown after submit)
                  <textarea className="form-input" rows={2} value={questionForm.rationale} onChange={(e) => setQuestionForm((f) => ({ ...f, rationale: e.target.value }))} />
                </label>
                <div className="form-actions">
                  <button type="button" className="admin-btn" onClick={saveQuestion} disabled={saving || !questionForm.question}>{saving ? "Saving…" : "Save question"}</button>
                  <button type="button" className="row-btn" onClick={() => setEditingQuestion(null)}>Cancel</button>
                </div>
              </div>
            )}

            <ol className="question-list">
              {quiz.questions.map((q) => (
                <li key={q.id}>
                  <span>{q.order_num}. {q.question}</span>
                  <div className="detail-row-actions">
                    <button type="button" className="row-btn" onClick={() => startEditQuestion(q)}>Edit</button>
                    <button type="button" className="row-btn danger" onClick={() => deleteQuestion(q.id)}>Delete</button>
                  </div>
                </li>
              ))}
            </ol>
          </div>
        ))}
        {quizzes.length === 0 && <p className="empty-inline">No quizzes yet.</p>}
      </section>

      <style>{`
        .sync-notice { margin: 0; padding: .75rem 1rem; background: #e8f2ef; border-radius: 8px; border: 1px solid #c3d9d2; color: #6b9e8e; }
        .detail-top { display: flex; align-items: center; gap: 1rem; }
        .flash-msg { color: #6b9e8e; font-weight: 600; font-size: .9rem; }
        .flash-msg.err { color: #dc2626; max-width: 520px; line-height: 1.4; }
        .detail-section { background: #fff; border: 1px solid #d8e4df; border-radius: 8px; padding: 1.25rem; }
        .detail-meta { font-size: .85rem; color: #5c6b66; }
        .section-hint { font-size: .85rem; color: #5c6b66; margin: 0 0 1rem; line-height: 1.5; }
        .form-subtitle { font-size: .95rem; font-weight: 700; color: #0f1a17; margin-bottom: 1rem; }
        .form-card.nested { margin-top: 1rem; margin-bottom: 1rem; background: #f4f8f6; }
        .detail-list { display: flex; flex-direction: column; gap: .5rem; }
        .detail-row { display: flex; justify-content: space-between; align-items: center; gap: 1rem; padding: .75rem 0; border-bottom: 1px solid #eef3f0; }
        .detail-row:last-child { border-bottom: none; }
        .detail-row-meta { display: block; font-size: .8rem; color: #8a9691; margin-top: .15rem; }
        .detail-row-actions { display: flex; flex-shrink: 0; }
        .empty-inline { color: #8a9691; font-size: .9rem; margin: .5rem 0; }
        .quiz-block { margin-top: 1rem; padding-top: 1rem; border-top: 1px solid #d8e4df; }
        .question-list { list-style: none; margin: .75rem 0 0; padding: 0; }
        .question-list li { display: flex; justify-content: space-between; align-items: flex-start; gap: 1rem; padding: .5rem 0; font-size: .875rem; color: #2f3d38; border-bottom: 1px solid #f4f8f6; }
        .options-grid { display: grid; grid-template-columns: 1fr 1fr; gap: .75rem; }
        .opt-label { display: flex; align-items: center; gap: .4rem; font-size: .8rem; }
        .form-input.mono { font-family: ui-monospace, monospace; font-size: .82rem; }
        @media (max-width: 700px) { .options-grid { grid-template-columns: 1fr; } .detail-row { flex-direction: column; align-items: flex-start; } }
      `}</style>
    </div>
  );
}
