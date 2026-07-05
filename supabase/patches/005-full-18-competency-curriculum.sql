-- ============================================================
-- Nurse Rocky — Patch 005: Full 18-Competency Curriculum
-- Aligns modules 1-11 to official competency names/content
-- and adds modules 12-18 with lesson content from curriculum.
-- Run in: Supabase Dashboard → SQL Editor
-- Safe to re-run: upserts modules, replaces lessons per module.
-- ============================================================

DO $$
DECLARE
  v_mod_id  INT;
  v_quiz_id UUID;
BEGIN

  -- ─────────────────────────────────────────────────────────────
  -- MODULE 1 · Functions as a Member of the Healthcare Facility
  -- ─────────────────────────────────────────────────────────────
  IF NOT EXISTS (SELECT 1 FROM modules WHERE order_num = 1) THEN
    INSERT INTO modules (title, description, order_num, is_published)
    VALUES ('Functions as a Member of the Healthcare Facility',
            'Understand the different healthcare settings, the CNA role within the healthcare team, ethical and legal responsibilities, and professional standards of conduct.',
            1, true)
    RETURNING id INTO v_mod_id;
  ELSE
    SELECT id INTO v_mod_id FROM modules WHERE order_num = 1;
    UPDATE modules SET
      title = 'Functions as a Member of the Healthcare Facility',
      description = 'Understand the different healthcare settings, the CNA role within the healthcare team, ethical and legal responsibilities, and professional standards of conduct.',
      is_published = true
    WHERE id = v_mod_id;
  END IF;

  DELETE FROM lessons WHERE module_id = v_mod_id;

  INSERT INTO lessons (module_id, title, content, order_num) VALUES
  (v_mod_id, 'Healthcare Settings and Their Functions',
   'As a Certified Nursing Assistant (CNA), it is important to understand the different types of healthcare settings and the role each plays in meeting the needs of patients and residents. Healthcare services are provided across a variety of environments, each designed to support individuals with different levels of medical, physical, emotional, and social needs.

Acute Care: Acute care facilities, such as hospitals, provide short-term medical treatment for serious illnesses, injuries, surgeries, and emergency conditions. Patients typically stay for a limited time and receive intensive medical care from a multidisciplinary healthcare team.

Long-Term Care: Long-term care facilities, often called nursing homes or skilled nursing facilities, provide ongoing care for individuals who require assistance with activities of daily living and medical monitoring over an extended period. Residents may remain in these facilities for months or years.

Assisted Living: Assisted living communities support individuals who need help with daily activities such as bathing, dressing, medication management, and meal preparation while maintaining as much independence as possible. Residents typically do not require the skilled nursing care provided in long-term care facilities.

Home Care: Home care services allow individuals to receive care in their own homes. CNAs may assist clients with personal care, meal preparation, mobility, and household tasks while promoting independence and comfort in a familiar environment.

Rehabilitation: Rehabilitation facilities focus on helping patients recover from injuries, surgeries, illnesses, or disabilities. The goal is to restore function, improve mobility, and maximize independence through therapies and supportive care.

Hospice: Hospice care provides compassionate end-of-life care for individuals with terminal illnesses. The focus is on comfort, dignity, pain management, emotional support, and quality of life for both the patient and their family rather than curative treatment.

Although each healthcare setting serves a unique purpose, all share the common goal of promoting health, safety, comfort, and quality of life. As CNAs, students must understand the functions of each setting and adapt their caregiving approach to meet the specific needs of the individuals they serve.', 1),

  (v_mod_id, 'The Nursing Team and Healthcare Professionals',
   'Quality patient care depends on effective teamwork among healthcare professionals. As a CNA, you are an important member of the healthcare team and play a vital role in supporting patients, residents, families, nurses, and other healthcare professionals.

The Registered Nurse (RN) is responsible for overseeing patient care and managing the nursing process. RNs assess patients, develop care plans, administer medications, perform treatments, supervise nursing personnel, provide patient education, and communicate with physicians and other healthcare providers.

The Licensed Practical Nurse (LPN) provides nursing care under the supervision of an RN or physician. LPN responsibilities may include monitoring patients, administering certain medications, performing treatments, collecting patient information, and documenting care.

The Certified Nursing Assistant (CNA) provides direct hands-on care to patients and residents. Duties may include assisting with bathing, grooming, dressing, toileting, feeding, mobility, vital signs, and observing changes in patient condition. CNAs serve as the eyes and ears of the healthcare team.

A successful healthcare team is built upon effective communication, mutual respect, professionalism, trust and accountability, cooperation and collaboration, patient-centered care, and shared goals and responsibilities. Each team member contributes specialized knowledge and skills while working together to achieve the best possible outcomes for patients and residents.

Other healthcare team members include physicians, nurse practitioners, dietitians, physical therapists, speech therapists, social workers, and occupational therapists. CNAs frequently work alongside all of these professionals and must communicate clearly and respectfully with each.', 2),

  (v_mod_id, 'Ethical and Legal Behavior — Resident Rights',
   'CNAs have a legal and ethical responsibility to provide care that protects resident rights, promotes safety, and follows all applicable laws, regulations, and professional standards. Ethical and legal behavior is the foundation of trustworthy healthcare practice.

Nursing assistant practice is regulated by multiple agencies including the Arizona State Board of Nursing (AZBN), which governs certification and standards of conduct; the Omnibus Budget Reconciliation Act (OBRA), which establishes federal requirements for training and resident rights; the Joint Commission (JCAHO), which sets national standards for quality and safety; and OSHA, which establishes workplace safety standards.

CNAs must always work within their legal scope of practice. They are not permitted to perform tasks that require clinical judgment, independent diagnosis, or procedures reserved for licensed nurses or other healthcare professionals.

Professional behavior is essential for maintaining trust and providing high-quality care. CNAs are expected to demonstrate: Caring (compassion and respect), Competence (performing tasks safely), Conscientiousness (attentiveness and personal hygiene), Courtesy (respectful communication), Dependability and Timeliness, Honesty, and Teamwork.

Key legal terms CNAs must understand include: Abandonment, Abuse (physical/verbal/emotional/financial), Advance Directive, Assault, Battery, Defamation of Character, False Imprisonment, Informed Consent, Invasion of Privacy, Neglect, and Restraints. Understanding these terms protects residents and CNAs alike.', 3),

  (v_mod_id, 'Mental Health and Social Service Needs of Residents',
   'CNAs play an important role in recognizing and supporting the mental health and social service needs of residents. While CNAs do not diagnose or provide treatment, they are often the primary caregivers who observe changes in behavior, emotional well-being, and social interaction.

Basic human needs throughout the lifespan are described through Maslow''s Hierarchy of Needs, which includes physiological needs (food, water, rest, shelter), safety and security needs, love and belonging needs, self-esteem needs, and self-actualization needs. CNAs must also understand Erikson''s stages of psychosocial development.

As individuals age, their needs may change to include increased physical support, emotional support and companionship, social interaction and community involvement, mental health support, and access to community resources. Older adults are often categorized as young-old (60–74), middle-old (75–84), and old-old (85+).

Aging involves important developmental tasks including adjusting to retirement, coping with physical changes and declining health, adapting to loss, maintaining independence while accepting assistance, and finding meaning and purpose in later life.

Changes in mental status and behavior may occur due to aging, illness, medication effects, or environmental factors. Common changes include confusion or disorientation, memory loss, mood changes (depression, anxiety), withdrawal from social activities, and changes in sleep or appetite. CNAs must observe, document, and report all changes to ensure residents receive appropriate care.', 4);

  UPDATE modules SET lessons_count = 4 WHERE id = v_mod_id;


  -- ─────────────────────────────────────────────────────────────
  -- MODULE 2 · Demonstrates Ethical and Legal Behavior
  -- ─────────────────────────────────────────────────────────────
  IF NOT EXISTS (SELECT 1 FROM modules WHERE order_num = 2) THEN
    INSERT INTO modules (title, description, order_num, is_published)
    VALUES ('Demonstrates Ethical and Legal Behavior',
            'Learn the legal and ethical standards governing CNA practice, resident rights, scope of practice, professional accountability, and key legal terminology.',
            2, true)
    RETURNING id INTO v_mod_id;
  ELSE
    SELECT id INTO v_mod_id FROM modules WHERE order_num = 2;
    UPDATE modules SET
      title = 'Demonstrates Ethical and Legal Behavior',
      description = 'Learn the legal and ethical standards governing CNA practice, resident rights, scope of practice, professional accountability, and key legal terminology.',
      is_published = true
    WHERE id = v_mod_id;
  END IF;

  DELETE FROM lessons WHERE module_id = v_mod_id;

  INSERT INTO lessons (module_id, title, content, order_num) VALUES
  (v_mod_id, 'Scope of Practice and Legal Limits',
   'CNAs must always work within their legal scope of practice. The scope of practice defines the tasks and responsibilities that a CNA is legally permitted to perform. CNAs are not permitted to perform tasks that require clinical judgment, independent diagnosis, or procedures reserved for licensed nurses or other healthcare professionals. Practicing within legal limits protects both the resident and the nursing assistant.

Functions, roles, responsibilities, and legal limits include assisting with activities of daily living, observing and reporting changes in condition, and supporting resident comfort and safety. CNAs work under the supervision of licensed nursing staff at all times.

Regulatory boards, laws, rules, and standards of care that govern CNA practice include the Arizona State Board of Nursing (AZBN), the Omnibus Budget Reconciliation Act (OBRA), the Joint Commission (JCAHO), and the Occupational Safety and Health Administration (OSHA).

To become a Certified Nursing Assistant in Arizona, individuals must complete an approved CNA training program, pass the state certification examination, and meet all eligibility requirements established by the AZBN. Certification must be maintained through renewal and continued compliance with state regulations.

Certain criminal conduct may impact eligibility for certification or renewal. Felony convictions or other disqualifying offenses may result in denial, suspension, or revocation of certification, depending on state board review and regulations.', 1),

  (v_mod_id, 'Resident Rights and Ethical Standards',
   'Residents in healthcare facilities have protected rights that CNAs must uphold at all times. These rights are established by federal law under OBRA and include the right to be treated with dignity and respect, the right to privacy and confidentiality, the right to make decisions about their care (self-determination), the right to be free from abuse and neglect, and the right to voice grievances without fear of retaliation.

CNAs are required to follow established standards of conduct including federal regulations under OBRA, Arizona State Board of Nursing Standards, Joint Commission safety and quality standards, and OSHA workplace safety standards.

Key ethical and legal terms every CNA must understand:
• Abandonment: Leaving a resident without proper care or supervision
• Abuse: Includes physical, sexual, verbal, emotional abuse, threats, humiliation, involuntary seclusion, and financial exploitation
• Advance Directive: Legal document outlining a resident''s healthcare wishes
• Advocate: A person who supports and protects resident rights
• Assault: Threatening harm to a resident
• Battery: Physical contact without consent
• Defamation of Character: False statements harming reputation
• False Imprisonment: Restricting a resident''s freedom unlawfully
• Informed Consent: A resident''s voluntary agreement to treatment
• Invasion of Privacy: Violating a resident''s right to confidentiality
• Neglect: Failure to provide necessary care
• Ombudsman: Advocate for residents in long-term care facilities
• Restraints: Chemical or physical methods used to restrict movement (strictly regulated)

Professional behavior expectations include caring, competence, conscientiousness, courtesy, dependability and timeliness, honesty, and teamwork. These standards ensure safe, ethical, and professional care delivery.', 2);

  UPDATE modules SET lessons_count = 2 WHERE id = v_mod_id;


  -- ─────────────────────────────────────────────────────────────
  -- MODULE 3 · Mental Health and Social Service Needs
  -- ─────────────────────────────────────────────────────────────
  IF NOT EXISTS (SELECT 1 FROM modules WHERE order_num = 3) THEN
    INSERT INTO modules (title, description, order_num, is_published)
    VALUES ('Identifies Mental Health and Social Service Needs',
            'Identify basic human needs across the lifespan, recognize developmental and behavioral changes in aging adults, and understand the social and cultural roles of older adults.',
            3, true)
    RETURNING id INTO v_mod_id;
  ELSE
    SELECT id INTO v_mod_id FROM modules WHERE order_num = 3;
    UPDATE modules SET
      title = 'Identifies Mental Health and Social Service Needs',
      description = 'Identify basic human needs across the lifespan, recognize developmental and behavioral changes in aging adults, and understand the social and cultural roles of older adults.',
      is_published = true
    WHERE id = v_mod_id;
  END IF;

  DELETE FROM lessons WHERE module_id = v_mod_id;

  INSERT INTO lessons (module_id, title, content, order_num) VALUES
  (v_mod_id, 'Basic Human Needs Across the Lifespan',
   'Basic human needs refer to the essential physical, emotional, social, cultural, and mental health requirements necessary for survival, comfort, and well-being. One of the most widely used frameworks is Maslow''s Hierarchy of Needs:

• Physiological needs: food, water, rest, shelter — the most basic survival requirements
• Safety and security needs: protection from harm, stable environment
• Love and belonging needs: relationships, social connection, being part of a community
• Self-esteem needs: respect, recognition, sense of accomplishment
• Self-actualization needs: reaching one''s full potential and personal growth

CNAs must also understand Erikson''s stages of psychosocial development, which describe how individuals grow and adapt emotionally and socially throughout life. In older adulthood, key developmental focus includes life review, acceptance, integrity, and coping with loss.

As individuals age, their needs may change and include increased physical support and healthcare needs, emotional support and companionship, social interaction and community involvement, mental health support and cognitive stimulation, and access to community and family resources.

Older adults are categorized into stages:
• Young-old (60–74 years): Generally active, independent, and socially engaged
• Middle-old (75–84 years): May experience increased health limitations and require more assistance
• Old-old (85+ years): Often require significant support with physical, cognitive, and social needs

CNAs must support residents through these transitions with empathy, respect, and encouragement.', 1),

  (v_mod_id, 'Mental Status, Behavioral Changes, and Social Roles',
   'Changes in mental status and behavior may occur due to aging, illness, medication effects, or environmental factors. CNAs are often the first to notice these changes and must report them promptly to the supervising nurse.

Common mental and behavioral changes include:
• Confusion or disorientation
• Memory loss or difficulty concentrating
• Mood changes such as depression, anxiety, or irritability
• Withdrawal from social activities
• Changes in sleep patterns or appetite

External factors that may also impact mental health include reduced income or financial stress, limited social interaction or isolation, chronic illness or pain, and loss of independence or mobility.

Aging involves important developmental tasks including adjusting to retirement and changes in income, coping with physical changes and declining health, adapting to loss of friends, family members, or spouse, maintaining independence while accepting needed assistance, and finding meaning and purpose in later life.

Older adults continue to play valuable roles within families, communities, and cultural groups. Key considerations include cultural and religious beliefs that may influence healthcare decisions and end-of-life care, changing family dynamics as older adults may transition from caregivers to care recipients, housing options as needs change, and retirement providing opportunities for hobbies, volunteering, and community involvement.

CNAs must respect cultural, spiritual, and social values while supporting residents'' continued participation in meaningful activities. Observing, documenting, and reporting mental and behavioral changes ensures residents receive appropriate care and support.', 2);

  UPDATE modules SET lessons_count = 2 WHERE id = v_mod_id;


  -- ─────────────────────────────────────────────────────────────
  -- MODULE 4 · Demonstrates Effective Communication
  -- ─────────────────────────────────────────────────────────────
  IF NOT EXISTS (SELECT 1 FROM modules WHERE order_num = 4) THEN
    INSERT INTO modules (title, description, order_num, is_published)
    VALUES ('Demonstrates Effective Communication',
            'Master verbal and nonverbal communication, medical terminology, active listening, therapeutic communication, chain of command, and conflict management in healthcare.',
            4, true)
    RETURNING id INTO v_mod_id;
  ELSE
    SELECT id INTO v_mod_id FROM modules WHERE order_num = 4;
    UPDATE modules SET
      title = 'Demonstrates Effective Communication',
      description = 'Master verbal and nonverbal communication, medical terminology, active listening, therapeutic communication, chain of command, and conflict management in healthcare.',
      is_published = true
    WHERE id = v_mod_id;
  END IF;

  DELETE FROM lessons WHERE module_id = v_mod_id;

  INSERT INTO lessons (module_id, title, content, order_num) VALUES
  (v_mod_id, 'Verbal and Nonverbal Communication',
   'Effective communication is a critical component of safe, accurate, and compassionate care. CNAs are responsible for conveying information clearly, listening actively, and ensuring that all communication supports resident dignity, safety, and well-being.

Effective communication includes both verbal and nonverbal methods:
• Verbal communication: spoken words used with residents, families, and staff
• Nonverbal communication: body language, facial expressions, eye contact, and gestures
• Written communication: documentation in care records and reports

CNA students must use appropriate medical terminology and facility-approved abbreviations. They should communicate clearly when documenting or reporting resident information, avoid using slang or unapproved abbreviations that may cause confusion, and ensure accuracy when describing symptoms, behaviors, or changes in condition.

When communicating with members of the healthcare team, CNAs should report observations, changes in condition, and concerns to the supervising nurse, follow the chain of command when communicating information, share relevant and accurate information in a timely manner, and collaborate respectfully with nurses, therapists, and other healthcare staff. CNAs do not diagnose or interpret medical conditions — they report observations only.

When communicating with residents and family, CNA students should use clear, simple language, listen actively and respond respectfully to questions or concerns, maintain confidentiality and privacy at all times, demonstrate empathy, patience, and respect in all interactions, and provide information within the CNA scope of practice.', 1),

  (v_mod_id, 'Chain of Command, Therapeutic Communication, and Conflict Management',
   'The chain of command is the structured system used to report information in a healthcare setting. CNA students must report concerns first to the supervising nurse, follow facility policies for escalating urgent issues, and understand that proper communication flow ensures resident safety and accountability.

Effective communication techniques include:
• Active listening: giving full attention, making eye contact, providing feedback, and avoiding interruption
• Speaking calmly and respectfully at all times
• Using open-ended questions when appropriate to encourage detailed responses
• Clarifying information to avoid misunderstandings
• Documenting observations accurately and completely

When conflict arises, CNAs must remain calm and professional, avoid arguing or becoming defensive, focus on the resident''s needs and safety, report unresolved conflicts to the supervisor, and use respectful communication to de-escalate situations.

Barriers to communication that CNAs must recognize and address include language differences, hearing impairment, cognitive impairment, cultural differences, pain or illness affecting the resident''s ability to communicate, and emotional distress.

Key principles for effective CNA communication:
• Effective communication is essential for safe and quality care
• CNAs must use both verbal and nonverbal communication appropriately
• Accurate reporting using medical terminology and approved abbreviations is required
• Communication must follow the chain of command
• CNAs must communicate respectfully with residents, families, and healthcare staff at all times', 2);

  UPDATE modules SET lessons_count = 2 WHERE id = v_mod_id;


  -- ─────────────────────────────────────────────────────────────
  -- MODULE 5 · Maintains a Safe Environment
  -- ─────────────────────────────────────────────────────────────
  IF NOT EXISTS (SELECT 1 FROM modules WHERE order_num = 5) THEN
    INSERT INTO modules (title, description, order_num, is_published)
    VALUES ('Maintains a Safe Environment for the Resident and Others',
            'Learn to identify safety hazards, follow emergency procedures, use safety equipment, and apply fall prevention and restraint alternatives to protect residents and staff.',
            5, true)
    RETURNING id INTO v_mod_id;
  ELSE
    SELECT id INTO v_mod_id FROM modules WHERE order_num = 5;
    UPDATE modules SET
      title = 'Maintains a Safe Environment for the Resident and Others',
      description = 'Learn to identify safety hazards, follow emergency procedures, use safety equipment, and apply fall prevention and restraint alternatives to protect residents and staff.',
      is_published = true
    WHERE id = v_mod_id;
  END IF;

  DELETE FROM lessons WHERE module_id = v_mod_id;

  INSERT INTO lessons (module_id, title, content, order_num) VALUES
  (v_mod_id, 'Safety Principles and Risk Management',
   'Safety is a fundamental responsibility in healthcare settings and requires constant awareness, adherence to facility policies, and prompt action to prevent accidents and injuries. CNAs play a critical role in identifying risks, following established safety procedures, and responding appropriately to non-medical emergencies.

Key safety concepts:
• Safety: Actions and conditions that prevent injury or harm to residents, staff, and visitors
• Risk Management: Identifying, reporting, and reducing potential hazards to prevent accidents or injuries
• Accident/Incident Reporting: Proper documentation and reporting of any unexpected event, injury, or unsafe condition according to facility policy
• Safety Hazards: Anything in the environment that could cause harm, including wet floors, clutter, faulty equipment, or unsafe practices

CNA students are required to follow all facility safety policies, procedures, and emergency plans including:
• Safety/Risk Management Procedures — follow all protocols to prevent accidents and injuries
• Disaster Plans — understand facility procedures for natural disasters or emergencies
• Bomb Threat Procedures — follow facility instructions calmly and report suspicious activity
• Infection Control Procedures — follow hand hygiene and PPE guidelines
• Hazard Communication — recognize warning labels and safety signs
• Radiation Protection Measures — follow precautions when caring for residents receiving radiation
• Fire Plan — follow RACE procedure (Rescue, Alarm, Contain, Extinguish/Evacuate)
• Evacuation Plan — know all exits and evacuation routes and assist residents safely
• Toxic Chemical and SDS Protocols — understand Safety Data Sheets for hazardous materials
• Oxygen Usage Safety — recognize oxygen as a fire hazard; no smoking or open flames near oxygen

CNAs must always remain alert and report unsafe conditions immediately to the supervising nurse.', 1),

  (v_mod_id, 'Fall Prevention, Safety Equipment, and Restraint Alternatives',
   'Falls are one of the most common causes of injury in healthcare settings. CNAs play a critical role in preventing falls by identifying residents at risk, maintaining a safe environment, and using proper techniques and equipment.

Fall prevention strategies include:
• Keeping floors clear and dry
• Ensuring bed is in the lowest position with brakes locked
• Keeping call light within the resident''s reach at all times
• Using bed and chair alarms for at-risk residents
• Wearing proper non-slip footwear
• Responding promptly to call lights to prevent residents from getting up unassisted
• Assisting with toileting on a regular schedule to reduce urgency

Safety equipment CNAs must know how to use includes:
• Fire Extinguishers: Use the PASS method — Pull, Aim, Squeeze, Sweep
• Eye Wash Stations: Know location and proper use in case of chemical exposure
• Bed alarms and call lights to prevent falls
• Wheelchair brakes and safety straps
• Gait belts for mobility assistance and transfers

Restraints are devices or methods that limit a resident''s movement. Physical and chemical restraints are strictly regulated. Before using any restraint, a physician order is required. CNAs must understand that restraint alternatives should always be explored first, including repositioning, providing meaningful activities, monitoring for pain or discomfort, and addressing unmet needs that may be causing behaviors.

CNAs must report any safety hazard, incident, fall, or near-miss immediately to the supervising nurse and complete required incident reports according to facility policy.', 2);

  UPDATE modules SET lessons_count = 2 WHERE id = v_mod_id;


  -- ─────────────────────────────────────────────────────────────
  -- MODULE 6 · General Principles of Infection Control
  -- ─────────────────────────────────────────────────────────────
  IF NOT EXISTS (SELECT 1 FROM modules WHERE order_num = 6) THEN
    INSERT INTO modules (title, description, order_num, is_published)
    VALUES ('Demonstrates General Principles of Infection Control',
            'Understand microorganisms, the chain of infection, standard and transmission-based precautions, PPE use, hand hygiene, and aseptic practices.',
            6, true)
    RETURNING id INTO v_mod_id;
  ELSE
    SELECT id INTO v_mod_id FROM modules WHERE order_num = 6;
    UPDATE modules SET
      title = 'Demonstrates General Principles of Infection Control',
      description = 'Understand microorganisms, the chain of infection, standard and transmission-based precautions, PPE use, hand hygiene, and aseptic practices.',
      is_published = true
    WHERE id = v_mod_id;
  END IF;

  DELETE FROM lessons WHERE module_id = v_mod_id;

  INSERT INTO lessons (module_id, title, content, order_num) VALUES
  (v_mod_id, 'Chain of Infection and Modes of Transmission',
   'Infection prevention and control are essential responsibilities in all healthcare settings. CNAs play a key role in breaking the chain of infection by following standard precautions, recognizing signs of infection, and maintaining a clean and safe environment.

Key infection control concepts:
• Types of microbes: Bacteria, viruses, fungi, and parasites that can cause infection
• Infectious process: The progression of infection from exposure to illness
• Infection control: Practices used to prevent the spread of microorganisms
• Body substances: Blood, urine, feces, saliva, mucus, vomit, and other bodily fluids that may carry infection
• Biohazard waste: Any waste contaminated with infectious materials
• Exposure report: Documentation completed when staff or resident may have been exposed to infectious material

The Chain of Infection — breaking any link prevents infection spread:
• Source: Where the microorganism originates
• Reservoir: Where microorganisms live and multiply
• Portal of Exit: How microorganisms leave the reservoir (coughing, blood, bodily fluids)
• Method of Transmission: How infection spreads (direct contact, indirect contact, airborne, droplet, vector)
• Portal of Entry: How microorganisms enter a new host (mouth, nose, broken skin, eyes)
• Susceptible Host: A person at risk for infection due to weakened immunity or health conditions

Signs of infection CNAs must recognize:
Objective signs: Fever or elevated temperature, redness/swelling/warmth at a site, drainage or pus from wounds, foul odor, increased heart rate or respiratory rate
Subjective signs: Pain or tenderness, fatigue or weakness, general feeling of illness, changes in behavior or appetite, confusion (especially in older adults)', 1),

  (v_mod_id, 'Standard Precautions, PPE, and Aseptic Practices',
   'Standard Precautions are the minimum infection prevention practices all healthcare workers must follow. They assume that all blood, body fluids, non-intact skin, and mucous membranes may contain infectious microorganisms.

Key standard precaution practices:
• Perform proper hand hygiene before and after all patient contact
• Use appropriate PPE (gloves, gowns, masks, eye protection) whenever risk of exposure exists
• Handle equipment, linens, and waste safely
• Follow safe practices for sharps disposal
• Apply respiratory hygiene and cough etiquette
• Maintain a clean patient environment

Hand hygiene is the most important single practice for preventing infection. CNAs must wash hands with soap and water when hands are visibly soiled, before and after patient care, after removing gloves, before eating, and after using the restroom. Alcohol-based hand sanitizer may be used when hands are not visibly soiled.

PPE selection depends on the task and exposure risk:
• Gloves: Required when contacting blood, body fluids, or contaminated surfaces
• Gown: Required when clothing may be soiled
• Mask: Required for respiratory precautions or droplet exposure risk
• Eye protection: Required when splashing is possible

Aseptic measures reduce the spread of microorganisms:
• Medical (Clean) Asepsis: Practices that reduce the number of microorganisms, including hand hygiene, PPE, and cleaning procedures
• Disinfection: The process of killing most microorganisms on surfaces and equipment
• Surgical (Sterile) Asepsis: Practices that eliminate all microorganisms (used in wound care and invasive procedures)

Transmission-based precautions are used in addition to standard precautions for residents with known or suspected infections. Types include contact precautions, droplet precautions, and airborne precautions.', 2);

  UPDATE modules SET lessons_count = 2 WHERE id = v_mod_id;


  -- ─────────────────────────────────────────────────────────────
  -- MODULE 7 · Provides Basic Emergency Care
  -- ─────────────────────────────────────────────────────────────
  IF NOT EXISTS (SELECT 1 FROM modules WHERE order_num = 7) THEN
    INSERT INTO modules (title, description, order_num, is_published)
    VALUES ('Provides Basic Emergency Care',
            'Learn to recognize signs of medical emergencies, apply first-aid principles, respond to choking and cardiac emergencies, and communicate effectively during urgent situations.',
            7, true)
    RETURNING id INTO v_mod_id;
  ELSE
    SELECT id INTO v_mod_id FROM modules WHERE order_num = 7;
    UPDATE modules SET
      title = 'Provides Basic Emergency Care',
      description = 'Learn to recognize signs of medical emergencies, apply first-aid principles, respond to choking and cardiac emergencies, and communicate effectively during urgent situations.',
      is_published = true
    WHERE id = v_mod_id;
  END IF;

  DELETE FROM lessons WHERE module_id = v_mod_id;

  INSERT INTO lessons (module_id, title, content, order_num) VALUES
  (v_mod_id, 'Recognizing and Responding to Medical Emergencies',
   'CNAs are often the first to witness emergencies in healthcare settings. Prompt recognition and response can help protect life, prevent further injury, and support positive outcomes. Emergency care requires calm thinking, quick action within the CNA scope of practice, and immediate communication with the supervising nurse or emergency response team.

Goals of emergency care and first aid:
• Preserve life and prevent death
• Prevent the condition from becoming worse
• Promote recovery and comfort the resident
• Ensure safety of the resident, staff, and others
• Provide immediate support until medical help arrives

Signs of medical emergencies requiring immediate attention:
• Difficulty breathing, choking, or inability to speak
• Chest pain or pressure (possible heart attack)
• Sudden weakness, numbness, or facial drooping (possible stroke)
• Sudden confusion or change in mental status
• Loss of consciousness or unresponsiveness
• Severe bleeding that cannot be controlled
• Seizures or convulsions
• Severe allergic reactions (swelling, difficulty breathing, hives)
• Sudden fall with injury or suspected fracture
• Blue or pale skin color indicating lack of oxygen

CNAs must report all emergency signs immediately and activate emergency procedures according to facility policy. The primary response is always: call for help, stay with the resident, keep them calm, and do not leave them alone.

Key principles:
• The goals of emergency care are to preserve life, prevent harm, and support recovery
• CNAs must act quickly but stay within their scope of practice
• Immediate reporting and communication with the nurse are critical
• Following facility emergency procedures ensures a coordinated response', 1),

  (v_mod_id, 'Basic First Aid Principles',
   'First aid involves immediate, temporary care provided until full medical treatment is available. CNAs must always remain within their scope of practice and follow facility policies and procedures when responding to emergencies.

Basic First-Aid Principles:
• Ensure scene safety: Before providing care, assess the environment for hazards
• Assess the resident''s condition: Observe for responsiveness, breathing, bleeding, and signs of distress
• Call for help immediately: Activate the chain of command or emergency response system
• Provide appropriate care within scope of practice: Offer basic support such as comfort, reassurance, and positioning
• Prevent further injury: Avoid moving the resident unless there is immediate danger
• Maintain airway, breathing, and circulation awareness (ABC): Recognize life-threatening conditions
• Control bleeding when possible: Apply pressure if trained and permitted by facility policy
• Remain calm and reassure the resident: Provide emotional support to reduce fear and anxiety
• Do not perform procedures outside CNA scope: Avoid administering medications or invasive interventions
• Report and document accurately: Communicate observations clearly to the supervising nurse

Common emergency situations CNAs may encounter and their responses:
• Choking: Follow facility protocol and Heimlich maneuver procedures if trained
• Falls: Do not move the resident until assessed; call for help immediately
• Seizures: Protect from injury, do not restrain, turn to side if possible, call for help
• Bleeding: Apply direct pressure with clean cloth if trained and permitted; call for help
• Suspected stroke (FAST): Face drooping, Arm weakness, Speech difficulty, Time to call for help
• Cardiac arrest: Call for help immediately; be prepared to assist with CPR per facility protocol

Early recognition and reporting of emergencies can save lives.', 2);

  UPDATE modules SET lessons_count = 2 WHERE id = v_mod_id;


  -- ─────────────────────────────────────────────────────────────
  -- MODULE 8 · Applies Principles of Basic Nutrition
  -- ─────────────────────────────────────────────────────────────
  IF NOT EXISTS (SELECT 1 FROM modules WHERE order_num = 8) THEN
    INSERT INTO modules (title, description, order_num, is_published)
    VALUES ('Applies Principles of Basic Nutrition to Resident Care',
            'Understand essential nutrient groups, balanced diets, hydration, special dietary needs, and the CNA role in supporting resident nutrition and intake documentation.',
            8, true)
    RETURNING id INTO v_mod_id;
  ELSE
    SELECT id INTO v_mod_id FROM modules WHERE order_num = 8;
    UPDATE modules SET
      title = 'Applies Principles of Basic Nutrition to Resident Care',
      description = 'Understand essential nutrient groups, balanced diets, hydration, special dietary needs, and the CNA role in supporting resident nutrition and intake documentation.',
      is_published = true
    WHERE id = v_mod_id;
  END IF;

  DELETE FROM lessons WHERE module_id = v_mod_id;

  INSERT INTO lessons (module_id, title, content, order_num) VALUES
  (v_mod_id, 'Essential Nutrients and Balanced Nutrition',
   'Nutrition plays a critical role in maintaining energy, supporting body functions, preventing illness, and promoting recovery in residents across all age groups. CNAs assist residents in meeting nutritional needs by providing support with meals, monitoring intake, and reporting concerns related to appetite, weight changes, or dietary tolerance.

The six essential nutrient groups and their functions:
• Carbohydrates: Main source of energy for the body and brain. Found in grains, fruits, vegetables, and sugars.
• Fats: Provide long-term energy storage and support cell function. Help the body absorb certain vitamins.
• Proteins: Build and repair body tissues. Support muscle growth, healing, and immune function.
• Vitamins: Support metabolism and body processes. Help maintain healthy skin, bones, and immune system.
• Minerals: Support bone health, fluid balance, and nerve function. Examples: calcium, iron, and potassium.
• Water: Essential for hydration, circulation, digestion, and temperature regulation. Helps transport nutrients and remove waste.

Basic food groups (MyPlate model):
• Grains: Bread, rice, pasta, cereals (energy source)
• Vegetables: Leafy greens, carrots, broccoli (vitamins and minerals)
• Fruits: Apples, bananas, berries (vitamins, fiber, hydration)
• Protein foods: Meat, poultry, fish, beans, eggs, nuts (body building and repair)
• Dairy: Milk, cheese, yogurt (calcium and bone health)
• Fats and oils: Used in small amounts for energy and nutrient absorption

The body needs nutrients to provide energy for daily activities, support growth and tissue repair, maintain immune system function, regulate body processes such as digestion and temperature, support brain function and emotional well-being, and prevent malnutrition and disease.

Older adults may have increased nutritional needs due to illness, decreased appetite, or difficulty eating, making CNA support especially important. Any changes in appetite or intake must be reported to the nurse.', 1),

  (v_mod_id, 'Special Diets, Hydration, and Meal Assistance',
   'Many residents have specific dietary needs that CNAs must be aware of and follow. Dietary restrictions are ordered by the physician or dietitian and must be followed precisely. Common special diets include:

• Regular diet: No restrictions
• Soft diet: Foods that are easy to chew and swallow for residents with dental issues or mild swallowing difficulties
• Pureed diet: All foods blended to a smooth consistency for residents with significant swallowing problems
• Thickened liquids: Liquids thickened to honey or nectar consistency to prevent aspiration in residents with dysphagia
• Low-sodium diet: Reduced salt intake for residents with hypertension or heart disease
• Diabetic diet: Controlled carbohydrate and sugar intake for residents with diabetes
• Low-fat diet: Reduced fat intake for residents with heart disease or high cholesterol
• Fluid restriction: Limited fluid intake for residents with certain heart or kidney conditions
• NPO (Nothing by Mouth): No food or fluid by mouth, typically ordered before surgery or procedures

Hydration is essential for all residents. Signs of dehydration include dry mouth, decreased urine output, dark-colored urine, confusion, dizziness, and fatigue. CNAs should offer fluids regularly and encourage adequate hydration unless restricted.

CNA responsibilities during meal assistance:
• Check dietary card or care plan for dietary restrictions before serving
• Position the resident properly (upright at 90 degrees) to reduce aspiration risk
• Provide assistance with feeding as needed while promoting independence
• Monitor intake and record fluid and food amounts as required
• Report concerns about appetite, swallowing, or intake to the nurse
• Never rush a resident during meals

Serving sizes help ensure balanced nutrition. Example portions: 1 slice of bread or ½ cup cooked rice (grain), 1 cup raw or ½ cup cooked vegetables, 1 medium fruit, 3 ounces of meat or fish, 1 cup of milk or yogurt.', 2);

  UPDATE modules SET lessons_count = 2 WHERE id = v_mod_id;


  -- ─────────────────────────────────────────────────────────────
  -- MODULE 9 · Personal Care and Grooming
  -- ─────────────────────────────────────────────────────────────
  IF NOT EXISTS (SELECT 1 FROM modules WHERE order_num = 9) THEN
    INSERT INTO modules (title, description, order_num, is_published)
    VALUES ('Provides Personal Care and Grooming',
            'Provide safe and dignified bathing, oral care, perineal care, grooming assistance, and skin observation while promoting resident independence and respecting individual preferences.',
            9, true)
    RETURNING id INTO v_mod_id;
  ELSE
    SELECT id INTO v_mod_id FROM modules WHERE order_num = 9;
    UPDATE modules SET
      title = 'Provides Personal Care and Grooming',
      description = 'Provide safe and dignified bathing, oral care, perineal care, grooming assistance, and skin observation while promoting resident independence and respecting individual preferences.',
      is_published = true
    WHERE id = v_mod_id;
  END IF;

  DELETE FROM lessons WHERE module_id = v_mod_id;

  INSERT INTO lessons (module_id, title, content, order_num) VALUES
  (v_mod_id, 'Principles of Daily Hygiene and Grooming',
   'Personal hygiene is a basic human need that directly impacts physical health, emotional well-being, self-esteem, and social interaction. CNAs play a vital role in assisting residents with hygiene needs while promoting independence and respecting individual preferences.

Personal hygiene needs and practices vary based on individual factors:
• Culture: Cultural beliefs may influence bathing frequency, hair care, modesty, and grooming practices
• Personal Choice: Residents have the right to choose how and when they receive personal care whenever possible. Preferences for products, routines, and grooming styles should be respected.
• Economic Consideration: Access to hygiene products may vary; CNAs may need to provide support using facility-supplied resources

Why personal hygiene matters:
• Prevents infection and promotes skin integrity
• Reduces body odor and maintains cleanliness
• Improves comfort and physical well-being
• Enhances self-esteem and emotional health
• Promotes social interaction and dignity
• Allows early identification of skin or health problems

Principles of care CNAs must consistently apply:
• Promote resident independence, privacy, and dignity at all times
• Encourage residents to perform as much of their own care as possible
• Maintain professional behavior — respect personal space and follow facility policies regarding appropriate caregiver-resident interactions
• Support routines that enhance a resident''s sense of normalcy and well-being
• Provide care in a respectful, calm, and supportive manner

During personal care, CNAs must observe and report:
• Skin condition (redness, breakdown, bruising, dryness, wounds)
• Scalp condition (dryness, lice, irritation)
• Oral health (odor, sores, dentures condition)
• Hair condition (cleanliness, tangles, lice)
• Nail condition (length, cleanliness, signs of infection)

All abnormal findings must be reported promptly to the supervising nurse.', 1),

  (v_mod_id, 'Bathing, Oral Care, Perineal Care, and Grooming Procedures',
   'Bathing helps remove dirt and microbes, promotes circulation, prevents skin breakdown, and provides an opportunity to observe the resident''s skin condition. CNAs must provide privacy, maintain dignity, and use appropriate water temperature during all bathing procedures.

Types of baths:
• Complete bed bath: For residents who cannot get out of bed
• Partial bed bath: Focuses on face, hands, underarms, and perineal area
• Tub bath or shower: For residents who can be safely transferred
• Sponge bath: Gentle option for fragile residents

During bathing, CNAs should:
• Check water temperature before starting (test with wrist or thermometer)
• Expose only the area being washed and cover all other areas
• Use clean technique and change water as needed
• Observe skin for any redness, breakdown, or abnormalities

Oral care prevents dental disease, infection, bad breath, and aspiration pneumonia. All residents require oral care at least twice daily. Special care is required for unconscious residents to prevent aspiration — use a small amount of solution and position the head to the side.

Perineal care must always be performed front to back to prevent urinary tract infections. Gloves must be worn, and privacy must be maintained throughout the procedure.

Hair care supports dignity and emotional well-being. CNAs should comb/brush hair gently, respect cultural preferences, and wash hair as scheduled or per resident preference.

Foot and nail care:
• Inspect feet and nails at each care session
• Soak feet if ordered and dry thoroughly between toes
• Report abnormalities — do not cut nails without specific order, especially for diabetic residents

Shaving: Use an electric or safety razor as directed, shave in the direction of hair growth, and report any skin irritation or cuts to the nurse.', 2);

  UPDATE modules SET lessons_count = 2 WHERE id = v_mod_id;


  -- ─────────────────────────────────────────────────────────────
  -- MODULE 10 · Measures Vital Signs
  -- ─────────────────────────────────────────────────────────────
  IF NOT EXISTS (SELECT 1 FROM modules WHERE order_num = 10) THEN
    INSERT INTO modules (title, description, order_num, is_published)
    VALUES ('Measures Vital Signs',
            'Learn to accurately measure and record temperature, pulse, blood pressure, respirations, and oxygen saturation, and recognize normal ranges and age-related variations.',
            10, true)
    RETURNING id INTO v_mod_id;
  ELSE
    SELECT id INTO v_mod_id FROM modules WHERE order_num = 10;
    UPDATE modules SET
      title = 'Measures Vital Signs',
      description = 'Learn to accurately measure and record temperature, pulse, blood pressure, respirations, and oxygen saturation, and recognize normal ranges and age-related variations.',
      is_published = true
    WHERE id = v_mod_id;
  END IF;

  DELETE FROM lessons WHERE module_id = v_mod_id;

  INSERT INTO lessons (module_id, title, content, order_num) VALUES
  (v_mod_id, 'Normal Vital Sign Values and Age-Related Variations',
   'Vital signs are essential indicators of a resident''s basic body function and overall health status. They provide important information about changes in condition and help the healthcare team identify when further assessment or intervention may be needed. CNAs are responsible for obtaining vital signs correctly, using proper technique and equipment, and reporting any abnormal findings promptly to the supervising nurse.

Normal vital sign ranges for adults:

Temperature:
• Oral temperature: Typically 97.6°F to 99.6°F
• Rectal temperature: Typically 0.5°F to 1.0°F higher than oral
• Tympanic (ear) temperature: Approximately 97.6°F to 99.6°F
• Rectal temperatures are generally higher and used when more accurate core temperature readings are needed

Pulse:
• Adults: Typically 60 to 100 beats per minute
• Pulse may be influenced by activity, emotions, medications, and health conditions
• Tachycardia (too fast) or bradycardia (too slow) must be reported

Respiratory Rate:
• Adults: Typically 12 to 20 breaths per minute
• Breathing should be regular, unlabored, and quiet
• Abnormal breathing patterns must be reported immediately

Blood Pressure:
• Normal adult range: Approximately 90/60 mmHg to 120/80 mmHg
• High blood pressure (hypertension) or low blood pressure (hypotension) must be reported

Oxygen Saturation:
• Normal adult range: 95–100%
• Measured using a pulse oximeter placed on the finger
• Values below 95% should be reported to the nurse

Key concepts:
• Normal ranges may vary based on age, condition, and individual factors
• CNAs must measure vital signs accurately using correct technique and equipment
• Any abnormal findings must be reported immediately
• Consistent monitoring helps detect early changes in a resident''s condition
• Accuracy, attention to detail, and proper documentation are essential responsibilities', 1),

  (v_mod_id, 'Measuring and Recording Body Temperature, Pulse, Respirations, and Blood Pressure',
   'Body temperature measurement:

Purpose: Used to assess overall health status, detect fever or infection, monitor changes in condition, evaluate response to treatment, and provide baseline data.

Factors that affect body temperature: Age (older adults may have lower baseline temperatures), time of day (lower in morning, higher in evening), physical activity, medications, and illness.

Types of thermometers used: Oral, rectal, tympanic (ear), axillary (armpit), and temporal artery (forehead).

Steps for taking oral temperature: Wash hands, apply gloves, place thermometer under tongue and ask resident to close lips, wait for signal, read and record result, clean/discard thermometer per policy.

Pulse measurement:

The radial pulse (wrist) is the most common site for routine pulse measurement. The carotid pulse (neck) may be used during emergency assessment. CNAs count beats for 30 seconds and multiply by 2 (or count for 60 seconds for irregular rhythms).

Characteristics to report: Rate, rhythm (regular or irregular), and strength (strong or weak).

Respirations:

Count breaths for 30 seconds and multiply by 2. Observe for rate, depth, and rhythm. Abnormal patterns such as labored breathing, shallow breathing, or irregular rhythm must be reported immediately.

Blood pressure measurement:

Use a properly sized cuff and a sphygmomanometer (manual or electronic). Position the resident with arm supported at heart level. The systolic pressure (top number) represents pressure when heart contracts; the diastolic pressure (bottom number) represents pressure when heart relaxes.

Documentation: All vital signs must be recorded immediately after measurement. Compare results to the resident''s baseline and previous readings. Report all abnormal findings to the supervising nurse without delay.', 2);

  UPDATE modules SET lessons_count = 2 WHERE id = v_mod_id;


  -- ─────────────────────────────────────────────────────────────
  -- MODULE 11 · Safe Transfers, Positioning, and Turning
  -- ─────────────────────────────────────────────────────────────
  IF NOT EXISTS (SELECT 1 FROM modules WHERE order_num = 11) THEN
    INSERT INTO modules (title, description, order_num, is_published)
    VALUES ('Demonstrates Safe Transfers, Positioning, and Turning',
            'Understand and apply safe body mechanics, resident transfer techniques, positioning, turning, range of motion, and prevention of complications related to limited mobility.',
            11, true)
    RETURNING id INTO v_mod_id;
  ELSE
    SELECT id INTO v_mod_id FROM modules WHERE order_num = 11;
    UPDATE modules SET
      title = 'Demonstrates Safe Transfers, Positioning, and Turning',
      description = 'Understand and apply safe body mechanics, resident transfer techniques, positioning, turning, range of motion, and prevention of complications related to limited mobility.',
      is_published = true
    WHERE id = v_mod_id;
  END IF;

  DELETE FROM lessons WHERE module_id = v_mod_id;

  INSERT INTO lessons (module_id, title, content, order_num) VALUES
  (v_mod_id, 'Safe Body Mechanics Principles',
   'Proper body mechanics are essential for preventing injury to both the resident and the CNA, maintaining safety during transfers, positioning, lifting, and turning activities. CNAs must apply these principles consistently in all care situations.

Basic principles of body mechanics:
• Maintain a wide base of support with feet shoulder-width apart
• Keep the center of gravity low by bending at the knees, not the waist
• Keep the back straight and aligned while performing care
• Lift using leg muscles rather than back muscles
• Keep objects and residents close to the body when lifting or moving
• Avoid twisting the body; instead, pivot with the feet
• Face the direction of movement when possible
• Use assistive devices and ask for help when needed

Techniques for safe body mechanics:
• Adjust bed height to a comfortable working level before beginning care
• Lock wheels on beds, wheelchairs, and stretchers before transfers
• Use proper hand placement and secure grips when assisting residents
• Coordinate movements with the resident and other caregivers when performing team lifts
• Encourage resident participation to the greatest extent possible
• Use gait belts and mechanical lifts according to facility policy
• Maintain proper posture throughout the procedure to prevent strain or injury

Unsafe body mechanics to avoid:
• Bending at the waist instead of the knees
• Twisting the back while lifting or moving a resident
• Reaching too far without moving the feet
• Lifting heavy objects or residents without assistance
• Failing to lock wheels before transfers
• Holding residents away from the body while lifting
• Poor posture that increases risk of strain or injury

Improper body mechanics can result in injury to the CNA, discomfort or harm to the resident, and unsafe care outcomes. Proper body mechanics help reduce fatigue, prevent musculoskeletal injury, and ensure resident safety.', 1),

  (v_mod_id, 'Effects of Limited Mobility and Positioning Techniques',
   'Limited mobility can significantly impact multiple body systems and increase the risk of complications if preventive care is not provided consistently. CNAs play a key role in maintaining resident comfort, promoting movement, and preventing avoidable decline.

Effects of limited mobility on the body:
• Decreased muscle strength and muscle wasting (atrophy)
• Joint stiffness and reduced range of motion
• Decreased circulation, increasing risk of blood clots (DVT)
• Reduced lung expansion, increasing risk of pneumonia
• Decreased appetite and digestive function
• Increased risk of pressure injuries (bedsores/pressure ulcers)
• Loss of independence and decreased ability to perform activities of daily living

Positioning principles:
• Change position at least every 2 hours to prevent pressure injuries
• Use pillows and positioning devices to maintain proper body alignment
• Keep bony prominences (heels, sacrum, hips, shoulders) off the bed surface
• Document position changes per facility policy

Common positions:
• Supine (flat on back): Use pillows under knees and heels off the mattress
• Lateral (on side): Support back and between knees with pillows
• Fowler''s (head of bed raised 45–60°): Used for eating, breathing difficulties
• Semi-Fowler''s (head of bed raised 30°): Reduces pressure and supports breathing
• Prone (on stomach): Use only as directed; rarely used in long-term care

Range of motion (ROM) exercises help maintain joint flexibility and prevent contractures. Passive ROM is performed by the CNA when the resident cannot move independently. Active ROM is performed by the resident themselves. Active-assistive ROM is performed with the resident''s participation.

Pressure injury prevention:
• Inspect skin during every repositioning turn
• Report any redness, skin breakdown, or changes to the nurse immediately
• Keep skin clean and dry
• Use pressure-reducing mattresses and positioning devices as ordered', 2);

  UPDATE modules SET lessons_count = 2 WHERE id = v_mod_id;


  -- ─────────────────────────────────────────────────────────────
  -- MODULE 12 · Cares for Cognitively Impaired Residents
  -- ─────────────────────────────────────────────────────────────
  IF NOT EXISTS (SELECT 1 FROM modules WHERE order_num = 12) THEN
    INSERT INTO modules (title, description, order_num, is_published)
    VALUES ('Cares for Cognitively Impaired Residents',
            'Learn to identify types of cognitive impairment, understand dementia and delirium, use effective communication strategies, and provide safe person-centered care for cognitively impaired residents.',
            12, true)
    RETURNING id INTO v_mod_id;
  ELSE
    SELECT id INTO v_mod_id FROM modules WHERE order_num = 12;
    UPDATE modules SET
      title = 'Cares for Cognitively Impaired Residents',
      description = 'Learn to identify types of cognitive impairment, understand dementia and delirium, use effective communication strategies, and provide safe person-centered care for cognitively impaired residents.',
      is_published = true
    WHERE id = v_mod_id;
  END IF;

  DELETE FROM lessons WHERE module_id = v_mod_id;

  INSERT INTO lessons (module_id, title, content, order_num) VALUES
  (v_mod_id, 'Types of Cognitive Impairment and Their Effects',
   'Caring for residents with cognitive impairment requires patience, understanding, and specialized communication skills. Cognitive impairment can affect memory, judgment, communication, and the ability to perform daily activities, making consistent, person-centered care essential.

Types of cognitive impairment:
• Dementia: A chronic, progressive decline in memory, thinking, and reasoning
• Delirium: A sudden, often reversible change in mental status caused by an underlying medical condition
• Varying levels of consciousness: Changes in alertness that may affect awareness and responsiveness

Effects of cognitive impairment on Activities of Daily Living (ADLs):
• Difficulty remembering how to complete tasks (bathing, dressing, eating)
• Poor judgment or unsafe decision-making
• Loss of problem-solving ability
• Communication challenges, including word-finding difficulty
• Reduced attention span and concentration
• Increased dependence on caregivers for basic needs

CNAs must provide guidance and assistance while encouraging independence whenever possible.

Common diseases that cause dementia (non-reversible):
• Alzheimer''s disease (most common)
• Lewy body dementia
• Parkinson''s disease
• Vascular dementia
• Frontotemporal dementia

These conditions are generally irreversible and progressively affect memory, behavior, and cognitive function.

Illness and health issues that cause delirium (reversible causes):
• Medication side effects or interactions
• Poor nutrition or dehydration (including alcohol misuse or withdrawal)
• Fever, infections, or anemia
• Emotional stress, depression, grief, or fatigue
• Injury, surgery, or hospitalization

Early identification and reporting of delirium symptoms are critical for resident recovery. Environmental factors that contribute to cognitive changes include unfamiliar environments, clutter, lack of environmental cues (clocks, calendars), overstimulation (noise, crowds), understimulation (isolation, boredom), and disruption of routine.', 1),

  (v_mod_id, 'Communication Strategies and Person-Centered Care for Cognitive Impairment',
   'Residents with cognitive impairment require individualized care that addresses physical, emotional, social, and safety needs. CNAs must use specialized communication strategies and create supportive environments.

Unique needs of residents with cognitive impairment:
• Communication support: Simple, clear, and calm communication
• ADL assistance: Step-by-step guidance and encouragement
• Social interaction: Opportunities to reduce isolation
• Meaningful activities: Activities tailored to abilities and interests

Effective communication strategies:
• Approach calmly and from the front to avoid startling the resident
• Use the resident''s name and identify yourself at each interaction
• Speak slowly, clearly, and use short simple sentences
• Ask one question at a time; use yes/no questions when possible
• Use a gentle, reassuring tone of voice
• Allow extra time for the resident to process and respond
• Use touch appropriately to provide comfort and reassurance
• Avoid arguing, correcting, or challenging the resident''s statements — use validation and redirection instead
• Match your facial expression and body language to your words

Behavioral responses common in dementia and how to respond:
• Wandering: Ensure a safe environment, use door alarms, redirect with activity
• Agitation or combativeness: Identify triggers, remove stressors, use calming techniques
• Sundowning (increased confusion in the evening): Maintain routine, provide calm environment, increase lighting
• Repetitive behaviors or questions: Respond calmly each time, do not show frustration
• Paranoia or accusations: Do not argue; redirect and reassure

Safety priorities for cognitively impaired residents:
• Remove or secure hazardous items from the environment
• Ensure identification bands are worn at all times
• Monitor for elopement risk and follow facility protocols
• Keep environment simple, familiar, and structured
• Report all behavioral changes immediately to the nurse', 2);

  UPDATE modules SET lessons_count = 2 WHERE id = v_mod_id;


  -- ─────────────────────────────────────────────────────────────
  -- MODULE 13 · Identifies Body Systems and Normal Aging Changes
  -- ─────────────────────────────────────────────────────────────
  IF NOT EXISTS (SELECT 1 FROM modules WHERE order_num = 13) THEN
    INSERT INTO modules (title, description, order_num, is_published)
    VALUES ('Identifies Function, Structure, and Normal Aging Changes of Body Systems',
            'Understand key anatomical terms, body organization, tissue types, major body systems, common health problems, and the normal aging changes CNAs must recognize and report.',
            13, true)
    RETURNING id INTO v_mod_id;
  ELSE
    SELECT id INTO v_mod_id FROM modules WHERE order_num = 13;
    UPDATE modules SET
      title = 'Identifies Function, Structure, and Normal Aging Changes of Body Systems',
      description = 'Understand key anatomical terms, body organization, tissue types, major body systems, common health problems, and the normal aging changes CNAs must recognize and report.',
      is_published = true
    WHERE id = v_mod_id;
  END IF;

  DELETE FROM lessons WHERE module_id = v_mod_id;

  INSERT INTO lessons (module_id, title, content, order_num) VALUES
  (v_mod_id, 'Body Organization, Anatomical Terms, and Tissue Types',
   'Understanding the human body is essential for CNAs in providing safe, accurate, and effective care. Knowledge of body systems, organs, tissues, and how they function helps CNAs recognize normal aging changes, identify potential health concerns, and report observations appropriately to the healthcare team.

Key anatomical terms:
• Anatomy: The study of body structure and the relationship between body parts
• Physiology: The study of how body systems and organs function
• Cells: The smallest living units of the body
• Tissues: Groups of similar cells that perform a specific function
• Organs: Structures made up of different tissues that perform specific functions
• Body systems: Groups of organs that work together to perform major body functions (e.g., respiratory, cardiovascular, nervous systems)

The four main types of tissue in the human body:
• Epithelial Tissue: Covers body surfaces, lines organs and cavities, and forms glands. Protects the body and helps with absorption and secretion.
• Connective Tissue: Supports, binds, and connects other tissues and organs. Examples include bone, blood, cartilage, fat, and ligaments.
• Muscle Tissue: Responsible for movement. Includes skeletal muscle (voluntary movement), smooth muscle (involuntary movement in organs), and cardiac muscle (heart function).
• Nervous Tissue: Transmits electrical signals throughout the body. Controls communication between the brain, spinal cord, and other body parts.

A basic understanding of body organization, anatomical terms, and tissue types provides the foundation for recognizing how the body functions and responding appropriately to changes in resident condition.', 1),

  (v_mod_id, 'Major Body Systems, Common Health Problems, and Normal Aging Changes',
   'CNAs must recognize the structure, function, common health problems, and normal aging changes of the major body systems in order to provide safe, informed, and effective care.

Respiratory System:
• Function: Supplies oxygen to the blood and removes carbon dioxide
• Key structures: Nose, pharynx, larynx, trachea, bronchi, alveoli, lungs, diaphragm
• Normal aging changes: Decreased lung elasticity, reduced lung capacity, weakened respiratory muscles, decreased cough reflex
• Common problems: Pneumonia, COPD, asthma, bronchitis, respiratory infections
• Signs to report: Difficulty breathing, abnormal sounds, changes in oxygen saturation, bluish skin

Cardiovascular System:
• Function: Circulates blood, oxygen, and nutrients throughout the body
• Normal aging changes: Decreased heart efficiency, thickening of vessel walls, reduced circulation
• Common problems: Heart failure, hypertension, coronary artery disease, peripheral vascular disease
• Signs to report: Chest pain, irregular pulse, swelling of feet and ankles, shortness of breath

Musculoskeletal System:
• Function: Provides movement, support, and protection
• Normal aging changes: Decreased muscle mass, reduced bone density (osteoporosis), joint stiffness
• Common problems: Fractures, arthritis, osteoporosis, contractures
• Signs to report: Pain, swelling, limited range of motion, falls

Nervous System:
• Function: Controls and coordinates all body functions
• Normal aging changes: Slowed reflexes, decreased sensory perception, memory changes
• Common problems: Stroke, Parkinson''s disease, dementia, peripheral neuropathy
• Signs to report: Sudden weakness, facial drooping, confusion, changes in speech or coordination

Integumentary System (Skin):
• Function: Protects body, regulates temperature, provides sensation
• Normal aging changes: Skin becomes thinner, drier, and more fragile; decreased elasticity and healing ability
• Common problems: Pressure injuries, skin tears, infections, rashes
• Signs to report: Redness, breakdown, bruising, wounds

Additional systems CNAs must understand: Endocrine (diabetes, thyroid issues), Digestive (bowel changes, constipation), Urinary (incontinence, UTI, kidney disease), and Reproductive systems and their age-related changes.', 2);

  UPDATE modules SET lessons_count = 2 WHERE id = v_mod_id;


  -- ─────────────────────────────────────────────────────────────
  -- MODULE 14 · Provides for Comfort and Rest
  -- ─────────────────────────────────────────────────────────────
  IF NOT EXISTS (SELECT 1 FROM modules WHERE order_num = 14) THEN
    INSERT INTO modules (title, description, order_num, is_published)
    VALUES ('Provides for Comfort and Rest',
            'Learn to gather data on resident comfort and pain levels, recognize verbal and non-verbal signs of discomfort, apply basic comfort measures, and understand sleep and rest needs.',
            14, true)
    RETURNING id INTO v_mod_id;
  ELSE
    SELECT id INTO v_mod_id FROM modules WHERE order_num = 14;
    UPDATE modules SET
      title = 'Provides for Comfort and Rest',
      description = 'Learn to gather data on resident comfort and pain levels, recognize verbal and non-verbal signs of discomfort, apply basic comfort measures, and understand sleep and rest needs.',
      is_published = true
    WHERE id = v_mod_id;
  END IF;

  DELETE FROM lessons WHERE module_id = v_mod_id;

  INSERT INTO lessons (module_id, title, content, order_num) VALUES
  (v_mod_id, 'Identifying and Observing Resident Comfort and Pain',
   'Providing comfort and promoting rest are essential responsibilities of the nursing assistant. Residents may experience discomfort or pain for many reasons, including illness, injury, chronic conditions, or emotional stress. CNAs play a vital role in observing, identifying, and reporting changes in a resident''s level of comfort.

CNA scope of practice in comfort observation:
• Observe residents during all care interactions
• Ask simple, appropriate questions about comfort when permitted
• Report all findings accurately to the licensed nurse
• Document observations according to facility policy

CNAs do not diagnose pain or determine medical treatment — they observe and report.

Why assessing comfort at every contact matters:
• Pain or discomfort may change quickly
• Early identification prevents complications
• Residents may not always verbally report pain
• It ensures individualized and safe care
• It supports accurate communication within the healthcare team

Barriers to resident comfort:
• Pain or injury
• Illness or chronic conditions
• Poor positioning or immobility
• Environmental factors (noise, temperature, lighting)
• Emotional distress (anxiety, fear, loneliness)
• Inadequate rest or sleep disruption
• Unmet basic needs (hunger, thirst, toileting needs)

Types of pain:
• Acute pain: Sudden, short-term pain often related to injury or illness
• Chronic pain: Ongoing pain that may last for months or longer

Non-verbal expressions of discomfort or pain CNAs must observe:
• Grimacing or facial tension
• Guarding or protecting a body part
• Restlessness or agitation
• Moaning, groaning, or crying
• Increased heart rate or breathing changes
• Refusal to move or participate in care
• Changes in behavior or appetite

Pain and comfort assessment scales:
• Numerical rating scales (0–10 pain scale)
• Facial expression scales
• Behavioral tools such as PAINAD (Pain Assessment in Advanced Dementia)
CNAs may assist in observing and reporting responses based on these tools but do not interpret clinical results independently.', 1),

  (v_mod_id, 'Basic Comfort Measures and Promoting Rest',
   'CNAs implement basic comfort measures within their scope of practice to reduce discomfort and promote rest and relaxation for residents.

Basic comfort measures CNAs can provide:
• Proper positioning and repositioning
• Providing warmth with blankets or adjusting room temperature
• Reducing noise and dimming lights when appropriate
• Offering back massage or relaxation techniques as permitted
• Assisting with oral hygiene to promote freshness
• Ensuring the resident is clean and dry
• Responding promptly to call lights
• Providing emotional support, presence, and reassurance
• Offering beverages or snacks if permitted and appropriate

Promoting rest and sleep:
Sleep is essential for healing, recovery, and overall well-being. CNAs support rest by minimizing unnecessary interruptions during sleep hours, keeping the environment quiet and comfortable, assisting the resident to a comfortable position before bed, completing care tasks at appropriate times to protect sleep, and reporting sleep disturbances to the nurse.

Common factors that disrupt sleep in residents:
• Pain or discomfort
• Frequent toileting needs
• Anxiety or depression
• Medication effects
• Environmental noise or lighting
• Illness or hospitalization

Comfort during bedmaking:
• Change linens regularly and keep bed free of wrinkles
• Ensure clean, dry, and wrinkle-free sheets to prevent pressure injury
• Use bed cradles if ordered to keep linens off the feet
• Always lower the bed to the lowest position after care is complete

Non-pharmacological comfort strategies (no medications required):
• Guided relaxation
• Calming music or familiar sounds
• Aromatherapy (if ordered and culturally appropriate)
• Gentle touch and presence
• Familiar objects or pictures in the room

Report any concerns about uncontrolled pain, persistent sleep disturbances, or changes in comfort level to the nurse immediately. All comfort measures and observations must be documented according to facility policy.', 2);

  UPDATE modules SET lessons_count = 2 WHERE id = v_mod_id;


  -- ─────────────────────────────────────────────────────────────
  -- MODULE 15 · Assists with Diagnostic Tests
  -- ─────────────────────────────────────────────────────────────
  IF NOT EXISTS (SELECT 1 FROM modules WHERE order_num = 15) THEN
    INSERT INTO modules (title, description, order_num, is_published)
    VALUES ('Assists with Diagnostic Tests',
            'Learn to properly collect, label, and transport specimens, provide pre- and post-procedure care, and accurately document and report diagnostic information to the nurse.',
            15, true)
    RETURNING id INTO v_mod_id;
  ELSE
    SELECT id INTO v_mod_id FROM modules WHERE order_num = 15;
    UPDATE modules SET
      title = 'Assists with Diagnostic Tests',
      description = 'Learn to properly collect, label, and transport specimens, provide pre- and post-procedure care, and accurately document and report diagnostic information to the nurse.',
      is_published = true
    WHERE id = v_mod_id;
  END IF;

  DELETE FROM lessons WHERE module_id = v_mod_id;

  INSERT INTO lessons (module_id, title, content, order_num) VALUES
  (v_mod_id, 'Specimen Collection and Handling',
   'Diagnostic testing helps the healthcare team identify health conditions, monitor treatment effectiveness, and make informed clinical decisions. CNAs assist with collecting and handling specimens used for laboratory testing. CNAs must follow strict procedures, maintain infection control standards, and ensure accurate labeling and timely delivery of specimens.

Types of specimens collected by nursing assistants:
• Urine specimens:
  - Routine urine samples
  - Clean-catch (midstream) specimens
  - 24-hour urine collections
  - Culture and sensitivity specimens
  - Sterile urine specimens (from Foley catheter)
• Stool (fecal) specimens from rectal collection, colostomy, or ileostomy output
• Sputum specimens
• Emesis (vomit) specimens

Collection, labeling, and transport of specimens:
• Perform hand hygiene and use standard precautions
• Explain the procedure clearly to the resident
• Collect the correct type of specimen as ordered
• Avoid contamination during collection
• Label the specimen immediately with the correct resident information (name, date, time, type of specimen)
• Send the specimen promptly to the laboratory or designated area

Accuracy in labeling and handling is essential to ensure correct test results and resident safety. Mislabeled or contaminated specimens can lead to incorrect diagnoses and treatment errors.

Additional testing procedures CNAs may assist with:
• Dipstick testing: Used to check urine for glucose, protein, or infection indicators
• Straining urine: Used to detect stones or sediment in urine
CNAs must always follow facility protocols and report results to the nurse.

Pre-procedure care: Explain the procedure to reduce anxiety, provide privacy, ensure proper positioning, gather necessary supplies.

Post-procedure care: Clean and assist the resident as needed, ensure comfort and safety, dispose of contaminated materials properly, perform hand hygiene, and report and document per facility policy.', 1),

  (v_mod_id, 'Documentation, Reporting, and Intake/Output Recording',
   'Accurate documentation and timely reporting are essential responsibilities of the CNA when assisting with diagnostic tests and specimen collection. Proper documentation ensures continuity of care, supports clinical decision-making, and helps the healthcare team monitor changes in a resident''s condition.

Documentation responsibilities:
• Record the type of specimen collected, date, and time
• Note any unusual findings or difficulties during collection
• Document resident response to the procedure
• Complete required facility forms accurately
• Report all results and observations to the supervising nurse promptly
• Never document information that was not directly observed or performed

Intake and Output (I&O) recording:
Many residents require monitoring of fluid intake and output. CNAs are responsible for accurately measuring and recording:
• All oral fluid intake (water, juice, soup, ice cream, gelatin)
• IV fluid intake (as directed)
• Urine output volume
• Emesis (vomit) volume
• Wound drainage (if applicable)
• Stool volume or frequency when ordered

Converting measurements: 1 ounce (oz) = 30 milliliters (mL). CNAs should be familiar with common container sizes used in their facility.

Signs of fluid imbalance to report:
• Decreased urine output or dark-colored urine (possible dehydration)
• Excessive thirst
• Swelling of hands, feet, or ankles (possible fluid overload)
• Sudden weight gain (may indicate fluid retention)
• Changes in breathing associated with fluid overload

Key documentation principles:
• Be accurate, objective, and factual — document only what you observe
• Record entries immediately after care is provided
• Use approved abbreviations only
• Never alter or falsify documentation
• If an error is made, follow facility policy for corrections

Reporting to the nurse is required for all abnormal findings, changes in condition, and any concerns identified during diagnostic procedures.', 2);

  UPDATE modules SET lessons_count = 2 WHERE id = v_mod_id;


  -- ─────────────────────────────────────────────────────────────
  -- MODULE 16 · Peri-Operative Care and Care for Special Needs
  -- ─────────────────────────────────────────────────────────────
  IF NOT EXISTS (SELECT 1 FROM modules WHERE order_num = 16) THEN
    INSERT INTO modules (title, description, order_num, is_published)
    VALUES ('Provides Care for the Peri-Operative and Special Needs Resident',
            'Learn to assist with pre-operative and post-operative care, provide physical and psychological preparation for surgery, recognize post-operative complications, and support residents with special needs.',
            16, true)
    RETURNING id INTO v_mod_id;
  ELSE
    SELECT id INTO v_mod_id FROM modules WHERE order_num = 16;
    UPDATE modules SET
      title = 'Provides Care for the Peri-Operative and Special Needs Resident',
      description = 'Learn to assist with pre-operative and post-operative care, provide physical and psychological preparation for surgery, recognize post-operative complications, and support residents with special needs.',
      is_published = true
    WHERE id = v_mod_id;
  END IF;

  DELETE FROM lessons WHERE module_id = v_mod_id;

  INSERT INTO lessons (module_id, title, content, order_num) VALUES
  (v_mod_id, 'Pre-Operative Care',
   'Peri-operative care refers to the care provided before, during, and after a surgical procedure. CNAs play an important supportive role in the pre-operative phase by assisting with both physical preparation and emotional support.

The preoperative period is the time before a surgical procedure begins. It includes all preparation activities that ensure the resident is physically and emotionally ready for surgery, focusing on safety, education, and preparation according to physician orders and facility policy.

Psychological preparation of the resident:
CNAs help reduce anxiety and promote comfort by:
• Listening carefully to the resident''s concerns and questions
• Providing reassurance within scope of practice
• Observing body language and non-verbal signs of anxiety, fear, or distress
• Reporting emotional concerns or significant anxiety to the nurse
• Maintaining a calm, respectful, and supportive presence
CNAs do not provide medical explanations of surgery but play a key role in emotional support and observation.

Physical preparation of the resident:
CNAs assist with physical preparation tasks including:
• Ensuring the resident has an identification band in place
• Observing and enforcing NPO (nothing by mouth) orders per facility policy
• Assisting with completion of surgical checklists (vital signs, last void time, required documentation)
• Removing water pitchers and food items as directed
• Assisting with bathing or showering to reduce infection risk
• Removing nail polish, makeup, and jewelry
• Securing and documenting resident valuables according to facility policy
• Assisting with surgical site preparation as directed by facility protocol
• Ensuring the resident is safe, comfortable, and properly positioned prior to transport

Pre-operative care is a critical responsibility that supports resident safety and surgical readiness. CNAs assist by preparing residents physically, providing emotional support, and ensuring all safety procedures are followed.', 1),

  (v_mod_id, 'Post-Operative Care',
   'Post-operative care refers to the care provided to a resident after a surgical procedure. CNAs play an important role in supporting recovery by ensuring safety, comfort, and careful observation for complications.

The post-operative period is the time after surgery when the resident is recovering from anesthesia and the surgical procedure. Close monitoring is required to ensure the resident is stable and recovering safely.

Preparation of the resident''s room:
Before the resident returns from surgery, the CNA may assist by:
• Preparing a surgical bed with clean linens and proper positioning for easy transfer
• Ensuring the bedside table contains necessary items (emesis basin, tissues)
• Setting up vital signs equipment for frequent monitoring
• Providing special equipment as required (oxygen setup, suction, or monitoring devices)
• Placing warmed blankets to maintain body temperature and comfort

Care of the resident after surgery:
• Properly identify the resident before providing care
• Assist with safe transfer from stretcher to bed using proper techniques
• Maintain airway safety and monitor breathing status
• Position the resident as ordered to promote comfort and drainage
• Observe for nausea or vomiting and provide emesis basin as needed
• Monitor and record vital signs as directed by the nurse
• Check the surgical site dressing for bleeding or drainage — do not remove dressings
• Monitor urinary output and record accurately
• Assist with pain reporting (ask the resident to describe pain level)
• Encourage deep breathing exercises as directed

Post-operative complications to observe and report immediately:
• Excessive bleeding or drainage from the surgical site
• Signs of infection (fever, increased redness, swelling, warmth, drainage)
• Difficulty breathing or oxygen saturation below normal range
• Sudden changes in vital signs
• Nausea, vomiting, or inability to tolerate fluids
• Signs of blood clots (leg swelling, pain, redness)
• Changes in mental status or level of consciousness
• Urinary retention (inability to void after surgery)

Report all changes in condition immediately to the supervising nurse and document per facility policy.', 2);

  UPDATE modules SET lessons_count = 2 WHERE id = v_mod_id;


  -- ─────────────────────────────────────────────────────────────
  -- MODULE 17 · Admission, Transfer, and Discharge
  -- ─────────────────────────────────────────────────────────────
  IF NOT EXISTS (SELECT 1 FROM modules WHERE order_num = 17) THEN
    INSERT INTO modules (title, description, order_num, is_published)
    VALUES ('Assists in Admission, Transfer, and Discharge of the Resident',
            'Learn to assist with resident admission procedures, room preparation, orientation, data collection, transfer between units, and safe and organized discharge processes.',
            17, true)
    RETURNING id INTO v_mod_id;
  ELSE
    SELECT id INTO v_mod_id FROM modules WHERE order_num = 17;
    UPDATE modules SET
      title = 'Assists in Admission, Transfer, and Discharge of the Resident',
      description = 'Learn to assist with resident admission procedures, room preparation, orientation, data collection, transfer between units, and safe and organized discharge processes.',
      is_published = true
    WHERE id = v_mod_id;
  END IF;

  DELETE FROM lessons WHERE module_id = v_mod_id;

  INSERT INTO lessons (module_id, title, content, order_num) VALUES
  (v_mod_id, 'Admitting a Resident to the Unit',
   'Admission, transfer, and discharge are important transitions in a resident''s healthcare experience. CNAs play a key role in helping residents feel safe, welcomed, and comfortable during these changes. CNAs must follow facility policies, maintain resident dignity, and communicate effectively with the healthcare team.

Preparation of the room before the resident arrives:
• Ensure the room is clean, organized, and safe
• Make the bed with clean linens and proper positioning
• Place necessary items within reach (call light, tissues, water if allowed, personal care items)
• Ensure privacy by closing curtains and doors as appropriate
• Check that equipment is functioning properly
A well-prepared room helps reduce anxiety and supports a smooth transition.

Greeting the resident and family:
• Greet the resident and family in a warm, respectful manner
• Introduce yourself and explain your role
• Offer assistance with settling in
• Demonstrate professionalism, kindness, and reassurance
This step builds trust and reduces anxiety during admission.

Orientation of the resident to their new environment:
• Explain the layout of the room and unit
• Show how to use the call light and explain its purpose
• Point out bathroom locations and safety features
• Introduce staff members when appropriate
• Review basic facility routines as directed

Assisting with data collection:
The CNA assists the nurse by gathering basic admission data including vital signs (temperature, pulse, respirations, blood pressure), height and weight measurements, and observations about the resident''s condition, mobility, and behavior. All information must be recorded accurately and reported promptly to the nurse.

Safety, comfort, and privacy measures:
• Ensure the resident is safely transferred and positioned
• Address comfort needs (pillows, blankets, positioning)
• Maintain privacy during all procedures
• Follow safety precautions (bed in low position, call light within reach, side rails per policy)

Personal item inventory:
• Document personal belongings brought by the resident
• Label items according to facility policy
• Ensure valuables are secured properly
• Report discrepancies or concerns to the nurse', 1),

  (v_mod_id, 'Transfer and Discharge Procedures',
   'Transfer and discharge are important care transitions that require careful preparation, communication, and attention to the resident''s physical and emotional needs.

Transfer of a resident refers to moving a resident from one unit, room, or facility to another. Transfer reasons may include a change in the resident''s condition requiring a higher or lower level of care, room reassignment, or transfer to a hospital or rehabilitation facility.

CNA responsibilities during transfer:
• Gather and organize the resident''s belongings
• Assist with packing personal items
• Transport the resident safely using appropriate equipment (wheelchair, stretcher)
• Provide emotional support and reassurance throughout the process
• Communicate all relevant care information to receiving staff
• Document the transfer per facility policy and report to the nurse

Discharge of a resident:
Discharge occurs when a resident leaves the facility to return home, move to another care setting, or for other reasons. Discharge requires coordination between the nurse, physician, social worker, and family.

CNA responsibilities during discharge:
• Assist with packing and organizing the resident''s belongings
• Ensure all personal items are returned (clothing, glasses, dentures, hearing aids, assistive devices)
• Assist the resident with dressing and preparing to leave
• Transport the resident to the discharge area safely
• Document discharge per facility policy

Discharge planning and education:
While CNAs do not provide discharge instructions (this is the nurse''s responsibility), they may reinforce simple care concepts and report any resident questions or concerns to the nurse.

Follow-up: Document any observations or concerns from the discharge process and report to the supervising nurse. Ensure the room is cleaned and prepared for the next resident according to facility policy.

Throughout all transitions — admission, transfer, and discharge — the CNA''s primary responsibilities are maintaining resident safety and dignity, communicating clearly with the healthcare team, and documenting accurately and promptly.', 2);

  UPDATE modules SET lessons_count = 2 WHERE id = v_mod_id;


  -- ─────────────────────────────────────────────────────────────
  -- MODULE 18 · Care for Residents and Family When Death is Imminent
  -- ─────────────────────────────────────────────────────────────
  IF NOT EXISTS (SELECT 1 FROM modules WHERE order_num = 18) THEN
    INSERT INTO modules (title, description, order_num, is_published)
    VALUES ('Provides Care for Residents and Family When Death is Imminent',
            'Understand end-of-life care principles, stages of dying, cultural and spiritual considerations, hospice care, post-mortem care, and how to support residents and families with compassion and dignity.',
            18, true)
    RETURNING id INTO v_mod_id;
  ELSE
    SELECT id INTO v_mod_id FROM modules WHERE order_num = 18;
    UPDATE modules SET
      title = 'Provides Care for Residents and Family When Death is Imminent',
      description = 'Understand end-of-life care principles, stages of dying, cultural and spiritual considerations, hospice care, post-mortem care, and how to support residents and families with compassion and dignity.',
      is_published = true
    WHERE id = v_mod_id;
  END IF;

  DELETE FROM lessons WHERE module_id = v_mod_id;

  INSERT INTO lessons (module_id, title, content, order_num) VALUES
  (v_mod_id, 'Principles of Caring for Dying Residents and Their Families',
   'Caring for residents and their families during the end-of-life process requires compassion, sensitivity, and professionalism. CNAs play a vital role in providing comfort, dignity, and emotional support when death is near. This care focuses on respecting the resident''s wishes, supporting family members, and maintaining a peaceful environment.

Attitudes and beliefs about death:
People respond to death and dying in different ways based on personal, cultural, spiritual, and emotional beliefs. CNAs must provide respectful and nonjudgmental care regardless of individual perspectives.

Common situations CNAs encounter:
• Sudden death: An unexpected death that may cause shock, confusion, and intense emotional distress for family members and caregivers. CNAs must remain calm, supportive, and respectful while following facility procedures.
• Terminal illness and expected death: A gradual decline where death is anticipated, allowing time for emotional preparation, planning, and support.

Stages of the dying process (Kübler-Ross model):
Many individuals experiencing terminal illness may go through emotional stages as they come to terms with death. These stages may occur in different orders and may be revisited multiple times.
• Denial: Refusing to accept the reality of impending death
• Anger: Feelings of frustration, resentment, or questioning "why me"
• Bargaining: Attempting to negotiate or make promises in hopes of delaying death
• Depression: Deep sadness, withdrawal, and grief over loss
• Acceptance: Coming to terms with death and finding peace

CNAs should understand that not every resident will experience all stages, and emotional responses may vary widely.

Physical signs of approaching death CNAs must observe and report:
• Decreased responsiveness or loss of consciousness
• Changes in breathing (irregular, labored, or periods of no breathing — Cheyne-Stokes respirations)
• Changes in skin color (mottling, pallor, cyanosis)
• Decreased blood pressure and irregular pulse
• Decreased urine output
• Cooling and discoloration of extremities
• Loss of bowel and bladder control
• Difficulty swallowing
All physical changes must be reported to the nurse immediately.', 1),

  (v_mod_id, 'Cultural Sensitivity, Hospice Care, and Post-Mortem Care',
   'End-of-life care requires compassion, respect, and cultural sensitivity. CNAs must support dying residents and their families by providing comfort, maintaining dignity, and honoring spiritual and cultural preferences.

Cultural and spiritual influences:
Cultural and spiritual beliefs significantly influence how individuals experience death and dying. CNAs must:
• Recognize and respect that beliefs about death vary widely
• Respect rituals, prayers, or spiritual practices important to the resident and family
• Support family involvement in culturally appropriate ways
• Avoid judgment or personal bias regarding beliefs and practices

Maintaining resident dignity:
• Provide privacy during care and family visits
• Ensure the resident is clean, comfortable, and properly positioned
• Speak respectfully and calmly to the resident and family
• Honor personal preferences whenever possible
• Avoid unnecessary exposure or disruption during care

CNA role in hospice care:
When a resident is receiving hospice care, the CNA''s role includes:
• Providing comfort-focused care rather than curative treatment
• Assisting with personal care such as bathing, oral hygiene, and repositioning
• Observing and reporting changes in condition or comfort
• Supporting pain relief measures as directed by the nurse
• Offering emotional presence and reassurance to the resident and family

Emotional support for families:
• Allow family members to be present and involved in care as desired
• Provide a quiet, private environment
• Offer simple comforts (chairs, blankets, water)
• Listen empathetically without offering false reassurances
• Notify the nurse if family members are in distress

Post-mortem care:
After death, the CNA assists with respectful care of the body according to facility policy. This includes maintaining dignity and privacy, following cultural and religious preferences of the family, and completing documentation per policy.

CNAs must also recognize the emotional impact that death may have on themselves, residents, families, and coworkers. Seeking support, debriefing with a supervisor, and practicing self-care are important for maintaining the emotional well-being of healthcare workers.', 2);

  UPDATE modules SET lessons_count = 2 WHERE id = v_mod_id;


  RAISE NOTICE 'Patch 005 complete: All 18 competency modules updated with lesson content.';
END $$;
