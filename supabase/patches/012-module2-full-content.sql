-- ============================================================
-- Nurse Rocky — Patch 012: Module 2 Full Content
-- "Demonstrates Ethical and Legal Behavior That Maintains Resident Rights"
-- Source: Competency 2.docx (12 sub-competencies: 2.1–2.12)
-- Run in: Supabase Dashboard → SQL Editor
-- ============================================================

DO $$
DECLARE
  v_mod_id INT;
BEGIN

  SELECT id INTO v_mod_id FROM modules WHERE order_num = 2;

  IF v_mod_id IS NULL THEN
    RAISE EXCEPTION 'Module 2 not found. Run seed-modules.sql first.';
  END IF;

  UPDATE modules SET
    title = 'Demonstrates Ethical and Legal Behavior That Maintains Resident Rights',
    description = 'Ethical and legal standards, the Resident''s Bill of Rights, privacy, confidentiality, personal choice, grievances, personal possessions, abuse prevention, mandated reporting, restraint alternatives, independence, and activity participation.',
    is_published = true,
    lessons_count = 12
  WHERE id = v_mod_id;

  DELETE FROM lessons WHERE module_id = v_mod_id;

  INSERT INTO lessons (module_id, title, content, order_num) VALUES

  (v_mod_id,
   '2.1 — Ethical and Legal Behavior That Maintains Standards',
   'Competency 2.0: Demonstrates Ethical and Legal Behavior That Maintains Resident Rights
Certified Nursing Assistants (CNAs) have a legal and ethical responsibility to provide care that protects resident rights, promotes safety, and follows all applicable laws, regulations, and professional standards. Ethical and legal behavior is the foundation of trustworthy healthcare practice and ensures that residents receive respectful, safe, and dignified care at all times.
Students will learn how ethical principles, legal guidelines, and professional standards guide CNA practice, with an emphasis on resident rights, scope of practice, and professional accountability.
Learning Goal 2.1
Demonstrate ethical and legal behavior by maintaining the standards set forth for healthcare professions.
A. Functions, Roles, Responsibilities, and Legal Limits of the Nursing Assistant
The CNA plays an essential role in the healthcare team by providing direct care to residents under the supervision of licensed nursing staff. Responsibilities include assisting with activities of daily living, observing and reporting changes in condition, and supporting resident comfort and safety.
CNAs must always work within their legal scope of practice. They are not permitted to perform tasks that require clinical judgment, independent diagnosis, or procedures reserved for licensed nurses or other healthcare professionals. Practicing within legal limits protects both the resident and the nursing assistant.
B. Regulatory Boards, Laws, Rules, and Standards of Care
Nursing assistant practice is regulated by multiple agencies and standards, including:
	•	Arizona State Board of Nursing (AZBN): Governs certification, practice requirements, and standards of conduct for nursing assistants.
	•	Omnibus Budget Reconciliation Act (OBRA): Establishes federal requirements for training, competency, and resident rights in long-term care facilities.
	•	Joint Commission (JCAHO): Sets national standards for quality and safety in healthcare organizations.
	•	Occupational Safety and Health Administration (OSHA): Establishes workplace safety standards to protect healthcare workers from hazards.
These agencies ensure that CNAs provide safe, consistent, and high-quality care while maintaining professional accountability.
C. Certification, Renewal Requirements, and Criminal Conduct
To become a Certified Nursing Assistant in Arizona, individuals must meet educational requirements approved by the Arizona State Board of Nursing and successfully complete a competency evaluation.
Certification requirements include:
	•	Completion of an approved CNA training program.
	•	Passing the state certification examination.
	•	Meeting all eligibility requirements established by the AZBN.
Certification must be maintained through renewal, which may include verification of work experience and continued compliance with state regulations.
Certain criminal conduct may impact eligibility for certification or renewal. Felony convictions or other disqualifying offenses may result in denial, suspension, or revocation of certification, depending on state board review and regulations.
D. Standards of Conduct
CNAs are required to follow established standards of conduct, including:
	•	Federal regulations under OBRA.
	•	Arizona State Board of Nursing Standards of Conduct for Nursing Assistants.
	•	Joint Commission safety and quality standards.
	•	OSHA workplace safety standards.
These standards ensure safe, ethical, and professional care delivery and help protect residents from harm, neglect, or abuse.
E. Professional Behaviors
Professional behavior is essential for maintaining trust and providing high-quality care. CNAs are expected to demonstrate:
	•	Caring: Showing compassion and respect for all residents.
	•	Competence: Performing tasks safely and correctly.
	•	Conscientiousness: Being attentive, responsible, and maintaining personal hygiene.
	•	Courtesy: Communicating respectfully with residents, families, and staff.
	•	Dependability and Timeliness: Arriving on time and completing assignments responsibly.
	•	Honesty: Reporting accurate information and avoiding falsification of records.
	•	Teamwork: Cooperating with healthcare team members to ensure quality care.
F. Key Ethical and Legal Terms
CNAs must understand and apply important legal and ethical terminology in daily practice, including:
	•	Abandonment: Leaving a resident without proper care or supervision.
	•	Abuse: Includes physical, sexual, verbal, emotional abuse, threats, humiliation, involuntary seclusion, and financial exploitation.
	•	Advance Directive: Legal document outlining a resident’s healthcare wishes.
	•	Advocate: A person who supports and protects resident rights.
	•	Assault: Threatening harm to a resident.
	•	Battery: Physical contact without consent.
	•	Code of Conduct: Standards governing professional behavior.
	•	Defamation of Character: False statements harming reputation (slander or libel).
	•	Dual Relationships and Professional Boundaries: Maintaining appropriate caregiver-resident relationships.
	•	Ethics: Moral principles guiding professional behavior.
	•	False Imprisonment: Restricting a resident’s freedom unlawfully.
	•	Informed Consent: A resident’s voluntary agreement to treatment after receiving information.
	•	Invasion of Privacy: Violating a resident’s right to confidentiality or personal space.
	•	Neglect: Failure to provide necessary care, including physical or psychosocial neglect.
	•	Ombudsman: Advocate for residents in long-term care facilities.
	•	Privacy: Protecting personal information, visits, telephone conversations, and care details.
	•	Quality of Life: Overall well-being of the resident.
	•	Restraints: Chemical or physical methods used to restrict movement (regulated and limited).
	•	Self-Determination Act: Federal law protecting resident rights in healthcare decisions.
	•	Standards of Care: Minimum acceptable level of care that must be provided.
	•	Theft: Taking property belonging to a resident or facility.
Summary
Ethical and legal behavior is essential to the role of the Certified Nursing Assistant. By understanding laws, regulations, professional standards, certification requirements, and resident rights, CNAs are able to provide safe, respectful, and legally compliant care. Upholding professional behavior and maintaining awareness of ethical responsibilities ensures dignity, safety, and trust for every resident served.',
   1),

  (v_mod_id,
   '2.2 — Interprets, Explains, and Applies the Resident''s Bill of Rights',
   'Competency 2.2: Interprets, Explains, and Applies the Resident’s Bill of Rights
The Resident’s Bill of Rights is a fundamental component of ethical and legal nursing assistant practice. It ensures that all residents receive care that respects their dignity, autonomy, privacy, and personal choices. Certified Nursing Assistants (CNAs) play a critical role in protecting and upholding these rights through daily interactions and care practices.
Students will learn how to interpret, explain, and apply the Resident’s Bill of Rights in all healthcare settings, while promoting safety, respect, and person-centered care.
Learning Goal 2.2
Interpret, explain, and apply the Resident’s Bill of Rights in daily nursing assistant practice.
Principles and Rationale of Resident Rights (Right to…)
A. Free Choice
Residents have the right to make their own decisions about their care, lifestyle, and daily activities. CNAs must respect individual preferences and support resident autonomy whenever possible.
B. Freedom from Abuse and Restraints
Residents have the right to be free from physical, emotional, verbal, sexual, and financial abuse, as well as unnecessary restraints. CNAs must provide care that promotes safety without violating personal freedom.
C. Privacy
Residents have the right to privacy during personal care, medical treatment, and communication. CNAs must knock before entering rooms, close curtains, and protect resident dignity at all times.
D. Confidentiality of Personal and Clinical Records (HIPAA)
Residents have the right to have their personal and medical information protected under HIPAA (Health Insurance Portability and Accountability Act) standards. CNAs must never share confidential information with unauthorized individuals.
E. Accommodation of Needs
Residents have the right to have their needs met in a way that supports overall well-being.
	•	Physical Needs: Assistance with mobility, hygiene, nutrition, and medical care.
	•	Psychosocial Needs: Emotional support, respect, social interaction, and mental well-being.
F. Organize and Participate in Family and Resident Groups
Residents have the right to participate in resident councils and family meetings to voice concerns and contribute to facility decisions.
G. Participate in Social, Religious, and Community Activities
Residents should be encouraged to maintain their cultural, spiritual, and social practices as part of a meaningful quality of life.
H. Examine Survey Results and Correction Plans
Residents have the right to review facility inspection results and understand how issues are being corrected to improve care quality.
I. Manage Personal Funds
Residents have the right to manage their own money or have it managed responsibly if assistance is needed, with full accountability and protection against theft or misuse.
J. Information About Medicare/Medicaid Eligibility
Residents have the right to receive clear information regarding financial assistance programs such as Medicare and Medicaid.
K. File Complaints About Abuse, Neglect, or Misappropriation of Property
Residents may report concerns without fear of punishment or retaliation. CNAs must support and report concerns through proper channels immediately.
L. Information About Advocacy Groups
Residents have the right to access external support systems, such as the ombudsman program, which advocates for resident rights in long-term care settings.
M. Immediate and Unlimited Access to Family or Relatives
Residents have the right to communicate with and receive visits from family members and loved ones, except under specific safety restrictions.
N. Share a Room with a Partner or Maintain Intimacy
Residents may request to share accommodations with a partner and maintain appropriate personal relationships, respecting dignity and privacy.
O. Perform or Not Perform Work for the Facility
Residents cannot be forced to work for the facility. Any voluntary work must respect resident choice and be appropriately compensated if applicable.
P. Remain in the Facility
Residents have the right to remain in the facility and not be transferred or discharged without proper notice and justification.
Q. Use Personal Possessions
Residents may bring and use personal belongings to maintain comfort, identity, and familiarity, as long as safety is not compromised.
R. Notification of Change in Condition
Residents or their representatives must be promptly informed of any significant changes in health status, care plans, or medical conditions.
Summary
The Resident’s Bill of Rights protects the dignity, independence, and well-being of every individual receiving care. CNAs are responsible for understanding, respecting, and applying these rights in daily practice. By upholding these principles, nursing assistants ensure that care is ethical, person-centered, and legally compliant while promoting trust and safety in the healthcare environment.',
   2),

  (v_mod_id,
   '2.3 — Provides for Resident Privacy',
   'Competency 2.3: Provides for Resident Privacy
Privacy is a fundamental resident right and an essential component of ethical and professional nursing assistant practice. Certified Nursing Assistants (CNAs) are responsible for protecting the dignity, confidentiality, and personal space of every resident during all aspects of care. Maintaining privacy builds trust, promotes comfort, and supports a respectful and safe healthcare environment.
Students will learn how to describe the resident’s right to privacy and demonstrate actions that protect privacy during care activities and daily interactions.
Learning Goal 2.3
Provide for resident privacy by understanding and applying principles of privacy in all care settings.
A. Description of the Resident’s Right to Privacy
Residents have the legal and ethical right to privacy in all areas of care. This includes protection of personal information, bodily privacy during care procedures, and respect for private communication and personal space. Privacy ensures that residents maintain dignity and control over who has access to their body, information, and personal environment.
The right to privacy includes:
	•	Receiving personal care in a private setting.
	•	Protection of medical and personal information.
	•	Freedom from unnecessary exposure during care.
	•	Private communication with family, friends, and healthcare providers.
	•	Respect for personal space and belongings.
CNAs must always treat residents with dignity and avoid actions that may cause embarrassment, discomfort, or loss of respect.
B. How the Nursing Assistant Maintains Resident Privacy
Nursing assistants play a key role in protecting resident privacy during all care activities. This requires awareness, professionalism, and consistent use of privacy practices.
CNAs help maintain privacy by:
	•	Knocking before entering a resident’s room and waiting for permission to enter.
	•	Closing doors, curtains, and privacy screens during personal care.
	•	Explaining procedures before beginning care to reduce anxiety and promote cooperation.
	•	Covering the resident appropriately during bathing, dressing, or repositioning.
	•	Ensuring only necessary body parts are exposed during care.
	•	Speaking quietly and avoiding sharing personal information in public areas.
	•	Limiting the number of people present during care procedures.
A. Methods to Maintain Privacy
Proper privacy practices must be followed at all times in healthcare settings. Examples include:
	•	Not taking vital signs or performing assessments in public areas such as dining rooms, hallways, or common spaces.
	•	Avoiding discussions about resident conditions in public areas or in front of other residents.
	•	Using privacy curtains or closing doors during examinations and personal care.
	•	Transporting residents in a way that preserves dignity and prevents unnecessary exposure.
	•	Securing personal records and avoiding leaving documents where others can view confidential information.
B. Maintaining Privacy While Performing Resident Care
CNAs must consistently protect privacy during direct care tasks such as bathing, toileting, dressing, and repositioning. This includes:
	•	Providing only necessary exposure during care procedures.
	•	Keeping the resident covered with a blanket or sheet whenever possible.
	•	Respecting resident preferences regarding gender of caregiver when feasible.
	•	Communicating respectfully and maintaining a professional tone.
	•	Ensuring that care is performed efficiently to reduce prolonged exposure.
Maintaining privacy during care not only protects the resident’s dignity but also supports emotional comfort and trust between the resident and caregiver.
Summary
Resident privacy is a protected right that must be respected at all times. CNAs are responsible for maintaining privacy through professional communication, proper care techniques, and awareness of the resident’s environment. By consistently protecting privacy, nursing assistants promote dignity, trust, and high-quality person-centered care in every healthcare setting.',
   3),

  (v_mod_id,
   '2.4 — Maintains Resident Confidentiality',
   'Competency 2.4: Maintains Resident Confidentiality
Confidentiality is a legal and ethical responsibility that protects a resident’s personal and medical information from unauthorized access or disclosure. Certified Nursing Assistants (CNAs) must understand and apply confidentiality standards in all healthcare interactions to ensure compliance with professional regulations and to maintain trust between residents, families, and healthcare providers.
Students will learn how to describe the resident’s right to confidentiality and demonstrate appropriate actions to protect private information in accordance with healthcare laws and facility policies.
Learning Goal 2.4
Maintain resident confidentiality by applying legal, ethical, and professional standards in daily practice.
A. Description of the Resident’s Right to Confidentiality
Residents have the legal right to have their personal, medical, and financial information kept private and shared only with authorized individuals involved in their care. This right is protected under federal law, including HIPAA (Health Insurance Portability and Accountability Act).
Confidentiality includes:
	•	Protection of medical diagnoses, treatments, and care plans.
	•	Security of personal information such as identification, financial status, and family details.
	•	Control over who can access or receive information about the resident.
	•	Assurance that information is only shared for legitimate healthcare purposes.
Residents must feel confident that their information will not be disclosed without permission or proper authorization.
B. How Nursing Assistants Protect Resident Confidentiality
CNAs play an important role in maintaining confidentiality by following facility policies, legal requirements, and professional standards at all times.
Nursing assistants protect confidentiality by:
	•	Sharing resident information only with authorized healthcare team members involved in care.
	•	Avoiding discussions about residents in public areas such as hallways, elevators, dining rooms, or break rooms.
	•	Not posting or sharing resident information on social media or personal devices.
	•	Securing written documents and ensuring care records are not left unattended.
	•	Logging out of electronic health record systems when not in use.
	•	Referring family members or unauthorized individuals to the supervising nurse for information.
A. HIPAA Regulations and the “Unintended Receiver”
HIPAA regulations require that all protected health information (PHI) be safeguarded from unintended or unauthorized disclosure. An “unintended receiver” refers to any individual who receives confidential information without proper authorization.
Examples include:
	•	Other residents or visitors overhearing conversations.
	•	Unauthorized staff members accessing records.
	•	Information being discussed in open or public settings.
CNAs must take precautions to prevent accidental disclosure by ensuring conversations and documentation are handled securely and professionally.
B. Methods to Protect the Resident’s Right to Confidentiality
CNAs can protect confidentiality by consistently applying safe and professional practices, including:
	•	Discussing resident care only in private or secure staff areas.
	•	Using discretion when communicating with the healthcare team.
	•	Following facility policies for handling and storing records.
	•	Verifying identity before sharing any information when authorized.
	•	Reporting any suspected breaches of confidentiality immediately to a supervisor.
	•	Maintaining professionalism and avoiding casual discussion of resident conditions.
Summary
Maintaining confidentiality is essential to protecting resident rights, building trust, and complying with federal and state laws. CNAs must understand HIPAA regulations and consistently apply safe practices to prevent unauthorized disclosure of information. By respecting confidentiality, nursing assistants ensure ethical care and support the dignity and privacy of every resident they serve.',
   4),

  (v_mod_id,
   '2.5 — Promotes the Resident''s Right to Make Personal Choices',
   'Competency 2.5: Promotes the Resident’s Right to Make Personal Choices to Accommodate Their Needs
Respecting personal choice is a key component of resident rights and person-centered care. Certified Nursing Assistants (CNAs) must support each resident’s right to make decisions about their daily care, routines, and lifestyle preferences. Promoting choice helps maintain dignity, independence, and quality of life while ensuring care is individualized to meet each resident’s physical, emotional, and psychosocial needs.
Students will learn how to describe the resident’s right to personal choice and apply strategies that support decision-making in daily care situations.
Learning Goal 2.5
Promote the resident’s right to make personal choices and provide opportunities for decision-making during care.
A. Description of the Resident’s Right to Personal Choice
Residents have the right to make decisions about their own lives, including healthcare, daily routines, and personal preferences. This right supports autonomy and recognizes that each individual has unique values, beliefs, and needs.
The right to personal choice includes:
	•	Choosing daily routines such as waking, bathing, and bedtime schedules.
	•	Selecting clothing, meals, and personal items.
	•	Making decisions about participation in activities and social interactions.
	•	Accepting or refusing care when appropriate and within legal guidelines.
	•	Expressing preferences for caregivers or methods of care when possible.
CNAs must respect these choices and avoid forcing or pressuring residents into decisions that go against their wishes.
B. Offering Choices When Caring for Residents
CNAs support resident autonomy by offering appropriate choices during care and daily interactions. Even small choices help residents feel valued and respected.
Examples include:
	•	Asking what time the resident prefers to complete hygiene care when possible.
	•	Offering clothing options instead of selecting for the resident.
	•	Allowing residents to choose meal options from approved diets.
	•	Asking whether the resident prefers to bathe in the morning or evening if permitted.
	•	Providing options for activity participation or leisure time.
	•	Respecting refusal of care and reporting concerns to the supervising nurse.
Offering choices should always be done respectfully and without overwhelming the resident with too many options.
A. Guidelines and Example Situations for Supporting the Right to Choose
CNAs must follow facility policies and ensure that choices remain safe and appropriate. While residents have the right to make personal decisions, some choices may require clinical guidance or safety considerations.
Examples include:
	•	A resident choosing what clothes to wear for the day.
	•	A resident deciding when to eat within scheduled meal times.
	•	A resident choosing whether to participate in group activities.
	•	A resident refusing a bath, where the CNA must respect the choice and report it appropriately.
	•	A resident selecting preferred methods of communication or personal routines.
In all cases, CNAs should balance respect for choice with safety requirements and communicate concerns to the nurse when necessary.
B. Methods to Protect the Resident’s Right to Make Personal Choices
CNAs protect resident rights by consistently supporting independence and encouraging participation in care decisions. Methods include:
	•	Asking permission before beginning any care task.
	•	Encouraging residents to express preferences and opinions.
	•	Respecting refusal of care while ensuring safety concerns are reported.
	•	Providing information in a clear and understandable manner to support informed decisions.
	•	Avoiding control or coercion in decision-making.
	•	Advocating for the resident when their preferences are not being respected.
	•	Documenting and reporting choices when required by facility policy.
Summary
Promoting personal choice is essential to maintaining dignity, independence, and quality of life for residents. CNAs must consistently provide opportunities for decision-making, respect individual preferences, and support resident autonomy within safe and appropriate boundaries. By encouraging personal choice, nursing assistants contribute to compassionate, person-centered care that honors each resident as an individual.',
   5),

  (v_mod_id,
   '2.6 — Gives Assistance in Resolving Grievances and Disputes',
   'Competency 2.6: Gives Assistance in Resolving Grievances and Disputes
Certified Nursing Assistants (CNAs) play an important role in supporting residents when they have concerns, complaints, or questions about their care. While CNAs do not resolve formal grievances independently, they are often the first point of contact for residents and must respond in a professional, respectful, and supportive manner. Understanding how to properly address concerns helps protect resident rights and promotes a safe and trusting healthcare environment.
Students will learn how to describe the resident’s right to voice grievances and identify appropriate CNA actions when assisting in the grievance process.
Learning Goal 2.6
Provide assistance in resolving grievances and disputes within the nursing assistant role.
A. Resident’s Right to Voice Disputes and Grievances
Residents have the legal and ethical right to express concerns, complaints, or dissatisfaction regarding their care without fear of retaliation, punishment, or loss of services. This right ensures that residents can advocate for themselves and receive appropriate attention when issues arise.
Residents have the right to:
	•	Voice complaints about care, treatment, or services.
	•	Report abuse, neglect, or mistreatment.
	•	Expect their concerns to be addressed promptly and respectfully.
	•	Be free from retaliation after filing a grievance.
	•	Participate in resolving concerns related to their care environment.
CNAs must respect and support this right at all times.
B. Role of the Nursing Assistant in Responding to Concerns
When a resident voices a concern, complaint, or question, the CNA’s role is to listen respectfully, remain calm, and take appropriate action according to facility policy. CNAs are not responsible for formally resolving grievances but must ensure concerns are reported through proper channels.
Appropriate CNA actions include:
	•	Listening to the resident without interrupting or becoming defensive.
	•	Showing empathy and taking concerns seriously.
	•	Reporting the issue promptly to the supervising nurse.
	•	Documenting concerns according to facility policy when required.
	•	Avoiding promises that cannot be kept or attempting to solve issues outside of scope.
	•	Supporting the resident in accessing appropriate resources when needed.
A. Key Terms and Concepts
1. Grievance
A formal complaint or concern expressed by a resident regarding care, services, or treatment.
2. Ombudsman
An independent advocate who represents residents in long-term care facilities and helps resolve complaints related to quality of care and resident rights.
3. Resident’s Council
A group of residents who meet to discuss concerns, suggest improvements, and address issues related to facility operations and quality of life.
B. Methods to Resolve Grievances and Disputes Within the CNA Role
CNAs support the grievance process by acting as advocates for resident well-being and ensuring proper communication. Methods include:
	•	Responding calmly and respectfully to resident concerns.
	•	Encouraging residents to express concerns to appropriate staff or leadership.
	•	Reporting issues immediately to the charge nurse or supervisor.
	•	Following facility procedures for documenting concerns.
	•	Supporting resident participation in councils or advocacy programs.
	•	Ensuring the resident feels heard and respected, even when the CNA cannot directly fix the issue.
CNAs must always remain within their scope of practice and avoid attempting to independently resolve complaints that require supervisory or administrative intervention.
Summary
Assisting with grievances and disputes is an important part of protecting resident rights and promoting quality care. CNAs serve as advocates by listening, reporting concerns, and supporting residents through appropriate channels. By responding professionally and following facility procedures, nursing assistants help ensure that resident concerns are addressed fairly, respectfully, and in a timely manner.',
   6),

  (v_mod_id,
   '2.7 — Maintains Care and Security of Resident''s Personal Possessions',
   'Competency 2.7: Maintains Care and Security of Resident’s Personal Possessions
Residents have the right to own, use, and protect their personal belongings while receiving care in a healthcare facility. Certified Nursing Assistants (CNAs) are responsible for supporting this right by ensuring that resident possessions are handled with respect, care, and security at all times. Protecting personal property promotes dignity, independence, and trust in the healthcare environment.
Students will learn how to describe the resident’s right to personal possessions and demonstrate methods for safely caring for and protecting those items in a healthcare setting.
Learning Goal 2.7
Maintain care and security of resident’s personal possessions while respecting resident rights and facility policies.
A. Resident’s Right Related to Personal Possessions
Residents have the legal and ethical right to retain and use their personal belongings while in a care facility. This includes clothing, toiletries, assistive devices, jewelry, photographs, and other personal items.
The right to personal possessions includes:
	•	Keeping personal items unless restricted for safety reasons.
	•	Using personal belongings to maintain comfort and identity.
	•	Protection of valuables from theft, loss, or damage.
	•	Access to secure storage for important items when needed.
	•	Being treated with respect regarding ownership of personal property.
CNAs must always recognize that resident belongings are an extension of their identity and dignity.
B. Role of the Nursing Assistant in Safeguarding Personal Possessions
The CNA plays an important role in ensuring that resident belongings are handled safely and respectfully. While CNAs are not responsible for managing financial assets, they must take precautions to protect personal items used in daily care.
CNAs help safeguard possessions by:
	•	Handling resident belongings carefully and only with permission.
	•	Ensuring items are returned to their proper place after use.
	•	Reporting lost, missing, or damaged items immediately to the nurse.
	•	Following facility policies for storage and security of valuables.
	•	Encouraging residents to keep track of their personal items when appropriate.
A. Principles and Rationale of Safeguarding Personal Possessions
Protecting resident belongings is essential for maintaining trust, preventing theft or loss, and preserving dignity. Residents may experience emotional distress when personal items are misplaced or damaged, making proper handling an important part of quality care.
Key principles include:
	•	Respect for ownership and personal property.
	•	Accountability in handling resident belongings.
	•	Prevention of loss, theft, or misplacement.
	•	Promotion of resident dignity and independence.
	•	Adherence to facility safety and security procedures.
B. Methods to Care for and Secure Resident Possessions
CNAs must use safe and consistent methods to ensure personal belongings are protected.
1. Safe Storage of Valuables
Valuables such as jewelry, money, or important documents should be stored according to facility policy, often in a secure location such as a locked drawer, safe, or designated storage area. CNAs must never take responsibility for personal valuables outside of approved procedures and should always involve supervisory staff when needed.
2. Labeling Personal Items and Containers
All resident belongings, including clothing, assistive devices, and personal containers, should be clearly labeled according to facility guidelines. Proper labeling helps prevent mix-ups, loss, and confusion between residents.
Additional safe practices include:
	•	Returning items to the correct resident after use.
	•	Keeping personal items organized and accessible.
	•	Ensuring assistive devices (glasses, hearing aids, dentures) are stored safely when not in use.
	•	Reporting any missing items immediately.
Summary
Maintaining the care and security of resident personal possessions is a key responsibility of the CNA. By respecting ownership, following facility procedures, and using safe handling and storage methods, nursing assistants help protect resident dignity, trust, and emotional well-being. Proper care of personal belongings is an essential part of providing respectful, person-centered care.',
   7),

  (v_mod_id,
   '2.8 — Promotes the Resident''s Right to Be Free from Abuse',
   'Competency 2.8: Promotes the Resident’s Right to Be Free from Abuse, Mistreatment, and Neglect
All residents have the fundamental right to live in an environment that is safe, respectful, and free from abuse, mistreatment, and neglect. Certified Nursing Assistants (CNAs) play a critical role in protecting this right by providing compassionate care, maintaining professional boundaries, and immediately reporting any concerns related to resident safety.
Students will learn how to recognize, prevent, and respond to abuse, mistreatment, and neglect in accordance with ethical, legal, and professional standards.
Learning Goal 2.8
Promote and protect the resident’s right to be free from abuse, mistreatment, and neglect.
A. Role of the Nursing Assistant in Protecting Residents
CNAs are often the primary caregivers and spend the most time with residents, placing them in a key position to observe changes in behavior, condition, or environment. The nursing assistant’s role includes:
	•	Providing safe, respectful, and compassionate care at all times.
	•	Following facility policies and professional standards of conduct.
	•	Maintaining appropriate professional boundaries.
	•	Observing and reporting any suspected abuse, neglect, or mistreatment immediately.
	•	Supporting residents who voice concerns or show signs of fear or distress.
	•	Participating in creating a safe care environment.
CNAs are legally required to report suspected abuse and must never attempt to handle or investigate cases independently.
B. Types of Elder Abuse
Elder abuse can take many forms, including:
	•	Physical Abuse: Hitting, pushing, shaking, or causing physical harm.
	•	Emotional or Psychological Abuse: Threats, humiliation, intimidation, or isolation.
	•	Verbal Abuse: Yelling, insulting, or using disrespectful language.
	•	Sexual Abuse: Any non-consensual sexual contact or behavior.
	•	Financial Abuse: Stealing money, property, or misusing a resident’s assets.
	•	Involuntary Seclusion: Separating a resident from others without medical justification.
	•	Neglect: Failure to provide necessary care, such as hygiene, nutrition, hydration, or medical attention.
C. Signs of Abuse
CNAs must remain alert to both physical and behavioral indicators of abuse or neglect. Common signs include:
	•	Unexplained bruises, burns, fractures, or injuries.
	•	Sudden changes in behavior or mood (fear, anxiety, withdrawal).
	•	Poor hygiene, malnutrition, or dehydration.
	•	Frequent injuries or repeated hospital visits.
	•	Fear of specific staff members or caregivers.
	•	Sudden financial changes or missing personal belongings.
	•	Unsafe living conditions or lack of basic care.
A. Signs of Abuse, Mistreatment, and Neglect
Additional warning signs may include:
	•	Resident flinching or avoiding physical contact.
	•	Inconsistent explanations for injuries.
	•	Delayed treatment of medical conditions.
	•	Untreated pressure injuries or infections.
	•	Emotional distress or depression without clear cause.
B. Methods to Protect Residents from Abuse, Mistreatment, and Neglect
CNAs can help prevent abuse and protect residents by consistently following safe and ethical practices, including:
	•	Providing care according to training and facility guidelines.
	•	Treating all residents with dignity, respect, and compassion.
	•	Reporting concerns immediately to the nurse or supervisor.
	•	Following the chain of command and mandated reporting laws.
	•	Maintaining professional boundaries at all times.
	•	Ensuring residents are not left unattended or in unsafe situations.
	•	Documenting and reporting observations accurately and promptly.
	•	Participating in ongoing education about abuse prevention.
Summary
Protecting residents from abuse, mistreatment, and neglect is one of the most important responsibilities of a Certified Nursing Assistant. By recognizing warning signs, providing safe care, and reporting concerns immediately, CNAs help ensure a secure and supportive environment for all residents. Upholding this right promotes dignity, safety, and trust within the healthcare setting.',
   8),

  (v_mod_id,
   '2.9 — Reports Abuse, Mistreatment, or Neglect to Supervisor',
   'Competency 2.9: Reports Any Instance of Abuse, Mistreatment, or Neglect to the Appropriate Supervisor
Certified Nursing Assistants (CNAs) have a legal and ethical duty to protect residents from harm. This includes the immediate reporting of any suspected or observed abuse, mistreatment, or neglect. Prompt reporting ensures resident safety, supports legal compliance, and upholds professional standards of care.
Students will learn the legal responsibility to report abuse, mistreatment, or neglect, as well as the correct procedures for reporting through the appropriate chain of command and external agencies when required.
Learning Goal 2.9
Report any instance of abuse, mistreatment, or neglect to the appropriate supervisor according to legal and facility requirements.
A. Legal Requirement and Consequences for Failure to Report
Under OBRA (Omnibus Budget Reconciliation Act) and state regulations, nursing assistants are considered mandated reporters. This means they are legally required to report any suspected or witnessed abuse, mistreatment, or neglect immediately.
Employee responsibilities include:
	•	Reporting concerns immediately to the appropriate supervisor or licensed nurse.
	•	Protecting residents from further harm.
	•	Following facility policies and procedures for reporting.
	•	Cooperating with investigations when required.
Failure to report abuse, mistreatment, or neglect can result in serious consequences, including:
	•	Disciplinary action by the employer (suspension or termination).
	•	Loss or revocation of CNA certification.
	•	Civil or criminal legal penalties.
	•	Potential liability for harm caused by failure to act.
Timely reporting is essential to ensure resident safety and legal compliance.
B. Methods and Chain of Command for Reporting Abuse, Mistreatment, or Neglect
CNAs must follow established reporting procedures to ensure concerns are addressed appropriately and documented correctly.
1. Chain of Command
The chain of command is the proper order of authority within a healthcare facility. CNAs should report concerns to:
	•	Charge nurse or supervising nurse.
	•	Nurse manager or supervisor if needed.
	•	Facility administrator if the issue is not resolved.
CNAs should never attempt to investigate the situation independently but must report observations immediately.
2. Facility Policy
Each healthcare facility has specific policies outlining how to report abuse, mistreatment, or neglect. CNAs must follow these policies exactly, including:
	•	Completing incident reports when required.
	•	Documenting factual observations only.
	•	Reporting immediately without delay.
3. Community Agencies
In certain situations, reports may also be made to external agencies such as:
	•	State health departments.
	•	Adult Protective Services (APS).
	•	Long-term care ombudsman programs.
These agencies help investigate concerns and ensure resident rights are protected.
Principles and Rationale for Reporting Abuse, Mistreatment, or Neglect
A. OBRA and State Requirements
Federal and state laws require all nursing assistants to report suspected abuse or neglect. These laws are designed to protect vulnerable individuals and ensure accountability in healthcare settings.
	•	Employee ResponsibilityCNAs are required to act immediately when abuse or neglect is suspected. Reporting is not optional and is a professional and legal obligation.
	•	Consequences for Failure to ReportFailing to report can result in serious harm to residents and may lead to disciplinary action, loss of certification, or legal consequences for the nursing assistant.
B. Methods to Report Abuse, Mistreatment, or Neglect
CNAs must use proper reporting procedures to ensure timely and effective intervention.
	•	Chain of CommandReport concerns directly to the supervising nurse or charge nurse as soon as the situation is identified.
	•	Facility PolicyFollow all documentation and reporting procedures established by the facility without delay.
	•	Community AgenciesWhen required, report concerns to external agencies such as Adult Protective Services or the long-term care ombudsman to ensure resident safety and legal compliance.
Summary
Reporting abuse, mistreatment, or neglect is a critical legal and ethical responsibility of the Certified Nursing Assistant. Immediate reporting through the proper chain of command and required agencies helps protect residents, prevent further harm, and ensure compliance with state and federal regulations. CNAs play a vital role in maintaining a safe, respectful, and accountable healthcare environment.',
   9),

  (v_mod_id,
   '2.10 — Utilizes Interventions That Minimize Restraints',
   'Competency 2.10: Utilizes Interventions That Minimize the Need for Restraints
The use of restraints in healthcare settings is strictly regulated and should only be used when absolutely necessary for resident safety. Certified Nursing Assistants (CNAs) play an important role in preventing the use of restraints by applying alternative interventions, maintaining resident safety, and observing residents who may be at risk. CNAs must always promote dignity, autonomy, and the least restrictive methods of care.
Students will learn ethical and legal considerations related to restraints, the resident’s right to be free from restraints, and appropriate CNA interventions to reduce restraint use while ensuring resident safety.
Learning Goal 2.10
Utilize interventions that minimize the need for restraints and promote resident safety and dignity.
 
A. Ethical and Legal Issues in the Use of Restraints
The use of restraints involves significant ethical and legal considerations because restraints can limit a resident’s freedom and autonomy. Restraints must never be used for staff convenience or as a substitute for proper care.
Key guidelines include:
	•	Restraints require a physician’s order and must be clearly justified.
	•	Use must follow JCAHO (Joint Commission) and facility standards.
	•	Restraints must be the least restrictive method necessary to ensure safety.
	•	Residents must be monitored closely and reassessed regularly.
	•	Restraints must be released at least every 2 hours, or more frequently per facility policy, with documentation of care provided.
Improper use of restraints may result in legal consequences, violation of resident rights, and disciplinary action.
B. Resident’s Right to Be Free from Restraints
Residents have the legal and ethical right to be free from unnecessary physical or chemical restraints. Restraints may only be used when all other alternatives have failed and when there is a clear medical necessity.
Resident rights related to restraints include:
	•	The right to informed consent when applicable.
	•	The right to the least restrictive intervention possible.
	•	The right to dignity, safety, and freedom of movement.
	•	Protection from misuse of physical, chemical, active, or passive restraints.
Types of restraints include:
	•	Physical restraints: Devices that restrict movement (e.g., belts, vests).
	•	Chemical restraints: Medications used to control behavior rather than treat a medical condition.
	•	Active restraints: Devices that directly limit motion.
	•	Passive restraints: Measures that restrict movement indirectly.
C. Role of the Nursing Assistant in Minimizing Restraints
CNAs are responsible for using safe, compassionate care strategies to reduce the need for restraints. This includes identifying potential risks and implementing alternatives before restraints are considered.
CNAs help minimize restraint use by:
	•	Providing frequent observation and supervision of residents at risk for falls or agitation.
	•	Responding promptly to resident needs such as toileting, hunger, thirst, pain, or discomfort.
	•	Using therapeutic communication, redirection, and meaningful activities to reduce agitation.
	•	Ensuring a safe environment with adequate lighting, clear pathways, and appropriate assistive devices.
	•	Reporting changes in behavior or safety concerns to the supervising nurse immediately.
	•	Assisting with mobility and exercise programs as ordered to maintain strength and reduce restlessness.
	•	Never applying restraints unless ordered by a physician and following all facility monitoring requirements.
Summary
CNAs play a vital role in minimizing restraint use by providing attentive care, addressing underlying needs, and promoting safe alternatives. By understanding ethical and legal requirements and applying supportive interventions, nursing assistants help protect resident rights, dignity, and safety while reducing unnecessary restraint use.',
   10),

  (v_mod_id,
   '2.11 — Promotes Resident Independence',
   'Competency 2.11: Promotes Resident Independence
Promoting resident independence is a core principle of nursing assistant practice and is essential to maintaining dignity, self-worth, and quality of life. Certified Nursing Assistants (CNAs) support each resident’s ability to function at their highest possible level of independence by encouraging participation in self-care and respecting individual capabilities and preferences.
Students will learn how to describe the resident’s right to self-determination and independence, and how to apply supportive interventions that encourage resident autonomy in daily care.
Learning Goal 2.11
Promote resident independence by supporting self-determination, self-care, and personal autonomy.
 
A. Resident’s Right to Self-Determination, Self-Care, and Independence
Residents have the legal and ethical right to make decisions about their own care and to participate in activities that promote independence. Self-determination means that residents have control over their own lives, including choices related to daily routines, personal care, and healthcare decisions.
Residents have the right to:
	•	Make choices about their care and daily activities.
	•	Participate in their own self-care to the greatest extent possible.
	•	Refuse assistance when appropriate and safe.
	•	Maintain control over personal decisions and lifestyle preferences.
	•	Receive support that encourages independence rather than dependency.
CNAs must respect these rights and avoid performing tasks for residents that they are capable of doing themselves.
 
B. Actions Nursing Assistants May Take to Promote Independence
CNAs play a key role in encouraging residents to remain as independent as possible by providing support rather than taking over tasks unnecessarily.
Actions that promote independence include:
	•	Encouraging residents to complete activities of daily living (ADLs) such as dressing, grooming, and feeding with minimal assistance.
	•	Offering guidance and assistance only when needed rather than performing tasks entirely for the resident.
	•	Allowing residents extra time to complete tasks at their own pace.
	•	Providing adaptive equipment (e.g., walkers, grab bars, adaptive utensils) as appropriate.
	•	Encouraging mobility and physical activity within safe limits.
	•	Supporting decision-making by offering choices in care routines and activities.
	•	Reinforcing resident strengths and abilities to build confidence.
 
A. Principles and Rationale of Promoting Resident Independence
Promoting independence is essential for physical health, emotional well-being, and overall quality of life. When residents are encouraged to do as much as possible for themselves, they maintain greater strength, mobility, and cognitive function.
Key principles include:
	•	Respect for autonomy and self-determination.
	•	Encouragement of dignity and self-worth.
	•	Prevention of unnecessary dependence on caregivers.
	•	Support of physical, emotional, and cognitive function.
	•	Focus on resident-centered care.
Encouraging independence also reduces frustration, improves satisfaction, and enhances the resident’s sense of control.
 
B. Methods to Promote Resident Independence
CNAs can use practical strategies to support independence in daily care activities while ensuring safety and comfort.
Methods include:
	•	Encouraging residents to perform tasks they are capable of doing safely.
	•	Breaking tasks into small steps to make them more manageable.
	•	Providing adaptive equipment and assistive devices.
	•	Allowing residents sufficient time without rushing or taking over tasks.
	•	Offering verbal cues or gentle reminders instead of full assistance.
	•	Setting up the environment to promote success (e.g., placing items within reach).
	•	Observing and reassessing the level of assistance needed as the resident’s condition changes.
 
Summary
Promoting resident independence is a vital part of providing respectful and high-quality care. CNAs must support self-determination by encouraging residents to participate in their own care, make choices, and maintain control over their daily lives. By using supportive strategies and respecting individual abilities, nursing assistants help residents maintain dignity, confidence, and the highest possible level of independence.',
   11),

  (v_mod_id,
   '2.12 — Assists Residents to Participate in Activities',
   'Competency 2.12: Assists Residents to Participate in Activities
Participation in activities is an important part of resident well-being and quality of life. Certified Nursing Assistants (CNAs) support residents by encouraging engagement in meaningful activities that promote physical health, emotional well-being, social interaction, and independence. Activities help residents maintain purpose, reduce isolation, and improve overall satisfaction with care.
Students will learn how to describe the resident’s right to participate in activities and demonstrate ways to support involvement in both daily and restorative activities.
Learning Goal 2.12
Assist residents to participate in activities that support physical, emotional, and social well-being.
 
A. Resident’s Right to Participate in Family and Group Activities
Residents have the right to participate in activities that support their interests, cultural beliefs, social needs, and personal preferences. This includes involvement in family gatherings, group activities, recreational programs, and care-related meetings.
Residents have the right to:
	•	Participate in social, recreational, and therapeutic activities.
	•	Attend family meetings and resident council meetings.
	•	Choose whether or not to participate in activities.
	•	Engage in activities that reflect personal interests and abilities.
	•	Be supported in maintaining social connections with family and peers.
CNAs must respect these rights and encourage participation without forcing involvement.
 
B. Activities of Daily Living and Restorative Activities
CNAs support both Activities of Daily Living (ADLs) and restorative activities that help residents maintain or improve their level of functioning.
Activities of Daily Living (ADLs) include:
	•	Bathing and personal hygiene
	•	Dressing and grooming
	•	Eating and hydration
	•	Mobility and transferring
	•	Toileting and continence care
Restorative activities include:
	•	Range of motion exercises
	•	Walking or mobility practice
	•	Strength and balance activities
	•	Cognitive stimulation activities
	•	Encouraging independence in self-care tasks
CNAs help residents remain active and engaged by integrating these activities into daily care routines.
 
A. Principles and Rationale of Assisting Residents with Activities
Supporting resident participation in activities is essential for maintaining health, independence, and emotional well-being.
Key principles include:
	•	Activities of Daily Living (ADLs): Encouraging residents to participate in self-care promotes independence and preserves functional ability.
	•	Family Meetings: Participation in family discussions and care planning meetings helps residents feel involved, informed, and supported in their care decisions.
Engagement in activities reduces boredom, prevents isolation, and supports both physical and mental health.
 
B. Methods to Assist Residents in Participating in Activities
CNAs can support resident participation in activities by using encouragement, communication, and individualized care approaches.
Methods include:
	•	Encouraging residents to attend group or recreational activities based on interest and ability.
	•	Assisting residents with mobility or transportation to activity areas.
	•	Providing reminders and positive encouragement to participate.
	•	Adjusting care schedules to allow time for activities.
	•	Offering choices in activity participation to respect resident preferences.
	•	Assisting with setup or preparation for activities as needed.
	•	Observing resident responses and reporting changes in interest or ability.
CNAs must always respect the resident’s right to refuse participation while continuing to offer encouragement and support.
 
Summary
Assisting residents with activities is an important part of holistic, person-centered care. CNAs play a key role in promoting engagement by encouraging participation in daily, social, and restorative activities. By supporting independence, respecting choices, and providing appropriate assistance, nursing assistants help improve quality of life and overall well-being for every resident.',
   12);

  RAISE NOTICE 'Module 2 updated with 12 lessons.';
END $$;
