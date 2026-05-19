-- Student portal enhancements: announcements, resources, policies, checklist, lesson time.

ALTER TABLE student_progress
  ADD COLUMN IF NOT EXISTS time_spent_sec INT DEFAULT 0,
  ADD COLUMN IF NOT EXISTS last_accessed_at TIMESTAMPTZ;

ALTER TABLE students
  ADD COLUMN IF NOT EXISTS last_lesson_id UUID REFERENCES lessons(id) ON DELETE SET NULL,
  ADD COLUMN IF NOT EXISTS last_module_id INT REFERENCES modules(id) ON DELETE SET NULL,
  ADD COLUMN IF NOT EXISTS policies_acknowledged_at TIMESTAMPTZ;

CREATE TABLE IF NOT EXISTS announcements (
  id              UUID PRIMARY KEY DEFAULT gen_random_uuid(),
  title           TEXT NOT NULL,
  body            TEXT NOT NULL,
  is_active       BOOLEAN DEFAULT TRUE,
  expires_at      TIMESTAMPTZ,
  created_at      TIMESTAMPTZ DEFAULT NOW()
);

CREATE TABLE IF NOT EXISTS course_resources (
  id              UUID PRIMARY KEY DEFAULT gen_random_uuid(),
  module_id       INT REFERENCES modules(id) ON DELETE SET NULL,
  title           TEXT NOT NULL,
  url             TEXT NOT NULL,
  resource_type   TEXT DEFAULT 'link',
  description     TEXT,
  order_num       INT DEFAULT 1,
  created_at      TIMESTAMPTZ DEFAULT NOW()
);

CREATE TABLE IF NOT EXISTS student_policy_acknowledgments (
  id              UUID PRIMARY KEY DEFAULT gen_random_uuid(),
  student_id      UUID REFERENCES students(id) ON DELETE CASCADE,
  policy_slug     TEXT NOT NULL,
  acknowledged_at TIMESTAMPTZ DEFAULT NOW(),
  UNIQUE(student_id, policy_slug)
);

CREATE TABLE IF NOT EXISTS student_checklist (
  id              UUID PRIMARY KEY DEFAULT gen_random_uuid(),
  student_id      UUID REFERENCES students(id) ON DELETE CASCADE,
  item_key        TEXT NOT NULL,
  completed       BOOLEAN DEFAULT FALSE,
  completed_at    TIMESTAMPTZ,
  UNIQUE(student_id, item_key)
);

CREATE TABLE IF NOT EXISTS support_messages (
  id              UUID PRIMARY KEY DEFAULT gen_random_uuid(),
  student_id      UUID REFERENCES students(id) ON DELETE CASCADE,
  subject         TEXT NOT NULL,
  message         TEXT NOT NULL,
  created_at      TIMESTAMPTZ DEFAULT NOW()
);

CREATE INDEX IF NOT EXISTS idx_announcements_active ON announcements(is_active);
CREATE INDEX IF NOT EXISTS idx_resources_module ON course_resources(module_id);
CREATE INDEX IF NOT EXISTS idx_policy_ack_student ON student_policy_acknowledgments(student_id);
CREATE INDEX IF NOT EXISTS idx_checklist_student ON student_checklist(student_id);

-- Sample announcement (inactive by default — admin can activate)
INSERT INTO announcements (title, body, is_active)
SELECT 'Welcome to Nurse Rocky', 'Complete Module 1 lessons, then take the Quiz and Test. Contact us if you need help.', FALSE
WHERE NOT EXISTS (SELECT 1 FROM announcements LIMIT 1);

-- Textbook / resources placeholder
INSERT INTO course_resources (module_id, title, url, resource_type, description, order_num)
SELECT 1, 'Module 1 — Policy Handbook', '/policies/policy-handbook', 'link', 'Required reading for Module 1', 1
WHERE NOT EXISTS (SELECT 1 FROM course_resources LIMIT 1);

INSERT INTO course_resources (module_id, title, url, resource_type, description, order_num)
SELECT NULL, 'Nurse Rocky Student Policies', '/policies', 'link', 'All program policies and compliance documents', 2
WHERE (SELECT COUNT(*) FROM course_resources) < 2;
