export const dynamic = "force-dynamic";

import Link from "next/link";
import { loadStudentPortal } from "@/lib/server/student-portal-session";
import { PageHeader, NotEnrolledBanner } from "../components/PortalChrome";
import { GradesTable } from "../components/GradesTable";

export default async function GradesPage() {
  const { data, isEnrolled } = await loadStudentPortal();

  return (
    <>
      <PageHeader
        title="Grades & assignments"
        description="Your best scores and pass status for every quiz and test in the program."
      />

      {isEnrolled && (
        <div style={{ marginBottom: "1.25rem" }}>
          <Link href="/dashboard/report" className="sp-btn-ghost">
            Print progress report →
          </Link>
        </div>
      )}

      {!isEnrolled && <NotEnrolledBanner />}

      {isEnrolled && <GradesTable grades={data?.allGrades ?? []} />}
    </>
  );
}
