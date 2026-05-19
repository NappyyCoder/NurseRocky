/** Pre-clinical checklist items (key → label). */
export const CLINICAL_CHECKLIST_ITEMS = [
  { key: "immunizations", label: "Immunizations & TB screening on file" },
  { key: "background_check", label: "Background check cleared" },
  { key: "hipaa_training", label: "HIPAA & confidentiality training reviewed" },
  { key: "dress_code", label: "Clinical dress code & ID badge requirements understood" },
  { key: "policies_read", label: "Program policies & handbook reviewed" },
  { key: "cpr_ready", label: "CPR certification (or scheduled)" },
] as const;

export type ChecklistKey = (typeof CLINICAL_CHECKLIST_ITEMS)[number]["key"];

/** Policy slugs students must acknowledge on first dashboard visit. */
export const REQUIRED_POLICY_SLUGS = [
  "privacy-policy",
  "terms-of-service",
  "academic-integrity",
  "compliance-attestation",
] as const;

export const MILESTONE_DEFINITIONS = [
  { id: "first_lesson", label: "First lesson complete", check: (s: MilestoneStats) => s.lessonsCompleted >= 1 },
  { id: "first_quiz", label: "First quiz passed", check: (s: MilestoneStats) => s.quizzesPassed >= 1 },
  { id: "module1", label: "Module 1 complete", check: (s: MilestoneStats) => s.modulesFullyComplete >= 1 },
  { id: "half", label: "Halfway there", check: (s: MilestoneStats) => s.overallPct >= 50 },
  { id: "clinical_half", label: "8+ clinical hours", check: (s: MilestoneStats) => s.clinicalHours >= 8 },
  { id: "graduate", label: "Program complete", check: (s: MilestoneStats) => s.isProgramComplete },
] as const;

export type MilestoneStats = {
  lessonsCompleted: number;
  quizzesPassed: number;
  modulesFullyComplete: number;
  overallPct: number;
  clinicalHours: number;
  isProgramComplete: boolean;
};

export function computeMilestones(stats: MilestoneStats) {
  return MILESTONE_DEFINITIONS.map((m) => ({
    id: m.id,
    label: m.label,
    earned: m.check(stats),
  }));
}
