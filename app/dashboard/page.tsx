export const dynamic = "force-dynamic";
export const revalidate = 0;

import Link from "next/link";
import { loadStudentPortal } from "@/lib/server/student-portal-session";
import { PageHeader, NotEnrolledBanner } from "./components/PortalChrome";
import { ProgressStatsGrid } from "./components/ProgressStatsGrid";
import { QuickLinks } from "./components/ResourcesList";
import { LessonSearch } from "./components/LessonSearch";

export default async function DashboardOverviewPage() {
  const { data, isEnrolled } = await loadStudentPortal();
  const firstName = data?.student.firstName ?? "Student";
  const stats = data?.stats;

  return (
    <>
      <PageHeader
        title={`Welcome${firstName !== "Student" ? `, ${firstName}` : ""}`}
        description={
          isEnrolled
            ? "Your CNA training overview — pick up where you left off or jump to any section."
            : "Complete enrollment to unlock your full course."
        }
      />

      {!isEnrolled && <NotEnrolledBanner />}

      {isEnrolled && data?.announcements.map((a) => (
        <div key={a.id} className="sp-banner info sp-announcement">
          <div>
            <strong>{a.title}</strong>
            <p>{a.body}</p>
          </div>
        </div>
      ))}

      {isEnrolled && data?.continueTarget && (
        <section className="sp-continue-hero">
          <div>
            <span className="sp-continue-label">Continue learning</span>
            <h2>{data.continueTarget.label}</h2>
            <p>{data.continueTarget.moduleTitle}</p>
          </div>
          <Link href={data.continueTarget.href} className="sp-btn-primary">
            {data.continueTarget.kind === "quiz" ? "Take assignment" : "Resume lesson"}
          </Link>
        </section>
      )}

      {isEnrolled && stats?.isProgramComplete && (
        <div className="sp-banner success">
          <span>Congratulations — you completed the program!</span>
          <Link href="/dashboard/certificate" className="sp-btn-ghost">
            View certificate →
          </Link>
        </div>
      )}

      {isEnrolled && stats && <ProgressStatsGrid stats={stats} />}

      {isEnrolled && (
        <section className="sp-section">
          <LessonSearch />
        </section>
      )}

      {isEnrolled && data?.milestones && (
        <section className="sp-section">
          <h2 className="sp-section-title">Milestones</h2>
          <div className="sp-milestones">
            {data.milestones.map((m) => (
              <span key={m.id} className={`sp-milestone${m.earned ? " earned" : ""}`}>
                {m.earned ? "✓" : "○"} {m.label}
              </span>
            ))}
          </div>
        </section>
      )}

      <section className="sp-section">
        <h2 className="sp-section-title">Quick links</h2>
        <QuickLinks />
      </section>
    </>
  );
}
