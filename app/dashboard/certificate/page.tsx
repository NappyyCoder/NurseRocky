export const dynamic = "force-dynamic";

import { auth } from "@clerk/nextjs/server";
import { redirect } from "next/navigation";
import Link from "next/link";
import { resolveStudentId } from "@/lib/server/resolve-student";
import { getStudentDashboardData } from "@/lib/server/student-dashboard";
import { PrintButton } from "./PrintButton";

const certStyles = `
.cert-page {
  min-height: 100vh;
  background: #f4f8f6;
  padding: 2rem;
  font-family: "DM Sans", system-ui, sans-serif;
  display: flex;
  flex-direction: column;
  align-items: center;
  gap: 1.5rem;
}
.cert-card {
  background: #fff;
  border: 2px solid #93b7a9;
  border-radius: 12px;
  padding: 3rem 2.5rem;
  max-width: 720px;
  width: 100%;
  text-align: center;
  box-shadow: 0 4px 24px rgba(0, 0, 0, 0.08);
}
.cert-org {
  text-transform: uppercase;
  letter-spacing: 0.12em;
  font-size: 0.75rem;
  color: #5c6b66;
  margin-bottom: 1rem;
}
.cert-page h1 {
  font-family: "Fraunces", serif;
  font-size: 2rem;
  color: #0f1a17;
  margin-bottom: 1.5rem;
}
.cert-presented { color: #5c6b66; margin-bottom: 0.25rem; }
.cert-name {
  font-family: "Fraunces", serif;
  font-size: 1.75rem;
  font-weight: 700;
  color: #93b7a9;
  margin: 0.5rem 0 1.5rem;
}
.cert-body { color: #4a5c55; line-height: 1.65; max-width: 520px; margin: 0 auto 1.5rem; }
.cert-date { font-weight: 600; color: #2f3d38; }
.cert-actions { display: flex; gap: 1rem; flex-wrap: wrap; justify-content: center; }
.cert-actions a { color: #93b7a9; font-weight: 600; align-self: center; text-decoration: none; }
@media print {
  .cert-actions { display: none; }
  .cert-page { background: #fff; padding: 0; }
}
`;

export default async function CertificatePage() {
  const { userId } = await auth();
  if (!userId) redirect("/sign-in");

  const studentId = await resolveStudentId(userId);
  if (!studentId) redirect("/dashboard");

  const data = await getStudentDashboardData(studentId);
  if (!data.student.enrolled) redirect("/dashboard");
  if (!data.stats.isProgramComplete) redirect("/dashboard");

  const name = data.student.firstName;
  const date = new Date().toLocaleDateString("en-US", {
    year: "numeric",
    month: "long",
    day: "numeric",
  });

  return (
    <>
      <style dangerouslySetInnerHTML={{ __html: certStyles }} />
      <div className="cert-page">
        <div className="cert-card">
          <p className="cert-org">Nurse Rocky CNA Training Program</p>
          <h1>Certificate of Completion</h1>
          <p className="cert-presented">This certifies that</p>
          <p className="cert-name">{name}</p>
          <p className="cert-body">
            has successfully completed all course modules, assignments, and required clinical hours
            for the Certified Nursing Assistant training program.
          </p>
          <p className="cert-date">{date}</p>
        </div>
        <div className="cert-actions">
          <PrintButton />
          <Link href="/dashboard">Back to dashboard</Link>
        </div>
      </div>
    </>
  );
}
