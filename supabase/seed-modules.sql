-- ============================================================
-- Nurse Rocky — Module & Quiz Seed Data
-- Run in: Supabase Dashboard → SQL Editor
-- Safe to re-run: deletes & re-creates quizzes per module,
-- leaves student progress and attempts untouched.
-- ============================================================

DO $$
DECLARE
  v_mod_id  INT;
  v_quiz_id UUID;
BEGIN

  -- ─────────────────────────────────────────────────────────────
  -- MODULE 1 · Introduction to Healthcare & CNA Role
  -- ─────────────────────────────────────────────────────────────
  IF NOT EXISTS (SELECT 1 FROM modules WHERE order_num = 1) THEN
    INSERT INTO modules (title, description, order_num, is_published)
    VALUES ('Introduction to Healthcare & CNA Role',
            'Learn the fundamentals of healthcare, the CNA role, scope of practice, patient rights, and professional behavior.',
            1, true)
    RETURNING id INTO v_mod_id;
  ELSE
    SELECT id INTO v_mod_id FROM modules WHERE order_num = 1;
    UPDATE modules SET title = 'Introduction to Healthcare & CNA Role', is_published = true WHERE id = v_mod_id;
  END IF;

  -- True/False Quiz
  DELETE FROM quizzes WHERE module_id = v_mod_id AND title = 'True/False Quiz';
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

  -- Mini Exam
  DELETE FROM quizzes WHERE module_id = v_mod_id AND title = 'Mini Exam';
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


  -- ─────────────────────────────────────────────────────────────
  -- MODULE 2 · Communication Skills
  -- ─────────────────────────────────────────────────────────────
  IF NOT EXISTS (SELECT 1 FROM modules WHERE order_num = 2) THEN
    INSERT INTO modules (title, description, order_num, is_published)
    VALUES ('Communication Skills',
            'Master verbal and nonverbal communication, active listening, therapeutic communication, and patient confidentiality.',
            2, true)
    RETURNING id INTO v_mod_id;
  ELSE
    SELECT id INTO v_mod_id FROM modules WHERE order_num = 2;
    UPDATE modules SET title = 'Communication Skills', is_published = true WHERE id = v_mod_id;
  END IF;

  DELETE FROM quizzes WHERE module_id = v_mod_id AND title = 'True/False Quiz';
  INSERT INTO quizzes (module_id, title, passing_score)
  VALUES (v_mod_id, 'True/False Quiz', 70) RETURNING id INTO v_quiz_id;

  INSERT INTO quiz_questions (quiz_id, question, options, correct_answer, rationale, order_num) VALUES
  (v_quiz_id, 'Active listening means giving full attention and providing feedback.',
   '["True","False"]', 0,
   'Active listening ensures accurate understanding and supports patient-centered care.', 1),
  (v_quiz_id, 'Nonverbal communication, like facial expressions, is unimportant in patient interactions.',
   '["True","False"]', 1,
   'Nonverbal cues convey emotions and affect how messages are received.', 2),
  (v_quiz_id, 'Therapeutic communication helps patients express feelings and needs.',
   '["True","False"]', 0,
   'This communication method supports emotional well-being and trust.', 3),
  (v_quiz_id, 'CNAs can ignore language barriers and rely on gestures alone.',
   '["True","False"]', 1,
   'Language barriers must be addressed to prevent miscommunication and errors.', 4),
  (v_quiz_id, 'Confidentiality must be maintained even among healthcare team members.',
   '["True","False"]', 0,
   'Patient information is protected by law and shared only as necessary for care.', 5);

  DELETE FROM quizzes WHERE module_id = v_mod_id AND title = 'Mini Exam';
  INSERT INTO quizzes (module_id, title, passing_score)
  VALUES (v_mod_id, 'Mini Exam', 70) RETURNING id INTO v_quiz_id;

  INSERT INTO quiz_questions (quiz_id, question, options, correct_answer, rationale, order_num) VALUES
  (v_quiz_id, 'Effective communication includes:',
   '["Listening and speaking clearly","Ignoring nonverbal cues","Using medical jargon with patients","Speaking only to nurses"]', 0,
   'Clear verbal and nonverbal communication improves patient understanding and safety.', 1),
  (v_quiz_id, 'Nonverbal communication includes:',
   '["Body language and facial expressions","Speaking loudly","Sending texts","Documenting notes"]', 0,
   'Nonverbal cues convey feelings and attitudes, impacting patient interactions.', 2),
  (v_quiz_id, 'Active listening involves:',
   '["Interrupting frequently","Giving full attention and feedback","Thinking about other tasks","Ignoring patient comments"]', 1,
   'Active listening ensures understanding and builds trust with patients.', 3),
  (v_quiz_id, 'Therapeutic communication is:',
   '["Helping patients express needs and feelings","Casual chatting with co-workers","Giving orders to patients","Ignoring patient concerns"]', 0,
   'Therapeutic communication focuses on patient-centered care and emotional support.', 4),
  (v_quiz_id, 'Barriers to communication include:',
   '["Language differences, hearing impairment, or cultural differences","Smiling at patients","Eye contact","Clear speech"]', 0,
   'Barriers can prevent patients from understanding care instructions.', 5),
  (v_quiz_id, 'Reporting patient concerns requires:',
   '["Ignoring them","Documenting and notifying the nurse","Sharing on social media","Only verbal discussion with other CNAs"]', 1,
   'Accurate reporting ensures patient safety and timely care interventions.', 6),
  (v_quiz_id, 'Using open-ended questions encourages:',
   '["Yes/no answers","Detailed responses from patients","Short responses only","Ignoring patient needs"]', 1,
   'Open-ended questions allow patients to explain their concerns fully.', 7),
  (v_quiz_id, 'Professional communication includes:',
   '["Respect and active listening","Gossip","Sarcasm","Avoiding patients"]', 0,
   'Professional communication fosters trust and teamwork in care.', 8),
  (v_quiz_id, 'CNAs should clarify information by:',
   '["Asking for repetition or explanation","Ignoring unclear instructions","Guessing","Delegating to another CNA"]', 0,
   'Clarification prevents errors and ensures proper patient care.', 9),
  (v_quiz_id, 'Patient confidentiality must be maintained:',
   '["Only with doctors","With all healthcare team members and as required by law","Only during hospital rounds","Never"]', 1,
   'HIPAA mandates confidentiality to protect patient privacy.', 10);


  -- ─────────────────────────────────────────────────────────────
  -- MODULE 3 · Safety & Infection Control
  -- ─────────────────────────────────────────────────────────────
  IF NOT EXISTS (SELECT 1 FROM modules WHERE order_num = 3) THEN
    INSERT INTO modules (title, description, order_num, is_published)
    VALUES ('Safety & Infection Control',
            'Learn standard precautions, hand hygiene, PPE use, sharps disposal, and infection prevention techniques.',
            3, true)
    RETURNING id INTO v_mod_id;
  ELSE
    SELECT id INTO v_mod_id FROM modules WHERE order_num = 3;
    UPDATE modules SET title = 'Safety & Infection Control', is_published = true WHERE id = v_mod_id;
  END IF;

  DELETE FROM quizzes WHERE module_id = v_mod_id AND title = 'True/False Quiz';
  INSERT INTO quizzes (module_id, title, passing_score)
  VALUES (v_mod_id, 'True/False Quiz', 70) RETURNING id INTO v_quiz_id;

  INSERT INTO quiz_questions (quiz_id, question, options, correct_answer, rationale, order_num) VALUES
  (v_quiz_id, 'Standard precautions apply to all patients regardless of diagnosis.',
   '["True","False"]', 0,
   'All body fluids are considered potentially infectious, so precautions are universal.', 1),
  (v_quiz_id, 'Alcohol-based hand sanitizer can replace handwashing even if hands are visibly dirty.',
   '["True","False"]', 1,
   'Soap and water are required when hands are soiled; sanitizer is only for clean hands.', 2),
  (v_quiz_id, 'CNAs should wear gloves when handling blood, body fluids, or contaminated equipment.',
   '["True","False"]', 0,
   'Gloves protect both patients and staff from infection.', 3),
  (v_quiz_id, 'Sharps can be disposed of in regular trash containers if wrapped.',
   '["True","False"]', 1,
   'Sharps must go in biohazard containers to prevent injury and contamination.', 4),
  (v_quiz_id, 'CNAs should educate patients on hand hygiene and infection prevention.',
   '["True","False"]', 0,
   'Patient education reduces infection risk and promotes safe practices.', 5);

  DELETE FROM quizzes WHERE module_id = v_mod_id AND title = 'Mini Exam';
  INSERT INTO quizzes (module_id, title, passing_score)
  VALUES (v_mod_id, 'Mini Exam', 70) RETURNING id INTO v_quiz_id;

  INSERT INTO quiz_questions (quiz_id, question, options, correct_answer, rationale, order_num) VALUES
  (v_quiz_id, 'Standard precautions apply to:',
   '["Only infected patients","All patients","Only staff","Visitors"]', 1,
   'Standard precautions assume all body fluids are potentially infectious.', 1),
  (v_quiz_id, 'Hand hygiene should be performed:',
   '["Before and after patient care","Only before meals","Once per shift","Only after glove use"]', 0,
   'Hand hygiene prevents pathogen transmission.', 2),
  (v_quiz_id, 'CNAs should wear gloves when:',
   '["Contacting blood or body fluids","Cleaning equipment","Assisting with personal care","All of the above"]', 3,
   'Gloves protect both patients and staff from infections.', 3),
  (v_quiz_id, 'Proper disposal of sharps is in:',
   '["Biohazard containers","Regular trash","Recycling bins","Kitchen trash"]', 0,
   'Sharps containers prevent injury and contamination.', 4),
  (v_quiz_id, 'PPE includes:',
   '["Gloves, gowns, masks, eye protection","Uniform only","Shoes only","None of the above"]', 0,
   'PPE protects staff and patients from exposure to pathogens.', 5),
  (v_quiz_id, 'Bloodborne pathogens include:',
   '["HIV, Hepatitis B, Hepatitis C","Influenza","Common cold","Strep throat"]', 0,
   'Bloodborne pathogens are transmitted through blood or body fluids.', 6),
  (v_quiz_id, 'Isolation precautions are used for:',
   '["Contagious patients","Non-infectious patients","Visitors","Staff only"]', 0,
   'Isolation prevents disease spread to others.', 7),
  (v_quiz_id, 'CNAs should educate patients on:',
   '["Hand hygiene","Cough etiquette","Safe disposal of tissues","All of the above"]', 3,
   'Patient education reduces infection risk.', 8),
  (v_quiz_id, 'Environmental cleaning prevents:',
   '["Spread of infection","Patient boredom","Nutrition problems","Exercise reduction"]', 0,
   'Regular cleaning reduces contamination and pathogen transmission.', 9),
  (v_quiz_id, 'CNAs must report:',
   '["Needle sticks","Exposure to body fluids","Suspected infections","All of the above"]', 3,
   'Prompt reporting ensures proper follow-up and safety measures.', 10);


  -- ─────────────────────────────────────────────────────────────
  -- MODULE 4 · Body Mechanics & Mobility
  -- ─────────────────────────────────────────────────────────────
  IF NOT EXISTS (SELECT 1 FROM modules WHERE order_num = 4) THEN
    INSERT INTO modules (title, description, order_num, is_published)
    VALUES ('Body Mechanics & Mobility',
            'Understand proper lifting techniques, patient transfers, gait belt use, and mobility assistance.',
            4, true)
    RETURNING id INTO v_mod_id;
  ELSE
    SELECT id INTO v_mod_id FROM modules WHERE order_num = 4;
    UPDATE modules SET title = 'Body Mechanics & Mobility', is_published = true WHERE id = v_mod_id;
  END IF;

  DELETE FROM quizzes WHERE module_id = v_mod_id AND title = 'True/False Quiz';
  INSERT INTO quizzes (module_id, title, passing_score)
  VALUES (v_mod_id, 'True/False Quiz', 70) RETURNING id INTO v_quiz_id;

  INSERT INTO quiz_questions (quiz_id, question, options, correct_answer, rationale, order_num) VALUES
  (v_quiz_id, 'Proper body mechanics reduces risk of injury for both CNAs and patients.',
   '["True","False"]', 0,
   'Correct posture and lifting techniques prevent musculoskeletal injuries.', 1),
  (v_quiz_id, 'CNAs should twist their back while lifting patients to use body strength.',
   '["True","False"]', 1,
   'Twisting increases the risk of back injuries; use legs and keep back straight.', 2),
  (v_quiz_id, 'Gait belts are used to assist patients with walking or transfers safely.',
   '["True","False"]', 0,
   'Gait belts provide stability and prevent falls during mobility.', 3),
  (v_quiz_id, 'Patients should be encouraged to move independently when possible.',
   '["True","False"]', 0,
   'Encouraging independence maintains strength and promotes recovery.', 4),
  (v_quiz_id, 'Logrolling is used to turn a patient while keeping the spine aligned.',
   '["True","False"]', 0,
   'Logrolling protects the patient''s spine, especially after surgery or injury.', 5);

  DELETE FROM quizzes WHERE module_id = v_mod_id AND title = 'Mini Exam';
  INSERT INTO quizzes (module_id, title, passing_score)
  VALUES (v_mod_id, 'Mini Exam', 70) RETURNING id INTO v_quiz_id;

  INSERT INTO quiz_questions (quiz_id, question, options, correct_answer, rationale, order_num) VALUES
  (v_quiz_id, 'Proper body mechanics helps prevent:',
   '["Fatigue and injury","Disease transmission","Infection","Poor nutrition"]', 0,
   'Correct posture, lifting, and movement reduce the risk of injury for CNAs and patients.', 1),
  (v_quiz_id, 'When lifting a patient, you should:',
   '["Bend at the waist","Bend your knees and keep back straight","Twist your back","Lift alone if heavy"]', 1,
   'Bending at the knees and keeping the back straight protects the spine.', 2),
  (v_quiz_id, 'The base of support is:',
   '["Your feet and legs while standing","Your hands","Your uniform","A wheelchair"]', 0,
   'A wide base of support provides stability during transfers.', 3),
  (v_quiz_id, 'When moving patients, CNAs should:',
   '["Use smooth, coordinated motions","Use jerky movements","Lift quickly","Avoid asking for help"]', 0,
   'Smooth movements reduce risk of injury and ensure patient comfort.', 4),
  (v_quiz_id, 'A gait belt is used to:',
   '["Assist patients in walking or transferring safely","Measure blood pressure","Provide nutrition","Support posture in bed only"]', 0,
   'Gait belts provide a secure hold to prevent falls during mobility.', 5),
  (v_quiz_id, 'Logrolling a patient is used to:',
   '["Turn a patient while keeping the spine aligned","Help with walking","Assist with meals","None of the above"]', 0,
   'Logrolling protects the spine, especially for patients with spinal injuries.', 6),
  (v_quiz_id, 'When lifting objects, CNAs should:',
   '["Hold objects far from the body","Hold objects close to the body","Twist while lifting","Lift with back only"]', 1,
   'Keeping objects close reduces strain on muscles and back.', 7),
  (v_quiz_id, 'CNAs should encourage patients to:',
   '["Move independently when possible","Avoid mobility","Depend entirely on staff","Only sit in bed"]', 0,
   'Promoting independence maintains strength and mobility.', 8),
  (v_quiz_id, 'Proper posture when standing includes:',
   '["Feet shoulder-width apart, knees slightly bent","Knees locked, leaning forward","Twisting torso","Bending back"]', 0,
   'Correct posture ensures stability and reduces injury risk.', 9),
  (v_quiz_id, 'CNAs should report:',
   '["Pain or discomfort while moving patients","Patient falls or near misses","Unsafe equipment","All of the above"]', 3,
   'Reporting issues ensures patient and staff safety.', 10);


  -- ─────────────────────────────────────────────────────────────
  -- MODULE 5 · Vital Signs
  -- ─────────────────────────────────────────────────────────────
  IF NOT EXISTS (SELECT 1 FROM modules WHERE order_num = 5) THEN
    INSERT INTO modules (title, description, order_num, is_published)
    VALUES ('Vital Signs',
            'Learn to accurately measure and record temperature, pulse, blood pressure, respirations, and oxygen saturation.',
            5, true)
    RETURNING id INTO v_mod_id;
  ELSE
    SELECT id INTO v_mod_id FROM modules WHERE order_num = 5;
    UPDATE modules SET title = 'Vital Signs', is_published = true WHERE id = v_mod_id;
  END IF;

  DELETE FROM quizzes WHERE module_id = v_mod_id AND title = 'True/False Quiz';
  INSERT INTO quizzes (module_id, title, passing_score)
  VALUES (v_mod_id, 'True/False Quiz', 70) RETURNING id INTO v_quiz_id;

  INSERT INTO quiz_questions (quiz_id, question, options, correct_answer, rationale, order_num) VALUES
  (v_quiz_id, 'Normal adult body temperature is approximately 98.6°F.',
   '["True","False"]', 0,
   '98.6°F is the standard average for a healthy adult.', 1),
  (v_quiz_id, 'CNAs should ignore abnormal vital signs unless instructed otherwise.',
   '["True","False"]', 1,
   'Reporting abnormal readings promptly is essential for patient safety.', 2),
  (v_quiz_id, 'Blood pressure is measured in mmHg.',
   '["True","False"]', 0,
   'Millimeters of mercury is the standard unit for blood pressure readings.', 3),
  (v_quiz_id, 'A normal adult pulse rate is 60–100 beats per minute.',
   '["True","False"]', 0,
   'Resting adult pulse rate falls within this range.', 4),
  (v_quiz_id, 'CNAs should rely on memory and not record vital signs.',
   '["True","False"]', 1,
   'Accurate documentation ensures proper care and legal compliance.', 5);

  DELETE FROM quizzes WHERE module_id = v_mod_id AND title = 'Mini Exam';
  INSERT INTO quizzes (module_id, title, passing_score)
  VALUES (v_mod_id, 'Mini Exam', 70) RETURNING id INTO v_quiz_id;

  INSERT INTO quiz_questions (quiz_id, question, options, correct_answer, rationale, order_num) VALUES
  (v_quiz_id, 'Normal adult body temperature is approximately:',
   '["95°F","98.6°F","100°F","102°F"]', 1,
   '98.6°F is considered the average normal adult temperature.', 1),
  (v_quiz_id, 'The normal adult pulse rate is:',
   '["40–60 bpm","60–100 bpm","100–120 bpm","120–140 bpm"]', 1,
   'A normal resting pulse for adults is 60–100 beats per minute.', 2),
  (v_quiz_id, 'Blood pressure is measured in:',
   '["Pounds","mmHg","Celsius","Beats per minute"]', 1,
   'Blood pressure is recorded in millimeters of mercury (mmHg).', 3),
  (v_quiz_id, 'A normal adult respiratory rate is:',
   '["8–12 breaths/min","12–20 breaths/min","20–28 breaths/min","28–36 breaths/min"]', 1,
   'Normal adult respiration is 12–20 breaths per minute.', 4),
  (v_quiz_id, 'CNAs should:',
   '["Take vital signs without patient consent","Report abnormal readings promptly","Ignore trends over time","Only take vital signs once a month"]', 1,
   'Timely reporting ensures prompt medical intervention when needed.', 5),
  (v_quiz_id, 'A sphygmomanometer measures:',
   '["Pulse","Blood pressure","Oxygen saturation","Temperature"]', 1,
   'It measures systolic and diastolic pressure.', 6),
  (v_quiz_id, 'When measuring pulse, CNAs should:',
   '["Use a stethoscope only","Palpate at wrist or neck","Guess the rate","Only measure when patient complains"]', 1,
   'Radial and carotid pulses are commonly palpated for accuracy.', 7),
  (v_quiz_id, 'Oxygen saturation is measured with:',
   '["Thermometer","Pulse oximeter","Sphygmomanometer","Stethoscope"]', 1,
   'Pulse oximeters assess oxygen levels in the blood.', 8),
  (v_quiz_id, 'When monitoring vital signs, CNAs should:',
   '["Rely on one reading","Compare with previous readings for trends","Ignore abnormal values","Only record verbally"]', 1,
   'Monitoring trends helps detect changes in patient condition.', 9),
  (v_quiz_id, 'CNAs must:',
   '["Document all vital signs accurately","Only report abnormal signs","Record approximate numbers","Use memory only"]', 0,
   'Accurate documentation is critical for safe care and legal compliance.', 10);


  -- ─────────────────────────────────────────────────────────────
  -- MODULE 6 · Personal Care & Hygiene
  -- ─────────────────────────────────────────────────────────────
  IF NOT EXISTS (SELECT 1 FROM modules WHERE order_num = 6) THEN
    INSERT INTO modules (title, description, order_num, is_published)
    VALUES ('Personal Care & Hygiene',
            'Provide safe and dignified bathing, oral care, perineal care, and grooming assistance.',
            6, true)
    RETURNING id INTO v_mod_id;
  ELSE
    SELECT id INTO v_mod_id FROM modules WHERE order_num = 6;
    UPDATE modules SET title = 'Personal Care & Hygiene', is_published = true WHERE id = v_mod_id;
  END IF;

  DELETE FROM quizzes WHERE module_id = v_mod_id AND title = 'True/False Quiz';
  INSERT INTO quizzes (module_id, title, passing_score)
  VALUES (v_mod_id, 'True/False Quiz', 70) RETURNING id INTO v_quiz_id;

  INSERT INTO quiz_questions (quiz_id, question, options, correct_answer, rationale, order_num) VALUES
  (v_quiz_id, 'Bathing patients helps remove dirt and microbes and prevents skin breakdown.',
   '["True","False"]', 0,
   'Hygiene is essential for patient health and comfort.', 1),
  (v_quiz_id, 'Oral care prevents infection and dental disease.',
   '["True","False"]', 0,
   'Proper oral hygiene maintains overall health and prevents complications.', 2),
  (v_quiz_id, 'Perineal care should be done back to front.',
   '["True","False"]', 1,
   'Cleaning front to back prevents urinary tract infections.', 3),
  (v_quiz_id, 'CNAs should encourage patients to maintain as much independence as possible.',
   '["True","False"]', 0,
   'Encouraging independence promotes dignity and self-esteem.', 4),
  (v_quiz_id, 'Foot and nail care is unnecessary for patients with normal mobility.',
   '["True","False"]', 1,
   'Regular foot and nail care prevents infection and skin breakdown in all patients.', 5);

  DELETE FROM quizzes WHERE module_id = v_mod_id AND title = 'Mini Exam';
  INSERT INTO quizzes (module_id, title, passing_score)
  VALUES (v_mod_id, 'Mini Exam', 70) RETURNING id INTO v_quiz_id;

  INSERT INTO quiz_questions (quiz_id, question, options, correct_answer, rationale, order_num) VALUES
  (v_quiz_id, 'Bathing a patient helps:',
   '["Remove dirt and microbes","Promote circulation","Prevent skin breakdown","All of the above"]', 3,
   'Regular hygiene maintains health and comfort.', 1),
  (v_quiz_id, 'Oral care prevents:',
   '["Dental disease","Infection","Bad breath","All of the above"]', 3,
   'Proper oral hygiene is essential for overall health.', 2),
  (v_quiz_id, 'When providing perineal care, CNAs should:',
   '["Clean from front to back","Clean back to front","Skip if patient is incontinent","Only use water"]', 0,
   'Cleaning front to back prevents infection.', 3),
  (v_quiz_id, 'CNAs should encourage patients to:',
   '["Maintain as much independence as possible","Have all tasks done for them","Ignore their preferences","Stay in bed only"]', 0,
   'Encouraging independence promotes dignity and self-esteem.', 4),
  (v_quiz_id, 'Foot and nail care is:',
   '["Necessary for all patients","Only needed for diabetics","Not part of CNA duties","Optional if patient objects"]', 0,
   'Regular foot and nail care prevents infection and skin breakdown in all patients.', 5),
  (v_quiz_id, 'When bathing a patient, the CNA should:',
   '["Expose the entire body at once","Provide privacy and cover areas not being washed","Skip areas the patient can reach","Use hot water for comfort"]', 1,
   'Privacy and dignity must be maintained during personal care.', 6),
  (v_quiz_id, 'Oral care for unconscious patients should:',
   '["Be skipped","Be done with care to prevent aspiration","Use the same technique as conscious patients","Use large amounts of water"]', 1,
   'Special precautions prevent aspiration during oral care for unconscious patients.', 7),
  (v_quiz_id, 'Hair care for patients helps:',
   '["Maintain appearance and self-esteem","Only improve appearance","Replace bathing","None of the above"]', 0,
   'Hair care supports dignity and emotional well-being.', 8),
  (v_quiz_id, 'When shaving a patient, CNAs should:',
   '["Use an electric or safety razor as directed","Use any available razor","Skip shaving entirely","Shave against the grain"]', 0,
   'Proper shaving technique prevents cuts and skin irritation.', 9),
  (v_quiz_id, 'Skin care during bathing includes:',
   '["Inspecting for redness or breakdown","Applying lotion if appropriate","Reporting any skin changes","All of the above"]', 3,
   'Thorough skin assessment during bathing helps prevent and detect pressure injuries.', 10);


  -- ─────────────────────────────────────────────────────────────
  -- MODULE 7 · Nutrition & Fluids
  -- ─────────────────────────────────────────────────────────────
  IF NOT EXISTS (SELECT 1 FROM modules WHERE order_num = 7) THEN
    INSERT INTO modules (title, description, order_num, is_published)
    VALUES ('Nutrition & Fluids',
            'Understand nutrition basics, hydration needs, dietary restrictions, and assistance with meals.',
            7, true)
    RETURNING id INTO v_mod_id;
  ELSE
    SELECT id INTO v_mod_id FROM modules WHERE order_num = 7;
    UPDATE modules SET title = 'Nutrition & Fluids', is_published = true WHERE id = v_mod_id;
  END IF;

  DELETE FROM quizzes WHERE module_id = v_mod_id AND title = 'True/False Quiz';
  INSERT INTO quizzes (module_id, title, passing_score)
  VALUES (v_mod_id, 'True/False Quiz', 70) RETURNING id INTO v_quiz_id;

  INSERT INTO quiz_questions (quiz_id, question, options, correct_answer, rationale, order_num) VALUES
  (v_quiz_id, 'Carbohydrates are the body''s main source of energy.',
   '["True","False"]', 0,
   'Carbohydrates fuel daily activities and body functions.', 1),
  (v_quiz_id, 'Proteins are essential for tissue repair and immune function.',
   '["True","False"]', 0,
   'Proteins help the body heal and maintain tissues.', 2),
  (v_quiz_id, 'Water is not necessary if the patient drinks other fluids.',
   '["True","False"]', 1,
   'Water is essential for hydration, waste elimination, and overall body function.', 3),
  (v_quiz_id, 'Thickened liquids are used for patients with swallowing difficulties.',
   '["True","False"]', 0,
   'Thickened liquids reduce the risk of aspiration in dysphagia patients.', 4),
  (v_quiz_id, 'CNAs should force patients to eat regardless of preferences.',
   '["True","False"]', 1,
   'Encouraging but not forcing promotes dignity and cooperation.', 5);


  -- ─────────────────────────────────────────────────────────────
  -- MODULE 8 · Elimination & Toileting
  -- ─────────────────────────────────────────────────────────────
  IF NOT EXISTS (SELECT 1 FROM modules WHERE order_num = 8) THEN
    INSERT INTO modules (title, description, order_num, is_published)
    VALUES ('Elimination & Toileting',
            'Assist patients with toileting, catheter care, bowel programs, and elimination documentation.',
            8, true)
    RETURNING id INTO v_mod_id;
  ELSE
    SELECT id INTO v_mod_id FROM modules WHERE order_num = 8;
    UPDATE modules SET title = 'Elimination & Toileting', is_published = true WHERE id = v_mod_id;
  END IF;

  DELETE FROM quizzes WHERE module_id = v_mod_id AND title = 'True/False Quiz';
  INSERT INTO quizzes (module_id, title, passing_score)
  VALUES (v_mod_id, 'True/False Quiz', 70) RETURNING id INTO v_quiz_id;

  INSERT INTO quiz_questions (quiz_id, question, options, correct_answer, rationale, order_num) VALUES
  (v_quiz_id, 'CNAs assist patients with toileting, catheter care, and bowel movements.',
   '["True","False"]', 0,
   'Elimination care is part of basic CNA responsibilities.', 1),
  (v_quiz_id, 'Gloves and hand hygiene are required when providing elimination care.',
   '["True","False"]', 0,
   'Gloves and hand hygiene prevent infection transmission.', 2),
  (v_quiz_id, 'Catheters are used for nutrition.',
   '["True","False"]', 1,
   'Catheters are for urinary drainage, not feeding.', 3),
  (v_quiz_id, 'CNAs should report changes in elimination patterns.',
   '["True","False"]', 0,
   'Reporting abnormalities ensures timely medical evaluation.', 4),
  (v_quiz_id, 'Bowel training programs promote regular elimination.',
   '["True","False"]', 0,
   'Structured programs help patients regain control and prevent complications.', 5);


  -- ─────────────────────────────────────────────────────────────
  -- MODULE 9 · Infection, Disease & Conditions
  -- ─────────────────────────────────────────────────────────────
  IF NOT EXISTS (SELECT 1 FROM modules WHERE order_num = 9) THEN
    INSERT INTO modules (title, description, order_num, is_published)
    VALUES ('Infection, Disease & Conditions',
            'Recognize common diseases, mental health basics, dementia care, and end-of-life considerations.',
            9, true)
    RETURNING id INTO v_mod_id;
  ELSE
    SELECT id INTO v_mod_id FROM modules WHERE order_num = 9;
    UPDATE modules SET title = 'Infection, Disease & Conditions', is_published = true WHERE id = v_mod_id;
  END IF;

  DELETE FROM quizzes WHERE module_id = v_mod_id AND title = 'True/False Quiz';
  INSERT INTO quizzes (module_id, title, passing_score)
  VALUES (v_mod_id, 'True/False Quiz', 70) RETURNING id INTO v_quiz_id;

  INSERT INTO quiz_questions (quiz_id, question, options, correct_answer, rationale, order_num) VALUES
  (v_quiz_id, 'Residents with diabetes may show signs of low blood sugar such as sweating, confusion, and shakiness.',
   '["True","False"]', 0,
   'These symptoms are classic signs of hypoglycemia, which is dangerous and requires immediate reporting. CNAs must recognize these early warning signs to ensure resident safety.', 1),
  (v_quiz_id, 'A CNA should tell a resident with depression to "cheer up" because it helps motivate them.',
   '["True","False"]', 1,
   'Telling a depressed resident to "cheer up" minimizes their feelings. CNAs should listen, observe, and report changes in mood or behavior to the nurse.', 2),
  (v_quiz_id, 'It is helpful to correct a resident with dementia when they say something that isn''t true, because it improves their memory.',
   '["True","False"]', 1,
   'Correcting or arguing with a resident who has dementia can cause agitation. CNAs should use validation and redirection, not confrontation.', 3),
  (v_quiz_id, 'Loss of appetite is common at the end of life, and CNAs should not force the resident to eat.',
   '["True","False"]', 0,
   'At end-of-life, the body naturally slows down. CNAs should focus on comfort and dignity, not forcing food or fluids.', 4),
  (v_quiz_id, 'A sudden change in behavior in a resident with dementia—such as increased confusion or withdrawal—may be a sign of illness or infection.',
   '["True","False"]', 0,
   'Sudden changes are not normal dementia progression. They may indicate infection (like a UTI), pain, or other medical issues. CNAs must observe and report changes immediately.', 5);


  -- ─────────────────────────────────────────────────────────────
  -- MODULE 10 · Infection Control Advanced
  -- ─────────────────────────────────────────────────────────────
  IF NOT EXISTS (SELECT 1 FROM modules WHERE order_num = 10) THEN
    INSERT INTO modules (title, description, order_num, is_published)
    VALUES ('Infection Control Advanced',
            'Review comprehensive infection control including PPE, bloodborne pathogens, isolation, and reporting requirements.',
            10, true)
    RETURNING id INTO v_mod_id;
  ELSE
    SELECT id INTO v_mod_id FROM modules WHERE order_num = 10;
    UPDATE modules SET title = 'Infection Control Advanced', is_published = true WHERE id = v_mod_id;
  END IF;

  DELETE FROM quizzes WHERE module_id = v_mod_id AND title = 'True/False Quiz';
  INSERT INTO quizzes (module_id, title, passing_score)
  VALUES (v_mod_id, 'True/False Quiz', 70) RETURNING id INTO v_quiz_id;

  INSERT INTO quiz_questions (quiz_id, question, options, correct_answer, rationale, order_num) VALUES
  (v_quiz_id, 'Standard precautions apply to all patients.',
   '["True","False"]', 0,
   'All body fluids are considered potentially infectious.', 1),
  (v_quiz_id, 'PPE includes gloves, gowns, masks, and eye protection.',
   '["True","False"]', 0,
   'PPE protects both staff and patients from exposure.', 2),
  (v_quiz_id, 'Bloodborne pathogens include HIV, Hepatitis B, and Hepatitis C.',
   '["True","False"]', 0,
   'These pathogens are transmitted through blood or body fluids.', 3),
  (v_quiz_id, 'CNAs should remove PPE after leaving the patient room.',
   '["True","False"]', 0,
   'Proper removal prevents cross-contamination and protects the environment.', 4),
  (v_quiz_id, 'Hand hygiene is only necessary after patient care.',
   '["True","False"]', 1,
   'Hand hygiene should be performed before and after patient contact, and after glove removal, to prevent infection.', 5);


  -- ─────────────────────────────────────────────────────────────
  -- MODULE 11 · Safety & Emergency Procedures (Bonus)
  -- ─────────────────────────────────────────────────────────────
  IF NOT EXISTS (SELECT 1 FROM modules WHERE order_num = 11) THEN
    INSERT INTO modules (title, description, order_num, is_published)
    VALUES ('Safety & Emergency Procedures',
            'Learn fire safety protocols, RACE and PASS procedures, seizure management, and hazard reporting.',
            11, true)
    RETURNING id INTO v_mod_id;
  ELSE
    SELECT id INTO v_mod_id FROM modules WHERE order_num = 11;
    UPDATE modules SET title = 'Safety & Emergency Procedures', is_published = true WHERE id = v_mod_id;
  END IF;

  DELETE FROM quizzes WHERE module_id = v_mod_id AND title = 'True/False Quiz';
  INSERT INTO quizzes (module_id, title, passing_score)
  VALUES (v_mod_id, 'True/False Quiz', 70) RETURNING id INTO v_quiz_id;

  INSERT INTO quiz_questions (quiz_id, question, options, correct_answer, rationale, order_num) VALUES
  (v_quiz_id, 'CNAs must know fire and emergency procedures.',
   '["True","False"]', 0,
   'Knowledge of safety protocols ensures protection of staff and patients.', 1),
  (v_quiz_id, 'RACE stands for Rescue, Alarm, Contain, Extinguish.',
   '["True","False"]', 0,
   'RACE provides steps to respond effectively to fires.', 2),
  (v_quiz_id, 'PASS is used for operating a fire extinguisher.',
   '["True","False"]', 0,
   'PASS (Pull, Aim, Squeeze, Sweep) ensures safe and proper use.', 3),
  (v_quiz_id, 'CNAs should restrain patients during seizures to prevent injury.',
   '["True","False"]', 1,
   'Restraint is unsafe; patients should be protected from surroundings instead.', 4),
  (v_quiz_id, 'Reporting hazards and accidents is optional.',
   '["True","False"]', 1,
   'Reporting prevents further injury and ensures a safe environment.', 5);

  RAISE NOTICE 'Seed complete: 11 modules, 22 quizzes, 115 questions loaded.';
END $$;
