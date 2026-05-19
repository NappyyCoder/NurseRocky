export const dynamic = "force-dynamic";

import { loadStudentPortal } from "@/lib/server/student-portal-session";
import { PageHeader, NotEnrolledBanner } from "../components/PortalChrome";
import { SupportForm } from "../components/SupportForm";

export default async function SupportPage() {
  const { isEnrolled } = await loadStudentPortal();

  return (
    <>
      <PageHeader
        title="Contact support"
        description="Questions about coursework, clinical scheduling, or your enrollment? Send us a message."
      />

      {!isEnrolled && <NotEnrolledBanner />}

      {isEnrolled && <SupportForm />}
    </>
  );
}
