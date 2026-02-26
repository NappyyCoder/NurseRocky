-- ============================================================
-- Nurse Rocky — Database Schema
-- Run this entire file in: Supabase Dashboard → SQL Editor
-- ============================================================

-- ── Students ─────────────────────────────────────────────────
-- One row per enrolled student, linked to their Clerk user ID.
CREATE TABLE IF NOT EXISTS students (
  id              UUID PRIMARY KEY DEFAULT gen_random_uuid(),
  clerk_user_id   TEXT UNIQUE NOT NULL,
  email           TEXT UNIQUE NOT NULL,
  first_name      TEXT,
  last_name       TEXT,
  enrolled               BOOLEAN DEFAULT FALSE,
  enrolled_at            TIMESTAMPTZ,
  stripe_customer_id     TEXT,
  stripe_payment_intent  TEXT,
  created_at             TIMESTAMPTZ DEFAULT NOW()
);

-- ── Modules ──────────────────────────────────────────────────
-- Course modules (each contains lessons and a quiz).
CREATE TABLE IF NOT EXISTS modules (
  id              SERIAL PRIMARY KEY,
  title           TEXT NOT NULL,
  description     TEXT,
  order_num       INT NOT NULL,
  lessons_count   INT DEFAULT 0,
  duration_min    INT DEFAULT 0,
  is_published    BOOLEAN DEFAULT TRUE,
  created_at      TIMESTAMPTZ DEFAULT NOW()
);

-- ── Lessons ──────────────────────────────────────────────────
-- Individual video/text lessons within a module.
CREATE TABLE IF NOT EXISTS lessons (
  id              UUID PRIMARY KEY DEFAULT gen_random_uuid(),
  module_id       INT REFERENCES modules(id) ON DELETE CASCADE,
  title           TEXT NOT NULL,
  video_url       TEXT,
  content         TEXT,
  duration_min    INT DEFAULT 0,
  order_num       INT NOT NULL,
  created_at      TIMESTAMPTZ DEFAULT NOW()
);

-- ── Quizzes ──────────────────────────────────────────────────
CREATE TABLE IF NOT EXISTS quizzes (
  id              UUID PRIMARY KEY DEFAULT gen_random_uuid(),
  module_id       INT REFERENCES modules(id) ON DELETE CASCADE,
  title           TEXT NOT NULL,
  passing_score   INT DEFAULT 70,
  created_at      TIMESTAMPTZ DEFAULT NOW()
);

-- ── Quiz Questions ────────────────────────────────────────────
-- options stored as JSONB array: ["Option A","Option B",...]
CREATE TABLE IF NOT EXISTS quiz_questions (
  id              UUID PRIMARY KEY DEFAULT gen_random_uuid(),
  quiz_id         UUID REFERENCES quizzes(id) ON DELETE CASCADE,
  question        TEXT NOT NULL,
  options         JSONB NOT NULL,
  correct_answer  INT NOT NULL,   -- index into options array (0-based)
  order_num       INT NOT NULL
);

-- ── Student Progress ─────────────────────────────────────────
-- Tracks which modules and lessons each student has completed.
CREATE TABLE IF NOT EXISTS student_progress (
  id              UUID PRIMARY KEY DEFAULT gen_random_uuid(),
  student_id      UUID REFERENCES students(id) ON DELETE CASCADE,
  module_id       INT REFERENCES modules(id) ON DELETE CASCADE,
  lesson_id       UUID REFERENCES lessons(id) ON DELETE CASCADE,
  completed       BOOLEAN DEFAULT FALSE,
  completed_at    TIMESTAMPTZ,
  UNIQUE(student_id, lesson_id)
);

-- ── Quiz Attempts ─────────────────────────────────────────────
-- Stores every quiz attempt a student makes.
CREATE TABLE IF NOT EXISTS quiz_attempts (
  id              UUID PRIMARY KEY DEFAULT gen_random_uuid(),
  student_id      UUID REFERENCES students(id) ON DELETE CASCADE,
  quiz_id         UUID REFERENCES quizzes(id) ON DELETE CASCADE,
  score           INT NOT NULL,
  passed          BOOLEAN NOT NULL,
  answers         JSONB,          -- student's submitted answers
  attempted_at    TIMESTAMPTZ DEFAULT NOW()
);

