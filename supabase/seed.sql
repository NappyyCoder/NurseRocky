-- ============================================================
-- Nurse Rocky — Seed Data
-- Run AFTER schema.sql in: Supabase Dashboard → SQL Editor
-- ============================================================

-- ── Modules ──────────────────────────────────────────────────
INSERT INTO modules (title, description, order_num, lessons_count, duration_min, is_published)
VALUES
  (
    'Introduction to the CNA Role',
    'Overview of the CNA profession, daily responsibilities, the healthcare team, and professional standards of conduct.',
    1, 4, 45, TRUE
  ),
  (
    'Patient Rights & Safety',
    'Understanding patient rights, HIPAA basics, confidentiality, safety protocols, and how to report concerns.',
    2, 5, 60, TRUE
  ),
  (
    'Infection Control',
    'Hand hygiene, personal protective equipment (PPE), standard precautions, isolation procedures, and preventing healthcare-associated infections.',
    3, 4, 50, TRUE
  ),
  (
    'Basic Nursing Skills',
    'Vital signs, bed making, personal care, repositioning patients, transfers, range-of-motion exercises, and documenting care.',
    4, 8, 90, TRUE
  ),
  (
    'Clinical Practice Prep',
    'What to expect during clinical rotations, how to communicate with the care team, professionalism in the clinical setting.',
    5, 3, 40, TRUE
  ),
  (
    'State Exam Preparation',
    'Practice tests, test-taking strategies, what to bring on exam day, and how the written and skills exams are scored.',
    6, 6, 75, TRUE
  )
ON CONFLICT DO NOTHING;

-- ── Sample Quiz for Module 1 ──────────────────────────────────
INSERT INTO quizzes (module_id, title, passing_score)
VALUES (1, 'Introduction to CNA Role — Knowledge Check', 70)
ON CONFLICT DO NOTHING;

-- Get the quiz id and insert questions
WITH q AS (SELECT id FROM quizzes WHERE title = 'Introduction to CNA Role — Knowledge Check' LIMIT 1)
INSERT INTO quiz_questions (quiz_id, question, options, correct_answer, order_num)
VALUES
  (
    (SELECT id FROM q),
    'What does CNA stand for?',
    '["Certified Nursing Assistant","Clinical Nursing Aide","Certified Nursing Aide","Care Nursing Assistant"]',
    0, 1
  ),
  (
    (SELECT id FROM q),
    'Who does a CNA primarily work under the supervision of?',
    '["A Physician","A Registered Nurse or Licensed Practical Nurse","A Hospital Administrator","A Physical Therapist"]',
    1, 2
  ),
  (
    (SELECT id FROM q),
    'Which of the following is a core responsibility of a CNA?',
    '["Prescribing medication","Performing surgery","Assisting with activities of daily living","Diagnosing illness"]',
    2, 3
  ),
  (
    (SELECT id FROM q),
    'How long is the Nurse Rocky CNA program?',
    '["6 months","30–45 days","1 year","3 months"]',
    1, 4
  ),
  (
    (SELECT id FROM q),
    'Which setting does a CNA NOT typically work in?',
    '["Hospital","Long-term care facility","Home health","Pharmacy dispensary"]',
    3, 5
  )
ON CONFLICT DO NOTHING;
