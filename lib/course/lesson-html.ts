import { htmlForModule1Lesson } from "./module1-lesson-bodies";

/**
 * Prefer curated in-repo HTML where present; fall back to Supabase `content`.
 */
export function getAugmentedLessonHtml(
  moduleId: number,
  orderNum: number,
  storedContent: string | null
): string {
  const trimmed = (storedContent ?? "").trim();
  if (trimmed) return trimmed;
  if (moduleId === 1) {
    return (htmlForModule1Lesson(orderNum) ?? "").trim();
  }
  return "";
}
