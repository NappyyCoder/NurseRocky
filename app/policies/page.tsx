import Link from "next/link";
import type { Metadata } from "next";
import { PolicyShell } from "@/components/PolicyShell";
import { POLICY_PAGES } from "@/lib/policies/content";

export const metadata: Metadata = {
  title: "Policies & Compliance | Nurse Rocky",
  description:
    "Privacy Policy, Terms of Service, ADA Accommodations, Academic Integrity, and other Nurse Rocky program policies.",
};

export default function PoliciesIndexPage() {
  return (
    <PolicyShell title="Policies & Compliance" isIndex>
      <header className="policy-header">
        <h1>Policies &amp; Compliance</h1>
        <p className="policy-subtitle">
          Nurse Rocky program policies, student responsibilities, and regulatory compliance documents.
        </p>
      </header>

      <div className="policy-index-grid policy-index-grid-full">
        {POLICY_PAGES.map((p) => (
          <Link key={p.slug} href={`/policies/${p.slug}`} className="policy-index-card">
            <h2>{p.title}</h2>
            <p>{p.subtitle}</p>
            <span className="policy-index-link">Read policy →</span>
          </Link>
        ))}
      </div>
    </PolicyShell>
  );
}