-- ── Clinical Hours ────────────────────────────────────────────
-- Admin logs approved clinical hours per student.
CREATE TABLE IF NOT EXISTS clinical_hours (
  id              UUID PRIMARY KEY DEFAULT gen_random_uuid(),
  student_id      UUID REFERENCES students(id) ON DELETE CASCADE,
  hours           NUMERIC(5,2) NOT NULL,
  notes           TEXT,
  date            DATE NOT NULL,
  approved_by     TEXT,
  created_at      TIMESTAMPTZ DEFAULT NOW()
);

-- ============================================================
-- ROW LEVEL SECURITY
-- ============================================================

ALTER TABLE students         ENABLE ROW LEVEL SECURITY;
ALTER TABLE student_progress ENABLE ROW LEVEL SECURITY;
ALTER TABLE quiz_attempts    ENABLE ROW LEVEL SECURITY;
ALTER TABLE clinical_hours   ENABLE ROW LEVEL SECURITY;
ALTER TABLE modules          ENABLE ROW LEVEL SECURITY;
ALTER TABLE lessons          ENABLE ROW LEVEL SECURITY;
ALTER TABLE quizzes          ENABLE ROW LEVEL SECURITY;
ALTER TABLE quiz_questions   ENABLE ROW LEVEL SECURITY;

-- Modules & lessons are readable by everyone (used on landing page too)
CREATE POLICY "modules_public_read"
  ON modules FOR SELECT USING (is_published = TRUE);

CREATE POLICY "lessons_public_read"
  ON lessons FOR SELECT USING (TRUE);

CREATE POLICY "quizzes_public_read"
  ON quizzes FOR SELECT USING (TRUE);

CREATE POLICY "quiz_questions_public_read"
  ON quiz_questions FOR SELECT USING (TRUE);

-- Students can only read/update their own record
CREATE POLICY "students_own_read"
  ON students FOR SELECT
  USING (clerk_user_id = current_setting('request.jwt.claims', TRUE)::jsonb->>'sub');

CREATE POLICY "students_own_update"
  ON students FOR UPDATE
  USING (clerk_user_id = current_setting('request.jwt.claims', TRUE)::jsonb->>'sub');

-- Students can read/insert their own progress
CREATE POLICY "progress_own_read"
  ON student_progress FOR SELECT
  USING (student_id IN (
    SELECT id FROM students
    WHERE clerk_user_id = current_setting('request.jwt.claims', TRUE)::jsonb->>'sub'
  ));

CREATE POLICY "progress_own_insert"
  ON student_progress FOR INSERT
  WITH CHECK (student_id IN (
    SELECT id FROM students
    WHERE clerk_user_id = current_setting('request.jwt.claims', TRUE)::jsonb->>'sub'
  ));

-- Students can read/insert their own quiz attempts
CREATE POLICY "attempts_own_read"
  ON quiz_attempts FOR SELECT
  USING (student_id IN (
    SELECT id FROM students
    WHERE clerk_user_id = current_setting('request.jwt.claims', TRUE)::jsonb->>'sub'
  ));

CREATE POLICY "attempts_own_insert"
  ON quiz_attempts FOR INSERT
  WITH CHECK (student_id IN (
    SELECT id FROM students
    WHERE clerk_user_id = current_setting('request.jwt.claims', TRUE)::jsonb->>'sub'
  ));

-- Students can read their own clinical hours
CREATE POLICY "clinical_own_read"
  ON clinical_hours FOR SELECT
  USING (student_id IN (
    SELECT id FROM students
    WHERE clerk_user_id = current_setting('request.jwt.claims', TRUE)::jsonb->>'sub'
  ));

-- ============================================================
-- INDEXES  (for fast lookups)
-- ============================================================
CREATE INDEX IF NOT EXISTS idx_students_clerk       ON students(clerk_user_id);
CREATE INDEX IF NOT EXISTS idx_progress_student     ON student_progress(student_id);
CREATE INDEX IF NOT EXISTS idx_progress_module      ON student_progress(module_id);
CREATE INDEX IF NOT EXISTS idx_attempts_student     ON quiz_attempts(student_id);
CREATE INDEX IF NOT EXISTS idx_clinical_student     ON clinical_hours(student_id);
CREATE INDEX IF NOT EXISTS idx_lessons_module       ON lessons(module_id);
CREATE INDEX IF NOT EXISTS idx_questions_quiz       ON quiz_questions(quiz_id);
