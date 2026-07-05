-- ============================================================
-- Nurse Rocky — Patch 006: Module 4 Full Content
-- Replaces lessons with all 4 sub-competencies from docx.
-- Run in: Supabase Dashboard → SQL Editor
-- ============================================================

DO $$
DECLARE
  v_mod_id INT;
BEGIN

  SELECT id INTO v_mod_id FROM modules WHERE order_num = 4;

  IF v_mod_id IS NULL THEN
    RAISE EXCEPTION 'Module 4 not found. Run patch 005 first.';
  END IF;

  UPDATE modules SET
    title = 'Demonstrates Effective Communication',
    description = 'Master verbal and nonverbal communication, medical terminology, chain of command, conflict management, observation and reporting skills, and effective communication with residents who have sensory, cognitive, or behavioral challenges.',
    is_published = true
  WHERE id = v_mod_id;

  DELETE FROM lessons WHERE module_id = v_mod_id;

  INSERT INTO lessons (module_id, title, content, order_num) VALUES

  -- ── Lesson 1 ──────────────────────────────────────────────────
  (v_mod_id,
   '4.1 — Uses Verbal and Nonverbal Communication to Accurately Present Information',
   '4.0 Competency: Demonstrates Effective Communication

Certified Nursing Assistant (CNA) students must demonstrate effective communication skills in all interactions with residents, families, and members of the healthcare team. Communication is a critical component of safe, accurate, and compassionate care. CNAs are responsible for conveying information clearly, listening actively, and ensuring that all communication supports resident dignity, safety, and well-being.

Effective communication includes both verbal and nonverbal methods such as speaking, listening, writing, body language, facial expressions, and tone of voice. CNA students must understand how to use these communication methods appropriately in different healthcare situations and settings.

4.1 Uses Verbal and Nonverbal Communication to Accurately Present Information

CNA students must be able to accurately share information using clear and professional communication skills. This includes recognizing the importance of reporting observations promptly and correctly to the healthcare team.

A. Uses Appropriate Medical Terminology and Abbreviations
CNA students should:
• Learn and use approved medical terminology and facility-approved abbreviations.
• Communicate clearly when documenting or reporting resident information.
• Avoid using slang or unapproved abbreviations that may cause confusion.
• Ensure accuracy when describing symptoms, behaviors, or changes in condition.

B. Communicates with Members of the Healthcare Team
CNA students are expected to:
• Report observations, changes in condition, and concerns to the supervising nurse.
• Follow the chain of command when communicating information or concerns.
• Share relevant and accurate information in a timely manner.
• Collaborate respectfully with nurses, therapists, and other healthcare staff.
• Understand that CNAs do not diagnose or interpret medical conditions but report observations only.

C. Communicates with Residents and Family
CNA students should:
• Use clear, simple language when speaking with residents and families.
• Listen actively and respond respectfully to questions or concerns.
• Maintain confidentiality and privacy at all times.
• Demonstrate empathy, patience, and respect in all interactions.
• Provide information within the CNA scope of practice and refer clinical questions to the nurse.

Communication Concepts

A. Medical Terminology and Abbreviations
Medical terminology and approved abbreviations are used in healthcare to ensure clear, consistent communication among professionals. CNA students must:
• Understand commonly used terms related to body systems, conditions, and care procedures.
• Use only facility-approved abbreviations.
• Ensure documentation is accurate, legible, and professional.

B. Types of Communication and Chain of Command
Communication in healthcare follows both formal and informal methods:
• Verbal communication: spoken words used with residents, families, and staff.
• Nonverbal communication: body language, facial expressions, eye contact, and gestures.
• Written communication: documentation in care records and reports.

The chain of command is the structured system used to report information in a healthcare setting. CNA students must:
• Report concerns first to the supervising nurse.
• Follow facility policies for escalating urgent issues.
• Understand that proper communication flow ensures resident safety and accountability.

C. Communication Techniques and Conflict Management
CNA students should use effective communication techniques such as:
• Active listening.
• Speaking calmly and respectfully.
• Using open-ended questions when appropriate.
• Clarifying information to avoid misunderstandings.

When conflict arises, CNAs must:
• Remain calm and professional.
• Avoid arguing or becoming defensive.
• Focus on the resident''s needs and safety.
• Report unresolved conflicts to the supervisor.
• Use respectful communication to de-escalate situations.

Key Concepts for CNA Students
• Effective communication is essential for safe and quality care.
• CNAs must use both verbal and nonverbal communication appropriately.
• Accurate reporting using medical terminology and approved abbreviations is required.
• Communication must follow the chain of command.
• CNAs must communicate respectfully with residents, families, and healthcare staff.
• Conflict should be managed professionally and reported when necessary.

By demonstrating effective communication skills, CNA students contribute to accurate care delivery, improved teamwork, and a safe, respectful healthcare environment.',
   1),

  -- ── Lesson 2 ──────────────────────────────────────────────────
  (v_mod_id,
   '4.2 — Responds Effectively to Resident Behavior in a Positive, Non-Threatening Way',
   '4.2 Competency: Responds Effectively to Resident Behavior in a Positive, Non-Threatening Way

Certified Nursing Assistant (CNA) students must demonstrate the ability to respond to resident behaviors in a calm, respectful, and supportive manner. Residents may express emotions such as fear, anger, confusion, frustration, or anxiety due to illness, pain, cognitive changes, or environmental stress. The CNA''s responsibility is to maintain a positive and non-threatening approach that promotes trust, safety, and dignity.

Effective communication helps reduce behavioral issues, prevent misunderstandings, and improve the quality of resident care. CNA students must understand how to use communication strategies that support cooperation and emotional well-being while avoiding actions or language that may escalate a situation.

A. Communication Guidelines
CNA students should follow these communication guidelines when interacting with residents:
• Approach residents calmly and respectfully at all times.
• Use a soft, clear, and reassuring tone of voice.
• Introduce yourself and explain care before beginning any procedure.
• Use the resident''s preferred name and maintain eye contact when appropriate.
• Allow residents time to respond without rushing or interrupting.
• Listen actively and acknowledge the resident''s feelings.
• Use simple, clear language that the resident can understand.
• Maintain privacy and dignity during all care activities.
• Remain patient even when the resident is upset or uncooperative.
• Avoid arguing, correcting, or challenging the resident unnecessarily.

These guidelines help build trust and reduce anxiety, especially for residents experiencing confusion, dementia, or emotional distress.

B. Barriers to Communication
CNA students must also recognize factors that can interfere with effective communication. These barriers may prevent residents from understanding or expressing their needs clearly.

Common barriers include:
• Hearing or vision impairments that make it difficult to receive information.
• Cognitive impairments such as dementia or memory loss.
• Language differences between the resident and caregiver.
• Emotional stress, including fear, anger, anxiety, or depression.
• Pain or physical discomfort that limits attention or focus.
• Environmental distractions such as noise, poor lighting, or interruptions.
• Cultural differences that influence communication styles or expectations.
• Use of medical jargon or complex language that is not easily understood.

CNA students should adjust their communication style to overcome these barriers by speaking clearly, using nonverbal cues, repeating or rephrasing information when needed, and ensuring the environment supports effective interaction.

Principles of Positive Communication
Positive communication is essential for providing compassionate, person-centered care. CNA students should:
• Focus on respect, empathy, and patience in all interactions.
• Support resident independence and encourage participation in care decisions.
• Respond to emotional behavior with understanding rather than judgment.
• Use calming techniques to reduce agitation or fear.
• Recognize that behavior is often a form of communication.

Key Concepts for CNA Students
• Residents must always be approached in a calm and non-threatening manner.
• Effective communication supports emotional safety and cooperation.
• Communication guidelines help maintain professionalism and trust.
• Barriers to communication must be identified and addressed appropriately.
• CNAs must adapt communication strategies to meet individual resident needs.
• Positive communication improves resident outcomes and quality of care.

By applying effective communication techniques and responding appropriately to resident behavior, CNA students help create a safe, respectful, and supportive healthcare environment.',
   2),

  -- ── Lesson 3 ──────────────────────────────────────────────────
  (v_mod_id,
   '4.3 — Observes and Describes Resident Physical and Emotional Condition Changes',
   '4.3 Competency: Observes and Describes Resident''s Physical and Emotional Condition Changes

Certified Nursing Assistant (CNA) students must develop strong observation skills to ensure resident safety and quality care. CNAs are often the first members of the healthcare team to notice changes in a resident''s condition. It is essential that CNA students accurately observe, identify, and report both physical and emotional changes in a timely manner to the supervising nurse.

Accurate observation and reporting help prevent complications, support early intervention, and promote positive health outcomes. CNAs do not diagnose conditions; instead, they observe, document, and report what they see, hear, and notice.

A. Identifies Subjective Observations
Subjective observations are information that the resident reports and cannot be directly measured by the CNA. These are based on what the resident feels or describes.

Examples include:
• Pain or discomfort ("I feel dizzy" or "I have a headache")
• Nausea or feelings of sickness
• Anxiety, sadness, or emotional distress
• Fatigue or weakness reported by the resident
• Complaints of not feeling well

CNAs must listen carefully to residents and report subjective concerns accurately to the nurse.

B. Identifies Objective Observations
Objective observations are factual, measurable, and directly observed by the CNA. These are based on what the CNA sees, hears, or measures.

Examples include:
• Changes in vital signs (if within CNA scope and facility policy)
• Skin color changes such as pale, flushed, or blue tones
• Swelling, bruising, or visible injury
• Changes in behavior such as confusion or agitation
• Difficulty breathing or coughing
• Changes in mobility or ability to perform ADLs
• Unusual odors or discharge

Objective observations must be recorded and reported clearly without interpretation or personal opinion.

C. Identifies Emergencies
An emergency is any situation that poses an immediate threat to the resident''s life or safety and requires urgent action.

Examples of emergencies include:
• Difficulty breathing or choking
• Chest pain or signs of a possible heart attack
• Sudden loss of consciousness
• Severe bleeding
• Seizures
• Sudden confusion or stroke-like symptoms (e.g., facial drooping, slurred speech, weakness)
• Serious falls or injuries

In emergencies, CNA students must:
• Stay calm and act immediately.
• Call for help according to facility policy.
• Remain with the resident if safe to do so.
• Follow emergency procedures and chain of command.

Key Concepts for Recognizing Changes to Report

A. Subjective Observations
• Based on what the resident reports.
• Cannot be measured directly.
• Must always be taken seriously and reported.

B. Objective Observations
• Based on what is seen, heard, or measured.
• Factual and measurable.
• Must be documented accurately and without opinion.

C. When to Report

1. Emergencies vs. Routine Observations
• Emergencies: Require immediate reporting and action due to risk of harm or death.
• Routine observations: Include non-urgent changes that still must be reported promptly to the nurse.

2. Timeliness of Reporting Observations
• All changes in condition must be reported as soon as they are noticed.
• Delayed reporting can place the resident at risk.
• CNAs must follow facility policy and chain of command when reporting concerns.

Key Concepts for CNA Students
• CNAs are responsible for observing and reporting changes, not diagnosing.
• Subjective and objective data are both important in resident care.
• Emergencies require immediate action and reporting.
• Timely communication can prevent complications and save lives.
• Accurate observation supports the healthcare team in providing safe and effective care.

By developing strong observation skills and reporting changes promptly, CNA students play a vital role in protecting resident health, safety, and well-being.',
   3),

  -- ── Lesson 4 ──────────────────────────────────────────────────
  (v_mod_id,
   '4.4 — Communication Skills with Residents Who Have Sensory Deficits',
   '4.4 Competency: Demonstrates Communication Skills with the Resident Who Has Sensory Deficits

Certified Nursing Assistant (CNA) students must demonstrate the ability to communicate effectively with residents who have sensory deficits, cognitive impairments, or challenging behaviors. Many residents in healthcare settings experience hearing loss, vision impairment, speech difficulties, cognitive decline, or emotional and behavioral changes. CNAs must adjust their communication methods to meet each resident''s individual needs while maintaining dignity, respect, and safety.

Effective communication promotes understanding, reduces frustration, and improves the quality of care. CNA students must be flexible, patient, and attentive when interacting with all residents, especially those with communication barriers.

A. Effective Communication with Hearing-Impaired Residents
CNA students should:
• Face the resident directly and maintain eye contact.
• Speak clearly, slowly, and at a normal volume (do not shout).
• Use simple words and short sentences.
• Reduce background noise and distractions.
• Use gestures, writing, or visual cues when needed.
• Ensure hearing aids are in place and functioning if applicable.
• Confirm understanding by asking the resident to repeat or respond.

B. Effective Communication with Visually Impaired Residents
CNA students should:
• Identify themselves when entering the room.
• Explain all actions before providing care.
• Use the resident''s name to gain attention.
• Describe surroundings, procedures, and locations clearly.
• Keep the environment consistent and free of hazards.
• Guide the resident by offering an elbow if assistance is needed.
• Ensure personal items are placed in consistent, known locations.

C. Effective Communication with Aphasic Residents
CNA students should:
• Give the resident time to respond without rushing.
• Use yes/no questions when appropriate.
• Use pictures, communication boards, or writing tools.
• Speak slowly and clearly using simple language.
• Avoid speaking for the resident unless necessary.
• Observe nonverbal cues such as facial expressions or gestures.
• Be patient and supportive during communication attempts.

D. Effective Communication with Cognitively Impaired Residents
CNA students should:
• Use short, simple instructions one step at a time.
• Repeat information as needed in a calm manner.
• Maintain a consistent routine to reduce confusion.
• Use the resident''s name and maintain eye contact.
• Avoid arguing or correcting unrealistic statements.
• Redirect conversation if the resident becomes confused or agitated.
• Provide reassurance and a calm environment.

E. Communicating with the Comatose Resident
CNA students should:
• Speak to the resident as if they can hear and understand.
• Explain all care before and during procedures.
• Provide touch in a respectful and gentle manner.
• Maintain privacy and dignity at all times.
• Observe for nonverbal responses such as facial movement or changes in vital signs.
• Treat the resident with respect regardless of responsiveness.

F. Communicating with the Physically Aggressive Resident
CNA students should:
• Stay calm and maintain a safe distance.
• Do not argue or attempt to physically restrain unless trained and directed.
• Use a calm, non-threatening tone of voice.
• Remove triggers or reduce environmental stress if possible.
• Seek assistance from the nurse or other staff immediately if safety is at risk.
• Prioritize personal safety and resident safety at all times.

G. Communicating with the Verbally Aggressive Resident
CNA students should:
• Remain calm and avoid responding with anger.
• Listen without interrupting when appropriate.
• Use respectful and non-defensive language.
• Set limits if necessary using professional communication.
• Avoid taking insults personally.
• Report ongoing verbal aggression to the supervising nurse.
• Redirect conversation to reduce escalation.

Guidelines for Communicating with Residents with Sensory Deficits

A. Hearing Impairment
• Face the resident and speak clearly.
• Reduce noise and distractions.
• Use visual or written communication tools.
• Confirm understanding.

B. Visual Impairment
• Identify yourself and explain actions.
• Describe surroundings and procedures.
• Maintain a safe and organized environment.
• Offer guidance when needed.

C. Aphasia
• Use simple language and yes/no questions.
• Be patient and allow extra response time.
• Use communication aids when available.
• Observe nonverbal communication.

D. Cognitive Impairment
• Use repetition and simple instructions.
• Maintain routine and consistency.
• Avoid confrontation or arguing.
• Provide reassurance.

E. Comatose Residents
• Speak respectfully as if they can hear.
• Provide explanation before care.
• Maintain dignity and comfort.
• Observe for subtle responses.

F. Physically Aggressive Residents
• Prioritize safety and remain calm.
• Avoid escalation or confrontation.
• Remove self from danger if needed.
• Report immediately.

G. Verbally Aggressive Residents
• Maintain professionalism and calm tone.
• Do not take comments personally.
• Set respectful boundaries.
• Report behavior when necessary.

Key Concepts for CNA Students
• Communication must be adapted to meet individual resident needs.
• Sensory, cognitive, and behavioral conditions require specialized approaches.
• Respect, dignity, and patience are essential in all interactions.
• Safety is always a priority when dealing with aggressive behaviors.
• CNAs must observe, adapt, and report changes or concerns promptly.

By demonstrating effective communication with all types of residents, CNA students ensure safe, compassionate, and person-centered care across all healthcare settings.',
   4);

  UPDATE modules SET lessons_count = 4 WHERE id = v_mod_id;

  RAISE NOTICE 'Patch 006 complete: Module 4 updated with 4 full lessons.';
END $$;
