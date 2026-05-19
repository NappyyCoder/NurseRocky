import Link from "next/link";
import { notFound } from "next/navigation";
import type { Metadata } from "next";
import { PolicyShell } from "@/components/PolicyShell";
import { PolicyDocumentImage } from "@/components/PolicyDocumentImage";
import { POLICY_BY_SLUG, POLICY_PAGES } from "@/lib/policies/content";

export function generateStaticParams() {
  return POLICY_PAGES.map((p) => ({ slug: p.slug }));
}

export async function generateMetadata(props: {
  params: Promise<{ slug: string }>;
}): Promise<Metadata> {
  const { slug } = await props.params;
  const policy = POLICY_BY_SLUG[slug];
  if (!policy) return { title: "Policy | Nurse Rocky" };
  return {
    title: `${policy.title} | Nurse Rocky`,
    description: policy.subtitle,
  };
}

export default async function PolicyDocumentPage(props: {
  params: Promise<{ slug: string }>;
}) {
  const { slug } = await props.params;
  const policy = POLICY_BY_SLUG[slug];
  if (!policy) notFound();

  return (
    <PolicyShell title={policy.title}>
      <header className="policy-header">
        <h1>{policy.title}</h1>
        <p className="policy-subtitle">{policy.subtitle}</p>
        <p className="policy-updated">Last updated: {policy.lastUpdated}</p>
      </header>

      {policy.documentImage && (
        <PolicyDocumentImage
          src={policy.documentImage}
          alt={`${policy.title} document`}
        />
      )}

      <article className="policy-prose">
        {policy.sections.map((section, i) => (
          <section key={i} className="policy-section">
            {section.heading && <h2>{section.heading}</h2>}
            {section.paragraphs?.map((p, j) => (
              <p key={j}>{p}</p>
            ))}
            {section.list && (
              <ul>
                {section.list.map((item, k) => (
                  <li key={k}>{item}</li>
                ))}
              </ul>
            )}
          </section>
        ))}
      </article>

      <aside className="policy-related">
        <h3>Related policies</h3>
        <ul>
          {POLICY_PAGES.filter((p) => p.slug !== slug).map((p) => (
            <li key={p.slug}>
              <Link href={`/policies/${p.slug}`}>{p.title}</Link>
            </li>
          ))}
        </ul>
      </aside>
    </PolicyShell>
  );
}
