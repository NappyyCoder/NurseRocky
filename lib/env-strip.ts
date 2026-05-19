/** Next.js/dotenv occasionally leaves wrapping quotes — breaks URLs and JWT keys. */
export function stripSurroundingQuotes(value: string | undefined): string {
  let s = (value ?? "").trim();
  if (
    (s.startsWith('"') && s.endsWith('"')) ||
    (s.startsWith("'") && s.endsWith("'"))
  ) {
    s = s.slice(1, -1).trim();
  }
  return s;
}
