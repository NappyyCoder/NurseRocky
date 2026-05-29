export const dynamic = "force-dynamic";
export const revalidate = 0;

import { redirect } from "next/navigation";
import Link from "next/link";
import { CompleteLessonButton } from "./CompleteLessonButton";
import { LessonTimeTracker } from "@/app/dashboard/components/LessonTimeTracker";
import { InteractiveSimulations } from "@/app/dashboard/components/InteractiveSimulations";
import { enrolledStudentCanVisitModule } from "@/lib/server/course-completion";
import { requireEnrolledStudentId } from "@/lib/server/student-portal-session";
import { supabaseAdmin } from "@/lib/supabase";
import { getAugmentedLessonHtml } from "@/lib/course/lesson-html";
import type { Lesson } from "@/lib/types";

export default async function LessonPage(props: {
  params: Promise<{ moduleId: string; lessonId: string }>;
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

  const { data: lessonRow } = await supabaseAdmin
    .from("lessons")
    .select("*")
    .eq("id", params.lessonId)
    .maybeSingle();

  const lesson = lessonRow as Lesson | null;
  if (!lesson || lesson.module_id !== moduleIdNum) redirect("/dashboard");

  const { data: sibs } = await supabaseAdmin
    .from("lessons")
    .select("id, order_num, title")
    .eq("module_id", moduleIdNum)
    .order("order_num");

  const siblings = (sibs ?? []) as Pick<Lesson, "id" | "order_num" | "title">[];
  const idx = siblings.findIndex((s) => s.id === lesson.id);
  const prev = idx > 0 ? siblings[idx - 1] : null;
  const next = idx >= 0 && idx < siblings.length - 1 ? siblings[idx + 1] : null;

  const bodyHtml = getAugmentedLessonHtml(
    lesson.module_id,
    lesson.order_num,
    lesson.content
  );

  const { data: prog } = await supabaseAdmin
    .from("student_progress")
    .select("completed")
    .eq("student_id", studentId)
    .eq("lesson_id", lesson.id)
    .maybeSingle();

  const alreadyDone = prog?.completed === true;

  return (
    <div className="lesson-shell">
      <div className="lesson-inner">
        <nav className="lesson-crumb">
          <Link href="/dashboard">Overview</Link>
          <span className="sep">/</span>
          <Link href="/dashboard/modules">Modules</Link>
          <span className="sep">/</span>
          <Link href={`/dashboard/modules/${moduleIdNum}`}>Module</Link>
          <span className="sep">/</span>
          <span>Lesson</span>
        </nav>

        <h1>{lesson.title}</h1>
        <p className="lesson-sub">
          ~{lesson.duration_min || 45} minute segment · Lesson {lesson.order_num}
          {siblings.length ? ` of ${siblings.length}` : ""}
        </p>

        <div className="lesson-progress-strip">
          <div className="lps-meta">
            <span>Lesson progress</span>
            <span>Lesson {lesson.order_num} of {siblings.length || 1}</span>
          </div>
          <div className="lps-bar">
            <div
              className="lps-fill"
              style={{
                width: `${siblings.length ? Math.round((lesson.order_num / siblings.length) * 100) : 0}%`,
              }}
            />
          </div>
        </div>

        {lesson.video_url && (
          <div className="lesson-video">
            <iframe
              src={lesson.video_url}
              title={lesson.title}
              allow="accelerometer; autoplay; clipboard-write; encrypted-media; gyroscope; picture-in-picture"
              allowFullScreen
            />
          </div>
        )}

        <article
          className="lesson-body"
          dangerouslySetInnerHTML={{ __html: bodyHtml }}
        />

        {lesson.module_id === 1 && lesson.order_num === 8 && <InteractiveSimulations />}
        <LessonTimeTracker lessonId={lesson.id} moduleId={moduleIdNum} />

        <div className="lesson-footer">
          <CompleteLessonButton
            lessonId={lesson.id}
            initialDone={alreadyDone}
          />

          <div className="lesson-nav-links">
            {prev ? (
              <Link
                href={`/dashboard/modules/${moduleIdNum}/lessons/${prev.id}`}
                className="ln prev"
              >
                ← Previous
              </Link>
            ) : (
              <span className="ln ghost">← Previous</span>
            )}
            {next ? (
              <Link
                href={`/dashboard/modules/${moduleIdNum}/lessons/${next.id}`}
                className="ln next"
              >
                Next →
              </Link>
            ) : (
              <Link href={`/dashboard/modules/${moduleIdNum}`} className="ln next">
                Overview →
              </Link>
            )}
          </div>
        </div>
      </div>

      <style>{`
        .lesson-shell {
          min-height: 100vh;
          background: #f8fafc;
          padding: 2rem 1.5rem;
          font-family: "DM Sans", system-ui, sans-serif;
          color: #0f172a;
        }
        .lesson-inner {
          max-width: 840px;
          margin: 0 auto;
          background: #fff;
          border-radius: 10px;
          border: 1px solid #e2e8f0;
          padding: 2rem 2.25rem 2.25rem;
          box-shadow: 0 1px 3px rgba(0, 0, 0, 0.05);
        }
        .lesson-crumb {
          font-size: 0.8rem;
          color: #64748b;
          margin-bottom: 1rem;
          display: flex;
          gap: 0.35rem;
          flex-wrap: wrap;
          align-items: center;
        }
        .lesson-crumb a {
          color: #0c7ab8;
          font-weight: 600;
          text-decoration: none;
        }
        .lesson-crumb a:hover {
          text-decoration: underline;
        }
        .lesson-crumb .sep {
          opacity: 0.6;
        }
        .lesson-inner h1 {
          font-family: "Fraunces", serif;
          font-weight: 700;
          letter-spacing: -0.025em;
          font-size: 1.62rem;
          line-height: 1.28;
          margin-bottom: 0.4rem;
        }
        .lesson-sub {
          color: #94a3b8;
          font-size: 0.85rem;
          margin-bottom: 1rem;
        }
        .lesson-video {
          position: relative;
          padding-bottom: 56.25%;
          height: 0;
          margin-bottom: 1.5rem;
          border-radius: 8px;
          overflow: hidden;
          background: #0f172a;
        }
        .lesson-video iframe {
          position: absolute;
          top: 0;
          left: 0;
          width: 100%;
          height: 100%;
          border: 0;
        }
        .lesson-progress-strip {
          margin-bottom: 1.6rem;
          padding: 0.75rem 0.9rem;
          background: #f8fafc;
          border: 1px solid #e2e8f0;
          border-radius: 8px;
        }
        .lps-meta {
          display: flex;
          justify-content: space-between;
          font-size: 0.78rem;
          color: #64748b;
          font-weight: 600;
          margin-bottom: 0.35rem;
        }
        .lps-bar {
          height: 6px;
          background: #e2e8f0;
          border-radius: 99px;
          overflow: hidden;
        }
        .lps-fill {
          height: 100%;
          background: #0c7ab8;
          border-radius: 99px;
        }
        .lesson-body .lesson-block .lesson-callout {
          border-radius: 10px;
          padding: 1rem 1.15rem;
          margin: 1.25rem 0;
        }
        .lesson-body .lesson-block .lesson-callout.info {
          background: #f0f9ff;
          border: 1px solid #bae6fd;
          border-left: 4px solid #0c7ab8;
        }
        .lesson-body .lesson-block .lesson-callout.path {
          background: #f8fafc;
          border: 1px solid #e2e8f0;
          border-left: 4px solid #16a34a;
        }
        .lesson-body .lesson-block .lesson-callout h3 {
          margin-top: 0;
          font-size: 1rem;
        }
        .lesson-body .lesson-block .lesson-path-list {
          margin: 0.5rem 0 0;
          padding-left: 1.25rem;
          line-height: 1.65;
          font-size: 0.9rem;
          color: #475569;
        }
        .lesson-body .lesson-block {
          padding-bottom: 0.25rem;
        }
        .lesson-body .lesson-block h2,
        .lesson-body .lesson-block h3 {
          font-family: "Fraunces", serif;
          color: #0f172a;
          letter-spacing: -0.02em;
        }
        .lesson-body .lesson-block h2 {
          margin-top: 1.85rem;
          margin-bottom: 0.85rem;
          font-size: 1.38rem;
        }
        .lesson-body .lesson-block h3 {
          margin-top: 1.75rem;
          margin-bottom: 0.65rem;
          font-size: 1.06rem;
        }
        .lesson-body .lesson-block p {
          line-height: 1.73;
          color: #475569;
          font-size: 0.935rem;
          margin: 0.55rem 0;
        }
        .lesson-body .lesson-block p.lead {
          margin-top: 0;
          color: #334155;
        }
        .lesson-body .lesson-block .lesson-list {
          padding-left: 1.35rem;
          margin: 0.75rem 0 1rem;
          line-height: 1.62;
          color: #475569;
          font-size: 0.92rem;
        }
        .lesson-body .lesson-block .lesson-list.options {
          list-style: upper-alpha;
        }
        .lesson-body .lesson-block .lesson-list.objectives {
          font-weight: 500;
        }
        .lesson-body .lesson-block .sim-card {
          border-left: 3px solid #0c7ab8;
          background: #f8fafc;
          padding: 1rem 1.15rem;
          margin: 1.5rem 0;
          border-radius: 8px;
        }
        .lesson-body .lesson-block .sim-card h3 {
          margin-top: 0;
          font-family: "Fraunces", serif;
          font-size: 1.05rem;
        }
        .lesson-body .lesson-block details.sim-rationale {
          margin-top: 0.95rem;
        }
        .lesson-body .lesson-block details.sim-rationale summary {
          cursor: pointer;
          color: #0c7ab8;
          font-weight: 700;
          font-size: 0.88rem;
        }
        .lesson-body .lesson-block .sim-answer,
        .lesson-body .lesson-block .sim-rationale {
          margin: 0.75rem 0;
          font-size: 0.92rem;
          color: #334155;
          line-height: 1.6;
        }
        .lesson-body .lesson-block .sim-feedback {
          margin: 0.5rem 0 0;
          font-size: 0.92rem;
          color: #334155;
        }
        .lesson-body .lesson-block .lesson-next-hint {
          margin-top: 1.25rem;
          font-weight: 500;
          color: #334155;
        }
        .lesson-footer {
          margin-top: 2.75rem;
          padding-top: 1.85rem;
          border-top: 1px solid #e2e8f0;
        }
        .lesson-nav-links {
          display: flex;
          justify-content: space-between;
          align-items: center;
          gap: 1rem;
          margin-top: 1.75rem;
        }
        .lesson-nav-links .ln {
          font-size: 0.87rem;
          font-weight: 600;
          text-decoration: none;
        }
        .lesson-nav-links .ln.prev,
        .lesson-nav-links .ln.next {
          color: #0c7ab8;
        }
        .lesson-nav-links .ln.next:hover,
        .lesson-nav-links .ln.prev:hover {
          text-decoration: underline;
        }
        .lesson-nav-links .ln.ghost {
          color: #cbd5e1;
          cursor: default;
        }
      `}</style>
    </div>
  );
}
