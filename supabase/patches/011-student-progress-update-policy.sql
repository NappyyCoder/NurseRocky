-- Ensure lesson completion columns and policies exist.
-- Run in: Supabase Dashboard → SQL Editor

ALTER TABLE student_progress
  ADD COLUMN IF NOT EXISTS completed_at TIMESTAMPTZ,
  ADD COLUMN IF NOT EXISTS last_accessed_at TIMESTAMPTZ,
  ADD COLUMN IF NOT EXISTS time_spent_sec INT DEFAULT 0;

ALTER TABLE students
  ADD COLUMN IF NOT EXISTS last_lesson_id UUID REFERENCES lessons(id) ON DELETE SET NULL,
  ADD COLUMN IF NOT EXISTS last_module_id INT REFERENCES modules(id) ON DELETE SET NULL,
  ADD COLUMN IF NOT EXISTS policies_acknowledged_at TIMESTAMPTZ;

CREATE TABLE IF NOT EXISTS student_policy_acknowledgments (
  id              UUID PRIMARY KEY DEFAULT gen_random_uuid(),
  student_id      UUID REFERENCES students(id) ON DELETE CASCADE,
  policy_slug     TEXT NOT NULL,
  acknowledged_at TIMESTAMPTZ DEFAULT NOW(),
  UNIQUE(student_id, policy_slug)
);

CREATE INDEX IF NOT EXISTS idx_policy_ack_student
  ON student_policy_acknowledgments(student_id);

CREATE UNIQUE INDEX IF NOT EXISTS student_progress_student_lesson_uidx
  ON student_progress (student_id, lesson_id);

DO $$
BEGIN
  IF NOT EXISTS (
    SELECT 1 FROM pg_policies
    WHERE tablename = 'student_progress'
      AND policyname = 'progress_own_update'
  ) THEN
    CREATE POLICY "progress_own_update"
      ON student_progress FOR UPDATE
      USING (student_id IN (
        SELECT id FROM students
        WHERE clerk_user_id = current_setting('request.jwt.claims', TRUE)::jsonb->>'sub'
      ))
      WITH CHECK (student_id IN (
        SELECT id FROM students
        WHERE clerk_user_id = current_setting('request.jwt.claims', TRUE)::jsonb->>'sub'
      ));
  END IF;
END $$;
