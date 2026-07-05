-- ============================================================
-- Nurse Rocky — Patch 021: Module 15 Full Content
-- "Assists with Diagnostic Tests"
-- Source: 15.0 Competency Assists with Diagnostic Tests.docx
-- Run in: Supabase Dashboard → SQL Editor
-- ============================================================

DO $$
DECLARE
  v_mod_id INT;
BEGIN

  SELECT id INTO v_mod_id FROM modules WHERE order_num = 15;

  IF v_mod_id IS NULL THEN
    RAISE EXCEPTION 'Module 15 not found. Run seed-modules.sql first.';
  END IF;

  UPDATE modules SET
    title = 'Assists with Diagnostic Tests',
    description = 'Collect, label, and transport specimens, provide pre- and post-procedure care, and document and report diagnostic information to the nurse.',
    is_published = true,
    lessons_count = 2
  WHERE id = v_mod_id;

  DELETE FROM lessons WHERE module_id = v_mod_id;

  INSERT INTO lessons (module_id, title, content, order_num) VALUES

  (v_mod_id,
   '15.1 — Collecting, Labeling, and Transporting Specimens',
   'Competency 15.0: Assists with Diagnostic Tests
Diagnostic testing is an important part of resident care because it helps the healthcare team identify health conditions, monitor treatment effectiveness, and make informed clinical decisions. Certified Nursing Assistants (CNAs) assist with collecting and handling specimens that are used for laboratory testing. CNAs must follow strict procedures, maintain infection control standards, and ensure accurate labeling and timely delivery of specimens.
Students will learn how to properly collect, label, and transport specimens, provide appropriate pre- and post-care, and follow facility policies when assisting with diagnostic testing.
 
Learning Goal 15.1
Demonstrate procedures for acquiring different types of specimens.
 
A. Types of Specimens Collected by Nursing Assistants
CNAs may be responsible for collecting several types of specimens, including:
	•	Urine specimens
	•	Stool (fecal) specimens
	•	Sputum specimens
	•	Emesis (vomit) specimens
Urine specimens may include:
	•	Routine urine samples
	•	Clean-catch (midstream) specimens
	•	24-hour urine collections
	•	Culture and sensitivity specimens
	•	Sterile urine specimens (from Foley catheter)
Stool specimens may be obtained from:
	•	Rectal collection
	•	Colostomy or ileostomy output
 
B. Collection, Labeling, and Transport of Specimens
CNAs must follow facility policies and infection control guidelines when collecting specimens. Key steps include:
	•	Performing hand hygiene and using standard precautions.
	•	Explaining the procedure clearly to the resident.
	•	Collecting the correct type of specimen as ordered.
	•	Avoiding contamination during collection.
	•	Labeling the specimen immediately with the correct resident information.
	•	Sending the specimen promptly to the laboratory or designated area for analysis.
Accuracy in labeling and handling is essential to ensure correct test results and resident safety.
 
C. Testing of Specimens (When Ordered)
In some cases, CNAs may assist with basic testing procedures, such as:
	•	Dipstick testing: Used to check urine for substances such as glucose, protein, or infection indicators.
	•	Straining urine: Used to detect stones or sediment in urine.
CNAs must always follow facility protocols and report results to the nurse according to policy.
 
D. Pre- and Post-Care for Specimen Collection
Proper resident care before and after specimen collection includes:
Pre-procedure care:
	•	Explain the procedure to reduce anxiety.
	•	Provide privacy and comfort.
	•	Ensure proper positioning.
	•	Gather necessary supplies.
Post-procedure care:
	•	Clean and assist the resident as needed.
	•	Ensure comfort and safety.
	•	Dispose of contaminated materials properly.
	•	Perform hand hygiene.
	•	Report and document per facility policy.
 
Summary
Assisting with diagnostic tests requires accuracy, attention to detail, and strict adherence to infection control procedures. CNAs play an important role in collecting and handling specimens that help guide resident diagnosis and treatment. By following proper procedures, communicating effectively, and maintaining resident dignity and safety, nursing assistants contribute to high-quality healthcare outcomes.',
   1),

  (v_mod_id,
   '15.2 — Documents and Reports Information to Nurse',
   'Competency 15.2: Documents and Reports Information to Nurse
Accurate documentation and timely reporting are essential responsibilities of the Certified Nursing Assistant (CNA) when assisting with diagnostic tests and specimen collection. Proper documentation ensures continuity of care, supports clinical decision-making, and helps the healthcare team monitor changes in a resident’s condition. CNAs must record information clearly, objectively, and according to facility policy, while immediately reporting any abnormal findings to the nurse.
Students will learn how to document specimen details, record intake and output (I&O), and complete required facility forms accurately and appropriately.
 
Learning Goal 15.2
Document and report information related to specimen collection and resident condition to the nurse.
 
A. Documenting Specimen Details
When collecting specimens, CNAs must accurately document key characteristics, including:
	•	Amount: The quantity of the specimen collected (when applicable).
	•	Color: Any observed changes such as dark, cloudy, or abnormal coloration.
	•	Odor: Any unusual or foul smell.
	•	Consistency or characteristics: For example, formed stool, liquid stool, or presence of mucus or blood.
All observations must be recorded objectively without interpretation or assumptions. Any abnormal findings must be reported immediately to the nurse.
 
B. Intake and Output (I&O)
CNAs may be responsible for measuring and documenting intake and output as part of monitoring fluid balance.
This includes:
	•	Intake: All fluids the resident consumes (oral, IV fluids if measured by CNA per facility policy).
	•	Output: Urine, emesis, stool, or other bodily fluids as assigned.
Accurate I&O documentation is essential for identifying fluid imbalance, dehydration, or other health concerns.
 
C. Facility Documentation Forms and Procedures
All documentation must follow facility-specific policies and procedures, which may include:
	•	Flow sheets or electronic health records (EHR)
	•	Specimen collection logs
	•	Intake and output records
	•	Incident or abnormal findings reports
CNAs must:
	•	Complete documentation promptly after care is provided.
	•	Use only approved abbreviations.
	•	Ensure information is legible, accurate, and complete.
	•	Report any unusual findings to the nurse immediately before or after documentation, as required.
 
Summary
Documentation and reporting are critical components of safe and effective nursing assistant practice. CNAs must carefully record specimen details, intake and output measurements, and other relevant observations while following facility policies. Accurate, timely, and objective documentation supports resident safety, communication among healthcare team members, and high-quality care.',
   2);

  RAISE NOTICE 'Module 15 updated with 2 lessons.';
END $$;
