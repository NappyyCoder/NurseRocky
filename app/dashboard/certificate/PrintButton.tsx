"use client";

export function PrintButton({ label = "Print certificate" }: { label?: string }) {
  return (
    <button type="button" className="print-btn" onClick={() => window.print()}>
      {label}
      <style jsx>{`
        .print-btn {
          background: linear-gradient(180deg, #c0d9d2 0%, #93b7a9 100%);
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
