import Link from "next/link";
import { BrandLogo } from "@/components/BrandLogo";

const NAV_LINKS = [
  { href: "/#careers", label: "Careers" },
  { href: "/#different", label: "About" },
  { href: "/#program", label: "Program" },
  { href: "/#tuition", label: "Tuition" },
  { href: "/policies", label: "Policies" },
] as const;

export function SiteNav() {
  return (
    <>
      <nav className="nav">
        <div className="nav-inner">
          <BrandLogo href="/" className="nav-logo" height={360} priority />
          <ul className="nav-links">
            {NAV_LINKS.map((link) => (
              <li key={link.href}>
                <Link href={link.href}>{link.label}</Link>
              </li>
            ))}
          </ul>
          <div className="nav-actions">
            <Link href="/sign-in" className="nav-signin">
              Student Sign In
            </Link>
            <Link href="/enroll" className="nav-cta">
              Enroll Now
            </Link>
          </div>
        </div>
      </nav>

      <nav className="mobile-nav" aria-label="Mobile navigation">
        <Link href="/#careers" className="mobile-nav-item">
          <svg viewBox="0 0 24 24" fill="none" stroke="currentColor" strokeWidth="2" strokeLinecap="round" strokeLinejoin="round">
            <rect x="2" y="7" width="20" height="14" rx="2" />
            <path d="M16 7V5a2 2 0 0 0-2-2h-4a2 2 0 0 0-2 2v2" />
          </svg>
          <span>Careers</span>
        </Link>
        <Link href="/sign-in" className="mobile-nav-item">
          <svg viewBox="0 0 24 24" fill="none" stroke="currentColor" strokeWidth="2" strokeLinecap="round" strokeLinejoin="round">
            <path d="M20 21v-2a4 4 0 0 0-4-4H8a4 4 0 0 0-4 4v2" />
            <circle cx="12" cy="7" r="4" />
          </svg>
          <span>Sign In</span>
        </Link>
        <Link href="/enroll" className="mobile-nav-cta">
          <div className="mobile-nav-cta-bubble">
            <svg viewBox="0 0 24 24" fill="none" stroke="currentColor" strokeWidth="2.5" strokeLinecap="round" strokeLinejoin="round">
              <path d="M5 12h14M12 5l7 7-7 7" />
            </svg>
          </div>
          <span>Enroll</span>
        </Link>
        <Link href="/policies" className="mobile-nav-item">
          <svg viewBox="0 0 24 24" fill="none" stroke="currentColor" strokeWidth="2" strokeLinecap="round" strokeLinejoin="round">
            <path d="M14 2H6a2 2 0 0 0-2 2v16a2 2 0 0 0 2 2h12a2 2 0 0 0 2-2V8z" />
            <polyline points="14 2 14 8 20 8" />
            <line x1="16" y1="13" x2="8" y2="13" />
            <line x1="16" y1="17" x2="8" y2="17" />
          </svg>
          <span>Policies</span>
        </Link>
        <Link href="/#program" className="mobile-nav-item">
          <svg viewBox="0 0 24 24" fill="none" stroke="currentColor" strokeWidth="2" strokeLinecap="round" strokeLinejoin="round">
            <rect x="3" y="4" width="18" height="18" rx="2" />
            <line x1="16" y1="2" x2="16" y2="6" />
            <line x1="8" y1="2" x2="8" y2="6" />
            <line x1="3" y1="10" x2="21" y2="10" />
          </svg>
          <span>Program</span>
        </Link>
      </nav>
    </>
  );
}
