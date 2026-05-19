"use client";

import { useCallback, useState } from "react";
import Link from "next/link";

export function LessonSearch() {
  const [query, setQuery] = useState("");
  const [results, setResults] = useState<
    { href: string; lessonTitle: string; moduleTitle: string }[]
  >([]);

  const runSearch = useCallback(async (q: string) => {
    setQuery(q);
    if (q.trim().length < 2) {
      setResults([]);
      return;
    }
    const res = await fetch(`/api/student/search?q=${encodeURIComponent(q)}`);
    const rows = await res.json();
    setResults(Array.isArray(rows) ? rows : []);
  }, []);

  return (
    <div className="sp-search">
      <input
        type="search"
        placeholder="Search lessons by title…"
        value={query}
        onChange={(e) => runSearch(e.target.value)}
        aria-label="Search lessons"
      />
      {results.length > 0 && (
        <ul className="sp-search-results">
          {results.map((r) => (
            <li key={r.href}>
              <Link href={r.href}>
                <strong>{r.lessonTitle}</strong>
                <span>{r.moduleTitle}</span>
              </Link>
            </li>
          ))}
        </ul>
      )}
    </div>
  );
}
