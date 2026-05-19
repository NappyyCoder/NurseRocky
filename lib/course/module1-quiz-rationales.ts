/** Rationales keyed by exact quiz question text (Module 1 curriculum document). */
export const MODULE_1_QUIZ_RATIONALES: Record<string, string> = {
  "CNAs can perform medical diagnoses independently.":
    "CNAs provide basic care and observe patient conditions, but do not diagnose illnesses.",
  "Patient confidentiality is a legal responsibility for CNAs.":
    "HIPAA laws require CNAs to protect patient information.",
  "Teamwork is unnecessary if the CNA is experienced.":
    "Collaboration is essential to ensure patient safety and quality care.",
  "CNAs are responsible for reporting changes in patient conditions to the nurse.":
    "Timely reporting allows for prompt intervention and care adjustments.",
  "Professionalism includes punctuality, respect, and ethical behavior.":
    "Professional behavior fosters trust and maintains a safe, effective work environment.",
  "CNAs are primarily responsible for:":
    "CNAs provide basic care such as bathing, feeding, and monitoring vital signs; they do not diagnose or prescribe.",
  "The scope of practice defines:":
    "Scope of practice ensures CNAs perform tasks safely within their legal limits.",
  "Confidentiality refers to:":
    "HIPAA laws protect patient privacy; CNAs must not disclose personal health information.",
  "CNAs report observations to:":
    "CNAs report changes in patient condition to nurses who can take appropriate action.",
  "Professional behavior includes:":
    "Professionalism ensures safe, respectful care and positive workplace interactions.",
  "A CNA's role includes:":
    "CNAs help with ADLs like bathing, feeding, and mobility; they do not perform medical procedures.",
  "A CNA\u2019s role includes:":
    "CNAs help with ADLs like bathing, feeding, and mobility; they do not perform medical procedures.",
  "Teamwork in healthcare is important because:":
    "Team collaboration ensures safer, efficient, and coordinated patient care.",
  "CNAs should use critical thinking to:":
    "Critical thinking helps CNAs identify changes and communicate them promptly.",
  "Patient rights include:":
    "Patients have legal rights to be treated with dignity and receive information about their care.",
  "Accountability in healthcare means:":
    "CNAs must be responsible for their actions to ensure safe, ethical care.",
};

export function rationaleForQuestion(question: string): string | null {
  return MODULE_1_QUIZ_RATIONALES[question.trim()] ?? null;
}
