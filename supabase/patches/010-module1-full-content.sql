-- ============================================================
-- Nurse Rocky — Patch 010: Module 1 Full Content
-- "Functions as a Member of the Health Care Facility and/or Community"
-- Source: Competency 1.docx (6 sub-competencies)
-- Run in: Supabase Dashboard → SQL Editor
-- ============================================================

DO $$
DECLARE
  v_mod_id INT;
BEGIN

  SELECT id INTO v_mod_id FROM modules WHERE order_num = 1;

  IF v_mod_id IS NULL THEN
    RAISE EXCEPTION 'Module 1 not found. Run seed-modules.sql first.';
  END IF;

  UPDATE modules SET
    title = 'Functions as a Member of the Health Care Facility',
    description = 'Understand healthcare settings, the nursing team, regulatory and professional guidelines, delegation, professional work habits, time management, and stress management as a CNA.',
    is_published = true
  WHERE id = v_mod_id;

  DELETE FROM lessons WHERE module_id = v_mod_id;

  INSERT INTO lessons (module_id, title, content, order_num) VALUES

  (v_mod_id,
   '1.1 — Essential Functions of Healthcare Facilities and Settings',
   'Competency 1.0: Functions as a Member of the Health Care Facility and/or Community

As a Certified Nursing Assistant (CNA), it is important to understand the different types of healthcare settings and the role each plays in meeting the needs of patients and residents. Healthcare services are provided across a variety of environments, each designed to support individuals with different levels of medical, physical, emotional, and social needs.

Students will learn the essential functions of healthcare facilities and the similarities and differences between acute care, long-term care, assisted living, home care, rehabilitation, and hospice services. Understanding these settings helps CNAs provide appropriate care while working effectively as members of the healthcare team.

Learning Goal 1.1
Identify the essential functions of healthcare facilities and distinguish between various healthcare settings.

Healthcare Settings

A. Acute Care
Acute care facilities, such as hospitals, provide short-term medical treatment for serious illnesses, injuries, surgeries, and emergency conditions. Patients typically stay for a limited time and receive intensive medical care from a multidisciplinary healthcare team.

B. Long-Term Care
Long-term care facilities, often called nursing homes or skilled nursing facilities, provide ongoing care for individuals who require assistance with activities of daily living and medical monitoring over an extended period. Residents may remain in these facilities for months or years.

C. Assisted Living
Assisted living communities support individuals who need help with daily activities such as bathing, dressing, medication management, and meal preparation while maintaining as much independence as possible. Residents typically do not require the skilled nursing care provided in long-term care facilities.

D. Home Care
Home care services allow individuals to receive care in their own homes. CNAs may assist clients with personal care, meal preparation, mobility, and household tasks while promoting independence and comfort in a familiar environment.

E. Rehabilitation
Rehabilitation facilities focus on helping patients recover from injuries, surgeries, illnesses, or disabilities. The goal is to restore function, improve mobility, and maximize independence through therapies and supportive care.

F. Hospice
Hospice care provides compassionate end-of-life care for individuals with terminal illnesses. The focus is on comfort, dignity, pain management, emotional support, and quality of life for both the patient and their family rather than curative treatment.

Summary
Although each healthcare setting serves a unique purpose, all share the common goal of promoting health, safety, comfort, and quality of life. As future CNAs, students must understand the functions of each setting and adapt their caregiving approach to meet the specific needs of the individuals they serve.',
   1),

  (v_mod_id,
   '1.2 — Essential Duties of the Nursing Team Within a Care Facility',
   'Competency 1.2: Explains the Essential Duties of the Nursing Team Within a Care Facility

Quality patient care depends on effective teamwork among healthcare professionals. As a Certified Nursing Assistant (CNA), you are an important member of the healthcare team and play a vital role in supporting patients, residents, families, nurses, and other healthcare professionals. Understanding the responsibilities of each team member helps ensure safe, coordinated, and compassionate care.

Students will learn the functions and duties of nursing personnel, the organizational structure of healthcare facilities, and the importance of collaborating with members of the interdisciplinary healthcare team.

Learning Goal 1.2
Explain the essential duties of the nursing team and demonstrate an understanding of teamwork within a healthcare facility.

A. Essential Function of the Registered Nurse (RN)
The Registered Nurse (RN) is responsible for overseeing patient care and managing the nursing process. RNs assess patients, develop care plans, administer medications, perform treatments, supervise nursing personnel, provide patient education, and communicate with physicians and other healthcare providers. The RN serves as a leader within the healthcare team and ensures that patient care meets established standards.

B. Essential Function of the Licensed Practical Nurse (LPN)
The Licensed Practical Nurse (LPN) provides nursing care under the supervision of an RN or physician. LPN responsibilities may include monitoring patients, administering certain medications, performing treatments, collecting patient information, documenting care, and reporting changes in a patient''s condition. The scope of practice for LPNs varies according to state regulations and facility policies.

C. Essential Function of the Nurse Assistant (CNA)
The Certified Nursing Assistant (CNA) provides direct hands-on care to patients and residents. Duties may include assisting with bathing, grooming, dressing, toileting, feeding, mobility, vital signs, and observing changes in patient condition. CNAs serve as the eyes and ears of the healthcare team and play a critical role in maintaining patient comfort, dignity, and safety.

D. Elements of a Functioning Healthcare Team
A successful healthcare team is built upon:
• Effective communication
• Mutual respect
• Professionalism
• Trust and accountability
• Cooperation and collaboration
• Patient-centered care
• Shared goals and responsibilities

Each team member contributes specialized knowledge and skills while working together to achieve the best possible outcomes for patients and residents.

E. Working with Other Members of the Healthcare Team
Healthcare facilities utilize an interdisciplinary team approach to provide comprehensive care. CNAs frequently work alongside a variety of healthcare professionals, including:

Physician — Diagnoses illnesses, prescribes treatments, and directs medical care.

Nurse Practitioner (NP) — Provides advanced patient care, performs assessments, diagnoses conditions, and may prescribe medications.

Dietitian — Assesses nutritional needs and develops specialized meal plans to support patient health and recovery.

Dietary Technician — Assists with implementing dietary plans and ensuring patients receive appropriate meals based on physician and dietitian recommendations.

Physical Therapist (PT) — Helps patients improve mobility, strength, balance, and physical function following illness, injury, or surgery.

Speech Therapist (Speech-Language Pathologist) — Assists patients who have difficulties with speech, communication, swallowing, or cognitive function.

Social Worker — Provides emotional support, counseling, discharge planning, community resource referrals, and assistance with social and financial concerns.

Organizational Structure in Healthcare
Healthcare facilities operate within a chain of command that establishes clear lines of authority and communication. CNAs report concerns and observations to their supervising nurse, who may communicate with other healthcare professionals as needed. Following the chain of command helps ensure patient safety, effective communication, and efficient problem-solving.

Summary
Every member of the healthcare team contributes to the delivery of high-quality patient care. By understanding the responsibilities of Registered Nurses, Licensed Practical Nurses, Nurse Assistants, and other healthcare professionals, CNA students can work collaboratively, communicate effectively, and provide safe, compassionate, and patient-centered care.',
   2),

  (v_mod_id,
   '1.3 — Nursing Assistant Role in Regulatory and Professional Guidelines',
   'Competency 1.3: Explains the Nursing Assistant Role as Outlined in Regulatory and Professional Guidelines

Certified Nursing Assistants (CNAs) are entrusted with providing safe, compassionate, and ethical care to patients and residents. To perform this role effectively, CNAs must understand and follow federal regulations, state laws, facility policies, and professional standards of conduct. These guidelines are designed to protect patients, promote quality care, and establish expectations for professional behavior in healthcare settings.

Students will learn the regulatory requirements and professional responsibilities that govern nursing assistant practice, including certification standards, ethical principles, patient rights, informed consent, and advance care planning.

Learning Goal 1.3
Explain the nursing assistant role as defined by regulatory agencies and professional standards.

A. Omnibus Budget Reconciliation Act (OBRA)
The Omnibus Budget Reconciliation Act (OBRA) established federal requirements for nursing assistant education, competency evaluation, and resident rights. OBRA was created to improve the quality of care provided in long-term care facilities and ensure that nursing assistants receive proper training before providing direct patient care.

Under OBRA guidelines, nursing assistants must:
• Complete an approved training program.
• Successfully pass a competency evaluation.
• Demonstrate ongoing competency in resident care.
• Protect resident rights, dignity, and privacy.
• Provide care that promotes the highest practical level of physical, mental, and psychosocial well-being.

B. Arizona State Board of Nursing Requirements for Certification
The Arizona State Board of Nursing establishes the requirements for becoming a Certified Nursing Assistant in Arizona. To obtain certification, individuals must:
• Complete a Board-approved nursing assistant training program.
• Successfully pass the state competency examination.
• Meet all eligibility requirements established by the Arizona State Board of Nursing.
• Comply with state laws and regulations governing nursing assistant practice.

Certification demonstrates that the nursing assistant possesses the knowledge and skills necessary to provide safe patient care.

C. Arizona State Board of Nursing Requirements for Recertification
To maintain active certification, nursing assistants must comply with Arizona State Board of Nursing recertification requirements. These requirements help ensure that CNAs remain competent and continue practicing safely.

Recertification may include:
• Meeting employment or work-hour requirements.
• Submitting renewal applications within designated timeframes.
• Maintaining compliance with state regulations and standards of conduct.
• Reporting information required by the Arizona State Board of Nursing.

Failure to maintain certification may result in the inability to practice as a CNA in Arizona.

D. Standards of Conduct (R4-19-814)
The Arizona Administrative Code R4-19-814 outlines standards of conduct for nursing assistants. These standards promote professionalism, accountability, and patient safety.

Nursing assistants are expected to:
• Practice within their scope of training.
• Provide safe and competent care.
• Respect patient rights and confidentiality.
• Report concerns that may affect patient safety.
• Maintain professional boundaries.
• Follow facility policies and state regulations.

Violations of these standards may result in disciplinary action, suspension, or revocation of certification.

E. Ethics in the Workplace
Ethics refers to the moral principles that guide professional behavior and decision-making. CNAs must demonstrate honesty, integrity, fairness, respect, and compassion in every patient interaction.

Ethical responsibilities include:
• Respecting patient dignity and autonomy.
• Maintaining confidentiality.
• Treating all patients fairly and without discrimination.
• Reporting abuse, neglect, or unsafe practices.
• Acting in the best interest of the patient at all times.

Ethical behavior helps build trust between patients, families, and healthcare providers.

F. Informed Consent
Informed consent is the process by which a patient voluntarily agrees to a treatment or procedure after receiving adequate information about the risks, benefits, and alternatives.

Although obtaining informed consent is typically the responsibility of the physician or licensed healthcare provider, CNAs should understand the concept and respect a patient''s right to make decisions about their care.

Patients have the right to:
• Ask questions.
• Refuse treatment.
• Receive information in a manner they can understand.
• Make healthcare decisions free from coercion.

CNAs should immediately report concerns if a patient appears confused, unwilling, or unable to provide informed consent.

G. Advance Directives and Do Not Resuscitate (DNR) Orders
Advance directives are legal documents that communicate a patient''s healthcare preferences if they become unable to make decisions for themselves. These documents help ensure that a patient''s wishes are respected during serious illness or end-of-life care.

Examples include:
• Living Wills
• Healthcare Powers of Attorney
• Medical Directives

A Do Not Resuscitate (DNR) order is a physician-authorized medical order indicating that cardiopulmonary resuscitation (CPR) should not be initiated if a patient''s heart or breathing stops.

CNAs must:
• Follow facility policies regarding advance directives and DNR orders.
• Respect patient wishes.
• Report questions or concerns to the supervising nurse.
• Never alter, interpret, or make decisions regarding advance directives independently.

Summary
Regulatory requirements and professional standards provide the foundation for safe and ethical nursing assistant practice. By understanding OBRA regulations, Arizona certification requirements, standards of conduct, ethical responsibilities, informed consent, and advance directives, CNA students can provide high-quality care while protecting the rights, dignity, and well-being of every patient they serve.',
   3),

  (v_mod_id,
   '1.4 — Describes the Delegation Process',
   'Competency 1.4: Describes the Delegation Process

Delegation is an essential part of healthcare teamwork and allows patient care tasks to be assigned safely and efficiently. In healthcare settings, licensed nurses may delegate specific tasks to nursing assistants when appropriate. Understanding the delegation process helps ensure that care is provided safely, effectively, and within the nursing assistant''s scope of practice.

As a Certified Nursing Assistant (CNA), you are responsible for performing delegated tasks competently, communicating concerns promptly, and recognizing situations that require additional guidance or supervision. Effective delegation promotes patient safety, teamwork, and high-quality care.

Learning Goal 1.4
Describe the delegation process and the responsibilities associated with delegated nursing tasks.

A. Responsibility and Accountability in Delegation
Delegation involves transferring responsibility for performing a specific task from a licensed nurse to a qualified nursing assistant. While the CNA may be responsible for completing the assigned task, the supervising nurse remains accountable for the overall nursing care provided to the patient.

The nursing assistant is responsible for:
• Accepting delegated tasks within their training and competency level.
• Performing tasks safely and accurately.
• Reporting observations and patient changes promptly.
• Seeking clarification when instructions are unclear.
• Following facility policies and procedures.

Accountability means that each healthcare team member is answerable for their actions and decisions related to patient care.

B. Factors Affecting Delegation
Several factors must be considered before a task is delegated. The supervising nurse evaluates whether the task can be safely assigned based on:
• The patient''s condition and stability.
• The complexity of the task.
• The CNA''s training, competency, and experience.
• Available supervision and support.
• Facility policies and procedures.
• Potential risks to patient safety.

Delegation decisions should always prioritize the well-being of the patient and ensure that care is delivered by qualified personnel.

C. The Five Rights of Delegation
The Five Rights of Delegation provide a framework for safe delegation and help reduce the risk of errors.

1. Right Task
The task is appropriate for delegation and falls within the CNA''s scope of practice.

2. Right Circumstance
The patient''s condition and care environment make delegation safe and appropriate.

3. Right Person
The task is delegated to an individual who has the necessary training, skills, and competency.

4. Right Direction and Communication
Clear instructions are provided regarding the task, expected outcomes, timelines, and reporting requirements.

5. Right Supervision and Evaluation
The supervising nurse remains available to provide guidance, monitor performance, and evaluate outcomes.

Following the Five Rights helps ensure safe and effective patient care.

D. Accepting and Refusing Delegation
CNAs have a professional responsibility to evaluate delegated tasks before accepting them. A nursing assistant should only accept assignments that fall within their education, training, competency, and facility policies.

A CNA should accept delegation when:
• The task is within their scope of practice.
• They have received appropriate training.
• They understand the instructions.
• Adequate supervision is available.

A CNA should refuse delegation when:
• The task is outside their scope of practice.
• They have not been trained to perform the task.
• The instructions are unclear.
• Patient safety may be compromised.
• Facility policy prohibits the task.

When refusing a delegated task, the CNA should communicate concerns respectfully and immediately to the supervising nurse. Refusing an unsafe assignment is an important professional responsibility and contributes to patient safety.

Summary
Delegation is a collaborative process that allows healthcare teams to provide efficient, high-quality patient care. By understanding responsibility and accountability, recognizing factors that affect delegation, applying the Five Rights of Delegation, and appropriately accepting or refusing assignments, CNA students can contribute to a safe healthcare environment while practicing within their role and scope of responsibility.',
   4),

  (v_mod_id,
   '1.5 — Professional Work Habits and Time Management Skills',
   'Competency 1.5: Demonstrates Professional Work Habits and Time Management Skills

Professional work habits and effective time management are essential skills for Certified Nursing Assistants (CNAs). Healthcare environments are often fast-paced and require nursing assistants to balance multiple responsibilities while maintaining high standards of patient care. Developing strong organizational skills helps CNAs provide safe, efficient, and compassionate care while meeting the needs of residents, patients, families, and the healthcare team.

Students will learn strategies for managing time effectively, prioritizing resident care, and maintaining professionalism in the workplace.

Learning Goal 1.5
Demonstrate professional work habits and effective time management skills in a healthcare setting.

A. Time Management Skills
Time management is the ability to organize, prioritize, and complete tasks efficiently while maintaining quality care and patient safety. Effective time management allows CNAs to meet resident needs, complete assignments, and respond appropriately to unexpected situations.

Important time management skills include:
• Arriving to work on time and prepared for duty.
• Planning and organizing daily assignments.
• Prioritizing tasks based on resident needs and safety concerns.
• Completing tasks within established timeframes.
• Avoiding unnecessary delays and distractions.
• Communicating effectively with supervisors and team members.
• Adapting to changes in workload and resident conditions.

Strong time management skills help reduce stress, improve productivity, and contribute to positive patient outcomes.

B. Application in the Work Setting
In healthcare settings, CNAs must use time management skills throughout their workday. Effective planning allows nursing assistants to provide quality care while balancing routine responsibilities and unexpected events.

Examples of applying time management in the workplace include:
• Reviewing resident assignments at the beginning of the shift.
• Prioritizing residents who require immediate assistance.
• Grouping similar tasks together to improve efficiency.
• Monitoring call lights and responding promptly.
• Reporting changes in resident condition without delay.
• Completing documentation accurately and on time.
• Working collaboratively with other team members to ensure resident needs are met.

CNAs must remain flexible, as resident conditions and care priorities can change quickly throughout a shift.

C. Realistic Resident Care Assignment Load
A resident care assignment refers to the group of residents or patients assigned to a CNA during a shift. Assignment loads may vary depending on the healthcare setting, resident acuity level, staffing patterns, and facility policies.

A realistic assignment load allows the CNA to:
• Provide safe and quality care.
• Meet residents'' physical, emotional, and psychosocial needs.
• Complete assigned tasks accurately.
• Respond to emergencies and unexpected situations.
• Maintain resident dignity, comfort, and safety.

CNAs should recognize when an assignment may exceed their ability to provide safe care and communicate concerns to the supervising nurse. Asking for assistance when needed is a professional responsibility and helps protect resident safety.

Professional Work Habits
Professionalism is demonstrated through daily actions and behaviors. Nursing assistants are expected to:
• Maintain a positive attitude.
• Demonstrate reliability and dependability.
• Follow facility policies and procedures.
• Dress appropriately according to facility standards.
• Respect resident rights and confidentiality.
• Communicate respectfully with residents, families, and coworkers.
• Accept feedback and strive for continuous improvement.
• Maintain accountability for assigned responsibilities.

Professional work habits help build trust and confidence among residents, families, and healthcare team members.

Summary
Professional work habits and effective time management are key components of successful nursing assistant practice. By organizing tasks, prioritizing resident needs, managing assignments responsibly, and demonstrating professionalism, CNAs contribute to a safe, efficient, and patient-centered healthcare environment. These skills support quality care, teamwork, and positive outcomes for the residents entrusted to their care.',
   5),

  (v_mod_id,
   '1.6 — Appropriate Stress Relieving Techniques',
   'Competency 1.6: Demonstrates Appropriate Stress Relieving Techniques

Working as a Certified Nursing Assistant (CNA) can be physically and emotionally demanding. CNAs often care for multiple residents with varying needs while working in fast-paced and high-responsibility environments. Because of this, it is essential for nursing assistants to recognize stress, develop healthy coping strategies, and apply effective stress management techniques to maintain personal well-being and provide safe, compassionate care.

Students will learn how to identify stress, apply stress-relieving techniques, and use healthy coping strategies within the healthcare work environment.

Learning Goal 1.6
Demonstrate appropriate stress-relieving techniques and apply stress management skills in a healthcare setting.

A. Stress Management Techniques
Stress management techniques are healthy strategies used to reduce physical, emotional, and mental strain. CNAs must develop effective coping skills to remain focused, calm, and professional while providing care.

Common stress management techniques include:
• Deep breathing exercises to promote relaxation and reduce anxiety.
• Taking short breaks when appropriate to reset focus and energy.
• Practicing positive self-talk and maintaining a constructive mindset.
• Using time management skills to reduce feelings of being overwhelmed.
• Seeking support from supervisors or team members when needed.
• Engaging in regular physical activity outside of work.
• Maintaining healthy sleep, nutrition, and hydration habits.
• Practicing mindfulness or brief grounding techniques during stressful moments.
• Using problem-solving skills to address challenges instead of avoiding them.

Healthy stress management helps CNAs maintain emotional balance and prevent burnout.

B. Application in the Work Setting
In healthcare environments, stress management techniques must be applied appropriately and professionally to ensure patient safety and quality care. CNAs should remain calm and focused, even during difficult or high-pressure situations.

Examples of applying stress management in the workplace include:
• Pausing briefly to take deep breaths before responding to a stressful situation.
• Prioritizing tasks to reduce feelings of overwhelm during busy shifts.
• Asking for assistance when workload demands exceed safe limits.
• Staying organized to reduce confusion and improve efficiency.
• Communicating clearly and respectfully with team members during conflict or pressure.
• Taking constructive feedback without becoming defensive.
• Maintaining professionalism when dealing with difficult residents or family members.
• Using short mental resets between tasks to maintain focus and accuracy.

CNAs must always ensure that stress does not interfere with patient care, safety, or professional behavior.

Summary
Stress is a normal part of working in healthcare, but effective stress management allows CNAs to remain professional, focused, and compassionate. By using healthy coping techniques and applying stress-relief strategies in the workplace, nursing assistants can improve their well-being, prevent burnout, and continue providing high-quality care to residents and patients.',
   6);

  UPDATE modules SET lessons_count = 6 WHERE id = v_mod_id;

  RAISE NOTICE 'Patch 010 complete: Module 1 updated with 6 full lessons.';
END $$;
