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

/** Strip boilerplate prefixes so lesson headings read like clear titles. */
const LEADING_VERBS_RE =
  /^(?:Demonstrates|Explains|Describes|Identifies|Applies|Uses|Maintains|Provides|Responds|Observes|Utilizes)\s+(?:the\s+)?/i;

function cleanTitleWords(text: string): string {
  let t = text.trim();
  t = t.replace(LEADING_VERBS_RE, "");
  t = t.replace(/\s+as Outlined in .+$/i, "");
  t = t.replace(/\s+Within a Care Facility$/i, "");
  t = t.replace(/\s+According to Recognized Standards of Care$/i, "");
  t = t.replace(/\s+and\/or Community$/i, "");
  return t.trim();
}

function formatHeadingText(line: string, level: "h2" | "h3" | "h4"): string {
  let text = line.trim();

  // Competency 1.5: Title…
  text = text.replace(/^Competency\s+\d+(?:\.\d+)?:\s*/i, "");
  // 6.0 Competency: Title…
  text = text.replace(/^\d+(?:\.\d+)?\s+Competency:\s*/i, "");

  // Learning Goal 1.5 → Learning Goal
  if (/^Learning Goal\s+\d+(?:\.\d+)?$/i.test(text)) {
    return "Learning Goal";
  }

  const subNum = text.match(/^(\d+\.\d+)\s+(.+)$/);
  if (subNum && level === "h2") {
    return `${subNum[1]} · ${cleanTitleWords(subNum[2])}`;
  }

  const letter = text.match(/^([A-G])\.\s+(.+)$/);
  if (letter && level === "h3") {
    return cleanTitleWords(letter[2]);
  }

  const num = text.match(/^(\d+)\.\s+(.+)$/);
  if (num && level === "h4") {
    return `${num[1]}. ${cleanTitleWords(num[2])}`;
  }

  return cleanTitleWords(text);
}

/**
 * Classify a single line to determine whether it should render as a heading
 * or body text.  Returns the heading tag ('h2' | 'h3' | 'h4') or null.
 *
 * Rules (in order):
 *  • Lines ending in ':' are always intro/body text, never headings.
 *  • "4.1 Title…" / "4.2 Title…" sub-competency numbers → h2
 *  • "A. Title…" / "B. Title…" lettered sections → h3
 *  • "1. Title…" / "2. Title…" numbered sub-sections → h4
 *  • Short title-cased standalone phrases with no common verb words → h2
 */
function headingLevel(line: string): "h2" | "h3" | "h4" | null {
  if (line.endsWith(":")) return null;

  // "Competency 1.5: …" — lesson competency title
  if (/^Competency \d+\.\d+:/i.test(line)) return "h2";

  // "4.1 Uses Verbal…"
  if (/^\d+\.\d+\s+[A-Z]/.test(line)) return "h2";

  // "A. Uses Appropriate…" through "G. …"
  if (/^[A-G]\.\s+[A-Z]/.test(line)) return "h3";

  // "1. Emergencies vs…"
  if (/^\d+\.\s+[A-Z]/.test(line)) return "h4";

  // Named section titles: short, no terminal period, starts uppercase,
  // no common verb words that would indicate a regular sentence.
  const VERB_RE =
    /\b(should|must|are|is|will|can|have|has|may|need|include|follow|ensure|help|provide)\b/i;
  if (
    line.length <= 72 &&
    /^[A-Z]/.test(line) &&
    !line.endsWith(".") &&
    !VERB_RE.test(line)
  ) {
    return "h2";
  }

  return null;
}

/**
 * Convert plain-text lesson content into the same styled HTML structure the
 * lesson page expects (`.lesson-block`, headings, `<p>`, `<p class="lead">`,
 * `<ul class="lesson-list">`).
 *
 * Blank lines create new blocks; lines beginning with a bullet become list
 * items; lines matching heading patterns become <h2/h3/h4>; everything else
 * is a <p>.  The very first paragraph is given class="lead".
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
      const line = lines[i];

      if (BULLET_RE.test(line)) {
        flushParagraph();
        const items: string[] = [];
        while (i < lines.length && BULLET_RE.test(lines[i])) {
          items.push(
            `<li>${escapeHtml(lines[i].replace(BULLET_RE, ""))}</li>`
          );
          i++;
        }
        parts.push(`<ul class="lesson-list">${items.join("")}</ul>`);
        continue;
      }

      const level = headingLevel(line);
      if (level) {
        flushParagraph();
        leadUsed = true; // headings count as "used" so next real text isn't a lead
        parts.push(
          `<${level} class="lc-heading lc-${level}">${escapeHtml(formatHeadingText(line, level))}</${level}>`
        );
        i++;
        continue;
      }

      paragraphBuffer.push(line);
      i++;
    }
    flushParagraph();
  }

  return `<section class="lesson-block">\n${parts.join("\n")}\n</section>`;
}
