export const dynamic = "force-dynamic";

import { loadStudentPortal } from "@/lib/server/student-portal-session";
import { PageHeader, NotEnrolledBanner } from "../components/PortalChrome";
import { ModuleList } from "../components/ModuleList";
import { LessonSearch } from "../components/LessonSearch";

export default async function ModulesPage() {
  const { data, isEnrolled } = await loadStudentPortal();

  return (
    <>
      <PageHeader
        title="Course modules"
        description="Work through all 18 competency modules at your own pace — lessons, assignments, and exam prep included."
      />

      {!isEnrolled && <NotEnrolledBanner />}

      {isEnrolled && (
        <section className="sp-section">
          <LessonSearch />
        </section>
      )}

      <ModuleList modules={data?.modules ?? []} isEnrolled={isEnrolled} />
    </>
  );
}
