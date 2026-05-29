-- ============================================================
-- Nurse Rocky — Lesson Content Seed
-- Run in: Supabase Dashboard → SQL Editor
-- Safe to re-run: deletes & re-inserts lessons per module.
-- Also updates module titles/descriptions to match curriculum.
-- ============================================================

DO $$
DECLARE
  v_mod_id INT;
BEGIN

  -- ─────────────────────────────────────────────────────────────
  -- MODULE 2 · Safety & Infection Control
  -- ─────────────────────────────────────────────────────────────
  SELECT id INTO v_mod_id FROM modules WHERE order_num = 2;

  UPDATE modules SET
    title = 'Safety & Infection Control',
    description = 'Learn standard precautions, OSHA standards, PPE, hand hygiene, isolation, and environmental safety.',
    lessons_count = 9
  WHERE id = v_mod_id;

  DELETE FROM lessons WHERE module_id = v_mod_id;

  INSERT INTO lessons (module_id, title, content, order_num) VALUES
  (v_mod_id, 'Prevent Infection Transmission', 'Preventing the transmission of infection is a core responsibility for all healthcare workers, including Certified Nursing Assistant (CNA) students. Students must take proactive steps to protect themselves, patients, and others from the spread of infectious agents.

CNA students are required to follow proper hand hygiene, use of personal protective equipment (PPE), respiratory hygiene, and safe handling of equipment and linens at all times. Standard precautions should be applied to all patient interactions, and isolation precautions must be followed when caring for patients with known or suspected infections.

Students should also avoid cross-contamination by properly cleaning and disinfecting surfaces and equipment, safely disposing of sharp and contaminated materials, and reporting any exposures or breaches in infection control protocols immediately to instructors or supervising staff.

Adhering to infection prevention practices is a professional and legal responsibility. CNA students are expected to consistently demonstrate knowledge and application of infection control procedures during classroom learning, skills labs, and clinical experiences. Failure to follow these protocols may result in corrective action, as preventing infection transmission is essential for patient safety and healthcare quality.', 1),

  (v_mod_id, 'Follow OSHA Standards', 'The Occupational Safety and Health Administration (OSHA) establishes standards to ensure a safe and healthy workplace in healthcare settings. As a Certified Nursing Assistant (CNA) student, you are required to follow OSHA regulations and facility policies to protect yourself, patients, and coworkers from workplace hazards.

CNA students must understand and comply with OSHA guidelines regarding bloodborne pathogens, personal protective equipment (PPE), safe patient handling, hazard communication, and infection control practices. This includes proper use of gloves, gowns, masks, and eye protection, safe disposal of sharps and contaminated materials, and reporting of workplace injuries or exposures.

Students are also responsible for recognizing potential hazards, following emergency procedures, and participating in safety training provided by the facility or program. Adherence to OSHA standards is a professional and legal responsibility, and CNA students are expected to demonstrate these practices consistently during skills labs, clinical rotations, and all patient care activities. Failure to follow OSHA standards may result in corrective action, as compliance ensures a safe learning and healthcare environment.', 2),

  (v_mod_id, 'Standard Precautions', 'Standard Precautions are the minimum infection prevention practices that all healthcare workers must follow to protect themselves, patients, and others from the spread of infection. As a Certified Nursing Assistant (CNA) student, you are required to apply Standard Precautions during all patient care activities, regardless of a patient''s diagnosis or known infection status.

Standard Precautions assume that all blood, body fluids, non-intact skin, and mucous membranes may contain infectious microorganisms. To reduce the risk of transmission, CNA students must consistently perform proper hand hygiene, use appropriate personal protective equipment (PPE) such as gloves, gowns, masks, and eye protection when necessary, and follow safe practices for handling equipment, linens, and waste.

Students must also follow facility policies for cleaning and disinfecting surfaces, safely disposing of sharps and contaminated materials, and preventing exposure to infectious agents. Proper respiratory hygiene, cough etiquette, and maintaining a clean patient environment are also essential components of Standard Precautions.

Adhering to Standard Precautions is a professional responsibility and a critical part of providing safe, high-quality patient care. All CNA students are expected to demonstrate knowledge of these practices and consistently apply them during training, skills practice, and clinical experiences. Failure to follow Standard Precautions may result in corrective action, as maintaining infection control is essential for patient safety and healthcare professionalism.', 3),

  (v_mod_id, 'Personal Protective Equipment (PPE)', 'Personal Protective Equipment (PPE) is specialized clothing or equipment worn by healthcare workers to protect themselves and their patients from the spread of infection. As a Certified Nursing Assistant (CNA) student, you are required to understand and properly use PPE whenever there is a risk of exposure to blood, body fluids, secretions, excretions, or other potentially infectious materials.

Common types of PPE include gloves, gowns, masks, face shields, and eye protection. The type of PPE used depends on the task being performed and the level of exposure risk. CNA students must always follow facility guidelines and instructor direction when selecting and using PPE.

Students must also learn and demonstrate the correct procedures for putting on (donning) and removing (doffing) PPE to prevent contamination. Proper disposal of used PPE and performing hand hygiene immediately after removal are critical steps in maintaining infection control.

PPE must be worn whenever indicated, including during patient care activities such as assisting with personal hygiene, handling contaminated linens, performing wound care assistance, or when contact with bodily fluids is possible. PPE should never be reused unless specifically designed for reuse and properly disinfected according to facility policies.

Using PPE correctly is an essential part of maintaining a safe healthcare environment. All CNA students are expected to follow PPE protocols at all times during skills practice, laboratory sessions, and clinical training.', 4),

  (v_mod_id, 'Hand Hygiene', 'Hand hygiene is one of the most important practices for preventing the spread of infection in healthcare settings. As a Certified Nursing Assistant (CNA) student, you are expected to perform proper hand hygiene consistently before and after all patient interactions and whenever contamination may occur.

Hand hygiene includes washing hands with soap and water or using an alcohol-based hand sanitizer when appropriate. CNA students must wash their hands with soap and water when hands are visibly soiled, after using the restroom, before eating, and after contact with bodily fluids. Alcohol-based hand sanitizer may be used when hands are not visibly dirty and quick disinfection is needed.

Students must follow proper handwashing technique, which includes wetting hands, applying soap, scrubbing all surfaces of the hands and wrists for at least 20 seconds, rinsing thoroughly, and drying with a clean paper towel. Proper hand hygiene should be performed before and after patient contact, before and after wearing gloves, after contact with potentially contaminated surfaces, and after removing personal protective equipment (PPE).

Maintaining proper hand hygiene is a professional responsibility and a critical part of infection control in healthcare environments.', 5),

  (v_mod_id, 'Fire & Disaster Safety', 'Fire and disaster safety are essential components of maintaining a safe healthcare environment. As a Certified Nursing Assistant (CNA) student, you are expected to understand and follow all fire and disaster safety protocols to protect yourself, patients, and others in the facility.

Students must be familiar with the facility''s emergency procedures, including evacuation routes, fire alarm locations, fire extinguisher use, and emergency codes. In the event of a fire, CNA students should follow the R.A.C.E. protocol: Rescue patients in immediate danger, Alarm by activating the fire alarm, Contain the fire by closing doors, and Extinguish the fire if it is safe to do so.

During disasters — such as natural events, hazardous spills, or security threats — students must remain calm, follow staff instructions, assist patients as directed, and participate in evacuation or shelter-in-place procedures if required. Proper documentation and reporting of incidents are also part of disaster safety responsibilities.

Adherence to fire and disaster safety procedures is a professional responsibility and is critical for ensuring the safety of patients, staff, and yourself. CNA students are expected to demonstrate knowledge of these procedures during classroom instruction, skills practice, and clinical experiences.', 6),

  (v_mod_id, 'Workplace Injuries', 'Workplace safety is a critical responsibility for all healthcare workers, including Certified Nursing Assistant (CNA) students. Students must take precautions to prevent injuries while performing patient care and other tasks in clinical and laboratory settings.

CNA students should follow proper body mechanics when lifting, transferring, or repositioning patients to avoid musculoskeletal injuries. Use of assistive devices, gait belts, and teamwork techniques is required whenever necessary. Students must also be aware of potential hazards such as wet floors, sharp instruments, or equipment malfunctions and take steps to prevent accidents.

In the event of a workplace injury, students must immediately report the incident to the instructor or supervising staff, seek appropriate medical attention, and complete any required documentation. Prompt reporting and follow-up help ensure proper care, prevent further injury, and support a safe learning and working environment.

All CNA students are expected to demonstrate safe practices consistently and to follow facility policies regarding workplace safety.', 7),

  (v_mod_id, 'Isolation Precautions', 'Isolation precautions are infection control measures used to prevent the spread of contagious diseases within healthcare settings. As a Certified Nursing Assistant (CNA) student, you are required to follow isolation precautions whenever caring for patients who have or may have an infectious condition.

There are different types of isolation precautions — such as contact, droplet, and airborne precautions — each designed to minimize the risk of transmitting specific pathogens. CNA students must understand the type of isolation required for each patient and use the appropriate personal protective equipment (PPE), including gloves, gowns, masks, and eye protection, as directed.

Students must also follow proper procedures for entering and exiting isolation rooms, handling contaminated materials, and performing hand hygiene before and after patient contact. Visitors should be instructed on proper precautions when entering isolation areas, and all equipment must be cleaned or disposed of according to facility protocols.

Adhering to isolation precautions is a professional responsibility and a critical component of patient safety and infection control.', 8),

  (v_mod_id, 'Environmental Safety', 'Maintaining a safe and clean environment is essential for protecting patients, staff, and CNA students from injury and infection. As a Certified Nursing Assistant (CNA) student, you are expected to follow environmental safety practices at all times while providing care.

Students must keep patient care areas free of hazards, including spills, clutter, and obstructed walkways, and report unsafe conditions immediately to instructors or supervising staff. Proper handling, storage, and disposal of equipment, medical supplies, linens, and hazardous materials are required to prevent accidents and contamination.

CNA students should also ensure that beds, wheelchairs, and other equipment are in safe working order and that safety devices, such as bed rails and call lights, are used appropriately. Following facility policies for cleaning, disinfecting, and maintaining a safe environment is a professional responsibility.

Consistent adherence to environmental safety practices helps prevent accidents, injuries, and the spread of infection.', 9);


  -- ─────────────────────────────────────────────────────────────
  -- MODULE 3 · Communication & Interpersonal Skills
  -- ─────────────────────────────────────────────────────────────
  SELECT id INTO v_mod_id FROM modules WHERE order_num = 3;

  UPDATE modules SET
    title = 'Communication & Interpersonal Skills',
    description = 'Master therapeutic communication, cultural competency, residents'' rights, reporting, and documentation.',
    lessons_count = 8
  WHERE id = v_mod_id;

  DELETE FROM lessons WHERE module_id = v_mod_id;

  INSERT INTO lessons (module_id, title, content, order_num) VALUES
  (v_mod_id, 'Therapeutic Communication', 'Therapeutic communication is a key skill for Certified Nursing Assistants (CNAs) and plays an important role in providing compassionate, patient-centered care. CNA students must communicate with residents, patients, families, and members of the healthcare team in a respectful, clear, and supportive manner.

Therapeutic communication involves actively listening, speaking calmly, showing empathy, maintaining appropriate eye contact, and using simple, respectful language that patients can easily understand. CNA students should encourage patients to express their feelings, concerns, and needs while responding with patience and understanding.

It is important to avoid arguing, judging, interrupting, or using medical jargon that may confuse patients. Nonverbal communication — such as facial expressions, body language, and tone of voice — should always convey kindness, professionalism, and reassurance.

Effective therapeutic communication helps build trust, reduces anxiety, promotes dignity, and improves the overall quality of care. CNA students are expected to practice therapeutic communication at all times while maintaining patient privacy, respect, and professionalism.', 1),

  (v_mod_id, 'Verbal and Nonverbal Communication', 'Effective communication is an essential skill for Certified Nursing Assistants (CNAs) and is critical for providing safe, respectful, and compassionate patient care. CNA students must use both verbal and nonverbal communication to interact clearly and appropriately with residents, patients, families, and members of the healthcare team.

Verbal communication includes speaking clearly, using respectful language, and explaining care procedures in a way that patients can easily understand. CNA students should speak calmly, listen carefully, allow patients time to respond, and encourage them to express their needs or concerns.

Nonverbal communication includes body language, facial expressions, tone of voice, eye contact, and gestures. CNA students should ensure their nonverbal signals reflect kindness, patience, and professionalism. Simple actions such as maintaining appropriate eye contact, smiling, nodding, and positioning themselves at the patient''s level can help build trust and comfort.

CNA students must be aware that patients may rely on nonverbal cues when they have difficulty speaking or understanding. By using positive verbal and nonverbal communication, CNAs can improve patient relationships, reduce anxiety, and promote a supportive healthcare environment.', 2),

  (v_mod_id, 'Cultural Competency', 'Cultural competency is an essential skill for Certified Nursing Assistants (CNAs) and helps ensure respectful, patient-centered care for individuals from diverse backgrounds. CNA students must recognize and respect differences in culture, religion, language, beliefs, traditions, and values that may influence a patient''s health practices and personal preferences.

CNA students are expected to treat all patients with dignity, fairness, and sensitivity regardless of their cultural background. This includes being open-minded, avoiding stereotypes or assumptions, and making an effort to understand each patient''s unique needs and perspectives. Students should communicate respectfully, ask appropriate questions when needed, and seek guidance from the healthcare team if cultural practices affect care.

Providing culturally competent care helps build trust, improves communication, and promotes better health outcomes. CNA students must demonstrate respect, empathy, and professionalism when caring for patients from all cultures and communities.', 3),

  (v_mod_id, 'Residents'' Rights', 'Residents'' rights are fundamental protections that ensure every patient or resident receives respectful, dignified, and ethical care. Certified Nursing Assistant (CNA) students must understand that all residents have the right to be treated with dignity, privacy, and respect at all times.

CNA students are expected to support and protect residents'' rights, including the right to make decisions about their care, the right to be informed about treatments and services, and the right to refuse care. Residents also have the right to privacy during personal care, confidential handling of their personal and medical information, and the ability to voice concerns or complaints without fear of punishment or retaliation.

Students must promote independence and allow residents to participate in their own care whenever possible. Respect for cultural preferences, personal choices, and individual dignity must always be maintained. Protecting residents'' rights helps create a safe, supportive, and respectful healthcare environment and is a core responsibility of every CNA.', 4),

  (v_mod_id, 'Reporting Changes in Condition', 'Certified Nursing Assistants (CNAs) play an important role in observing residents and patients and reporting any changes in their condition. Because CNAs often spend the most time with patients, they are usually the first to notice physical, emotional, or behavioral changes that may indicate a health concern.

CNA students must carefully observe patients during daily care and promptly report any unusual signs or symptoms to the supervising nurse. Changes that should be reported may include pain, shortness of breath, confusion, fever, skin changes, loss of appetite, unusual behavior, difficulty moving, or any sudden decline in a patient''s condition.

Students should report observations clearly, accurately, and without delay according to facility procedures. It is important to describe exactly what was observed rather than making assumptions or diagnoses.

Timely reporting helps the healthcare team respond quickly, prevent complications, and ensure the patient receives appropriate care. Observing and reporting changes in condition is a critical responsibility that helps protect patient safety and well-being.', 5),

  (v_mod_id, 'Abuse & Neglect Reporting', 'Certified Nursing Assistants (CNAs) play a critical role in protecting the safety and well-being of residents and patients. CNA students must understand that abuse, neglect, mistreatment, and exploitation are strictly prohibited in all healthcare settings. Abuse may be physical, emotional, verbal, sexual, or financial, while neglect occurs when a patient''s basic needs such as food, hygiene, safety, or medical care are not properly met.

CNA students are required to remain alert for any signs or symptoms of abuse or neglect, including unexplained injuries, sudden changes in behavior, fear of certain individuals, poor hygiene, or untreated medical conditions. If a student suspects or witnesses abuse or neglect, they must report it immediately to their instructor, supervisor, or appropriate facility authority according to facility policy and state regulations.

CNA students must never ignore or attempt to handle suspected abuse on their own. Prompt reporting helps protect vulnerable individuals and ensures that proper investigation and intervention can occur. Protecting patients from harm is a professional and ethical responsibility of every CNA.', 6),

  (v_mod_id, 'Medical Terminology Basics', 'Medical terminology is the language used by healthcare professionals to describe the body, medical conditions, treatments, and procedures. Certified Nursing Assistant (CNA) students must develop a basic understanding of common medical terms in order to communicate effectively with nurses, doctors, and other members of the healthcare team.

CNA students should become familiar with basic medical terms related to body systems, vital signs, common illnesses, and daily care procedures. Understanding medical terminology helps students accurately follow instructions, recognize important information in patient charts, and report observations clearly.

Students do not need to diagnose medical conditions, but they must understand key terms used in patient care and documentation. Learning medical terminology also helps CNAs communicate more confidently and professionally within the healthcare environment.

Developing strong medical terminology skills supports safe patient care, improves teamwork, and helps CNA students better understand the healthcare setting in which they work.', 7),

  (v_mod_id, 'Documentation Basics', 'Accurate charting and documentation is an essential responsibility for Certified Nursing Assistants (CNAs) and plays a vital role in patient safety and quality care. CNA students must record the care they provide and report important observations clearly, accurately, and promptly according to facility policies and procedures.

Documentation should always be factual, objective, and completed as soon as possible after care is given. CNA students must only document tasks they personally performed or observations they directly witnessed. Personal opinions, assumptions, or incomplete information should never be included in patient records.

Students must ensure that documentation is legible, correct, and follows proper charting guidelines. Any changes in a patient''s condition — such as pain, unusual behavior, skin changes, or safety concerns — must be reported to the nurse immediately and documented according to protocol.

Maintaining accurate documentation supports communication among the healthcare team, protects patient safety, and ensures legal and professional accountability. CNA students must also follow all privacy and confidentiality rules when handling patient information.', 8);


  -- ─────────────────────────────────────────────────────────────
  -- MODULE 4 · Basic Nursing Skills
  -- ─────────────────────────────────────────────────────────────
  SELECT id INTO v_mod_id FROM modules WHERE order_num = 4;

  UPDATE modules SET
    title = 'Basic Nursing Skills',
    description = 'Learn vital signs, height & weight, intake & output, pain assessment, specimen collection, and skin integrity.',
    lessons_count = 7
  WHERE id = v_mod_id;

  DELETE FROM lessons WHERE module_id = v_mod_id;

  INSERT INTO lessons (module_id, title, content, order_num) VALUES
  (v_mod_id, 'Vital Signs', 'Understanding and accurately measuring vital signs is a critical component of providing safe and effective patient care. Vital signs — temperature, pulse, respiration, blood pressure, and sometimes oxygen saturation — offer essential information about a resident''s health status and can indicate changes in condition that require prompt attention.

CNAs must measure vital signs according to facility policies, using proper techniques and equipment, document results accurately, and report any abnormal findings immediately to the supervising nurse. Consistency, attention to detail, and communication are key to ensuring resident safety and supporting the healthcare team in making informed clinical decisions.', 1),

  (v_mod_id, 'Height & Weight', 'Measuring a resident''s height and weight is an important part of assessing overall health and monitoring changes over time. As a CNA, you must use proper techniques and equipment to obtain accurate measurements while ensuring resident safety and comfort.

Record height and weight carefully, follow facility protocols, and report any significant changes or concerns to the supervising nurse. Accurate measurements help guide nutrition, medication dosing, and care planning, supporting the resident''s well-being and the healthcare team''s decision-making.', 2),

  (v_mod_id, 'Intake & Output', 'Monitoring a resident''s intake and output is essential for assessing hydration, nutrition, and overall health. As a CNA, you are responsible for accurately measuring and recording all fluids a resident consumes (oral liquids, tube feedings, IV fluids) and eliminates (urine, vomit, diarrhea, and drainage from tubes).

Follow facility policies, use proper measuring techniques, and document all findings carefully. Promptly report any unusual patterns, such as decreased urine output or excessive fluid loss, to the supervising nurse. Accurate I&O monitoring helps the healthcare team identify potential health issues and guide appropriate care interventions.', 3),

  (v_mod_id, 'Pain Assessment', 'Assessing and reporting pain is a vital part of resident care. As a CNA, you should observe and ask residents about their pain, including location, intensity, duration, and factors that worsen or relieve it. Use appropriate pain scales as directed by your facility and document your observations accurately.

Always report any new, worsening, or uncontrolled pain to the supervising nurse promptly. Effective pain assessment helps ensure resident comfort, supports proper treatment, and contributes to the overall quality of care.', 4),

  (v_mod_id, 'Observation & Reporting', 'Accurate observation and timely reporting are essential responsibilities of a CNA. You are expected to carefully monitor residents for changes in physical condition, behavior, mental status, and overall well-being. This includes noting signs of pain, illness, injury, or changes in mood and appetite.

Document your observations clearly and objectively, and promptly communicate any significant changes or concerns to the supervising nurse. Effective observation and reporting help ensure resident safety, support the healthcare team''s decisions, and contribute to high-quality care.', 5),

  (v_mod_id, 'Specimen Collection', 'Specimen collection is an important task that helps the healthcare team diagnose and monitor a resident''s health. As a CNA, you may assist in collecting urine, stool, sputum, or other non-invasive specimens according to facility policies and proper procedures.

Always follow standard precautions, use the correct containers, label specimens accurately, and handle them safely. Promptly deliver specimens to the appropriate department or report to the supervising nurse as instructed. Accurate collection and handling of specimens ensure reliable test results and support safe, effective resident care.', 6),

  (v_mod_id, 'Skin Integrity', 'Maintaining and monitoring skin integrity is a key part of providing safe and effective care. As a CNA, you should routinely observe residents for signs of skin breakdown, such as redness, pressure ulcers, rashes, or wounds. Perform skin care according to facility protocols, reposition residents as needed, and ensure proper hygiene and moisture management.

Document your observations accurately and report any changes or concerns to the supervising nurse promptly. Protecting skin integrity helps prevent infections, promotes comfort, and supports overall health and well-being.', 7);


  -- ─────────────────────────────────────────────────────────────
  -- MODULE 5 · Personal Care Skills
  -- ─────────────────────────────────────────────────────────────
  SELECT id INTO v_mod_id FROM modules WHERE order_num = 5;

  UPDATE modules SET
    title = 'Personal Care Skills',
    description = 'Provide safe and dignified bathing, grooming, oral care, toileting, perineal care, and dressing assistance.',
    lessons_count = 6
  WHERE id = v_mod_id;

  DELETE FROM lessons WHERE module_id = v_mod_id;

  INSERT INTO lessons (module_id, title, content, order_num) VALUES
  (v_mod_id, 'Bathing', 'Bathing is an essential nursing assistant skill that promotes hygiene, comfort, dignity, and overall well-being for residents. As a CNA, you are responsible for assisting with or performing bathing procedures while ensuring the resident''s safety, privacy, and respect at all times.

CNA students must understand the different types of baths, including bed baths, partial baths, tub baths, and showers, and apply the appropriate method based on the resident''s condition, mobility level, and care plan. Proper bathing technique includes maintaining water temperature, using clean supplies, washing from cleanest to dirtiest areas, and thoroughly drying the skin to prevent breakdown.

During bathing, CNAs must observe the resident''s skin for redness, irritation, bruising, or signs of pressure injuries and promptly report any abnormalities to the nurse. Infection control practices, such as proper hand hygiene and use of PPE, must always be followed.

Equally important is maintaining the resident''s dignity by providing privacy, explaining each step before performing it, and encouraging independence whenever possible.', 1),

  (v_mod_id, 'Grooming', 'Grooming is a vital component of personal care that supports a resident''s dignity, self-esteem, and overall well-being. As a CNA, you are responsible for assisting residents with daily grooming tasks while promoting independence, respect, and comfort.

CNA students must be able to provide or assist with grooming activities such as hair care, oral hygiene, shaving, nail care, and skin care. These tasks should be performed according to the resident''s preferences, cultural considerations, and individualized care plan.

During grooming, CNAs must use proper infection control practices, including hand hygiene and the use of clean or disposable equipment. Safety is essential — especially when using razors, scissors, or assisting residents with limited mobility. CNAs should monitor for signs of skin irritation, oral health issues, nail abnormalities, or changes in appearance and report any concerns to the nurse promptly.', 2),

  (v_mod_id, 'Oral Care', 'Oral care is a fundamental nursing assistant skill that promotes comfort, prevents infection, and supports overall health. As a CNA, you are responsible for assisting residents with daily oral hygiene while maintaining dignity, safety, and infection control standards.

CNA students must be able to provide oral care for both conscious and unconscious residents, including brushing teeth, cleaning dentures, and performing mouth care using appropriate techniques. Proper oral care helps prevent complications such as bad breath, gum disease, tooth decay, and infections.

When providing oral care, CNAs must follow standard precautions, including proper hand hygiene and the use of gloves. For residents who are unconscious or at risk for aspiration, special care must be taken to position the resident safely (such as side-lying) and to use minimal fluid to prevent choking.

CNAs should observe the mouth, gums, lips, and tongue for signs of redness, sores, bleeding, dryness, or infection, and report any abnormalities to the nurse promptly.', 3),

  (v_mod_id, 'Toileting', 'Toileting is a fundamental nursing assistant skill that supports a resident''s dignity, comfort, and overall health. As a CNA, you are responsible for assisting residents with toileting needs in a respectful, safe, and timely manner while promoting independence whenever possible.

CNA students must understand how to assist with various toileting methods, including use of the bathroom, bedpan, urinal, and bedside commode. Prompt response to toileting requests helps prevent discomfort, incontinence episodes, and skin breakdown.

Proper technique includes ensuring privacy, using correct body mechanics, maintaining cleanliness, and performing perineal care as needed. CNAs must monitor for changes in urine or bowel patterns, such as frequency, color, odor, consistency, or presence of blood, and report any abnormalities to the nurse promptly.', 4),

  (v_mod_id, 'Perineal Care', 'Perineal care is a critical nursing assistant skill that promotes hygiene, prevents infection, and protects skin integrity in the genital and perineal area. As a CNA, you are responsible for providing this care with the highest level of dignity, privacy, and respect.

CNA students must be able to perform perineal care for both male and female residents, following proper techniques based on anatomy and the resident''s condition. Proper technique requires cleaning from front to back (especially for female residents) to prevent the spread of bacteria and reduce the risk of urinary tract infections.

Infection control is essential during perineal care. CNAs must perform hand hygiene, wear gloves, and use clean supplies for each resident. The area should be washed gently with warm water and mild soap, rinsed thoroughly, and dried completely to prevent skin irritation and breakdown.

Special attention should be given to residents with catheters, ensuring proper cleaning around the catheter site to reduce the risk of infection.', 5),

  (v_mod_id, 'Dressing & Undressing', 'Dressing and undressing are essential activities of daily living (ADLs) that support a resident''s comfort, dignity, independence, and self-esteem. As a CNA, you are responsible for assisting residents with clothing while ensuring safety, respect, and adherence to their individualized care plan.

When assisting residents with one-sided weakness (such as after a stroke), clothing should be applied to the affected (weaker) side first and removed from the unaffected (stronger) side first to prevent injury and promote comfort. CNAs should encourage residents to participate in dressing as much as possible to maintain independence and self-confidence.

Safety is a priority during dressing and undressing. CNAs must use proper body mechanics, avoid pulling or twisting limbs, and ensure the resident is in a stable position during care. During the process, CNAs should observe the resident''s skin for redness, bruising, swelling, or signs of discomfort and report any concerns to the nurse.', 6);


  -- ─────────────────────────────────────────────────────────────
  -- MODULE 6 · Mobility & Body Mechanics
  -- ─────────────────────────────────────────────────────────────
  SELECT id INTO v_mod_id FROM modules WHERE order_num = 6;

  UPDATE modules SET
    title = 'Mobility & Body Mechanics',
    description = 'Learn safe transfer techniques, gait belt use, positioning, range of motion, fall prevention, and proper body mechanics.',
    lessons_count = 6
  WHERE id = v_mod_id;

  DELETE FROM lessons WHERE module_id = v_mod_id;

  INSERT INTO lessons (module_id, title, content, order_num) VALUES
  (v_mod_id, 'Transfers', 'Transfers are a critical nursing assistant skill that involves safely moving residents from one position or location to another, such as from bed to chair, wheelchair to toilet, or chair to standing. As a CNA, you are responsible for ensuring that all transfers are performed safely to prevent injury to both the resident and yourself.

CNA students must understand and apply proper transfer techniques based on the resident''s mobility level, strength, and care plan. This includes the use of assistive devices such as gait belts, slide boards, and mechanical lifts when indicated. Before any transfer, CNAs must assess the environment for safety hazards, lock wheels on beds and wheelchairs, and ensure the resident is wearing non-skid footwear.

Proper body mechanics are essential during transfers. CNAs should keep their back straight, bend at the knees, and use their legs when lifting or assisting. During transfers, CNAs must observe the resident for signs of dizziness, weakness, pain, or instability and stop the transfer if safety is compromised.', 1),

  (v_mod_id, 'Gait Belts', 'A gait belt is an essential safety device used by CNAs to assist residents with transfers and ambulation while reducing the risk of falls and injury. As a CNA, you are responsible for using a gait belt correctly to provide secure support and maintain both resident and caregiver safety.

The gait belt should be applied snugly around the resident''s waist, over clothing, with enough space to fit two fingers between the belt and the resident''s body. During transfers or ambulation, the CNA should stand to the resident''s weaker side (if applicable), maintain a firm grip on the belt from underneath, and use proper body mechanics.

Gait belts should not be used for residents with certain conditions, such as abdominal injuries, recent surgeries, feeding tubes, or severe respiratory issues, unless directed by the care plan. CNAs must continuously observe the resident for signs of fatigue, dizziness, or instability and respond immediately if the resident begins to lose balance.', 2),

  (v_mod_id, 'Positioning', 'Positioning is a fundamental nursing assistant skill that promotes comfort, prevents complications, and supports overall health and safety. As a CNA, you are responsible for properly positioning residents to maintain body alignment, reduce pressure, and prevent skin breakdown and contractures.

CNA students must understand and perform common positioning techniques, including supine (on the back), lateral (side-lying), Fowler''s (head elevated), and Sims'' positions. Repositioning should be done at least every two hours, or according to the care plan, to prevent pressure injuries and improve circulation.

Proper technique includes using pillows, wedges, or other supportive devices to maintain alignment and relieve pressure on bony prominences such as the heels, hips, elbows, and sacrum. During positioning, CNAs must observe the skin for redness, irritation, or breakdown and report any concerns to the nurse promptly.', 3),

  (v_mod_id, 'Range of Motion', 'Range of Motion (ROM) exercises are essential nursing assistant skills that help maintain or improve a resident''s joint flexibility, prevent stiffness, reduce the risk of contractures, and promote overall mobility and independence. As a CNA, you are responsible for assisting residents with ROM exercises safely and according to their individualized care plan.

CNA students must understand the difference between active ROM (performed by the resident) and passive ROM (assisted by the CNA). Proper technique requires supporting the joint above and below the area being exercised, moving the joint gently through its full range without forcing or causing pain. Exercises should be done slowly, smoothly, and within the resident''s comfort level.

Report any signs of pain, swelling, redness, or limited movement to the nurse immediately. Residents should be encouraged to participate as much as possible to maintain independence and strength.', 4),

  (v_mod_id, 'Fall Prevention', 'Fall prevention is a critical responsibility for CNAs, as falls can result in serious injury, loss of independence, and decreased quality of life for residents. As a CNA, you are responsible for identifying fall risks, implementing safety measures, and assisting residents in ways that minimize the chance of falls.

CNA students must understand common risk factors for falls, including mobility limitations, medication side effects, poor vision, environmental hazards, and confusion. Preventive measures include keeping walkways clear, ensuring proper lighting, using assistive devices correctly, keeping frequently used items within reach, and locking wheelchair and bed brakes.

After any fall or near-fall, the incident must be documented immediately and reported according to facility policy. Educating residents about safety, encouraging participation in their care, and maintaining a safe environment are essential components of quality CNA care.', 5),

  (v_mod_id, 'Body Mechanics', 'Body mechanics refers to the safe and efficient use of the body during all physical activities, including lifting, transferring, repositioning, and assisting residents. Proper body mechanics help prevent injury to both the CNA and the resident while promoting safe patient care.

CNA students must understand the principles of body mechanics, which include maintaining a stable base of support, keeping the back straight, bending at the knees and hips rather than the waist, holding objects close to the body, and avoiding twisting motions while lifting or turning residents.

CNAs should always assess the situation before moving a resident, use assistive devices when indicated, and ask for help with heavy or dependent residents. CNAs should monitor their own posture, avoid overreaching, and stop any activity that causes strain or discomfort.', 6);


  -- ─────────────────────────────────────────────────────────────
  -- MODULE 7 · Nutrition & Hydration
  -- ─────────────────────────────────────────────────────────────
  SELECT id INTO v_mod_id FROM modules WHERE order_num = 7;

  UPDATE modules SET
    title = 'Nutrition & Hydration',
    description = 'Learn proper feeding techniques, special dietary needs, and hydration monitoring.',
    lessons_count = 3
  WHERE id = v_mod_id;

  DELETE FROM lessons WHERE module_id = v_mod_id;

  INSERT INTO lessons (module_id, title, content, order_num) VALUES
  (v_mod_id, 'Feeding Techniques', 'Feeding residents is an essential nursing assistant skill that supports nutrition, hydration, comfort, and overall health. As a CNA, you are responsible for assisting residents with meals safely, respectfully, and according to their individualized care plan.

CNA students must understand proper feeding techniques, including hand hygiene, positioning, and safe handling of utensils and food. Residents should be seated upright at a 90-degree angle (or as directed by the care plan) to reduce the risk of choking or aspiration. For residents with swallowing difficulties, CNAs must follow dietary restrictions and special instructions, such as thickened liquids or pureed foods.

During feeding, CNAs should offer small bites, allow adequate time to chew and swallow, and encourage independence whenever possible. CNAs must monitor for signs of choking, coughing, difficulty swallowing, or fatigue and respond immediately. CNAs must record the amount of food and fluid consumed and report changes in appetite or swallowing abilities to the nurse promptly.', 1),

  (v_mod_id, 'Special Diets', 'Special diets are an important aspect of resident care that support health, manage medical conditions, and promote recovery. CNA students must be familiar with common types of special diets, including:

- Diabetic or carbohydrate-controlled diets to manage blood sugar levels
- Low-sodium diets for residents with heart or kidney conditions
- Low-fat or cholesterol-restricted diets for cardiovascular health
- Pureed, soft, or mechanically altered diets for residents with swallowing difficulties (dysphagia)
- Allergen-free diets to prevent allergic reactions

CNAs must follow dietary instructions exactly, including portion sizes, consistency, and timing. Residents should be positioned upright, and any signs of choking, coughing, or difficulty swallowing must be reported immediately. CNAs should monitor residents for changes in appetite, weight, or tolerance of the diet and report concerns to the nurse or dietary team.', 2),

  (v_mod_id, 'Hydration', 'Hydration is a critical component of resident care that supports overall health, organ function, and well-being. As a CNA, you are responsible for assisting residents in maintaining adequate fluid intake according to their individualized care plan while observing for signs of dehydration or fluid overload.

CNA students must understand the importance of offering fluids frequently, providing a variety of acceptable beverages, and encouraging residents to drink according to their needs and preferences. Residents who are weak, confused, or unable to drink independently require assistance.

CNAs should note changes in urine output, skin turgor, dryness of lips or mucous membranes, and any signs of discomfort, and promptly report concerns to the nurse. CNAs should accurately record the type and amount of fluid intake, as well as any refusals or difficulties, to support ongoing care and treatment planning.', 3);


  -- ─────────────────────────────────────────────────────────────
  -- MODULE 8 · Elimination & Toileting
  -- ─────────────────────────────────────────────────────────────
  SELECT id INTO v_mod_id FROM modules WHERE order_num = 8;

  UPDATE modules SET
    title = 'Elimination & Toileting',
    description = 'Assist patients with bowel and bladder care, ostomy awareness, and proper toileting techniques.',
    lessons_count = 3
  WHERE id = v_mod_id;

  DELETE FROM lessons WHERE module_id = v_mod_id;

  INSERT INTO lessons (module_id, title, content, order_num) VALUES
  (v_mod_id, 'Bowel & Bladder Care', 'As a Certified Nursing Assistant (CNA), you play a vital role in promoting the health, comfort, and dignity of residents by assisting with bowel and bladder care. Proper care involves helping residents maintain regular elimination patterns, recognizing changes in bowel or urinary habits, and preventing complications such as infections, incontinence, or skin breakdown.

Key responsibilities include:
- Assisting residents with toileting needs in a timely, respectful, and safe manner
- Using appropriate hygiene techniques to prevent infection, including hand hygiene and perineal care
- Monitoring and recording bowel movements and urinary output accurately, noting color, consistency, and frequency
- Recognizing signs of constipation, diarrhea, urinary tract infections, or incontinence and promptly reporting changes to the nurse
- Supporting residents who use catheters, ostomy devices, or incontinence products according to care plans
- Maintaining privacy and promoting independence, encouraging residents to participate in their own care as much as possible

Proper bowel and bladder care not only preserves physical health but also supports emotional well-being and dignity.', 1),

  (v_mod_id, 'Ostomy Awareness', 'Certified Nursing Assistants (CNAs) play an essential role in supporting residents with ostomies, ensuring their safety, comfort, and dignity. An ostomy is a surgically created opening in the abdomen that allows waste to leave the body, often due to medical conditions affecting the bowel or bladder.

Key responsibilities include:
- Providing respectful and compassionate care, maintaining the resident''s privacy during ostomy management
- Assisting with emptying, cleaning, and changing ostomy bags according to the care plan and under the guidance of the nurse
- Observing the stoma and surrounding skin for changes in color, swelling, irritation, or leakage, and reporting concerns immediately
- Educating and encouraging residents to participate in their ostomy care as appropriate, fostering independence
- Following infection control practices, including hand hygiene and proper disposal of ostomy supplies

By understanding ostomy care and being aware of residents'' physical and emotional needs, CNAs help maintain health, dignity, and quality of life.', 2),

  (v_mod_id, 'Toileting', 'As a Certified Nursing Assistant (CNA), assisting residents with toileting is an essential part of promoting their dignity, comfort, and overall health. Proper toileting care supports elimination, prevents complications such as urinary tract infections or skin breakdown, and respects the resident''s privacy and independence.

Key responsibilities include:
- Assisting residents to the bathroom, bedside commode, or providing a bedpan or urinal as needed
- Encouraging residents to communicate their needs promptly and supporting their independence whenever possible
- Following proper hygiene practices, including hand hygiene and perineal care, to prevent infection
- Observing and documenting changes in elimination patterns, including frequency, color, consistency, or signs of discomfort, and promptly reporting concerns to the nurse
- Ensuring safety during toileting, including preventing falls and maintaining proper body mechanics
- Respecting privacy and providing support in a compassionate and nonjudgmental manner', 3);


  -- ─────────────────────────────────────────────────────────────
  -- MODULE 9 · Infection, Disease & Conditions
  -- ─────────────────────────────────────────────────────────────
  SELECT id INTO v_mod_id FROM modules WHERE order_num = 9;

  UPDATE modules SET
    title = 'Infection, Disease & Conditions',
    description = 'Recognize common diseases, support mental health, provide dementia and Alzheimer''s care, and assist with end-of-life care.',
    lessons_count = 4
  WHERE id = v_mod_id;

  DELETE FROM lessons WHERE module_id = v_mod_id;

  INSERT INTO lessons (module_id, title, content, order_num) VALUES
  (v_mod_id, 'Common Diseases', 'As a Certified Nursing Assistant (CNA), understanding common diseases helps you provide safe, informed, and compassionate care to residents. While CNAs do not diagnose or treat illnesses, recognizing signs and symptoms of common conditions allows timely reporting to the nurse and supports resident well-being.

Key responsibilities include:
- Being familiar with common chronic and acute conditions such as diabetes, hypertension, heart disease, respiratory illnesses, urinary tract infections, dementia, and infections like influenza or pneumonia
- Observing and reporting changes in the resident''s condition, including vital signs, behavior, appetite, or mobility
- Assisting residents with disease-specific needs, such as monitoring blood sugar, supporting mobility for joint conditions, or following diet restrictions
- Practicing infection control measures to prevent the spread of communicable diseases
- Providing emotional support and promoting safety, comfort, and independence for residents managing chronic illnesses

By understanding common diseases and their impact on daily care, CNAs contribute to early detection of complications and support individualized, person-centered care.', 1),

  (v_mod_id, 'Mental Health Basics', 'As a Certified Nursing Assistant (CNA), understanding mental health is essential for providing compassionate, safe, and person-centered care. Residents may experience a variety of mental health conditions, including depression, anxiety, dementia, schizophrenia, or mood disorders. While CNAs do not diagnose or treat mental health conditions, recognizing signs and providing appropriate support is critical for overall well-being.

Key responsibilities include:
- Observing and reporting changes in mood, behavior, or cognitive function to the nurse promptly
- Providing a safe, calm, and supportive environment that reduces stress and promotes emotional stability
- Practicing active listening and therapeutic communication to encourage residents to express feelings and needs
- Supporting routines and daily activities while respecting residents'' autonomy and preferences
- Maintaining privacy, dignity, and confidentiality in all interactions
- Assisting with coping strategies and activities that promote mental wellness, such as social engagement and structured daily routines

By understanding mental health basics, CNAs can help identify early warning signs, prevent crises, and support residents'' emotional and psychological health.', 2),

  (v_mod_id, 'Dementia & Alzheimer''s Care', 'As a Certified Nursing Assistant (CNA), providing care for residents with dementia or Alzheimer''s disease requires patience, compassion, and understanding. These conditions affect memory, thinking, behavior, and the ability to perform daily activities.

Key responsibilities include:
- Assisting with daily activities such as bathing, dressing, toileting, and eating, while promoting independence as much as possible
- Using clear communication, simple instructions, and non-verbal cues to reduce confusion and anxiety
- Observing and reporting changes in behavior, mood, or cognitive function promptly to the nurse
- Maintaining a calm, safe, and structured environment to prevent agitation, wandering, or accidents
- Providing emotional support and reassurance, recognizing that residents may feel frustrated, fearful, or confused
- Respecting the resident''s dignity, routines, and personal preferences, and encouraging social engagement and meaningful activities

By understanding the unique needs of residents with dementia or Alzheimer''s disease, CNAs can deliver compassionate, person-centered care that enhances safety, comfort, and overall well-being.', 3),

  (v_mod_id, 'End-of-Life Care', 'As a Certified Nursing Assistant (CNA), providing end-of-life care requires compassion, respect, and sensitivity. Residents nearing the end of life may experience physical, emotional, and spiritual changes, and CNAs play a vital role in ensuring comfort, dignity, and support for both the resident and their family.

Key responsibilities include:
- Assisting with comfort measures such as repositioning, hygiene, oral care, and pain management under the guidance of the nurse
- Observing and promptly reporting changes in physical condition, vital signs, or emotional state to the nurse
- Providing emotional support and companionship to residents and their families, respecting their wishes and cultural practices
- Maintaining privacy and dignity at all times, ensuring respectful and compassionate care
- Assisting with feeding, hydration, and elimination needs as tolerated, while recognizing and honoring the resident''s preferences
- Collaborating with the healthcare team to provide holistic, person-centered care during the dying process

By delivering attentive and compassionate end-of-life care, CNAs help ensure that residents experience comfort, dignity, and emotional support during their final days.', 4);


  -- ─────────────────────────────────────────────────────────────
  -- MODULE 10 · Clinical Readiness
  -- ─────────────────────────────────────────────────────────────
  SELECT id INTO v_mod_id FROM modules WHERE order_num = 10;

  UPDATE modules SET
    title = 'Clinical Readiness',
    description = 'Prepare for certification through skills review, scenario-based learning, mock charting, and professional expectations.',
    lessons_count = 4
  WHERE id = v_mod_id;

  DELETE FROM lessons WHERE module_id = v_mod_id;

  INSERT INTO lessons (module_id, title, content, order_num) VALUES
  (v_mod_id, 'Skills Review', 'As a Certified Nursing Assistant (CNA) student, regular skills review is essential to ensure safe, accurate, and compassionate care. Skills review reinforces competency in core areas such as infection control, vital signs, body mechanics, patient mobility, personal care, communication, and documentation.

By routinely practicing and evaluating these skills, students build confidence, maintain high performance standards, and prepare for real-world clinical situations and state certification testing. Consistent skills review also helps CNAs stay current with best practices, recognize areas needing improvement, and deliver quality care that promotes residents'' dignity, comfort, and safety.', 1),

  (v_mod_id, 'Scenario-Based Learning', 'Scenario-based learning gives CNA students the opportunity to apply their knowledge and skills in realistic, hands-on situations. By working through patient care scenarios, students learn how to think critically, respond calmly under pressure, and make safe, patient-centered decisions.

This approach reinforces essential competencies such as communication, infection control, mobility assistance, vital sign monitoring, and recognizing changes in condition. Scenario-based learning also encourages teamwork, problem-solving, and accountability — key qualities needed in clinical settings. Through guided practice and reflection, students build confidence, improve clinical judgment, and become better prepared for both state competency exams and real-world caregiving.', 2),

  (v_mod_id, 'Mock Charting', 'Mock charting allows CNA students to practice accurate, timely, and objective documentation in a safe learning environment. By completing simulated charting exercises, students learn how to record care using proper medical terminology, approved abbreviations, and factual observations.

This practice helps reinforce the importance of accuracy, legibility, and confidentiality in all written and electronic entries. Through mock charting, CNA students develop confidence in documenting vital signs, intake and output, mobility assistance, personal care activities, and changes in a resident''s condition. Mastering these skills prepares students for real clinical documentation and supports effective communication within the healthcare team.', 3),

  (v_mod_id, 'Professional Expectations', 'As a CNA student, maintaining high professional standards is essential in both the classroom and clinical setting. Professional expectations include demonstrating reliability, punctuality, and readiness to learn each day.

Students are expected to show respect for residents, families, instructors, and healthcare team members while upholding dignity, compassion, and cultural sensitivity in all interactions. CNAs must follow facility policies, scope of practice guidelines, and ethical standards, including maintaining confidentiality under HIPAA. Professional behavior also includes using appropriate communication, practicing safe care, accepting constructive feedback, and taking responsibility for one''s actions.

By meeting these expectations consistently, CNA students prepare themselves to become trustworthy, competent, and respected healthcare professionals.', 4);


  RAISE NOTICE 'Lesson seed complete: modules 2-10 updated with lesson content.';
END $$;
