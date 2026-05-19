-- Optional rationales on quiz questions (admin-editable).
ALTER TABLE quiz_questions ADD COLUMN IF NOT EXISTS rationale TEXT;
