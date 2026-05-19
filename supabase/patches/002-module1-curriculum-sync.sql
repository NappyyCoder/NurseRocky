-- Re-sync Module 1 metadata, lessons, quizzes, and questions to match curriculum document.
-- Run in Supabase SQL Editor (safe to re-run; replaces Module 1 quiz data).

UPDATE modules SET
  title = 'Module 1: Introduction to Healthcare & CNA Role',
  description = 'Module 1: Introduction to Healthcare & CNA Role (6 Hours). Learning Objectives: Define CNA scope of practice; Identify healthcare team roles; Understand workplace professionalism. Topics: Healthcare settings, CNA responsibilities, Legal scope of practice, Professional conduct, HIPAA. Assessment: Quiz, Test.',
  lessons_count = 8,
  duration_min = 360
WHERE id = 1;

DELETE FROM quizzes WHERE module_id = 1;
DELETE FROM lessons WHERE module_id = 1;

INSERT INTO lessons (module_id, title, content, duration_min, order_num) VALUES
  (1, 'Module 1: Orientation & Foundations — Welcome to Nurse Rocky', NULL, 45, 1),
  (1, 'Role of the Certified Nursing Assistant (CNA)', NULL, 45, 2),
  (1, 'Scope of Practice for Certified Nursing Assistants', NULL, 45, 3),
  (1, 'Healthcare Team', NULL, 45, 4),
  (1, 'Professional Behavior', NULL, 45, 5),
  (1, 'HIPAA & Confidentiality', NULL, 45, 6),
  (1, 'Legal & Ethical Standards', NULL, 45, 7),
  (1, 'Sample Simulation', NULL, 45, 8);

WITH
ins_tf AS (
  INSERT INTO quizzes (module_id, title, passing_score)
  VALUES (1, 'CNA True/False Quiz: Modules 1', 70)
  RETURNING id
),
ins_ex AS (
  INSERT INTO quizzes (module_id, title, passing_score)
  VALUES (1, 'CNA Mini Exam: Module 1 – Introduction to Healthcare & CNA Role', 70)
  RETURNING id
)
INSERT INTO quiz_questions (quiz_id, question, options, correct_answer, order_num)
SELECT * FROM (
  SELECT (SELECT id FROM ins_tf),'CNAs can perform medical diagnoses independently.','["True","False"]'::jsonb, 1::int, 1
  UNION ALL SELECT (SELECT id FROM ins_tf),'Patient confidentiality is a legal responsibility for CNAs.','["True","False"]'::jsonb, 0, 2
  UNION ALL SELECT (SELECT id FROM ins_tf),'Teamwork is unnecessary if the CNA is experienced.','["True","False"]'::jsonb, 1, 3
  UNION ALL SELECT (SELECT id FROM ins_tf),'CNAs are responsible for reporting changes in patient conditions to the nurse.','["True","False"]'::jsonb, 0, 4
  UNION ALL SELECT (SELECT id FROM ins_tf),'Professionalism includes punctuality, respect, and ethical behavior.','["True","False"]'::jsonb, 0, 5
  UNION ALL SELECT (SELECT id FROM ins_ex),'CNAs are primarily responsible for:','["a) Diagnosing illnesses","b) Providing direct patient care","c) Prescribing medications","d) Performing surgeries"]'::jsonb, 1, 1
  UNION ALL SELECT (SELECT id FROM ins_ex),'The scope of practice defines:','["a) Legal limits of duties","b) How to clean equipment","c) Meal planning","d) Doctor\u2019s responsibilities"]'::jsonb, 0, 2
  UNION ALL SELECT (SELECT id FROM ins_ex),'Confidentiality refers to:','["a) Sharing patient information freely","b) Keeping patient information private","c) Documenting staff schedules","d) Reporting co-worker mistakes only"]'::jsonb, 1, 3
  UNION ALL SELECT (SELECT id FROM ins_ex),'CNAs report observations to:','["a) Family members","b) The supervising nurse","c) Other patients","d) Insurance companies"]'::jsonb, 1, 4
  UNION ALL SELECT (SELECT id FROM ins_ex),'Professional behavior includes:','["a) Punctuality and respect","b) Gossiping with staff","c) Ignoring patient requests","d) Using personal devices during care"]'::jsonb, 0, 5
  UNION ALL SELECT (SELECT id FROM ins_ex),'A CNA\u2019s role includes:','["a) Administering medications independently","b) Assisting with activities of daily living (ADLs)","c) Performing surgery","d) Diagnosing diseases"]'::jsonb, 1, 6
  UNION ALL SELECT (SELECT id FROM ins_ex),'Teamwork in healthcare is important because:','["a) It helps prevent errors","b) It improves patient care","c) It enhances communication","d) All of the above"]'::jsonb, 3, 7
  UNION ALL SELECT (SELECT id FROM ins_ex),'CNAs should use critical thinking to:','["a) Follow instructions blindly","b) Assess patient needs and report concerns","c) Ignore unusual observations","d) Prescribe treatment"]'::jsonb, 1, 8
  UNION ALL SELECT (SELECT id FROM ins_ex),'Patient rights include:','["a) Respect, privacy, and informed consent","b) Free meals only","c) Unlimited phone use","d) Choice of CNA staff"]'::jsonb, 0, 9
  UNION ALL SELECT (SELECT id FROM ins_ex),'Accountability in healthcare means:','["a) Blaming others for mistakes","b) Accepting responsibility for one\u2019s actions","c) Avoiding tasks","d) Delegating care without instructions"]'::jsonb, 1, 10
) AS q(quiz_id, question, options, correct_answer, order_num);
