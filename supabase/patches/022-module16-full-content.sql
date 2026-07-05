-- ============================================================
-- Nurse Rocky — Patch 022: Module 16 Full Content
-- "Provides Care for the Peri-Operative Resident and/or Resident with Special Needs"
-- Source: 16.0 Competency Provides Care for the Peri Operative Resident and or Resident with Special Needs.docx
-- Run in: Supabase Dashboard → SQL Editor
-- ============================================================

DO $$
DECLARE
  v_mod_id INT;
BEGIN

  SELECT id INTO v_mod_id FROM modules WHERE order_num = 16;

  IF v_mod_id IS NULL THEN
    RAISE EXCEPTION 'Module 16 not found. Run seed-modules.sql first.';
  END IF;

  UPDATE modules SET
    title = 'Provides Care for the Peri-Operative and Special Needs Resident',
    description = 'Pre-operative and post-operative care, surgical complications, wound and drainage observation, medical devices, and care for residents with special needs.',
    is_published = true,
    lessons_count = 3
  WHERE id = v_mod_id;

  DELETE FROM lessons WHERE module_id = v_mod_id;

  INSERT INTO lessons (module_id, title, content, order_num) VALUES

  (v_mod_id,
   '16.1 — Assists with Pre-Operative Care',
   'Competency 16.0: Provides Care for the Peri-Operative Resident and/or Resident with Special Needs
Peri-operative care refers to the care provided before, during, and after a surgical procedure. Certified Nursing Assistants (CNAs) play an important supportive role in the pre-operative phase by assisting with both physical preparation and emotional support. CNAs must follow facility policies, maintain resident safety, and report any concerns to the nurse promptly. Proper pre-operative care helps reduce anxiety, prevent complications, and ensure the resident is safely prepared for surgery.
Students will learn how to assist with pre-operative care by supporting both the physical and psychological needs of the resident.
 
Learning Goal 16.1
Assist with pre-operative care.
 
A. Definition of Preoperative Period
The preoperative period is the time before a surgical procedure begins. It includes all preparation activities that ensure the resident is physically and emotionally ready for surgery. This phase focuses on safety, education, and preparation according to physician orders and facility policy.
 
B. Psychological Preparation of the Resident
Emotional support is an important part of pre-operative care. CNAs help reduce anxiety and promote comfort by:
	•	Listening carefully to the resident’s concerns and questions.
	•	Providing reassurance within scope of practice.
	•	Observing body language and non-verbal signs of anxiety, fear, or distress.
	•	Reporting emotional concerns or significant anxiety to the nurse.
	•	Maintaining a calm, respectful, and supportive presence.
CNAs do not provide medical explanations of surgery but play a key role in emotional support and observation.
 
C. Physical Preparation of the Resident
CNAs assist with physical preparation tasks to ensure safety and compliance with surgical requirements, including:
	•	Ensuring the resident has an identification band in place.
	•	Observing and enforcing NPO (nothing by mouth) orders per facility policy.
	•	Assisting with completion of surgical checklists (including vital signs, last void time, and required documentation).
	•	Removing water pitchers and food items as directed.
	•	Assisting with bathing or showering to reduce infection risk.
	•	Removing nail polish, makeup, and jewelry.
	•	Securing and documenting resident valuables according to facility policy.
	•	Assisting with surgical site preparation as directed by facility protocol.
	•	Ensuring the resident is safe, comfortable, and properly positioned prior to transport.
 
Summary
Pre-operative care is a critical responsibility that supports resident safety and surgical readiness. CNAs assist by preparing residents physically, providing emotional support, and ensuring all safety procedures are followed according to facility policy. By observing carefully, communicating effectively, and maintaining attention to detail, nursing assistants help ensure a safe and smooth surgical experience for the resident.',
   1),

  (v_mod_id,
   '16.2 — Assists with Post-Operative Care',
   'Competency 16.2: Assists with Post-Operative Care
Post-operative care refers to the care provided to a resident after a surgical procedure. Certified Nursing Assistants (CNAs) play an important role in supporting recovery by ensuring safety, comfort, and careful observation for complications. CNAs must follow facility policies, maintain infection control, and report all changes in the resident’s condition promptly to the nurse. Effective post-operative care helps prevent complications and supports healing and recovery.
Students will learn how to prepare the resident’s room, provide basic post-operative care, recognize potential complications, and report findings appropriately.
 
Learning Goal 16.2
Assist with post-operative care.
 
A. Definition of Post-Operative Period
The post-operative period is the time after surgery has been completed and the resident is recovering from anesthesia and the surgical procedure. During this time, close monitoring is required to ensure the resident is stable and recovering safely.
 
B. Preparation of the Resident’s Room
Before the resident returns from surgery, the CNA may assist in preparing a safe and comfortable environment, including:
	•	Preparing a surgical bed with clean linens and proper positioning for easy transfer.
	•	Ensuring the bedside table contains necessary items such as an emesis basin and tissues.
	•	Setting up vital signs equipment for frequent monitoring.
	•	Providing special equipment as required by facility policy (e.g., oxygen setup, suction, or monitoring devices).
	•	Placing warmed blankets to maintain body temperature and comfort.
A properly prepared room helps ensure safety, comfort, and efficient post-operative monitoring.
 
C. Care of the Resident After Surgery
CNAs assist with basic care needs and monitoring after the resident returns from surgery:
	•	Properly identify the resident before providing care.
	•	Assist with safe transfer from stretcher to bed using proper techniques.
	•	Maintain airway safety and monitor breathing status.
	•	Position the resident as ordered to promote comfort and drainage.
	•	Observe for nausea or vomiting and provide emesis basin as needed.
	•	Follow standard precautions due to possible exposure to bodily fluids.
	•	Assist with coughing, deep breathing, and use of incentive spirometer if not contraindicated.
	•	Take and record vital signs and pain level according to facility protocol.
	•	Measure and document the first post-operative void as directed.
 
D. Common Complications of Surgery
CNAs must be aware of potential post-operative complications, including:
	•	Bleeding or excessive drainage
	•	Infection (fever, redness, swelling, or foul odor at surgical site)
	•	Respiratory complications (difficulty breathing, low oxygen levels)
	•	Nausea and vomiting
	•	Blood clots (swelling, pain, or redness in extremities)
	•	Changes in level of consciousness or confusion
	•	Severe or uncontrolled pain
Early identification of these signs is critical for resident safety.
 
E. Reporting Observations to the Nurse
CNAs must promptly report any abnormal findings, including:
	•	Changes in vital signs
	•	Increased pain or discomfort
	•	Signs of infection or bleeding
	•	Difficulty breathing or changes in oxygen levels
	•	Changes in mental status or alertness
	•	Inability to urinate or changes in output
Timely reporting ensures the healthcare team can respond quickly to complications.
 
Summary
Post-operative care is essential for safe recovery after surgery. CNAs support residents by preparing the environment, assisting with basic care needs, monitoring for complications, and reporting changes promptly. By following facility policies and maintaining careful observation, nursing assistants play a vital role in promoting recovery, safety, and comfort during the post-operative period.',
   2),

  (v_mod_id,
   '16.3 — Assists with Care of Residents with Special Needs',
   'Competency 16.3: Assists with Care of Residents with Special Needs
Residents with special medical needs require careful monitoring, supportive care, and adherence to facility policies to ensure safety and promote healing. Certified Nursing Assistants (CNAs) play an important role in providing hands-on assistance and observing for changes in condition. CNAs do not perform sterile or complex medical procedures independently, but they may assist with delegated tasks for medically stable residents and must always report findings promptly to the nurse.
Students will learn how to assist with specialized care procedures, recognize abnormal findings, and support residents with medical devices and therapies while maintaining safety, dignity, and infection control standards.
 
Learning Goal 16.3
Assist with care of residents with special needs.
 
A. Wound Dressings and Drainage Observation
CNAs may assist by observing and reporting the condition of dressings and wounds when delegated.
Responsibilities include:
	•	Observing dressing integrity and noting drainage.
	•	Reporting color, amount, odor, and type of drainage.
	•	Watching for signs of infection such as redness, swelling, or warmth.
	•	Reporting all findings to the nurse promptly.
CNAs do not perform sterile dressing changes unless specifically trained and delegated according to facility policy.
 
B. Gravity Drains
Gravity drains allow fluid to flow out of the body naturally.
CNAs may:
	•	Ensure tubing is not kinked or blocked.
	•	Keep drainage bags below the level of the wound as instructed.
	•	Observe and report amount, color, and odor of drainage.
	•	Report signs of leakage, blockage, or discomfort.
 
C. Surgical Evacuators
Surgical evacuators remove fluid from surgical sites.
CNAs may:
	•	Ensure device remains secured and functioning.
	•	Observe drainage output.
	•	Report changes in amount, color, or consistency.
	•	Report device disconnection or malfunction immediately.
 
D. Sump Drains
Sump drains use suction and irrigation to remove fluid.
CNAs may:
	•	Observe for proper functioning of the system.
	•	Ensure tubing remains properly positioned.
	•	Report any obstruction, leakage, or unusual drainage.
 
E. Abdominal Binders
Abdominal binders provide support and comfort after surgery or injury.
CNAs may:
	•	Apply or adjust binders as delegated.
	•	Ensure proper fit without restricting breathing.
	•	Observe for skin irritation or discomfort.
	•	Report redness, pain, or improper fit.
 
F. ACE Wraps and Non-Sterile Dressings
CNAs may assist with:
	•	Applying elastic (ACE) wraps or non-sterile dressings as delegated.
	•	Ensuring proper circulation is not restricted.
	•	Checking for swelling, numbness, or discoloration.
	•	Reporting any signs of impaired circulation or skin breakdown.
 
G. Anti-Embolism Stockings and Devices
These devices help prevent blood clots.
CNAs may:
	•	Apply stockings or devices per facility policy.
	•	Ensure correct size and placement.
	•	Remove and inspect skin as scheduled.
	•	Report redness, pain, or swelling in extremities.
 
H. Immobilization Devices
Immobilization devices help maintain proper alignment and prevent injury.
CNAs may:
	•	Ensure devices are properly positioned.
	•	Check skin under devices for irritation or breakdown.
	•	Maintain safety and comfort.
	•	Report tightness, pain, or circulation issues.
 
I. Feeding Tubes
Feeding tubes provide nutrition when residents cannot eat orally.
CNAs may:
	•	Observe tube placement and site condition (as trained).
	•	Keep resident in proper position during and after feeding.
	•	Report leakage, redness, or swelling at the site.
	•	Monitor for signs of discomfort or aspiration risk.
 
J. Infusion Therapy
Infusion therapy delivers fluids or medications through IV systems.
CNAs may:
	•	Observe IV site for redness, swelling, or leakage.
	•	Ensure tubing is not pulled or kinked.
	•	Report pain, infiltration, or changes at the site.
	•	Monitor resident comfort and response.
 
K. Ventilator Care
Ventilators assist with breathing for residents who cannot breathe independently.
CNAs may:
	•	Observe respiratory status and alertness.
	•	Ensure tubing remains connected and secure.
	•	Report alarms or changes in breathing immediately.
	•	Maintain resident comfort and safety.
	•	Never adjust ventilator settings.
 
General Responsibilities for Special Procedures
For all special care procedures, CNAs must:
	•	Follow facility policies and scope of practice.
	•	Perform hand hygiene and infection control measures.
	•	Observe carefully for changes in condition.
	•	Report findings, including drainage, skin condition, device function, and resident response.
	•	Document observations accurately and objectively.
 
Summary
Care for residents with special needs requires attention to detail, strong observation skills, and strict adherence to facility policy. CNAs play a vital role in supporting residents with medical devices and treatments by providing safe care, maintaining comfort, and reporting changes promptly. Through careful observation and communication, nursing assistants help ensure positive outcomes and resident safety.',
   3);

  RAISE NOTICE 'Module 16 updated with 3 lessons.';
END $$;
