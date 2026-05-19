export type PolicySection = {
  heading?: string;
  paragraphs?: string[];
  list?: string[];
};

export type PolicyPage = {
  slug: string;
  title: string;
  subtitle: string;
  lastUpdated: string;
  /** Optional scanned policy document — add PNG/JPG to public/images/policies/ */
  documentImage?: string;
  sections: PolicySection[];
};

export const POLICY_PAGES: PolicyPage[] = [
  {
    slug: "privacy-policy",
    title: "Privacy Policy",
    subtitle: "How Nurse Rocky collects, uses, and protects your information.",
    lastUpdated: "May 19, 2026",
    documentImage: "/images/policies/privacy-policy.png",
    sections: [
      {
        paragraphs: [
          "Nurse Rocky (“we,” “us,” or “our”) respects your privacy. This Privacy Policy explains how we collect, use, disclose, and safeguard information when you visit our website, enroll in our Certified Nursing Assistant (CNA) program, or use our student learning platform.",
        ],
      },
      {
        heading: "Information we collect",
        paragraphs: ["We may collect the following types of information:"],
        list: [
          "Personal identifiers: name, email address, phone number, mailing address, and date of birth",
          "Account credentials managed through our authentication provider (Clerk)",
          "Payment information processed securely through Stripe (we do not store full card numbers)",
          "Educational records: enrollment status, lesson progress, quiz scores, clinical hours, and attendance",
          "Technical data: IP address, browser type, device information, and usage logs",
        ],
      },
      {
        heading: "How we use information",
        paragraphs: ["We use collected information to:"],
        list: [
          "Process enrollment and tuition payments",
          "Provide access to online coursework, assessments, and student dashboards",
          "Track academic progress, clinical hours, and program completion",
          "Communicate about your program, schedule, and compliance requirements",
          "Improve our website, platform, and training services",
          "Comply with legal, regulatory, and accreditation obligations",
        ],
      },
      {
        heading: "Sharing and disclosure",
        paragraphs: [
          "We do not sell your personal information. We may share information with service providers that help us operate our program (e.g., payment processing, hosting, email delivery) under contractual confidentiality obligations. We may also disclose information when required by law, court order, or to protect the rights and safety of students, staff, and the public.",
        ],
      },
      {
        heading: "Student health and educational records",
        paragraphs: [
          "Information related to your training may constitute educational records subject to applicable privacy laws. Clinical and attendance documentation is maintained for compliance and certification purposes. Access is limited to authorized Nurse Rocky personnel.",
        ],
      },
      {
        heading: "Data security and retention",
        paragraphs: [
          "We implement reasonable administrative, technical, and physical safeguards to protect your information. No method of transmission over the Internet is completely secure. We retain information as long as needed to provide services, meet legal requirements, and maintain accurate academic records.",
        ],
      },
      {
        heading: "Your choices",
        paragraphs: [
          "You may request access to or correction of your personal information by contacting us. You may opt out of non-essential marketing emails at any time. Some data collection is required to participate in the CNA program.",
        ],
      },
      {
        heading: "Contact",
        paragraphs: [
          "Questions about this Privacy Policy may be directed to Nurse Rocky through the contact information on our website or your enrollment materials.",
        ],
      },
    ],
  },
  {
    slug: "terms-of-service",
    title: "Terms of Service",
    subtitle: "Terms governing use of the Nurse Rocky website and online platform.",
    lastUpdated: "May 19, 2026",
    documentImage: "/images/policies/terms-of-service.png",
    sections: [
      {
        paragraphs: [
          "These Terms of Service (“Terms”) govern your access to and use of the Nurse Rocky website, student portal, and related online services. By enrolling, creating an account, or using our platform, you agree to these Terms.",
        ],
      },
      {
        heading: "Eligibility and enrollment",
        paragraphs: [
          "You must meet program eligibility requirements, including age, background check, immunization, and any state-specific prerequisites for CNA training. Enrollment is confirmed upon acceptance, payment of applicable fees, and completion of required documentation.",
        ],
      },
      {
        heading: "Tuition and refunds",
        paragraphs: [
          "Tuition, fees, and payment schedules are disclosed at enrollment. Refund policies, if any, are stated in your enrollment agreement and applicable state regulations. Failure to pay may result in suspension of platform access.",
        ],
      },
      {
        heading: "Platform use",
        paragraphs: ["Students agree to:"],
        list: [
          "Use the platform only for legitimate educational purposes",
          "Maintain the confidentiality of login credentials",
          "Not share, copy, or distribute course materials without authorization",
          "Not attempt to disrupt, reverse engineer, or compromise platform security",
          "Complete coursework honestly and in accordance with the Academic Integrity Policy",
        ],
      },
      {
        heading: "Intellectual property",
        paragraphs: [
          "All course content, modules, assessments, branding, and materials are owned by Nurse Rocky or its licensors. You receive a limited, non-transferable license to access materials for personal educational use during enrollment.",
        ],
      },
      {
        heading: "Disclaimer",
        paragraphs: [
          "Online materials supplement—but do not replace—required clinical training and instructor supervision. Successful completion of Nurse Rocky coursework does not guarantee employment or state certification until all program and regulatory requirements are met.",
        ],
      },
      {
        heading: "Limitation of liability",
        paragraphs: [
          "To the fullest extent permitted by law, Nurse Rocky is not liable for indirect, incidental, or consequential damages arising from use of the platform. Our total liability is limited to the amount you paid for the program in the twelve months preceding the claim.",
        ],
      },
      {
        heading: "Changes and termination",
        paragraphs: [
          "We may update these Terms at any time. Continued use after changes constitutes acceptance. We may suspend or terminate access for violations of these Terms or program policies.",
        ],
      },
    ],
  },
  {
    slug: "ada-accommodations",
    title: "ADA Accommodations",
    subtitle: "Equal access and reasonable accommodations for qualified students.",
    lastUpdated: "May 19, 2026",
    documentImage: "/images/policies/ada-accommodations.png",
    sections: [
      {
        paragraphs: [
          "Nurse Rocky is committed to providing equal access to its CNA training program for qualified applicants and students with disabilities, in accordance with the Americans with Disabilities Act (ADA) and applicable state laws.",
        ],
      },
      {
        heading: "Reasonable accommodations",
        paragraphs: [
          "A reasonable accommodation is a modification or adjustment that enables a qualified individual with a disability to participate in the program without fundamentally altering essential program requirements. Examples may include extended time on written assessments, note-taking assistance, accessible materials, or adjusted scheduling where clinically appropriate.",
        ],
      },
      {
        heading: "Essential functions",
        paragraphs: [
          "CNAs must be able to perform essential physical and cognitive functions in clinical settings, including assisting patients with mobility, hygiene, and safety. Some accommodations may not be possible if they would pose a direct threat to health or safety or would fundamentally alter clinical competency standards.",
        ],
      },
      {
        heading: "Request process",
        paragraphs: ["To request an accommodation:"],
        list: [
          "Submit a written request to Nurse Rocky administration as early as possible—preferably before enrollment or the start of clinical rotations",
          "Provide documentation from a qualified professional describing the disability and recommended accommodations, when applicable",
          "Participate in an interactive process to determine reasonable and effective accommodations",
          "Notify the program promptly if your needs change during the course of training",
        ],
      },
      {
        heading: "Confidentiality",
        paragraphs: [
          "Disability-related information is kept confidential and shared only with personnel who have a legitimate need to know in order to implement approved accommodations.",
        ],
      },
      {
        heading: "Appeals",
        paragraphs: [
          "If you disagree with an accommodation decision, you may follow the Grievance Procedure to request review of your request.",
        ],
      },
    ],
  },
  {
    slug: "academic-integrity",
    title: "Academic Integrity Policy",
    subtitle: "Standards for honest, ethical completion of coursework and assessments.",
    lastUpdated: "May 19, 2026",
    documentImage: "/images/policies/academic-integrity.png",
    sections: [
      {
        paragraphs: [
          "Nurse Rocky expects all students to demonstrate honesty, integrity, and professional ethics in all academic and clinical activities. Academic integrity is essential to patient safety and the credibility of your CNA credential.",
        ],
      },
      {
        heading: "Prohibited conduct",
        paragraphs: ["The following are examples of academic dishonesty:"],
        list: [
          "Cheating on quizzes, exams, or skills check-offs",
          "Sharing assessment answers or using unauthorized materials during testing",
          "Plagiarism or submitting work that is not your own",
          "Falsifying attendance, clinical hours, or skills documentation",
          "Impersonating another student or allowing another person to complete work on your behalf",
          "Unauthorized recording or distribution of course materials",
        ],
      },
      {
        heading: "Clinical and professional conduct",
        paragraphs: [
          "Students must adhere to HIPAA, patient dignity standards, infection control protocols, and facility policies during clinical experiences. Violations in clinical settings may result in immediate removal and disciplinary action.",
        ],
      },
      {
        heading: "Consequences",
        paragraphs: [
          "Violations may result in a warning, assignment retake, module reset, suspension from clinical activities, program dismissal, or referral to regulatory bodies depending on severity. Decisions are documented and may affect eligibility for certification.",
        ],
      },
      {
        heading: "Reporting",
        paragraphs: [
          "Students and staff should report suspected violations to program administration. Retaliation against good-faith reporters is prohibited.",
        ],
      },
    ],
  },
  {
    slug: "grievance-procedure",
    title: "Grievance Procedure",
    subtitle: "How to raise concerns and seek resolution within the program.",
    lastUpdated: "May 19, 2026",
    documentImage: "/images/policies/grievance-procedure.png",
    sections: [
      {
        paragraphs: [
          "Nurse Rocky provides a fair and accessible process for students to raise concerns regarding program policies, instructor conduct, grades, accommodations, discrimination, harassment, or other matters affecting their education.",
        ],
      },
      {
        heading: "Informal resolution",
        paragraphs: [
          "Students are encouraged to first discuss concerns directly with the instructor or staff member involved, when appropriate and safe to do so. Many issues can be resolved promptly through open communication.",
        ],
      },
      {
        heading: "Formal grievance",
        paragraphs: ["To file a formal grievance:"],
        list: [
          "Submit a written statement describing the concern, dates, individuals involved, and desired outcome",
          "Include supporting documentation when available",
          "Deliver the grievance to Nurse Rocky program administration within thirty (30) days of the incident, when feasible",
        ],
      },
      {
        heading: "Review process",
        paragraphs: [
          "Administration will acknowledge receipt within five (5) business days and conduct a impartial review. You may be asked to participate in a meeting. A written decision will be provided explaining findings and any corrective actions.",
        ],
      },
      {
        heading: "Non-retaliation",
        paragraphs: [
          "No student will be penalized for filing a grievance in good faith. Knowingly false or malicious complaints may themselves result in disciplinary action.",
        ],
      },
      {
        heading: "External options",
        paragraphs: [
          "If internal resolution is not satisfactory, students may contact applicable state licensing, workforce training, or civil rights agencies as provided by law.",
        ],
      },
    ],
  },
  {
    slug: "policy-handbook",
    title: "Policy Handbook",
    subtitle: "Overview of program rules, expectations, and student responsibilities.",
    lastUpdated: "May 19, 2026",
    documentImage: "/images/policies/policy-handbook.png",
    sections: [
      {
        paragraphs: [
          "This Policy Handbook summarizes key rules governing Nurse Rocky CNA students. It should be read together with your enrollment agreement, clinical contracts, and individual policy pages on this website.",
        ],
      },
      {
        heading: "Program structure",
        paragraphs: [
          "The CNA program combines online modules, skills practice, and supervised clinical hours. Students must complete all required lessons, pass assessments, meet attendance requirements, and satisfy clinical competencies to be eligible for program completion documentation.",
        ],
      },
      {
        heading: "Student responsibilities",
        list: [
          "Attend all scheduled classes, labs, and clinical shifts punctually",
          "Maintain professional appearance and conduct per program dress code",
          "Complete coursework and assignments by published deadlines",
          "Report changes in contact information, health status, or legal eligibility promptly",
          "Protect patient privacy and follow HIPAA at all times",
          "Notify instructors of absences according to the Attendance Records policy",
        ],
      },
      {
        heading: "Health and safety",
        paragraphs: [
          "Students must comply with immunization, TB screening, background check, and any facility health requirements before clinical placement. Illness or exposure that may affect patient safety must be reported immediately.",
        ],
      },
      {
        heading: "Technology requirements",
        paragraphs: [
          "Online modules require reliable internet access and a compatible device. Students are responsible for maintaining their account credentials and completing platform-based lessons and quizzes.",
        ],
      },
      {
        heading: "Related policies",
        paragraphs: [
          "See also: Privacy Policy, Terms of Service, ADA Accommodations, Academic Integrity Policy, Grievance Procedure, Attendance Records, and Compliance Attestation.",
        ],
      },
    ],
  },
  {
    slug: "attendance-records",
    title: "Attendance Records",
    subtitle: "Attendance requirements, documentation, and make-up procedures.",
    lastUpdated: "May 19, 2026",
    documentImage: "/images/policies/attendance-records.png",
    sections: [
      {
        paragraphs: [
          "Regular attendance is required for CNA training. Attendance is tracked for online modules, in-person skills sessions, and clinical rotations. Accurate records are maintained for compliance, certification eligibility, and employer reference.",
        ],
      },
      {
        heading: "Online module attendance",
        paragraphs: [
          "Progress in the student dashboard—including lesson completion timestamps and quiz submissions—serves as the official record of online participation. Students should complete modules in the recommended order unless otherwise directed.",
        ],
      },
      {
        heading: "Clinical and skills attendance",
        paragraphs: [
          "Clinical and skills sessions are mandatory. Each scheduled hour must be attended in full unless excused in advance. Tardiness may be counted as partial absence. Unexcused absences from clinical may result in suspension or dismissal.",
        ],
      },
      {
        heading: "Excused absences",
        paragraphs: [
          "Absences may be excused for documented illness, emergency, bereavement, or other circumstances approved by administration. Students must notify the program before the missed session when possible and provide documentation upon return.",
        ],
      },
      {
        heading: "Make-up work",
        paragraphs: [
          "Make-up sessions for missed clinical or skills time are offered when feasible but are not guaranteed. Students are responsible for completing any assigned remediation. Excessive absences may require repeating portions of the program or withdrawal.",
        ],
      },
      {
        heading: "Record retention",
        paragraphs: [
          "Attendance and progress records are retained in accordance with regulatory requirements and may be shared with clinical partners, state agencies, or employers as authorized.",
        ],
      },
    ],
  },
  {
    slug: "compliance-attestation",
    title: "Compliance Attestation",
    subtitle: "Student acknowledgment of program policies and regulatory requirements.",
    lastUpdated: "May 19, 2026",
    documentImage: "/images/policies/compliance-attestation.png",
    sections: [
      {
        paragraphs: [
          "By enrolling in Nurse Rocky and continuing in the CNA program, students attest that they have read, understand, and agree to comply with all program policies, clinical facility rules, and applicable laws governing healthcare training and practice.",
        ],
      },
      {
        heading: "Student attestation",
        paragraphs: ["Each student acknowledges that they:"],
        list: [
          "Have reviewed the Policy Handbook and related policies on this website",
          "Understand academic integrity, attendance, and professional conduct expectations",
          "Will maintain confidentiality of patient information under HIPAA",
          "Will promptly disclose any criminal charge, substance issue, or health condition that may affect patient safety or clinical eligibility",
          "Understand that falsification of records or misrepresentation may result in dismissal and referral to authorities",
          "Agree to submit required immunization, background check, and compliance documentation before clinical placement",
        ],
      },
      {
        heading: "Clinical compliance",
        paragraphs: [
          "Students assigned to clinical sites must also comply with each facility’s policies, including dress code, infection control, social media restrictions, and mandatory reporting obligations.",
        ],
      },
      {
        heading: "Ongoing obligation",
        paragraphs: [
          "Compliance is continuous throughout the program. Students must re-attest when policies are updated or when returning from leave. Program administration may require signed acknowledgment forms in addition to this online attestation.",
        ],
      },
      {
        heading: "Questions",
        paragraphs: [
          "Contact Nurse Rocky administration before clinical placement if you have questions about your ability to meet these requirements or need accommodations under the ADA Accommodations policy.",
        ],
      },
    ],
  },
];

export const POLICY_BY_SLUG = Object.fromEntries(
  POLICY_PAGES.map((p) => [p.slug, p])
) as Record<string, PolicyPage>;

export function policyPath(slug: string) {
  return `/policies/${slug}`;
}
