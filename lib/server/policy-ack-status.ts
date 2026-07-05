import { REQUIRED_POLICY_SLUGS } from "@/lib/student-portal/constants";

/** Whether the student still needs to complete the policy acknowledgment modal. */
export function studentNeedsPolicyAck(
  policiesAcknowledgedAt: string | null | undefined,
  ackedSlugs: string[]
): boolean {
  if (policiesAcknowledgedAt) return false;
  const acked = new Set(ackedSlugs);
  return REQUIRED_POLICY_SLUGS.some((slug) => !acked.has(slug));
}
