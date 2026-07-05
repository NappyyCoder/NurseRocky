-- ============================================================
-- Nurse Rocky — Patch 009: Module 7 Full Content
-- "Provides Basic Emergency Care"
-- Run in: Supabase Dashboard → SQL Editor
-- ============================================================

DO $$
DECLARE
  v_mod_id INT;
BEGIN

  SELECT id INTO v_mod_id FROM modules WHERE order_num = 7;

  IF v_mod_id IS NULL THEN
    RAISE EXCEPTION 'Module 7 not found. Run patch 005 first.';
  END IF;

  UPDATE modules SET
    title = 'Provides Basic Emergency Care',
    description = 'Learn to recognize and respond to medical emergencies, apply basic first-aid principles, perform CPR and AED use, and identify specific emergencies including cardiac arrest, stroke, seizures, choking, burns, and poisoning.',
    is_published = true
  WHERE id = v_mod_id;

  DELETE FROM lessons WHERE module_id = v_mod_id;

  INSERT INTO lessons (module_id, title, content, order_num) VALUES

  -- ── Lesson 1 ──────────────────────────────────────────────────
  (v_mod_id,
   '7.1 — Applies Principles of Basic Emergency Care in Resident Care',
   '7.0 Competency: Provides Basic Emergency Care

Certified Nursing Assistant (CNA) students must understand and apply the basic principles of emergency care in order to respond quickly, safely, and appropriately when a resident experiences a sudden change in condition or medical emergency. CNAs are often the first to witness emergencies in healthcare settings, and their prompt recognition and response can help protect life, prevent further injury, and support positive outcomes.

Emergency care requires calm thinking, quick action within the CNA scope of practice, and immediate communication with the supervising nurse or emergency response team.

7.1 Applies Principles of Basic Emergency Care in Resident Care

A. Goals of Emergency Care and First Aid
CNA students must understand that the primary goals of emergency care and first aid are to:
• Preserve life and prevent death.
• Prevent the condition from becoming worse.
• Promote recovery and comfort the resident.
• Ensure safety of the resident, staff, and others.
• Provide immediate support until medical help arrives.

CNAs must remain calm during emergencies and follow facility policies, emergency protocols, and the chain of command.

B. Signs of Medical Emergencies
CNA students must be able to recognize signs that indicate a medical emergency requiring immediate attention. Early recognition is critical for resident safety.

Common signs of medical emergencies include:
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

CNAs must report all emergency signs immediately and activate emergency procedures according to facility policy.

Key Concepts for CNA Students
• The goals of emergency care are to preserve life, prevent harm, and support recovery.
• CNAs must act quickly but stay within their scope of practice.
• Recognizing signs of medical emergencies is essential for resident safety.
• Immediate reporting and communication with the nurse are critical.
• Following facility emergency procedures helps ensure a coordinated response.

By understanding and applying basic emergency care principles, CNA students play a vital role in ensuring rapid response, resident safety, and effective support during medical emergencies.',
   1),

  -- ── Lesson 2 ──────────────────────────────────────────────────
  (v_mod_id,
   '7.2 — Demonstrates Knowledge of Basic First-Aid Principles',
   '7.2 Competency: Demonstrates Knowledge of Basic First-Aid Principles

Certified Nursing Assistant (CNA) students must demonstrate knowledge of basic first-aid principles to respond safely and appropriately when a resident experiences injury, sudden illness, or an unexpected change in condition. First aid involves immediate, temporary care provided until full medical treatment is available. CNAs must always remain within their scope of practice and follow facility policies and procedures when responding to emergencies.

The primary focus of first aid is to preserve life, prevent further injury, and promote recovery while maintaining resident safety and dignity.

Basic First-Aid Principles
CNA students must understand and apply the following principles:
• Ensure scene safety: Before providing care, assess the environment for hazards to protect yourself, the resident, and others.
• Assess the resident''s condition: Observe for responsiveness, breathing, bleeding, and signs of distress.
• Call for help immediately: Activate the chain of command or emergency response system according to facility policy.
• Provide appropriate care within scope of practice: Offer basic support such as comfort, reassurance, and positioning while awaiting medical assistance.
• Prevent further injury: Avoid moving the resident unless there is immediate danger.
• Maintain airway, breathing, and circulation awareness (ABC): Recognize life-threatening conditions and respond promptly.
• Control bleeding when possible: Apply pressure if trained and permitted by facility policy.
• Remain calm and reassure the resident: Provide emotional support to reduce fear and anxiety.
• Do not perform procedures outside CNA scope: Avoid administering medications or invasive interventions.
• Report and document accurately: Communicate observations clearly to the supervising nurse and complete required incident reports.

Key Concepts for CNA Students
• First aid is immediate care provided until professional medical treatment is available.
• Safety of the resident and caregiver is the first priority.
• CNAs must act quickly but remain within their scope of practice.
• Early recognition and reporting of emergencies can save lives.
• Calm, supportive communication helps reduce resident distress during emergencies.
• All incidents must be reported according to facility policy.

By applying basic first-aid principles, CNA students contribute to safe, effective, and compassionate emergency response while ensuring resident dignity and protection.',
   2),

  -- ── Lesson 3 ──────────────────────────────────────────────────
  (v_mod_id,
   '7.3 — Responds to Emergency Situations',
   '7.3 Competency: Responds to Emergency Situations

Certified Nursing Assistant (CNA) students must understand how to respond appropriately in emergency situations to ensure the safety, survival, and well-being of residents. In healthcare settings, emergencies require immediate action, clear communication, and adherence to established facility protocols. CNAs must remain calm, act within their scope of practice, and activate emergency response systems without delay.

Emergency response skills such as CPR, AED use, and choking interventions are critical components of basic life support and may be required until advanced medical personnel arrive.

Emergency Procedures for Healthcare Providers

A. Cardiopulmonary Resuscitation (CPR)
CPR is an emergency procedure used when a resident is unresponsive and not breathing normally.

CNA students must understand that CPR:
• Helps maintain blood flow and oxygen to vital organs.
• Should be initiated immediately when a resident is unresponsive and not breathing.
• Requires following facility policy and training certification.
• Must be performed until emergency medical services arrive or the resident shows signs of recovery.

CNAs must ensure the scene is safe, call for help, and follow emergency response procedures before beginning CPR when required and trained.

B. Automated External Defibrillator (AED)
An AED is a portable device used to deliver an electric shock to the heart in cases of sudden cardiac arrest.

CNA students must:
• Turn on the AED and follow voice prompts.
• Attach pads to the resident as instructed by the device.
• Ensure no one is touching the resident during analysis or shock delivery.
• Resume CPR immediately after the shock if directed.
• Continue following AED prompts until emergency personnel arrive.

AED use must always follow training and facility policy.

C. Abdominal-Thrust Maneuver
The abdominal-thrust maneuver is used to assist a resident who is choking and cannot breathe, speak, or cough effectively.

CNA students must:
• Recognize signs of severe airway obstruction.
• Call for help immediately.
• Perform abdominal thrusts only if trained and authorized.
• Continue until the object is expelled or the resident becomes unresponsive.
• If the resident becomes unresponsive, initiate CPR and follow emergency procedures.

Key Concepts for CNA Students
• Rapid response in emergencies can save lives.
• CNAs must remain calm and follow established emergency procedures.
• CPR, AED use, and choking interventions must only be performed when trained and authorized.
• Activation of the emergency response system is always a priority.
• CNAs must work within their scope of practice and follow facility policy.
• Clear communication and teamwork are essential during emergencies.

By demonstrating knowledge of emergency procedures, CNA students help ensure quick, effective, and safe responses that protect resident life and support positive outcomes in critical situations.',
   3),

  -- ── Lesson 4 ──────────────────────────────────────────────────
  (v_mod_id,
   '7.4 — Identifies Specific Emergencies and Responds per Standards of Care',
   '7.4 Competency: Identifies Specific Types of Emergencies, Responds and Reports According to Recognized Standards of Care

Certified Nursing Assistant (CNA) students must be able to recognize specific types of medical emergencies, respond appropriately within their scope of practice, and report immediately to the supervising nurse or emergency response team. Prompt recognition and action are essential to protect resident life, prevent further injury, and ensure timely medical intervention.

CNAs are not responsible for diagnosing conditions; instead, they observe signs and symptoms, provide basic support, and activate emergency procedures according to facility policy and recognized standards of care.

Types of Emergencies and Standards of Care

A. Asphyxia
Asphyxia occurs when the body is deprived of oxygen.

CNA Response:
• Call for help immediately.
• Check airway and breathing.
• Begin emergency procedures as trained.
• Stay with the resident and follow facility protocol.

B. Choking
Choking is a blockage of the airway that prevents breathing.

CNA Response:
• Ask if the resident can speak or cough.
• If unable to breathe, call for help immediately.
• Perform abdominal thrusts if trained and permitted.
• Begin CPR if the resident becomes unresponsive.

C. Chest Pain
Chest pain may indicate a heart attack or other serious condition.

CNA Response:
• Stop activity and keep the resident calm.
• Call for help immediately.
• Assist resident to a comfortable position.
• Observe and report symptoms promptly.

D. Cardiac Arrest
Cardiac arrest is when the heart stops beating effectively.

CNA Response:
• Check responsiveness and breathing.
• Call emergency response system immediately.
• Begin CPR if trained.
• Use AED if available and trained.
• Continue until help arrives.

E. Stroke / Transient Ischemic Attack (TIA)
Stroke/TIA involves interrupted blood flow to the brain.

CNA Response:
• Note sudden weakness, facial drooping, or speech changes.
• Call for help immediately.
• Keep resident safe and in a resting position.
• Do not give food or fluids.

F. Hemorrhage
Hemorrhage is severe or uncontrolled bleeding.

CNA Response:
• Apply direct pressure if trained and safe.
• Call for help immediately.
• Monitor vital signs if assigned.
• Do not remove soaked dressings; add layers if needed.

G. Anaphylaxis
Anaphylaxis is a severe allergic reaction.

CNA Response:
• Call for emergency help immediately.
• Watch for difficulty breathing, swelling, or rash.
• Assist with emergency medications only if permitted by facility policy.
• Stay with the resident until help arrives.

H. Seizures
Seizures involve uncontrolled electrical activity in the brain.

CNA Response:
• Protect resident from injury (clear surroundings).
• Do not restrain the resident.
• Do not place anything in the mouth.
• Time the seizure.
• Place resident on their side after seizure ends if safe.

I. Shock / Fainting
Shock is a life-threatening condition; fainting may be a temporary loss of consciousness.

CNA Response:
• Lay resident flat and elevate legs if appropriate.
• Keep resident warm and calm.
• Call for help immediately.
• Monitor breathing and responsiveness.

J. Burns
Burns may result from heat, chemicals, or electricity.

CNA Response:
• Remove resident from source of injury if safe.
• Cool burn with appropriate measures per facility policy.
• Do not apply creams or break blisters.
• Report immediately.

K. Poisonings
Poisoning occurs from ingestion, inhalation, or exposure to toxic substances.

CNA Response:
• Call for emergency assistance immediately.
• Do not induce vomiting unless directed.
• Identify substance if possible.
• Follow facility and emergency protocols.

Key Concepts for CNA Students
• Rapid recognition of emergencies is critical to resident survival.
• CNAs must remain calm and follow established emergency procedures.
• Immediate reporting and activation of emergency response systems is required.
• CNAs must work within their scope of practice at all times.
• Preventing further injury is a priority in all emergency situations.
• Documentation and communication with the healthcare team are essential.

By identifying emergencies quickly and responding appropriately, CNA students play a vital role in ensuring resident safety, supporting emergency care, and promoting positive outcomes in critical situations.',
   4);

  UPDATE modules SET lessons_count = 4 WHERE id = v_mod_id;

  RAISE NOTICE 'Patch 009 complete: Module 7 updated with 4 full lessons.';
END $$;
