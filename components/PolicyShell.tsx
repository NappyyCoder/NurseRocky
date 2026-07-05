import Link from "next/link";
import { POLICY_PAGES } from "@/lib/policies/content";
import { SiteNav } from "@/components/SiteNav";
import { BrandLogo } from "@/components/BrandLogo";

export function PolicyShell({
  title,
  children,
  isIndex = false,
}: {
  title: string;
  children: React.ReactNode;
  isIndex?: boolean;
}) {
  return (
    <>
      <SiteNav />

      <main className="policy-page">
        <div className={`container policy-page-inner${isIndex ? " policy-page-index" : ""}`}>
          <nav className="policy-bc" aria-label="Breadcrumb">
            <Link href="/">Home</Link>
            <span>/</span>
            {isIndex ? (
              <span>Policies</span>
            ) : (
              <>
                <Link href="/policies">Policies</Link>
                <span>/</span>
                <span>{title}</span>
              </>
            )}
          </nav>
          {children}
        </div>
      </main>

      <footer className="footer footer-policy">
        <div className="container">
          <div className="footer-grid">
            <div className="footer-brand">
              <BrandLogo href="/" height={150} />
              <p>Accelerated CNA training with clinical experience and career support.</p>
            </div>
            <div className="footer-col">
              <h4>Policies</h4>
              <ul>
                {POLICY_PAGES.slice(0, 4).map((p) => (
                  <li key={p.slug}><Link href={`/policies/${p.slug}`}>{p.title}</Link></li>
                ))}
              </ul>
            </div>
            <div className="footer-col">
              <h4>Compliance</h4>
              <ul>
                {POLICY_PAGES.slice(4).map((p) => (
                  <li key={p.slug}><Link href={`/policies/${p.slug}`}>{p.title}</Link></li>
                ))}
              </ul>
            </div>
            <div className="footer-col">
              <h4>Program</h4>
              <ul>
                <li><Link href="/#program">Overview</Link></li>
                <li><Link href="/enroll">Apply Now</Link></li>
                <li><Link href="/sign-in">Student Sign In</Link></li>
              </ul>
            </div>
          </div>
          <div className="footer-bottom">
            <p>© {new Date().getFullYear()} Nurse Rocky. All rights reserved.</p>
            <p><Link href="/policies">Policies &amp; Compliance</Link></p>
          </div>
        </div>
      </footer>

      {/* mobile nav from SiteNav */}
    </>
  );
}
