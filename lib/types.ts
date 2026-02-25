// ── Database Types ────────────────────────────────────────────

export interface Student {
  id: string;
  clerk_user_id: string;
  email: string;
  first_name: string | null;
  last_name: string | null;
  enrolled: boolean;
  enrolled_at: string | null;
  created_at: string;
}

export interface Module {
  id: number;
  title: string;
  description: string | null;
  order_num: number;
  lessons_count: number;
  duration_min: number;
  is_published: boolean;
  created_at: string;
}

export interface Lesson {
  id: string;
  module_id: number;
  title: string;
  video_url: string | null;
  content: string | null;
  duration_min: number;
  order_num: number;
  created_at: string;
}

export interface Quiz {
  id: string;
  module_id: number;
  title: string;
  passing_score: number;
  created_at: string;
}

export interface QuizQuestion {
  id: string;
  quiz_id: string;
  question: string;
  options: string[];
  correct_answer: number;
  order_num: number;
}

export interface StudentProgress {
  id: string;
  student_id: string;
  module_id: number;
  lesson_id: string;
  completed: boolean;
  completed_at: string | null;
}

export interface QuizAttempt {
  id: string;
  student_id: string;
  quiz_id: string;
  score: number;
  passed: boolean;
  answers: number[] | null;
  attempted_at: string;
}

export interface ClinicalHours {
  id: string;
  student_id: string;
  hours: number;
  notes: string | null;
  date: string;
  approved_by: string | null;
  created_at: string;
}
