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

      {isEnrolled && (
        <div className="sp-welcome-letter sp-card" style={{ marginBottom: "1.5rem" }}>
          <p className="sp-welcome-letter-heading">Welcome to Nurse Rocky Institute</p>
          <p>
            We are honored that you have chosen to take the first step toward becoming a Certified
            Nursing Assistant (CNA) — a career dedicated to compassion, service, and making a
            meaningful difference in the lives of others.
          </p>
          <p>
            At Nurse Rocky Institute, we believe that great caregivers are built through knowledge,
            confidence, and hands-on skills. Our program is designed to prepare you for success by
            combining clear instruction, practical training, and real-world healthcare scenarios
            that reflect the responsibilities of today&apos;s CNAs.
          </p>
          <p>
            During your training, you will learn essential skills such as patient care, infection
            control, communication, safety procedures, and professional ethics. More importantly,
            you will develop the confidence and compassion needed to care for patients with dignity
            and respect.
          </p>
          <p>
            Our goal is not only to help you pass your state CNA certification exam, but also to
            prepare you for a rewarding career in healthcare — with opportunities in hospitals,
            long-term care facilities, home health, and other healthcare settings.
          </p>
          <p className="sp-welcome-letter-footer">
            <em>Welcome to Nurse Rocky Institute — Where Compassion Meets Career.</em>
          </p>
        </div>
      )}

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
