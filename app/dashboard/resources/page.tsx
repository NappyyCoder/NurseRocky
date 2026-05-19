export const dynamic = "force-dynamic";

import { loadStudentPortal } from "@/lib/server/student-portal-session";
import { PageHeader, NotEnrolledBanner } from "../components/PortalChrome";
import { ResourcesList } from "../components/ResourcesList";

export default async function ResourcesPage() {
  const { data, isEnrolled } = await loadStudentPortal();

  return (
    <>
      <PageHeader
        title="Resources & textbook"
        description="Program handbook, policy documents, and supplemental study materials."
      />

      {!isEnrolled && <NotEnrolledBanner />}

      {isEnrolled && <ResourcesList resources={data?.resources ?? []} />}
    </>
  );
}
