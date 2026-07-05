-- ============================================================
-- Nurse Rocky — Patch 024: Module 18 Full Content
-- "Provides Care for Residents and Family When Death is Imminent"
-- Source: 18.0 Competency Provides Care for Residents and Family When Death is Imminent.docx
-- Run in: Supabase Dashboard → SQL Editor
-- ============================================================

DO $$
DECLARE
  v_mod_id INT;
BEGIN

  SELECT id INTO v_mod_id FROM modules WHERE order_num = 18;

  IF v_mod_id IS NULL THEN
    RAISE EXCEPTION 'Module 18 not found. Run seed-modules.sql first.';
  END IF;

  UPDATE modules SET
    title = 'Provides Care for Residents and Family When Death is Imminent',
    description = 'End-of-life attitudes and stages of dying, cultural and spiritual care, imminent death signs, DNR and advance directives, postmortem care, and body preparation for removal.',
    is_published = true,
    lessons_count = 5
  WHERE id = v_mod_id;

  DELETE FROM lessons WHERE module_id = v_mod_id;

  INSERT INTO lessons (module_id, title, content, order_num) VALUES

  (v_mod_id,
   '18.1 — Principles of Caring for Dying Residents and Families',
   'Competency 18.0: Provides Care for Residents and Family When Death is Imminent
Caring for residents and their families during the end-of-life process requires compassion, sensitivity, and professionalism. Certified Nursing Assistants (CNAs) play a vital role in providing comfort, dignity, and emotional support when death is near. This care focuses on respecting the resident’s wishes, supporting family members, and maintaining a peaceful environment. CNAs must also understand common emotional responses to dying and recognize the stages individuals may experience during the dying process.
Students will learn how to recognize attitudes about death, understand the stages of dying, and provide supportive care for residents and families during this sensitive time.
 
Learning Goal 18.1
Identify and recognize principles of caring for dying residents and their family members.
 
A. Attitudes and Beliefs About Death
People respond to death and dying in different ways based on personal, cultural, spiritual, and emotional beliefs. CNAs must provide respectful and nonjudgmental care regardless of individual perspectives.
Common situations include:
	•	Sudden death: An unexpected death that may cause shock, confusion, and intense emotional distress for family members and caregivers.
	•	Terminal illness and expected death: A gradual decline where death is anticipated, allowing time for emotional preparation, planning, and support.
CNAs must remain calm, supportive, and respectful in both situations while following facility procedures.
 
B. Stages of the Dying Process
Many individuals experiencing terminal illness may go through emotional stages as they come to terms with death. These stages may occur in different orders and may be revisited multiple times.
	•	Denial: Refusing to accept the reality of impending death.
	•	Anger: Feelings of frustration, resentment, or questioning “why me.”
	•	Bargaining: Attempting to negotiate or make promises in hopes of delaying death.
	•	Depression: Deep sadness, withdrawal, and grief over loss.
	•	Acceptance: Coming to terms with death and finding peace.
CNAs should understand that not every resident will experience all stages, and emotional responses may vary.
 
Summary
End-of-life care requires empathy, patience, and respect. CNAs support residents and families by recognizing different attitudes about death, understanding emotional stages of dying, and providing compassionate presence. Through dignified care and emotional support, nursing assistants help ensure comfort and peace during one of life’s most sensitive transitions.',
   1),

  (v_mod_id,
   '18.2 — Spiritual and Cultural End-of-Life Care',
   'Competency 18.2: Assists in Care of Dying Resident and Their Family Members Considering Spiritual and Cultural Beliefs
End-of-life care requires compassion, respect, and cultural sensitivity. Certified Nursing Assistants (CNAs) play a key role in supporting dying residents and their families by providing comfort, maintaining dignity, and honoring spiritual and cultural preferences. Care must be delivered with professionalism while respecting legal and ethical standards. CNAs must also recognize the emotional impact that death may have on themselves, residents, families, and coworkers.
Students will learn how to provide culturally sensitive end-of-life care, support hospice residents, maintain dignity, and understand appropriate emotional and professional boundaries.
 
Learning Goal 18.2
Assist in care of dying resident and their family members considering spiritual and cultural beliefs.
 
A. Cultural and Spiritual Influences
Cultural and spiritual beliefs significantly influence how individuals experience death and dying. CNAs must recognize and respect these differences by:
	•	Understanding that beliefs about death vary widely among individuals and families.
	•	Respecting rituals, prayers, or spiritual practices important to the resident and family.
	•	Supporting family involvement in culturally appropriate ways.
	•	Avoiding judgment or personal bias regarding beliefs and practices.
Respect for cultural and spiritual diversity helps promote comfort and peace during the end-of-life process.
 
B. Maintaining Resident Dignity
Maintaining dignity is essential when caring for a dying resident. CNAs support dignity by:
	•	Providing privacy during care and family visits.
	•	Ensuring the resident is clean, comfortable, and properly positioned.
	•	Speaking respectfully and calmly to the resident and family.
	•	Honoring personal preferences whenever possible.
	•	Avoiding unnecessary exposure or disruption during care.
Dignified care helps preserve the resident’s sense of worth and respect at the end of life.
 
C. Nursing Assistant Role in Hospice Care
When a resident is receiving hospice care, the CNA’s role includes:
	•	Providing comfort-focused care rather than curative treatment.
	•	Assisting with personal care such as bathing, oral hygiene, and repositioning.
	•	Observing and reporting changes in condition or comfort.
	•	Supporting pain relief measures as directed by the nurse.
	•	Offering emotional presence and reassurance to the resident and family.
CNAs must follow the hospice care plan and report all changes promptly to the nurse.
 
D. Impact of Death on the Nursing Assistant and Others
The death of a resident can emotionally affect:
	•	Nursing assistants
	•	Healthcare team members
	•	Other residents
	•	Family members
CNAs may experience feelings of sadness, grief, or emotional fatigue. It is important to:
	•	Acknowledge personal feelings in a healthy and professional way.
	•	Seek support from supervisors or coworkers when needed.
	•	Maintain professionalism while on duty.
 
E. Legal and Ethical Standards in End-of-Life Care
CNAs must always follow legal and ethical guidelines by:
	•	Respecting resident rights and advance directives.
	•	Maintaining confidentiality and privacy (HIPAA compliance).
	•	Following facility policies regarding end-of-life care.
	•	Avoiding actions outside of scope of practice.
	•	Providing care without discrimination or personal bias.
Professional boundaries must always be maintained while offering compassionate care.
 
Summary
Care of the dying resident requires compassion, cultural awareness, and professional integrity. CNAs support residents and families by honoring spiritual and cultural beliefs, maintaining dignity, assisting with hospice care, and following ethical and legal standards. Through respectful and supportive care, nursing assistants help ensure comfort and peace during the end-of-life journey.',
   2),

  (v_mod_id,
   '18.3 — Care When Death Is Imminent',
   'Competency 18.3: Provides Care for Residents When Death Is Imminent
Care for a resident when death is imminent requires sensitivity, professionalism, and strict adherence to facility policy and legal-ethical standards. Certified Nursing Assistants (CNAs) play an important role in observing changes in condition, maintaining comfort, supporting the family, and reporting findings to the nurse. CNAs must understand signs that death is approaching, follow advance directives, and ensure accurate observation and documentation when vital signs cease.
Students will learn how to identify signs of impending death, recognize and follow advance directives, and properly observe, report, and document end-of-life changes according to facility protocol.
 
Learning Goal 18.3
Provide care for residents when death is imminent.
 
A. Signs of Impending Death
CNAs must be able to recognize common signs that indicate a resident is nearing death, including:
	•	Decreased level of consciousness or unresponsiveness
	•	Irregular or shallow breathing patterns (e.g., periods of apnea)
	•	Cool, pale, or mottled skin
	•	Weak or irregular pulse
	•	Decreased urine output or incontinence
	•	Loss of appetite or refusal of fluids and food
	•	Increased sleep or inability to wake easily
	•	Changes in vital signs (often declining)
These signs must be observed carefully and reported promptly to the nurse.
 
B. Advance Directives and DNR Orders
CNAs must understand and follow all legal and facility requirements regarding end-of-life wishes, including:
	•	Do Not Resuscitate (DNR) orders: Indicates that CPR or resuscitation efforts should not be performed if the resident stops breathing or their heart stops.
	•	Advance directives: Legal documents that outline the resident’s wishes for end-of-life care, including treatment preferences and interventions.
Nursing assistants must:
	•	Follow the resident’s documented wishes at all times.
	•	Never initiate resuscitation if a DNR is in place.
	•	Notify the nurse immediately when a change in condition is observed.
	•	Follow facility protocol exactly when death appears imminent or occurs.
 
C. Observation, Reporting, and Documentation of Death
When death is suspected or occurs, CNAs must:
	•	Observe for absence of breathing and lack of pulse as directed by facility policy.
	•	Immediately report findings to the nurse.
	•	Not independently confirm or pronounce death.
	•	Follow instructions from the licensed nurse regarding next steps.
If required by facility policy, CNAs may assist in:
	•	Documenting cessation of vital signs as directed.
	•	Recording the time and observations accurately and objectively.
	•	Completing documentation forms according to facility procedures.
All documentation must be factual, timely, and compliant with facility policy.
 
Summary
Providing care when death is imminent requires careful observation, respect for resident wishes, and strict adherence to legal and ethical standards. CNAs play a critical role in identifying signs of impending death, following advance directives such as DNR orders, and accurately reporting and documenting changes. Through compassionate care and professional responsibility, nursing assistants help ensure dignity and respect during the final stage of life.',
   3),

  (v_mod_id,
   '18.4 — Postmortem Care and Cultural Practices',
   'Competency 18.4: Provides Postmortem Care Adhering to Cultural Practices and Facility Policy
Postmortem care is the care provided to a resident after death. This care must be performed with respect, dignity, cultural sensitivity, and strict adherence to facility policy. Certified Nursing Assistants (CNAs) play an important role in preparing the body, supporting the family’s wishes, and ensuring personal belongings are handled appropriately. CNAs must also recognize and respect cultural and spiritual practices related to death and dying.
Students will learn how to provide postmortem care, respect cultural practices, assist with personal belongings, and support organ donation processes within their role.
 
Learning Goal 18.4
Provide postmortem care while adhering to cultural practices and facility policy.
 
A. Cultural Practices in Caring for the Deceased
Different cultures and religions have specific practices regarding death and postmortem care. CNAs must:
	•	Respect cultural and spiritual beliefs related to death.
	•	Follow family requests within facility policy and legal guidelines.
	•	Allow space for prayers, rituals, or quiet time when appropriate.
	•	Avoid judgment or personal bias toward cultural practices.
	•	Communicate respectfully with family members and the care team.
Cultural sensitivity ensures dignity and comfort for both the deceased and grieving family members.
 
B. Personal Care of the Resident After Death
CNAs may assist with postmortem care by:
1. Bathing and cleansing the body
	•	Gently cleaning the body as needed.
	•	Maintaining dignity throughout the process.
	•	Following infection control and facility procedures.
2. Dressing the body
	•	Dressing the resident according to family wishes or facility protocol.
	•	Ensuring clothing is clean and appropriate.
3. Care of personal belongings
	•	Gathering and labeling personal items carefully.
	•	Securing valuables according to facility policy.
	•	Returning belongings to the family as directed.
4. Positioning the body
	•	Positioning the resident in a natural, respectful manner.
	•	Aligning the body according to facility procedure.
	•	Closing eyes and placing dentures if appropriate and directed.
5. Respect for the deceased
	•	Speaking respectfully and maintaining a calm, professional demeanor.
	•	Ensuring privacy during all care activities.
	•	Handling the body with dignity at all times.
 
C. Organ Donation
CNAs may be involved in supporting organ donation procedures by:
	•	Recognizing that organ donation is handled according to legal consent and facility policy.
	•	Not making independent decisions or discussions about donation.
	•	Notifying the nurse immediately when death occurs or is suspected.
	•	Supporting the process respectfully and maintaining confidentiality.
	•	Assisting with care only as directed by the nurse and facility protocol.
 
Summary
Postmortem care requires compassion, respect, and cultural awareness. CNAs support this process by providing dignified care of the body, honoring cultural and spiritual practices, managing personal belongings appropriately, and following legal procedures related to organ donation. Through professionalism and sensitivity, nursing assistants help ensure that end-of-life care is carried out with respect for both the resident and their family.',
   4),

  (v_mod_id,
   '18.5 — Prepares Body for Removal from Unit',
   'Competency 18.5: Prepares Body for Removal from Unit
Preparing a resident’s body for removal from the unit is a sensitive and important responsibility that must be performed with dignity, respect, and strict adherence to facility policy. Certified Nursing Assistants (CNAs) play a supportive role in ensuring that postmortem care is completed appropriately, the environment is maintained in a respectful manner, and all documentation is accurate and timely. Special attention must be given to the emotional needs of the family and the well-being of other residents on the unit.
Students will learn how to prepare the body for removal, maintain dignity and respect for the deceased, support family considerations, and complete required documentation according to facility protocol.
 
Learning Goal 18.5
Prepare the body for removal from the unit while maintaining dignity, respect, and proper documentation.
 
A. Procedure for Removal of the Body
CNAs assist in preparing the resident’s body for removal by following facility policy and maintaining a calm, respectful environment. Key steps include:
	•	Ensuring privacy by closing curtains, doors, and limiting unnecessary traffic in the room.
	•	Completing postmortem care as directed, including cleansing and positioning of the body.
	•	Placing the resident in a clean gown or clothing according to family wishes or facility protocol.
	•	Removing or securing tubes, equipment, or medical devices as directed by the nurse and facility policy.
	•	Positioning the body in a respectful manner (typically supine with arms placed appropriately).
	•	Ensuring identification tags are placed according to policy to maintain correct identification.
	•	Covering the body appropriately to preserve dignity during transport.
 
B. Maintaining Dignity and Respect
Throughout the process, CNAs must:
	•	Treat the deceased with respect at all times.
	•	Speak in a calm, professional manner while in the room.
	•	Avoid unnecessary exposure of the body.
	•	Respect cultural, religious, and family wishes when possible and within policy.
	•	Maintain a quiet and respectful environment to support grieving families and other residents nearby.
 
C. Support for Family and Other Residents
CNAs should:
	•	Allow family members privacy and time with the deceased when permitted.
	•	Be sensitive to emotional reactions and respond with compassion.
	•	Minimize disruptions on the unit during body removal.
	•	Maintain confidentiality and professionalism at all times.
	•	Be aware of how the situation may affect other residents and help maintain a calm environment.
 
D. Documentation and Reporting
CNAs must:
	•	Complete documentation according to facility policy and scope of practice.
	•	Record care provided and observations objectively and accurately.
	•	Report completion of postmortem care and readiness for transport to the nurse.
	•	Follow all facility procedures regarding forms, time documentation, and release protocols.
 
Summary
Preparing a body for removal from the unit requires professionalism, respect, and compassion. CNAs ensure that postmortem care is completed properly, dignity is maintained, and the environment remains respectful for families and other residents. By following facility procedures and documenting accurately, nursing assistants help ensure that end-of-life care is handled with honor and integrity.',
   5);

  RAISE NOTICE 'Module 18 updated with 5 lessons.';
END $$;
