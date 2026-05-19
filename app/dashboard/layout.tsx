export const dynamic = "force-dynamic";

import "./student-portal.css";
import { loadPortalShell } from "@/lib/server/student-portal-session";
import { StudentPortalLayout } from "./components/StudentPortalLayout";

export default async function DashboardLayout({
  children,
}: {
  children: React.ReactNode;
}) {
  const shell = await loadPortalShell();

  return (
    <StudentPortalLayout
      firstName={shell.firstName}
      isEnrolled={shell.isEnrolled}
      needsPolicyAck={shell.needsPolicyAck}
    >
      {children}
    </StudentPortalLayout>
  );
}
