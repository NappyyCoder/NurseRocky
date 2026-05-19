"use client";

export function PrintButton({ label = "Print certificate" }: { label?: string }) {
  return (
    <button type="button" className="print-btn" onClick={() => window.print()}>
      {label}
      <style jsx>{`
        .print-btn {
          background: #0c7ab8;
          color: #fff;
          border: none;
          border-radius: 6px;
          padding: 0.5rem 1rem;
          font-weight: 600;
          cursor: pointer;
        }
      `}</style>
    </button>
  );
}
