-- ============================================================
-- Nurse Rocky — Patch 015: Module 9 Full Content
-- "Provides the Resident with Personal Care and Grooming"
-- Source: 9.0 Competency Provides the Resident with Personal Care and Grooming.docx
-- Run in: Supabase Dashboard → SQL Editor
-- ============================================================

DO $$
DECLARE
  v_mod_id INT;
BEGIN

  SELECT id INTO v_mod_id FROM modules WHERE order_num = 9;

  IF v_mod_id IS NULL THEN
    RAISE EXCEPTION 'Module 9 not found. Run seed-modules.sql first.';
  END IF;

  UPDATE modules SET
    title = 'Provides the Resident with Personal Care and Grooming',
    description = 'Daily hygiene principles, bathing, skin and perineal care, oral and hair care, dressing, AM/PM care, prosthetics, and documentation of personal care.',
    is_published = true,
    lessons_count = 3
  WHERE id = v_mod_id;

  DELETE FROM lessons WHERE module_id = v_mod_id;

  INSERT INTO lessons (module_id, title, content, order_num) VALUES

  (v_mod_id,
   '9.1 — Principles of Daily Hygiene and Grooming',
   '9.0 Competency: Provides the Resident with Personal Care and Grooming
Certified Nursing Assistant (CNA) students must understand and demonstrate the principles of personal care and grooming to support resident health, comfort, dignity, and quality of life. Personal hygiene is a basic human need that directly impacts physical health, emotional well-being, self-esteem, and social interaction. CNAs play a vital role in assisting residents with hygiene needs while promoting independence and respecting individual preferences.
 
9.1 Provides for and Adheres to the Principles of Daily Hygiene and Grooming
 
Principles of Hygiene and Grooming
 
A. Personal Hygiene Needs and Practices
CNA students must recognize that hygiene practices vary based on individual factors, including:
	•	Culture
	•	Cultural beliefs may influence bathing frequency, hair care, modesty, and grooming practices.
	•	Personal Choice
	•	Residents have the right to choose how and when they receive personal care whenever possible.
	•	Preferences for products, routines, and grooming styles should be respected.
	•	Economic Consideration
	•	Access to hygiene products or personal items may vary based on financial resources.
	•	CNAs may need to provide support using facility-supplied resources when appropriate.
 
B. Rationale for Providing Personal Care
CNA students must understand why personal hygiene is important:
	•	Prevents infection and promotes skin integrity.
	•	Reduces body odor and maintains cleanliness.
	•	Improves comfort and physical well-being.
	•	Enhances self-esteem and emotional health.
	•	Promotes social interaction and dignity.
	•	Allows early identification of skin or health problems.
 
C. Principles of Care
CNA students must consistently apply the following principles when providing personal care:
 
1. Promote Resident Independence, Privacy, and Dignity
	•	Encourage residents to perform as much of their own care as possible.
	•	Provide privacy through curtains, doors, and proper covering.
	•	Respect resident preferences and comfort during care.
 
2. Boundary Issues Related to Personal Care
	•	Maintain professional behavior at all times.
	•	Avoid unnecessary physical contact.
	•	Respect personal space and privacy.
	•	Follow facility policies regarding appropriate caregiver-resident interactions.
 
3. Quality of Life
	•	Understand that personal hygiene contributes to emotional comfort and self-confidence.
	•	Support routines that enhance a resident’s sense of normalcy and well-being.
	•	Provide care in a respectful, calm, and supportive manner.
 
4. Observation of Skin, Scalp, Mouth, Hair, and Nails
CNA students must use personal care time to observe and report:
	•	Skin condition (redness, breakdown, bruising, dryness, wounds)
	•	Scalp condition (dryness, lice, irritation)
	•	Oral health (odor, sores, dentures condition)
	•	Hair condition (cleanliness, tangles, lice)
	•	Nail condition (length, cleanliness, signs of infection)
All abnormal findings must be reported promptly to the supervising nurse.
 
Key Concepts for CNA Students
	•	Personal hygiene is essential for health, comfort, and dignity.
	•	Residents have individual preferences influenced by culture, choice, and circumstances.
	•	CNAs must promote independence while providing safe assistance.
	•	Professional boundaries must always be maintained during personal care.
	•	Personal care provides opportunities for important health observations.
	•	Respect, privacy, and dignity must guide all grooming and hygiene activities.
By applying the principles of personal care and grooming, CNA students help ensure residents maintain cleanliness, comfort, and dignity while supporting overall health and quality of life.',
   1),

  (v_mod_id,
   '9.2 — Assists Resident in Personal Care and Grooming Needs',
   '9.2 Competency: Assists Resident in Personal Care and Grooming Needs
Certified Nursing Assistant (CNA) students must demonstrate the ability to safely and effectively assist residents with personal care and grooming tasks. Personal care is essential to maintaining hygiene, comfort, dignity, and overall health. CNAs must follow the resident’s care plan, respect individual preferences, and provide care in a manner that promotes independence, privacy, and respect at all times.
 
A. Bathing the Resident
CNA students must provide bathing assistance based on resident needs and care plans while maintaining privacy, safety, and dignity. Bathing methods may include:
	•	Complete bed bath: For residents unable to get out of bed.
	•	Partial bath: Focuses on essential areas such as face, hands, underarms, and perineal area.
	•	Tub bath: Resident bathes in a tub with assistance as needed.
	•	Shower: Resident bathes independently or with assistance in a shower.
	•	Whirlpool bath: Therapeutic bathing when ordered.
	•	Special bathing techniques: Such as towel baths or bag baths for comfort or infection control.
	•	Bathing residents with dementia: Use calm communication, routine, and reassurance to reduce anxiety.
	•	Collaborate with the nursing team to determine bathing type and frequency.
 
B. Skin Care (Including Back Rub)
CNA students must provide appropriate skin care to maintain integrity and comfort:
	•	Follow scope of practice and care plan instructions.
	•	Keep skin clean, dry, and moisturized as appropriate.
	•	Provide gentle back rubs to promote circulation and relaxation.
	•	Observe for redness, breakdown, bruising, or irritation.
	•	Report abnormal findings immediately to the nurse.
	•	Understand complications of inadequate skin care, such as pressure injuries and infection.
 
C. Elimination, Toileting, Perineal, and Ostomy Care
CNA students must assist residents with elimination needs while maintaining dignity and infection control:
	•	Provide privacy and assist with bedpans, urinals, commodes, and toilet use.
	•	Perform correct perineal care for cleanliness and infection prevention.
	•	Provide care for indwelling or external catheters as directed.
	•	Assist with ostomy care and observe for skin breakdown or irritation.
	•	Support incontinent residents with hygiene and brief changes.
	•	Assist with bowel and bladder training programs.
	•	Observe and report abnormal findings such as skin tears, bruising, or changes in elimination.
	•	Accurately measure, calculate, and record intake and output when required.
 
D. Mouth and Denture Care
CNA students must provide oral hygiene to promote comfort and prevent infection:
	•	Perform routine mouth care for residents.
	•	Clean and properly handle complete or partial dentures and bridges.
	•	Ensure dentures are stored safely when not in use.
	•	Provide extra care for cognitively impaired residents using simple instructions and reassurance.
	•	Observe for abnormal findings such as sores, bleeding, or poor oral hygiene.
 
E. Hair Care and Shampoo
CNA students must assist with hair hygiene based on resident preference and condition:
	•	Provide combing and grooming to maintain cleanliness and dignity.
	•	Perform bed shampoos or assisted hair washing when needed.
	•	Use alternative methods such as dry shampoos or bonnet shampoos when appropriate.
	•	Observe for abnormalities such as lice, scalp irritation, or hair loss.
	•	Respect resident grooming preferences and cultural practices.
 
F. Nail Care
CNA students must provide basic nail care while following safety guidelines:
	•	Maintain clean, trimmed nails when permitted by facility policy.
	•	Avoid nail care for residents with:
	•	Diabetes
	•	Circulatory problems
	•	Anticoagulant therapy
	•	Thickened or abnormal nails requiring specialist care
	•	Observe for signs of infection, discoloration, or injury.
	•	Report abnormal findings to the nurse.
 
G. Foot Care
CNA students must:
	•	Keep feet clean, dry, and properly positioned.
	•	Observe for wounds, redness, swelling, or poor circulation.
	•	Ensure proper footwear is used.
	•	Report abnormal findings promptly.
 
H. Shaving the Resident
CNA students must:
	•	Follow safety and infection control procedures.
	•	Use proper shaving techniques (electric or manual per policy).
	•	Provide care carefully to avoid cuts or irritation.
	•	Observe for skin changes or abnormalities.
	•	Respect resident preferences regarding facial hair.
 
I. Dressing the Resident
CNA students must assist residents with dressing while promoting independence:
	•	Encourage resident choice in clothing and appearance.
	•	Ensure clothing is safe, clean, and appropriate for the environment.
	•	Use adaptive devices for residents with physical limitations.
	•	Maintain comfort and dignity during dressing.
	•	Support cognitively impaired residents with simple step-by-step instructions.
 
J. A.M./P.M. Care
CNA students must provide morning and evening care based on resident needs:
	•	Morning care includes hygiene, dressing, and preparation for the day.
	•	Evening care includes comfort measures, hygiene, and preparation for rest.
	•	Respect resident preferences and routines.
	•	Provide privacy and promote relaxation.
 
K. Prosthetic and Orthotic Devices
CNA students must assist with care of supportive devices:
	•	Understand the purpose of prosthetic (replacement body parts) and orthotic (support devices) equipment.
	•	Ensure devices are clean, properly fitted, and safely applied.
	•	Observe skin under and around devices for breakdown or irritation.
	•	Report discomfort, damage, or misalignment to the nurse immediately.
 
Key Concepts for CNA Students
	•	Personal care promotes health, dignity, and quality of life.
	•	CNAs must follow care plans and respect resident preferences.
	•	Safety, infection control, and privacy are essential in all care tasks.
	•	Observation and reporting of abnormal findings are critical responsibilities.
	•	Residents should be encouraged to maintain independence whenever possible.
	•	Professional boundaries must always be maintained.
By providing compassionate and skilled assistance with personal care and grooming, CNA students help ensure residents maintain comfort, dignity, and optimal health outcomes.',
   2),

  (v_mod_id,
   '9.3 — Reports and Documents Personal Care Tasks and Observations',
   '9.3 Competency: Reports and Documents Personal Care and Grooming Tasks, Observations, and Resident Response
Certified Nursing Assistant (CNA) students must understand the importance of accurate reporting and documentation related to personal care and grooming activities. Documentation is a critical component of resident care because it provides the healthcare team with essential information about the resident’s condition, response to care, and any changes that may require further assessment or intervention.
CNAs are responsible for communicating clearly, honestly, and promptly with the supervising nurse and for documenting care according to facility policy and legal standards.
 
Reporting and Documentation Responsibilities
 
A. Completion of Care
CNA students must document all personal care and grooming tasks that have been completed, including:
	•	Bathing (type and assistance level provided)
	•	Oral hygiene and denture care
	•	Hair care and grooming
	•	Nail and foot care (when permitted)
	•	Dressing and grooming assistance
	•	AM/PM care
	•	Skin care interventions and repositioning assistance
Documentation must be completed in a timely manner and reflect only care that was actually provided.
 
B. Observations
CNA students must accurately observe and report changes in the resident’s condition during personal care activities, including:
	•	Skin condition (redness, breakdown, bruising, wounds, or dryness)
	•	Scalp and hair condition (lice, irritation, or hair loss)
	•	Oral health (sores, bleeding gums, foul odor, or denture issues)
	•	Nail and foot condition (infection, discoloration, swelling, or injury)
	•	Changes in mobility, strength, or endurance
	•	Signs of pain, discomfort, or distress
All observations must be objective, factual, and based on what is seen, heard, or measured.
 
C. Resident Tolerance, Response, or Problems with Personal Care
CNA students must document and report how the resident responds to personal care, including:
	•	Tolerance of bathing, grooming, or dressing procedures
	•	Cooperation or resistance during care
	•	Signs of fatigue, pain, or discomfort
	•	Emotional responses such as anxiety, fear, or agitation
	•	Any refusal of care or partial completion of tasks
	•	Safety concerns or difficulties encountered during care
Any problems or changes in condition must be reported immediately to the supervising nurse.
 
Key Concepts for CNA Students
	•	Accurate documentation is a legal and professional responsibility.
	•	All care must be documented promptly after completion.
	•	Observations must be objective, clear, and factual.
	•	Changes in resident condition or behavior must always be reported.
	•	Documentation supports continuity of care and resident safety.
	•	CNAs must never chart care that was not performed.
By accurately reporting and documenting personal care and grooming tasks, CNA students help ensure safe, consistent, and high-quality resident care while supporting effective communication within the healthcare team.',
   3);

  RAISE NOTICE 'Module 9 updated with 3 lessons.';
END $$;
