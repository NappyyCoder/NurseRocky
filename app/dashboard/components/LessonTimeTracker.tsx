"use client";

import { useEffect, useRef } from "react";

export function LessonTimeTracker({
  lessonId,
  moduleId,
}: {
  lessonId: string;
  moduleId: number;
}) {
  const sent = useRef(false);

  useEffect(() => {
    const tick = () => {
      fetch("/api/student/lesson-time", {
        method: "POST",
        headers: { "Content-Type": "application/json" },
        body: JSON.stringify({ lesson_id: lessonId, module_id: moduleId, seconds: 30 }),
      }).catch(() => {});
    };

    const interval = setInterval(tick, 30000);
    tick();

    const onLeave = () => {
      if (sent.current) return;
      sent.current = true;
      navigator.sendBeacon?.(
        "/api/student/lesson-time",
        new Blob(
          [JSON.stringify({ lesson_id: lessonId, module_id: moduleId, seconds: 15 })],
          { type: "application/json" }
        )
      );
    };

    window.addEventListener("beforeunload", onLeave);
    return () => {
      clearInterval(interval);
      window.removeEventListener("beforeunload", onLeave);
      onLeave();
    };
  }, [lessonId, moduleId]);

  return null;
}
