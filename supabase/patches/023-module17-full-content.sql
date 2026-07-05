-- ============================================================
-- Nurse Rocky — Patch 023: Module 17 Full Content
-- "Assists in Admission, Transfer, and Discharge of the Resident"
-- Source: 17.0 Competency Assists in Admission, Transfer, and Discharge of the Resident.docx
-- Run in: Supabase Dashboard → SQL Editor
-- ============================================================

DO $$
DECLARE
  v_mod_id INT;
BEGIN

  SELECT id INTO v_mod_id FROM modules WHERE order_num = 17;

  IF v_mod_id IS NULL THEN
    RAISE EXCEPTION 'Module 17 not found. Run seed-modules.sql first.';
  END IF;

  UPDATE modules SET
    title = 'Assists in Admission, Transfer, and Discharge of the Resident',
    description = 'Admission procedures, room preparation, orientation, unit transfers, discharge instructions, belongings, transport, and reporting.',
    is_published = true,
    lessons_count = 3
  WHERE id = v_mod_id;

  DELETE FROM lessons WHERE module_id = v_mod_id;

  INSERT INTO lessons (module_id, title, content, order_num) VALUES

  (v_mod_id,
   '17.1 — Procedures for Admitting a Resident to the Unit',
   'Competency 17.0: Assists in Admission, Transfer, and Discharge of the Resident
Admission, transfer, and discharge are important transitions in a resident’s healthcare experience. Certified Nursing Assistants (CNAs) play a key role in helping residents feel safe, welcomed, and comfortable during these changes. CNAs must follow facility policies, maintain resident dignity, and communicate effectively with the healthcare team to ensure accurate information and continuity of care.
Students will learn how to assist with the admission process, support resident orientation, gather basic data, and report observations appropriately.
 
Learning Goal 17.1
Demonstrate the procedures for admitting a resident to the unit.
 
A. Preparation of the Room
Before the resident arrives, the CNA helps prepare a safe and comfortable environment by:
	•	Ensuring the room is clean, organized, and safe.
	•	Making the bed with clean linens and proper positioning.
	•	Placing necessary items within reach (call light, tissues, water if allowed, and personal care items).
	•	Ensuring privacy by closing curtains and doors as appropriate.
	•	Checking that equipment is functioning properly.
A well-prepared room helps reduce anxiety and supports a smooth transition for the resident.
 
B. Greeting the Resident and Family
When the resident arrives, the CNA should:
	•	Greet the resident and family in a warm, respectful manner.
	•	Introduce themselves and explain their role.
	•	Offer assistance with settling in.
	•	Demonstrate professionalism, kindness, and reassurance.
This step helps build trust and reduces anxiety during admission.
 
C. Orientation of the Resident
Orientation helps the resident become familiar with their new environment. The CNA should:
	•	Explain the layout of the room and unit.
	•	Show how to use the call light and explain its purpose.
	•	Point out bathroom locations and safety features.
	•	Introduce staff members when appropriate.
	•	Review basic facility routines as directed.
Clear orientation promotes safety and comfort.
 
D. Assisting with Data Collection
The CNA assists the nurse by gathering basic admission data, including:
	•	Vital signs (temperature, pulse, respirations, blood pressure).
	•	Height and weight measurements.
	•	Observations about the resident’s condition, mobility, and behavior.
All information must be recorded accurately and reported promptly to the nurse.
 
E. Safety, Comfort, and Privacy Measures
During admission, the CNA ensures:
	•	The resident is safely transferred and positioned in bed or chair.
	•	Comfort needs are addressed (pillows, blankets, positioning).
	•	Privacy is maintained during all procedures.
	•	Safety precautions are followed (bed in low position, call light within reach, side rails per policy).
These measures support dignity, comfort, and fall prevention.
 
F. Personal Item Inventory
The CNA may assist with:
	•	Documenting personal belongings brought by the resident.
	•	Labeling items according to facility policy.
	•	Ensuring valuables are secured properly.
	•	Reporting discrepancies or concerns to the nurse.
This helps prevent loss and ensures accountability.
 
G. Reporting and Communication
After admission procedures, the CNA must:
	•	Communicate all observations and measurements to the nurse.
	•	Report the resident’s physical condition and emotional response.
	•	Document information according to facility policy.
Accurate communication ensures safe and effective care planning.
 
Summary
Admission is the first step in a resident’s care experience and sets the tone for their stay. CNAs play an essential role in preparing the environment, welcoming the resident, assisting with basic data collection, and ensuring safety and comfort. Through clear communication, careful observation, and compassionate care, nursing assistants help create a positive and supportive admission experience.',
   1),

  (v_mod_id,
   '17.2 — Procedures for Transferring a Resident from the Unit',
   'Competency 17.2: Demonstrates Procedures for Transferring a Resident from the Unit
Resident transfer is the process of moving a resident from one unit, room, or facility area to another. This transition requires careful planning, communication, and attention to safety to ensure continuity of care and protect the resident’s physical and emotional well-being. Certified Nursing Assistants (CNAs) play a key role in supporting the resident during this process while following facility policies and maintaining dignity and respect.
Students will learn how to assist with preparing for transfer, moving personal belongings, transporting the resident safely, and communicating relevant information to the healthcare team.
 
Learning Goal 17.2
Demonstrate the procedures for transferring a resident from the unit.
 
A. Preparation of the Room
Before the transfer occurs, the CNA should:
	•	Ensure the resident’s current room is organized and ready for departure.
	•	Gather and prepare personal belongings for transport.
	•	Verify that all equipment is properly labeled and ready for movement.
	•	Assist in maintaining a clean, safe environment during the transition.
Proper preparation helps ensure nothing is lost and the process is efficient.
 
B. Transfer of Personal Belongings and Equipment
The CNA may assist with:
	•	Collecting and labeling personal items according to facility policy.
	•	Safely packing clothing, hygiene items, and assistive devices.
	•	Ensuring medical equipment (as applicable) is transferred appropriately.
	•	Confirming that all belongings are accounted for before leaving the unit.
This step helps prevent loss and ensures continuity of care.
 
C. Greeting the Resident and Family
During transfer preparation and departure, the CNA should:
	•	Greet the resident and family in a respectful and supportive manner.
	•	Explain the transfer process in simple terms within scope of practice.
	•	Provide reassurance and emotional support.
	•	Maintain professionalism and empathy during the transition.
This helps reduce anxiety and promotes cooperation.
 
D. Transporting the Resident
When transporting the resident, the CNA must:
	•	Ensure safe transfer methods are used (wheelchair, stretcher, or bed as appropriate).
	•	Follow proper body mechanics and safety protocols.
	•	Maintain resident privacy and dignity during transport.
	•	Ensure the resident is comfortable and properly positioned.
Resident safety is the highest priority during transport.
 
E. Orientation of the Resident
Upon arrival at the new unit or room, the CNA should:
	•	Introduce the resident to the new environment.
	•	Explain the location of the bed, bathroom, and call light.
	•	Assist with familiarization of staff and routines as appropriate.
	•	Help the resident feel safe and comfortable in the new setting.
Orientation reduces confusion and anxiety.
 
F. Safety, Comfort, and Privacy Measures
During and after transfer, the CNA must:
	•	Ensure the resident is safely positioned in the new bed or chair.
	•	Provide comfort measures such as blankets or pillows.
	•	Maintain privacy at all times.
	•	Ensure safety equipment (call light, bed position, alarms) is in place per policy.
These actions promote comfort and prevent injury.
 
G. Reporting and Communication
After the transfer is complete, the CNA must:
	•	Report the resident’s condition and response to the nurse.
	•	Communicate any changes in behavior, mobility, or emotional state.
	•	Document transfer-related information according to facility policy.
Accurate communication ensures continuity of care and resident safety.
 
Summary
Resident transfer is a coordinated process that requires attention to detail, safety, and compassionate care. CNAs support this process by preparing the environment, assisting with belongings, safely transporting residents, and ensuring proper orientation in the new setting. Through effective communication and careful observation, nursing assistants help ensure a smooth and safe transition for residents.',
   2),

  (v_mod_id,
   '17.3 — Procedures for Discharging a Resident',
   'Competency 17.3: Demonstrates Procedures for Discharging a Resident
Discharge is the process of preparing a resident to leave a healthcare facility or transfer to another level of care. It requires organization, safety awareness, and effective communication to ensure continuity of care. Certified Nursing Assistants (CNAs) play a supportive role by assisting with basic discharge tasks, maintaining resident dignity, and reporting observations to the nurse. All discharge procedures must be completed according to facility policy and professional standards.
Students will learn how to assist with discharge instructions, manage personal belongings, provide safe transport, and ensure comfort and safety during the discharge process.
 
Learning Goal 17.3
Demonstrate the procedures for discharging a resident.
 
A. Assist with Discharge Instructions
CNAs may assist by:
	•	Supporting the nurse in reinforcing discharge instructions as directed.
	•	Ensuring the resident understands basic directions within the CNA scope.
	•	Encouraging the resident to ask questions and report concerns to the nurse.
	•	Clarifying non-medical information only as permitted by facility policy.
 
B. Secure Personal Belongings
The CNA assists by:
	•	Gathering and organizing the resident’s personal belongings.
	•	Ensuring items are labeled according to facility policy.
	•	Checking rooms, closets, and drawers to prevent items from being left behind.
	•	Securing valuables per facility procedures.
	•	Reporting missing or unaccounted items to the nurse.
 
C. Transport the Resident
When transporting the resident, the CNA must:
	•	Use appropriate and safe transfer methods (wheelchair, stretcher, or assistance with walking as appropriate).
	•	Maintain proper body mechanics and safety techniques.
	•	Ensure the resident is securely positioned during transport.
	•	Maintain dignity and respect throughout the process.
 
D. Safety Measures
CNAs must ensure:
	•	The resident is safe during all stages of discharge.
	•	Fall precautions are followed during transfer and transport.
	•	Equipment is used correctly and safely.
	•	The environment is clear of hazards.
Resident safety remains the highest priority throughout discharge.
 
E. Comfort Measures
CNAs should provide comfort by:
	•	Offering reassurance and emotional support.
	•	Assisting with positioning for comfort during transport.
	•	Providing blankets or other comfort items as appropriate.
	•	Remaining calm and respectful during the discharge process.
 
F. Privacy Needs
CNAs must:
	•	Maintain confidentiality of resident information.
	•	Ensure privacy during dressing, packing, and transport.
	•	Close curtains and doors as appropriate.
	•	Respect the resident’s dignity at all times.
 
G. Reporting and Communication
After discharge procedures are completed, the CNA must:
	•	Communicate observations of the resident’s condition and behavior to the nurse.
	•	Report any concerns or unusual findings immediately.
	•	Document actions and observations according to facility policy.
 
Summary
Discharge is an important step in the continuity of care that requires organization, attention to detail, and respect for the resident. CNAs support this process by assisting with belongings, ensuring safety and comfort, maintaining privacy, and communicating effectively with the healthcare team. Through professional and compassionate care, nursing assistants help ensure a smooth and dignified transition for the resident.',
   3);

  RAISE NOTICE 'Module 17 updated with 3 lessons.';
END $$;
