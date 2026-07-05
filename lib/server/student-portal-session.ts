import { cache } from "react";
import { auth } from "@clerk/nextjs/server";
import { redirect } from "next/navigation";
import { resolveStudentId } from "@/lib/server/resolve-student";
import { getStudentDashboardData } from "@/lib/server/student-dashboard";
import { studentNeedsPolicyAck } from "@/lib/server/policy-ack-status";
import { supabaseAdmin } from "@/lib/supabase";

export const getCachedStudentDashboard = cache(async (studentId: string) => {
  return getStudentDashboardData(studentId);
});

/** Dedupe student lookup within a single request. */
export const getCachedStudentId = cache(async () => {
  const { userId } = await auth();
  if (!userId) return null;
  return resolveStudentId(userId);
});

/** Minimal data for layout shell — 2 fast queries instead of full dashboard. */
export const getPortalShell = cache(async (studentId: string) => {
  const [{ data: student }, { data: policyAcks }] = await Promise.all([
    supabaseAdmin
      .from("students")
      .select("first_name, enrolled, policies_acknowledged_at")
      .eq("id", studentId)
      .single(),
    supabaseAdmin
      .from("student_policy_acknowledgments")
      .select("policy_slug")
      .eq("student_id", studentId),
  ]);

  const ackedSlugs = (policyAcks ?? []).map((p) => p.policy_slug as string);
  const needsPolicyAck = studentNeedsPolicyAck(
    student?.policies_acknowledged_at as string | null | undefined,
    ackedSlugs
  );

  return {
    firstName: student?.first_name?.trim() || "Student",
    isEnrolled: student?.enrolled === true,
    needsPolicyAck,
  };
});

/** Require sign-in; returns student id (may be null if not in DB yet). */
export async function requireStudentSession() {
  const { userId } = await auth();
  if (!userId) redirect("/sign-in");
  const studentId = await getCachedStudentId();
  return { userId, studentId };
}

/** Shell only — for layout. */
export async function loadPortalShell() {
  const { userId } = await auth();
  if (!userId) redirect("/sign-in");
  const studentId = await getCachedStudentId();
  if (!studentId) {
    return { firstName: "Student", isEnrolled: false, needsPolicyAck: false };
  }
  return getPortalShell(studentId);
}

/** Full dashboard payload for portal pages. */
export async function loadStudentPortal() {
  const { studentId } = await requireStudentSession();
  if (!studentId) {
    return { data: null, isEnrolled: false };
  }
  const data = await getCachedStudentDashboard(studentId);
  return { data, isEnrolled: data.student.enrolled === true };
}

/** Enrolled student id or redirect to dashboard. */
export async function requireEnrolledStudentId() {
  const { studentId } = await requireStudentSession();
  if (!studentId) redirect("/dashboard");
  const { data } = await supabaseAdmin
    .from("students")
    .select("id, enrolled")
    .eq("id", studentId)
    .single();
  if (!data?.enrolled) redirect("/dashboard");
  return studentId;
}
