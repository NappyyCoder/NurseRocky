import Link from "next/link";
import type { StudentDashboardData } from "@/lib/server/student-dashboard";

export function ResourcesList({ resources }: { resources: StudentDashboardData["resources"] }) {
  if (resources.length === 0) {
    return <p className="sp-empty">No resources published yet.</p>;
  }

  return (
    <ul className="sp-resource-list">
      {resources.map((r) => (
        <li key={r.id}>
          <a
            href={r.url}
            className="sp-resource-item"
            target={r.url.startsWith("http") ? "_blank" : undefined}
            rel={r.url.startsWith("http") ? "noreferrer" : undefined}
          >
            <strong>{r.title}</strong>
            {r.description && <span>{r.description}</span>}
          </a>
        </li>
      ))}
    </ul>
  );
}

export function QuickLinks() {
  const links = [
    { href: "/dashboard/modules", title: "Course modules", desc: "Lessons and assignments" },
    { href: "/dashboard/grades", title: "Grades", desc: "Scores and attempt history" },
    { href: "/dashboard/clinical", title: "Clinical hours", desc: "Hours log and checklist" },
    { href: "/dashboard/resources", title: "Resources", desc: "Handbook and study materials" },
    { href: "/dashboard/support", title: "Support", desc: "Contact the Nurse Rocky team" },
    { href: "/dashboard/report", title: "Progress report", desc: "Printable summary" },
  ];

  return (
    <div className="sp-quick-links">
      {links.map((l) => (
        <Link key={l.href} href={l.href} className="sp-quick-link">
          <strong>{l.title}</strong>
          <span>{l.desc}</span>
        </Link>
      ))}
    </div>
  );
}
