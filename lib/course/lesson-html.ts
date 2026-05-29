import { htmlForModule1Lesson } from "./module1-lesson-bodies";

/**
 * Prefer curated in-repo HTML where present; otherwise format the stored
 * Supabase `content` (which may be plain text) into clean lesson HTML.
 */
export function getAugmentedLessonHtml(
  moduleId: number,
  orderNum: number,
  storedContent: string | null
): string {
  const trimmed = (storedContent ?? "").trim();

  if (trimmed) {
    if (looksLikeHtml(trimmed)) return trimmed;
    return plainTextToLessonHtml(trimmed);
  }

  if (moduleId === 1) {
    return (htmlForModule1Lesson(orderNum) ?? "").trim();
  }

  return "";
}

/** Detect content that is already marked-up HTML so we leave it untouched. */
function looksLikeHtml(text: string): boolean {
  return /^<(section|div|article|h[1-6]|p|ul|ol)\b/i.test(text);
}

function escapeHtml(text: string): string {
  return text
    .replace(/&/g, "&amp;")
    .replace(/</g, "&lt;")
    .replace(/>/g, "&gt;");
}

const BULLET_RE = /^[-•*]\s+/;

/**
 * Convert plain-text lesson content into the same styled HTML structure the
 * lesson page expects (`.lesson-block`, `<p>`, `<p class="lead">`,
 * `<ul class="lesson-list">`). Blocks are separated by blank lines; lines that
 * begin with a dash/bullet become list items. The first paragraph is treated
 * as a lead-in.
 */
export function plainTextToLessonHtml(text: string): string {
  const trimmed = text.trim();
  if (!trimmed) return "";

  const blocks = trimmed.split(/\n\s*\n+/);
  const parts: string[] = [];
  let leadUsed = false;

  for (const block of blocks) {
    const lines = block
      .split("\n")
      .map((line) => line.trim())
      .filter(Boolean);

    let paragraphBuffer: string[] = [];

    const flushParagraph = () => {
      if (!paragraphBuffer.length) return;
      const cls = leadUsed ? "" : ' class="lead"';
      leadUsed = true;
      parts.push(`<p${cls}>${escapeHtml(paragraphBuffer.join(" "))}</p>`);
      paragraphBuffer = [];
    };

    let i = 0;
    while (i < lines.length) {
      if (BULLET_RE.test(lines[i])) {
        flushParagraph();
        const items: string[] = [];
        while (i < lines.length && BULLET_RE.test(lines[i])) {
          items.push(
            `<li>${escapeHtml(lines[i].replace(BULLET_RE, ""))}</li>`
          );
          i++;
        }
        parts.push(`<ul class="lesson-list">${items.join("")}</ul>`);
      } else {
        paragraphBuffer.push(lines[i]);
        i++;
      }
    }
    flushParagraph();
  }

  return `<section class="lesson-block">\n${parts.join("\n")}\n</section>`;
}
