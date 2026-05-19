-- Run once in Supabase SQL Editor on existing databases.
-- Paid checkout inserts a student row before Clerk exists; clerk_user_id is linked when they sign in.
ALTER TABLE students ALTER COLUMN clerk_user_id DROP NOT NULL;
