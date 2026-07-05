-- ============================================================
-- Nurse Rocky — Patch 007: Module 5 Full Content
-- "Maintains a Safe Environment for the Resident and Others"
-- Run in: Supabase Dashboard → SQL Editor
-- ============================================================

DO $$
DECLARE
  v_mod_id INT;
BEGIN

  SELECT id INTO v_mod_id FROM modules WHERE order_num = 5;

  IF v_mod_id IS NULL THEN
    RAISE EXCEPTION 'Module 5 not found. Run patch 005 first.';
  END IF;

  UPDATE modules SET
    title = 'Maintains a Safe Environment for the Resident and Others',
    description = 'Learn to identify and eliminate safety hazards, follow facility emergency and disaster plans, use safety equipment correctly, prevent falls, and recognize and report workplace violence.',
    is_published = true
  WHERE id = v_mod_id;

  DELETE FROM lessons WHERE module_id = v_mod_id;

  INSERT INTO lessons (module_id, title, content, order_num) VALUES

  -- ── Lesson 1 ──────────────────────────────────────────────────
  (v_mod_id,
   '5.1 — Identifies Ways to Promote Safety and Handle Non-Medical Emergencies',
   '5.0 Competency: Maintains a Safe Environment for the Resident and Others

Certified Nursing Assistant (CNA) students must demonstrate the ability to maintain a safe, secure, and hazard-free environment for residents, staff, and visitors. Safety is a fundamental responsibility in healthcare settings and requires constant awareness, adherence to facility policies, and prompt action to prevent accidents and injuries.

CNAs play a critical role in identifying risks, following established safety procedures, and responding appropriately to non-medical emergencies. A safe environment supports resident well-being, reduces harm, and promotes quality care outcomes.

5.1 Identifies Ways to Promote Safety and Handle Non-Medical Emergencies

CNA students must understand that safety involves preventing harm before it occurs and responding appropriately when unexpected situations arise.

A. Safety and Risk Management Principles and Concepts
CNA students should understand the following key concepts:
• Safety: Actions and conditions that prevent injury or harm to residents, staff, and visitors.
• Risk Management: Identifying, reporting, and reducing potential hazards to prevent accidents or injuries.
• Accident/Incident Reporting: Proper documentation and reporting of any unexpected event, injury, or unsafe condition according to facility policy.
• Safety Hazards: Anything in the environment that could cause harm, including wet floors, clutter, faulty equipment, or unsafe practices.

CNA students must always remain alert and report unsafe conditions immediately to the supervising nurse.

B. Adherence to Safety Policies and Facility Plans
CNA students are required to follow all facility safety policies, procedures, and emergency plans. These include:

Safety/Risk Management Procedures
• Follow all protocols to prevent accidents and injuries.
• Report hazards immediately.

Disaster Plans
• Understand facility procedures for natural disasters or emergencies.
• Follow assigned roles during emergency situations.

Bomb Threat Procedures
• Follow facility instructions calmly and immediately.
• Report suspicious activity to the supervisor.

Infection Control Procedures
• Follow hand hygiene and PPE guidelines.
• Prevent the spread of infection through proper practices.

Hazard Communication
• Recognize warning labels and safety signs.
• Follow instructions on chemical and material safety guidelines.

Radiation Protection Measures
• Follow precautions when caring for residents receiving radiation therapy.
• Limit exposure according to facility guidelines.

Fire Plan
• Follow the RACE procedure (Rescue, Alarm, Contain, Extinguish/Evacuate).
• Know fire extinguisher locations and usage.

Evacuation Plan (Floor/Exit Plan)
• Know all exits and evacuation routes.
• Assist residents safely during evacuation procedures.

Toxic Chemical and MSDS Protocols
• Understand Safety Data Sheets (SDS) for hazardous materials.
• Follow proper handling and storage instructions.

Oxygen Usage Safety
• Recognize oxygen as a fire hazard.
• No smoking or open flames near oxygen use.
• Ensure proper storage and signage.

C. Use of Safety Equipment
CNA students must know how to identify and use safety equipment appropriately, including:

Fire Extinguishers
• Understand the PASS method (Pull, Aim, Squeeze, Sweep).
• Use only if trained and safe to do so.

Eye Wash Stations
• Know location and proper use in case of chemical exposure.
• Assist residents or staff in flushing eyes when needed.

Other Safety Equipment
• Bed alarms and call lights to prevent falls.
• Wheelchair brakes and safety straps.
• Personal protective equipment (PPE) such as gloves, masks, and gowns.
• Transfer equipment to prevent injury during mobility assistance.

Key Concepts for CNA Students
• Safety is a continuous responsibility in all healthcare settings.
• CNAs must identify and report hazards immediately.
• Facility policies and emergency plans must always be followed.
• Proper use of safety equipment helps prevent injuries and emergencies.
• Infection control is a critical part of maintaining a safe environment.
• Awareness and communication are essential to effective risk management.

By understanding and applying safety principles, CNA students contribute to a secure environment that protects residents, staff, and visitors while promoting high-quality, compassionate care.',
   1),

  -- ── Lesson 2 ──────────────────────────────────────────────────
  (v_mod_id,
   '5.2 — Identifies Environmental Safety Hazards and Methods to Prevent Accidents',
   '5.2 Competency: Identifies Environmental Safety Hazards and Methods Used to Prevent Accidents

Certified Nursing Assistant (CNA) students must understand that maintaining a safe environment is essential to preventing injuries and protecting residents, staff, and visitors. CNAs are responsible for identifying environmental hazards, applying preventive safety measures, and promptly reporting potential risks to the supervising nurse. Early recognition of hazards and consistent safety practices significantly reduce accidents in healthcare settings.

A. Identifies Environmental Safety Hazards
CNA students must be able to recognize common environmental hazards that can lead to accidents or injuries, including:
• Wet or slippery floors
• Cluttered pathways or obstructed walkways
• Unlocked wheelchair or bed wheels
• Unsafe use of side rails (risk of suffocation or entrapment)
• Beds positioned too high or improperly adjusted
• Improper shoes, loose clothing, or unsafe footwear
• Slippery surfaces in bathrooms or care areas
• Items placed out of resident reach leading to unsafe stretching or climbing
• Dim or inadequate lighting
• Frayed electrical cords or damaged equipment
• Improper use of assistive devices (walkers, canes, wheelchairs)
• Hot liquids or food that may cause burns
• Smoking or exposure to open flames
• Exposure to extreme weather conditions
• Unsecured or improperly stored chemicals
• Improper handling of sharps (needles, broken glass)
• Gas leaks or unsafe equipment use

CNA students must remain alert at all times and take immediate action to correct or report hazards.

B. Preventive Measures and Guiding Principles to Prevent Accidents
CNA students should apply the following principles to reduce risk:
• Gentleness: Use careful, controlled movements when assisting residents.
• Slow and "steady as she goes": Avoid rushing during care or transfers.
• Eliminate/control hazards: Remove or correct unsafe conditions immediately when possible.
• ACT Principle — A: Awareness — Be alert to potential risks in the environment. C: Correction — Fix or reduce hazards when safe and appropriate. T: Take precautions — Use safety measures to prevent injury.
• Inter-department communication: Report hazards promptly and collaborate with the healthcare team to ensure safety.

C. Common Types of Injuries in Healthcare Facilities
CNA students must recognize common injuries that may occur, including:
• Skin tears or injuries from sharp objects
• Muscle strains and sprains from improper lifting or movement
• Bruises from bumps or falls
• Falls resulting in minor or severe injury

Falls

Falls are one of the most common and serious safety concerns in healthcare settings. CNA students must understand:
• Prevention: Keep environments clutter-free, ensure proper lighting, assist residents when needed, and use fall precautions.
• Assisting a Falling Resident: If a fall cannot be prevented, gently lower the resident if possible and protect the head.
• Care After a Fall: Do not move the resident unless necessary for safety; report immediately and follow facility protocol.

D. Utilizes Measures to Identify Risk Factors and Prevent Falls
CNA students should:
• Identify residents at high risk for falls (weakness, confusion, unsteady gait, medications).
• Ensure call lights are within reach.
• Keep bed in lowest position when appropriate.
• Encourage proper footwear and assistive device use.
• Maintain clear pathways and proper lighting.
• Respond promptly to resident requests for assistance.

E. Common Causes of Accidents in Older Adults
Older adults are at higher risk for accidents due to:
• Decreased vision or hearing
• Muscle weakness and decreased balance
• Chronic illness or medication side effects
• Confusion or cognitive impairment
• Slow reaction time
• Environmental unfamiliarity
• History of previous falls

F. Age-Related Safety Measures
CNA students should implement safety measures such as:
• Ensuring proper lighting and visibility
• Providing assistive devices as needed
• Encouraging slow and safe movement
• Offering assistance with ambulation and transfers
• Removing environmental hazards promptly
• Promoting hydration, nutrition, and rest to reduce weakness

G. Nursing Assistant Responsibilities: Reporting and Notification
CNA students must:
• Immediately report all hazards and unsafe conditions to the supervising nurse.
• Report any resident fall, injury, or accident promptly.
• Complete incident reporting procedures according to facility policy.
• Communicate changes in resident condition or risk factors.
• Never attempt to conceal or ignore safety concerns.

Key Concepts for CNA Students
• Safety hazards must be identified and corrected immediately when possible.
• Prevention is the most effective method of reducing accidents.
• Falls and injuries are often preventable through awareness and proper care.
• Older adults require special attention due to increased risk factors.
• CNAs must follow all facility safety procedures and report concerns promptly.
• Communication and teamwork are essential for maintaining a safe environment.

By recognizing environmental hazards and applying preventive safety measures, CNA students help ensure a secure, injury-free environment that protects residents and supports high-quality care.',
   2),

  -- ── Lesson 3 ──────────────────────────────────────────────────
  (v_mod_id,
   '5.3 — Identifies Safety Measures to Prevent Workplace Violence',
   '5.3 Competency: Identifies Safety Measures to Prevent Workplace Violence

Certified Nursing Assistant (CNA) students must understand that workplace violence is any act or threat of physical violence, harassment, intimidation, or other disruptive behavior that occurs in the healthcare environment. CNAs are responsible for maintaining a safe, respectful, and secure environment for residents, coworkers, and visitors by recognizing risk factors, following facility safety procedures, and reporting potential threats immediately.

Preventing workplace violence requires awareness, communication, adherence to policy, and the consistent use of safety practices in all interactions.

A. Identifies Common Measures to Prevent Workplace Violence
CNA students must be familiar with strategies used to reduce and prevent workplace violence, including environmental safety systems and facility procedures.

Environmental Systems
• Secure entry points to control access to the facility.
• Surveillance systems such as cameras in common areas.
• Well-lit hallways, entrances, and parking areas.
• Emergency call systems and panic alarms.
• Restricted access to sensitive or high-risk areas.

Facility Policies and Procedures

Visitor Sign-In
• All visitors must check in according to facility policy.
• Visitor badges must be worn and visible at all times.
• Unauthorized individuals should be reported immediately.

Identification Badges for Staff
• All staff must wear visible identification at all times.
• Proper identification helps distinguish staff from visitors or unauthorized persons.

Timely Communication
• Report suspicious behavior or safety concerns immediately.
• Use established communication channels and chain of command.
• Share relevant safety information with the healthcare team promptly.

Personal Safety Practices
• Stay aware of surroundings at all times.
• Avoid walking alone in unsafe or isolated areas when possible.
• Keep personal belongings secure.
• Maintain professional boundaries with residents, visitors, and coworkers.
• Follow de-escalation techniques when encountering aggressive behavior.

B. Nursing Assistant''s Responsibility for Reporting Potential Violence
CNA students play a critical role in preventing workplace violence by observing and reporting warning signs early. CNAs must:
• Report any threatening, aggressive, or suspicious behavior immediately to the supervising nurse or appropriate authority.
• Document incidents according to facility policy.
• Never attempt to manage violent situations alone.
• Follow the chain of command for escalating concerns.
• Participate in maintaining a safe and secure work environment by remaining alert and proactive.

Warning signs that must be reported may include:
• Verbal threats or intimidation
• Aggressive body language or behavior
• Unauthorized individuals in restricted areas
• Escalating conflicts between residents, visitors, or staff
• Any situation that feels unsafe or potentially dangerous

Key Concepts for CNA Students
• Workplace violence prevention is a shared responsibility of all healthcare staff.
• Environmental safety systems help reduce risks and improve security.
• Facility policies such as visitor sign-in and staff identification are essential safeguards.
• Timely communication is critical to preventing escalation of dangerous situations.
• CNAs must always prioritize personal safety and the safety of others.
• All potential threats or concerning behaviors must be reported immediately.

By following safety procedures and remaining alert to potential risks, CNA students contribute to a secure, professional, and safe healthcare environment for everyone.',
   3);

  UPDATE modules SET lessons_count = 3 WHERE id = v_mod_id;

  RAISE NOTICE 'Patch 007 complete: Module 5 updated with 3 full lessons.';
END $$;
