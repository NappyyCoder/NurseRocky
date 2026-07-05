-- ============================================================
-- Nurse Rocky — Patch 020: Module 14 Full Content
-- "Provides for Comfort and Rest"
-- Source: 14.0 Competency Provides for Comfort and Rest.docx
-- Run in: Supabase Dashboard → SQL Editor
-- ============================================================

DO $$
DECLARE
  v_mod_id INT;
BEGIN

  SELECT id INTO v_mod_id FROM modules WHERE order_num = 14;

  IF v_mod_id IS NULL THEN
    RAISE EXCEPTION 'Module 14 not found. Run seed-modules.sql first.';
  END IF;

  UPDATE modules SET
    title = 'Provides for Comfort and Rest',
    description = 'Observe and report comfort and pain levels, recognize verbal and non-verbal signs of discomfort, apply basic comfort measures, and support rest and sleep.',
    is_published = true,
    lessons_count = 1
  WHERE id = v_mod_id;

  DELETE FROM lessons WHERE module_id = v_mod_id;

  INSERT INTO lessons (module_id, title, content, order_num) VALUES

  (v_mod_id,
   '14.1 — Identifying Resident Comfort, Pain, and Comfort Measures',
   'Competency 14.0: Provides for Comfort and Rest
Providing comfort and promoting rest are essential responsibilities of the nursing assistant. Residents may experience discomfort or pain for many reasons, including illness, injury, chronic conditions, or emotional stress. Certified Nursing Assistants (CNAs) play a vital role in observing, identifying, and reporting changes in a resident’s level of comfort and responding appropriately within their scope of practice. Careful observation and communication help ensure timely interventions and improve quality of life.
Students will learn how to gather information about resident comfort, recognize signs of discomfort or pain, and implement basic comfort measures while working within the nursing assistant role.
 
Learning Goal 14.1
Gather data to identify the resident’s level of comfort (or level of pain).
 
A. Nursing Assistant Scope of Practice in Comfort Observation
CNAs are responsible for observing and reporting signs of comfort or discomfort but do not diagnose pain or determine medical treatment. Within their scope of practice, nursing assistants:
	•	Observe residents during all care interactions.
	•	Ask simple, appropriate questions about comfort when permitted.
	•	Report all findings accurately to the licensed nurse.
	•	Document observations according to facility policy.
 
B. Purpose of Observing Comfort at Every Contact
Assessing comfort at each resident interaction is essential because:
	•	Pain or discomfort may change quickly.
	•	Early identification prevents complications.
	•	Residents may not always verbally report pain.
	•	It ensures individualized and safe care.
	•	It supports accurate communication within the healthcare team.
 
C. Barriers to Resident Comfort
Several factors may prevent or reduce comfort, including:
	•	Pain or injury
	•	Illness or chronic conditions
	•	Poor positioning or immobility
	•	Environmental factors (noise, temperature, lighting)
	•	Emotional distress (anxiety, fear, loneliness)
	•	Inadequate rest or sleep disruption
	•	Unmet basic needs (hunger, thirst, toileting needs)
 
D. Types of Pain and Factors Affecting Comfort
CNAs may observe different types of pain, including:
	•	Acute pain: Sudden, short-term pain often related to injury or illness.
	•	Chronic pain: Ongoing pain that may last for months or longer.
Factors that may affect comfort include:
	•	Physical condition
	•	Emotional state
	•	Cognitive status
	•	Cultural background and personal preferences
	•	Mobility level
 
E. Non-Verbal Expressions of Discomfort or Pain
Residents may show discomfort without speaking. CNAs should observe for:
	•	Grimacing or facial tension
	•	Guarding or protecting a body part
	•	Restlessness or agitation
	•	Moaning, groaning, or crying
	•	Increased heart rate or breathing changes
	•	Refusal to move or participate in care
	•	Changes in behavior or appetite
 
F. Pain and Comfort Assessment Scales
Various tools may be used to measure comfort or pain, including:
	•	Numerical rating scales (0–10 pain scale)
	•	Facial expression scales
	•	Behavioral tools such as PAINAD (Pain Assessment in Advanced Dementia)
CNAs may assist in observing and reporting responses based on these tools but do not interpret clinical results independently.
 
G. Comfort-Enhancing Measures Within CNA Scope of Practice
CNAs can support resident comfort using non-pharmacological interventions such as:
	•	Repositioning the resident regularly.
	•	Assisting with preferred bathing methods.
	•	Providing gentle touch and back rubs (if allowed).
	•	Maintaining a calm, respectful approach.
	•	Offering music, relaxation techniques, or distraction.
	•	Ensuring a comfortable room environment (temperature, lighting, noise).
	•	Supporting use of pillows or supports for alignment.
	•	Applying warm or cold packs only if ordered.
	•	Encouraging rest and sleep routines.
 
H. Reporting and Documentation of Comfort Level
CNAs must:
	•	Report changes in comfort or signs of pain immediately to the nurse.
	•	Document observations accurately and objectively.
	•	Include resident statements, behaviors, and responses to interventions.
	•	Avoid interpreting or diagnosing pain levels.
 
Summary
Comfort and rest are essential components of quality care. CNAs play a key role in observing, identifying, and reporting changes in a resident’s comfort level. By recognizing signs of pain, using approved comfort measures, and communicating effectively with the healthcare team, nursing assistants help improve resident well-being, dignity, and quality of life.',
   1);

  RAISE NOTICE 'Module 14 updated with 1 lesson.';
END $$;
