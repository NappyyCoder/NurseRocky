"use client";

import Link from "next/link";
import { usePathname } from "next/navigation";
import { UserButton } from "@clerk/nextjs";
import { PolicyAckModal } from "./PolicyAckModal";
import { useState } from "react";

const NAV = [
  {
    href: "/dashboard",
    label: "Overview",
    match: (p: string) => p === "/dashboard",
    icon: (
      <svg viewBox="0 0 24 24" fill="none" stroke="currentColor" strokeWidth="2" strokeLinecap="round">
        <rect x="3" y="3" width="7" height="7" /><rect x="14" y="3" width="7" height="7" />
        <rect x="3" y="14" width="7" height="7" /><rect x="14" y="14" width="7" height="7" />
      </svg>
    ),
  },
  {
    href: "/dashboard/modules",
    label: "Modules",
    match: (p: string) => p === "/dashboard/modules" || p.startsWith("/dashboard/modules/"),
    icon: (
      <svg viewBox="0 0 24 24" fill="none" stroke="currentColor" strokeWidth="2" strokeLinecap="round">
        <path d="M4 19.5A2.5 2.5 0 0 1 6.5 17H20" /><path d="M6.5 2H20v20H6.5A2.5 2.5 0 0 1 4 19.5v-15A2.5 2.5 0 0 1 6.5 2z" />
      </svg>
    ),
  },
  {
    href: "/dashboard/grades",
    label: "Grades",
    match: (p: string) => p === "/dashboard/grades",
    icon: (
      <svg viewBox="0 0 24 24" fill="none" stroke="currentColor" strokeWidth="2" strokeLinecap="round">
        <path d="M9 11l3 3L22 4" /><path d="M21 12v7a2 2 0 0 1-2 2H5a2 2 0 0 1-2-2V5a2 2 0 0 1 2-2h11" />
      </svg>
    ),
  },
  {
    href: "/dashboard/clinical",
    label: "Clinical",
    match: (p: string) => p === "/dashboard/clinical",
    icon: (
      <svg viewBox="0 0 24 24" fill="none" stroke="currentColor" strokeWidth="2" strokeLinecap="round">
        <path d="M22 12h-4l-3 9L9 3l-3 9H2" />
      </svg>
    ),
  },
  {
    href: "/dashboard/resources",
    label: "Resources",
    match: (p: string) => p === "/dashboard/resources",
    icon: (
      <svg viewBox="0 0 24 24" fill="none" stroke="currentColor" strokeWidth="2" strokeLinecap="round">
        <path d="M14 2H6a2 2 0 0 0-2 2v16a2 2 0 0 0 2 2h12a2 2 0 0 0 2-2V8z" /><polyline points="14 2 14 8 20 8" />
      </svg>
    ),
  },
  {
    href: "/dashboard/support",
    label: "Support",
    match: (p: string) => p === "/dashboard/support",
    icon: (
      <svg viewBox="0 0 24 24" fill="none" stroke="currentColor" strokeWidth="2" strokeLinecap="round">
        <path d="M4 4h16c1.1 0 2 .9 2 2v12c0 1.1-.9 2-2 2H4c-1.1 0-2-.9-2-2V6c0-1.1.9-2 2-2z" /><polyline points="22,6 12,13 2,6" />
      </svg>
    ),
  },
];

const MOBILE_NAV = NAV.filter((n) =>
  ["/dashboard", "/dashboard/modules", "/dashboard/grades", "/dashboard/clinical"].includes(n.href)
);

export function StudentPortalLayout({
  firstName,
  isEnrolled,
  needsPolicyAck,
  children,
}: {
  firstName: string;
  isEnrolled: boolean;
  needsPolicyAck: boolean;
  children: React.ReactNode;
}) {
  const pathname = usePathname();
  const [showPolicy, setShowPolicy] = useState(needsPolicyAck && isEnrolled);

  const isLessonFlow = pathname.includes("/lessons/") || pathname.includes("/quiz/");

  if (isLessonFlow) {
    return <>{children}</>;
  }

  return (
    <div className="student-portal">
      {showPolicy && <PolicyAckModal onDone={() => setShowPolicy(false)} />}

      <aside className="student-portal-sidebar">
        <Link href="/" className="student-portal-logo">
          Nurse <span>Rocky</span>
        </Link>
        <div className="student-portal-badge">Student Portal</div>
        <nav className="student-portal-nav" aria-label="Student portal">
          {NAV.map((item) => (
            <Link
              key={item.href}
              href={item.href}
              className={`student-portal-nav-link${item.match(pathname) ? " active" : ""}`}
            >
              {item.icon}
              {item.label}
            </Link>
          ))}
        </nav>
        <div className="student-portal-sidebar-footer">
          <UserButton afterSignOutUrl="/" />
          <span className="student-portal-username">{firstName}</span>
        </div>
      </aside>

      <div className="student-portal-main">
        <div className="student-portal-topbar">
          <Link href="/" className="student-portal-logo">
            Nurse <span>Rocky</span>
          </Link>
          <UserButton afterSignOutUrl="/" />
        </div>
        {children}
      </div>

      <nav className="student-portal-mobile-nav" aria-label="Mobile navigation">
        {MOBILE_NAV.map((item) => (
          <Link
            key={item.href}
            href={item.href}
            className={`student-portal-mobile-link${item.match(pathname) ? " active" : ""}`}
          >
            {item.icon}
            {item.label}
          </Link>
        ))}
      </nav>
    </div>
  );
}
