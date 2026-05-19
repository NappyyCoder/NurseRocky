export function PageHeader({ title, description }: { title: string; description?: string }) {
  return (
    <header className="sp-page-header">
      <h1>{title}</h1>
      {description && <p>{description}</p>}
    </header>
  );
}

export function NotEnrolledBanner() {
  return (
    <div className="sp-banner warn">
      <div>
        <strong>Your course is not unlocked yet.</strong>
        <br />
        <span style={{ color: "#c2410c", fontSize: "0.88rem" }}>
          Complete enrollment to access modules, assignments, and clinical hours.
        </span>
      </div>
      <a href="/enroll" className="sp-btn-secondary" style={{ background: "#f97316" }}>
        Enroll now
      </a>
    </div>
  );
}
