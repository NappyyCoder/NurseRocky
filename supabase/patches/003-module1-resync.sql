-- ============================================================
-- Patch 003 · Module 1 Re-sync
-- Run in: Supabase Dashboard → SQL Editor
--
-- Fixes Module 1 so it matches modules 2-10:
--   • Removes duplicate / old-format quizzes (keeps exactly one
--     True/False Quiz and one Mini Exam)
--   • Inserts clean question options (no "a) b) c)" prefixes) with
--     rationales so the answer review works
--   • Normalizes the title to match the rest of the course
-- Lesson rows are left intact (they use the curated in-app text).
-- Safe to re-run.
-- ============================================================

DO $$
DECLARE
  v_mod_id  INT;
  v_quiz_id UUID;
BEGIN
  SELECT id INTO v_mod_id FROM modules WHERE order_num = 1;

  IF v_mod_id IS NULL THEN
    RAISE EXCEPTION 'Module 1 (order_num = 1) not found. Run seed-modules.sql first.';
  END IF;

  UPDATE modules SET
    title = 'Introduction to Healthcare & CNA Role',
    description = 'Learn the fundamentals of healthcare, the CNA role, scope of practice, the healthcare team, professionalism, HIPAA, and legal and ethical standards.',
    is_published = true
  WHERE id = v_mod_id;

  -- Remove ALL existing Module 1 quizzes (clears duplicates + old format).
  DELETE FROM quizzes WHERE module_id = v_mod_id;

  -- ── True/False Quiz ──────────────────────────────────────────
  INSERT INTO quizzes (module_id, title, passing_score)
  VALUES (v_mod_id, 'True/False Quiz', 70) RETURNING id INTO v_quiz_id;

  INSERT INTO quiz_questions (quiz_id, question, options, correct_answer, rationale, order_num) VALUES
  (v_quiz_id, 'CNAs can perform medical diagnoses independently.',
   '["True","False"]', 1,
   'CNAs provide basic care and observe patient conditions, but do not diagnose illnesses.', 1),
  (v_quiz_id, 'Patient confidentiality is a legal responsibility for CNAs.',
   '["True","False"]', 0,
   'HIPAA laws require CNAs to protect patient information.', 2),
  (v_quiz_id, 'Teamwork is unnecessary if the CNA is experienced.',
   '["True","False"]', 1,
   'Collaboration is essential to ensure patient safety and quality care.', 3),
  (v_quiz_id, 'CNAs are responsible for reporting changes in patient conditions to the nurse.',
   '["True","False"]', 0,
   'Timely reporting allows for prompt intervention and care adjustments.', 4),
  (v_quiz_id, 'Professionalism includes punctuality, respect, and ethical behavior.',
   '["True","False"]', 0,
   'Professional behavior fosters trust and maintains a safe, effective work environment.', 5);

  -- ── Mini Exam ────────────────────────────────────────────────
  INSERT INTO quizzes (module_id, title, passing_score)
  VALUES (v_mod_id, 'Mini Exam', 70) RETURNING id INTO v_quiz_id;

  INSERT INTO quiz_questions (quiz_id, question, options, correct_answer, rationale, order_num) VALUES
  (v_quiz_id, 'CNAs are primarily responsible for:',
   '["Diagnosing illnesses","Providing direct patient care","Prescribing medications","Performing surgeries"]', 1,
   'CNAs provide basic care such as bathing, feeding, and monitoring vital signs; they do not diagnose or prescribe.', 1),
  (v_quiz_id, 'The scope of practice defines:',
   '["Legal limits of duties","How to clean equipment","Meal planning","Doctor''s responsibilities"]', 0,
   'Scope of practice ensures CNAs perform tasks safely within their legal limits.', 2),
  (v_quiz_id, 'Confidentiality refers to:',
   '["Sharing patient information freely","Keeping patient information private","Documenting staff schedules","Reporting co-worker mistakes only"]', 1,
   'HIPAA laws protect patient privacy; CNAs must not disclose personal health information.', 3),
  (v_quiz_id, 'CNAs report observations to:',
   '["Family members","The supervising nurse","Other patients","Insurance companies"]', 1,
   'CNAs report changes in patient condition to nurses who can take appropriate action.', 4),
  (v_quiz_id, 'Professional behavior includes:',
   '["Punctuality and respect","Gossiping with staff","Ignoring patient requests","Using personal devices during care"]', 0,
   'Professionalism ensures safe, respectful care and positive workplace interactions.', 5),
  (v_quiz_id, 'A CNA''s role includes:',
   '["Administering medications independently","Assisting with activities of daily living (ADLs)","Performing surgery","Diagnosing diseases"]', 1,
   'CNAs help with ADLs like bathing, feeding, and mobility; they do not perform medical procedures.', 6),
  (v_quiz_id, 'Teamwork in healthcare is important because:',
   '["It helps prevent errors","It improves patient care","It enhances communication","All of the above"]', 3,
   'Team collaboration ensures safer, efficient, and coordinated patient care.', 7),
  (v_quiz_id, 'CNAs should use critical thinking to:',
   '["Follow instructions blindly","Assess patient needs and report concerns","Ignore unusual observations","Prescribe treatment"]', 1,
   'Critical thinking helps CNAs identify changes and communicate them promptly.', 8),
  (v_quiz_id, 'Patient rights include:',
   '["Respect, privacy, and informed consent","Free meals only","Unlimited phone use","Choice of CNA staff"]', 0,
   'Patients have legal rights to be treated with dignity and receive information about their care.', 9),
  (v_quiz_id, 'Accountability in healthcare means:',
   '["Blaming others for mistakes","Accepting responsibility for one''s actions","Avoiding tasks","Delegating care without instructions"]', 1,
   'CNAs must be responsible for their actions to ensure safe, ethical care.', 10);

  RAISE NOTICE 'Module 1 re-sync complete: 1 module updated, 2 quizzes, 15 questions.';
END $$;
