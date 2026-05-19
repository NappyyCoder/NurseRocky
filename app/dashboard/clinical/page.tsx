export const dynamic = "force-dynamic";

import { loadStudentPortal } from "@/lib/server/student-portal-session";
import { PageHeader, NotEnrolledBanner } from "../components/PortalChrome";
import { ClinicalPanel } from "../components/ClinicalPanel";

export default async function ClinicalPage() {
  const { data, isEnrolled } = await loadStudentPortal();

  return (
    <>
      <PageHeader
        title="Clinical hours"
        description="Track required clinical time and complete your pre-clinical checklist before rotations."
      />

      {!isEnrolled && <NotEnrolledBanner />}

      {isEnrolled && data && (
        <ClinicalPanel
          clinical={data.clinical}
          checklist={data.checklist}
          studyMinutes={data.stats.totalStudyMinutes}
        />
      )}
    </>
  );
}
