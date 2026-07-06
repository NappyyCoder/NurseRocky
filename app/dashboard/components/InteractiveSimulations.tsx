"use client";

import { useEffect } from "react";

/** Makes static sim-card options in lesson 8 clickable with immediate feedback. */
export function InteractiveSimulations() {
  useEffect(() => {
    const cards = document.querySelectorAll(".lesson-body .sim-card");
    cards.forEach((card) => {
      const answerEl = card.querySelector(".sim-answer");
      if (!answerEl) return;

      const match = answerEl.textContent?.match(/Answer:\s*([A-D])/i);
      const correctLetter = match?.[1]?.toUpperCase();
      if (!correctLetter) return;

      answerEl.setAttribute("hidden", "true");
      card.querySelectorAll(".sim-rationale, .sim-feedback").forEach((el) => {
        (el as HTMLElement).style.display = "none";
      });

      const options = card.querySelectorAll(".lesson-list.options li");
      options.forEach((li, idx) => {
        const letter = String.fromCharCode(65 + idx);
        (li as HTMLElement).style.cursor = "pointer";
        (li as HTMLElement).style.padding = "0.5rem 0.65rem";
        (li as HTMLElement).style.borderRadius = "6px";
        (li as HTMLElement).style.transition = "background 0.15s";

        li.addEventListener("click", () => {
          options.forEach((o) => {
            (o as HTMLElement).style.background = "";
            (o as HTMLElement).style.fontWeight = "";
          });

          const isCorrect = letter === correctLetter;
          (li as HTMLElement).style.background = isCorrect ? "#e8f2ef" : "#fee2e2";
          (li as HTMLElement).style.fontWeight = "600";

          card.querySelectorAll(".sim-rationale, .sim-feedback").forEach((el) => {
            (el as HTMLElement).style.display = "block";
          });
          answerEl.removeAttribute("hidden");
        });
      });
    });
  }, []);

  return null;
}
