"use client";

import { PrintButton } from "../certificate/PrintButton";
import Link from "next/link";

export function ReportHeader() {
  return (
    <header className="report-header no-print">
      <Link href="/dashboard">← Back to dashboard</Link>
      <PrintButton label="Print report" />
      <style dangerouslySetInnerHTML={{
        __html: `
          .report-header {
            max-width: 800px;
            margin: 0 auto 1.5rem;
            display: flex;
            justify-content: space-between;
            align-items: center;
          }
          .report-header a {
            color: #0c7ab8;
            font-weight: 600;
            text-decoration: none;
          }
        `,
      }} />
    </header>
  );
}
