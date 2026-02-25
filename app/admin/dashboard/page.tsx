import { auth } from "@clerk/nextjs/server";
import { redirect } from "next/navigation";
import { UserButton } from "@clerk/nextjs";

const students = [
  { id: 1, name: "Maria Santos", email: "maria@email.com", enrolled: "Jan 15, 2026", progress: 83, status: "active" },
  { id: 2, name: "James Carter", email: "james@email.com", enrolled: "Jan 22, 2026", progress: 50, status: "active" },
  { id: 3, name: "Aisha Johnson", email: "aisha@email.com", enrolled: "Feb 1, 2026",  progress: 17, status: "active" },
  { id: 4, name: "Derek Williams", email: "derek@email.com", enrolled: "Feb 10, 2026", progress: 0,  status: "pending" },
];

export default async function AdminDashboard() {
  const { sessionClaims } = await auth();
  const role = (sessionClaims?.metadata as { role?: string })?.role;
  if (role !== "admin") redirect("/admin/sign-in");

  return (
    <div className="portal">

      {/* ── Sidebar ─────────────────────────────── */}
      <aside className="sidebar">
        <a href="/" className="sidebar-logo">Nurse <span>Rocky</span></a>
        <div className="sidebar-badge">Admin Panel</div>
        <nav className="sidebar-nav">
          <a href="/admin/dashboard" className="sidebar-link active">
            <svg viewBox="0 0 24 24" fill="none" stroke="currentColor" strokeWidth="2" strokeLinecap="round"><rect x="3" y="3" width="7" height="7"/><rect x="14" y="3" width="7" height="7"/><rect x="3" y="14" width="7" height="7"/><rect x="14" y="14" width="7" height="7"/></svg>
            Overview
          </a>
          <a href="#students" className="sidebar-link">
            <svg viewBox="0 0 24 24" fill="none" stroke="currentColor" strokeWidth="2" strokeLinecap="round"><path d="M17 21v-2a4 4 0 0 0-4-4H5a4 4 0 0 0-4 4v2"/><circle cx="9" cy="7" r="4"/><path d="M23 21v-2a4 4 0 0 0-3-3.87"/><path d="M16 3.13a4 4 0 0 1 0 7.75"/></svg>
            Students
          </a>
          <a href="#modules" className="sidebar-link">
            <svg viewBox="0 0 24 24" fill="none" stroke="currentColor" strokeWidth="2" strokeLinecap="round"><path d="M4 19.5A2.5 2.5 0 0 1 6.5 17H20"/><path d="M6.5 2H20v20H6.5A2.5 2.5 0 0 1 4 19.5v-15A2.5 2.5 0 0 1 6.5 2z"/></svg>
            Modules
          </a>
          <a href="#quizzes" className="sidebar-link">
            <svg viewBox="0 0 24 24" fill="none" stroke="currentColor" strokeWidth="2" strokeLinecap="round"><path d="M9 11l3 3L22 4"/><path d="M21 12v7a2 2 0 0 1-2 2H5a2 2 0 0 1-2-2V5a2 2 0 0 1 2-2h11"/></svg>
            Quizzes
          </a>
          <a href="#clinical" className="sidebar-link">
            <svg viewBox="0 0 24 24" fill="none" stroke="currentColor" strokeWidth="2" strokeLinecap="round"><path d="M22 12h-4l-3 9L9 3l-3 9H2"/></svg>
            Clinical
          </a>
        </nav>
        <div className="sidebar-footer">
          <UserButton afterSignOutUrl="/" />
          <span className="sidebar-username">Admin</span>
        </div>
      </aside>

      {/* ── Main ─────────────────────────────────── */}
      <main className="portal-main">

        <header className="portal-header">
          <div>
            <h1 className="portal-welcome">Admin Dashboard</h1>
            <p className="portal-subtitle">Nurse Rocky CNA Program</p>
          </div>
          <div className="portal-header-right">
            <UserButton afterSignOutUrl="/" />
          </div>
        </header>

        {/* Stats */}
        <div className="progress-grid">
          <div className="progress-card">
            <div className="progress-icon blue">
              <svg viewBox="0 0 24 24" fill="none" stroke="currentColor" strokeWidth="2" strokeLinecap="round"><path d="M17 21v-2a4 4 0 0 0-4-4H5a4 4 0 0 0-4 4v2"/><circle cx="9" cy="7" r="4"/></svg>
            </div>
            <div>
              <div className="progress-num">4</div>
              <div className="progress-label">Total Students</div>
            </div>
          </div>
          <div className="progress-card">
            <div className="progress-icon green">
              <svg viewBox="0 0 24 24" fill="none" stroke="currentColor" strokeWidth="2" strokeLinecap="round"><polyline points="22 7 13.5 15.5 8.5 10.5 2 17"/><polyline points="16 7 22 7 22 13"/></svg>
            </div>
            <div>
              <div className="progress-num">3</div>
              <div className="progress-label">Active Enrollments</div>
            </div>
          </div>
          <div className="progress-card">
            <div className="progress-icon orange">
              <svg viewBox="0 0 24 24" fill="none" stroke="currentColor" strokeWidth="2" strokeLinecap="round"><circle cx="12" cy="8" r="6"/><path d="M15.477 12.89L17 22l-5-3-5 3 1.523-9.11"/></svg>
            </div>
            <div>
              <div className="progress-num">0</div>
              <div className="progress-label">Certified</div>
            </div>
          </div>
          <div className="progress-card">
            <div className="progress-icon purple">
              <svg viewBox="0 0 24 24" fill="none" stroke="currentColor" strokeWidth="2" strokeLinecap="round"><line x1="12" y1="1" x2="12" y2="23"/><path d="M17 5H9.5a3.5 3.5 0 0 0 0 7h5a3.5 3.5 0 0 1 0 7H6"/></svg>
            </div>
            <div>
              <div className="progress-num">6</div>
              <div className="progress-label">Modules Live</div>
            </div>
          </div>
        </div>

        {/* Students table */}
        <section id="students" className="portal-section">
          <div className="section-head">
            <h2 className="portal-section-title">Students</h2>
            <button className="admin-btn">+ Add Student</button>
          </div>
          <div className="table-wrap">
            <table className="admin-table">
              <thead>
                <tr>
                  <th>Name</th>
                  <th>Email</th>
                  <th>Enrolled</th>
                  <th>Progress</th>
                  <th>Status</th>
                  <th>Actions</th>
                </tr>
              </thead>
              <tbody>
                {students.map((s) => (
                  <tr key={s.id}>
                    <td className="td-name">{s.name}</td>
                    <td className="td-muted">{s.email}</td>
                    <td className="td-muted">{s.enrolled}</td>
                    <td>
                      <div className="progress-bar-wrap">
                        <div className="progress-bar" style={{ width: `${s.progress}%` }} />
                        <span>{s.progress}%</span>
                      </div>
                    </td>
                    <td>
                      <span className={`status-badge ${s.status}`}>{s.status}</span>
                    </td>
                    <td>
                      <button className="row-btn">View</button>
                    </td>
                  </tr>
                ))}
              </tbody>
            </table>
          </div>
        </section>

        {/* Modules management */}
        <section id="modules" className="portal-section">
          <div className="section-head">
            <h2 className="portal-section-title">Modules</h2>
            <button className="admin-btn">+ Add Module</button>
          </div>
          <div className="modules-admin-grid">
            {["Introduction to CNA Role","Patient Rights & Safety","Infection Control","Basic Nursing Skills","Clinical Practice Prep","State Exam Preparation"].map((title, i) => (
              <div className="module-admin-card" key={i}>
                <div className="module-admin-num">0{i + 1}</div>
                <div className="module-admin-title">{title}</div>
                <div className="module-admin-actions">
                  <button className="row-btn">Edit</button>
                  <button className="row-btn danger">Remove</button>
                </div>
              </div>
            ))}
          </div>
        </section>

      </main>

      <style>{`
        .portal {
          display: grid;
          grid-template-columns: 240px 1fr;
          min-height: 100vh;
          font-family: "DM Sans", system-ui, sans-serif;
          background: #f8fafc;
        }
        .sidebar {
          background: #0f172a;
          display: flex;
          flex-direction: column;
          padding: 1.75rem 1.25rem;
          position: sticky;
          top: 0;
          height: 100vh;
        }
        .sidebar-logo {
          font-family: "Fraunces", serif;
          font-size: 1.3rem;
          font-weight: 700;
          color: #bae6fd;
          text-decoration: none;
          letter-spacing: -.02em;
          display: block;
        }
        .sidebar-logo span { color: #ffffff; }
        .sidebar-badge {
          display: inline-block;
          font-size: .7rem;
          font-weight: 700;
          text-transform: uppercase;
          letter-spacing: .08em;
          color: #bae6fd;
          border: 1px solid rgba(186,230,253,.3);
          border-radius: 99px;
          padding: .15rem .6rem;
          margin: .5rem 0 2rem;
        }
        .sidebar-nav { display: flex; flex-direction: column; gap: .25rem; flex: 1; }
        .sidebar-link {
          display: flex; align-items: center; gap: .75rem;
          padding: .65rem .9rem; border-radius: 6px;
          color: #94a3b8; font-size: .9rem; font-weight: 500;
          text-decoration: none; transition: all .15s ease;
        }
        .sidebar-link svg { width: 18px; height: 18px; flex-shrink: 0; }
        .sidebar-link:hover { background: rgba(255,255,255,.07); color: #e2e8f0; }
        .sidebar-link.active { background: rgba(12,122,184,.25); color: #bae6fd; }
        .sidebar-footer {
          display: flex; align-items: center; gap: .75rem;
          padding-top: 1.5rem; border-top: 1px solid rgba(255,255,255,.08);
        }
        .sidebar-username { color: #94a3b8; font-size: .85rem; }

        .portal-main { padding: 2rem; overflow-y: auto; }
        .portal-header {
          display: flex; justify-content: space-between;
          align-items: flex-start; margin-bottom: 2rem;
        }
        .portal-header-right { display: none; }
        .portal-welcome {
          font-family: "Fraunces", serif; font-size: 1.75rem;
          font-weight: 700; color: #0f172a; letter-spacing: -.02em;
        }
        .portal-subtitle { color: #64748b; font-size: .95rem; margin-top: .2rem; }

        .progress-grid {
          display: grid; grid-template-columns: repeat(4, 1fr);
          gap: 1rem; margin-bottom: 2.5rem;
        }
        .progress-card {
          background: #fff; border: 1px solid #e2e8f0; border-radius: 8px;
          padding: 1.25rem; display: flex; align-items: center; gap: 1rem;
          box-shadow: 0 1px 3px rgba(0,0,0,.06);
        }
        .progress-icon {
          width: 44px; height: 44px; border-radius: 8px;
          display: flex; align-items: center; justify-content: center; flex-shrink: 0;
        }
        .progress-icon svg { width: 20px; height: 20px; }
        .progress-icon.blue { background: #e0f4ff; color: #0c7ab8; }
        .progress-icon.green { background: #dcfce7; color: #16a34a; }
        .progress-icon.orange { background: #ffedd5; color: #ea580c; }
        .progress-icon.purple { background: #f3e8ff; color: #9333ea; }
        .progress-num { font-family: "Fraunces", serif; font-size: 1.3rem; font-weight: 700; color: #0f172a; line-height: 1; }
        .progress-label { font-size: .78rem; color: #64748b; margin-top: .2rem; }

        .portal-section { margin-bottom: 2.5rem; }
        .section-head { display: flex; justify-content: space-between; align-items: center; margin-bottom: 1rem; }
        .portal-section-title { font-family: "Fraunces", serif; font-size: 1.2rem; font-weight: 700; color: #0f172a; }

        .admin-btn {
          background: #0c7ab8; color: #fff; border: none; border-radius: 6px;
          padding: .5rem 1rem; font-size: .85rem; font-weight: 600;
          cursor: pointer; transition: background .15s;
        }
        .admin-btn:hover { background: #085d8c; }

        .table-wrap { overflow-x: auto; border-radius: 8px; border: 1px solid #e2e8f0; }
        .admin-table { width: 100%; border-collapse: collapse; background: #fff; font-size: .875rem; }
        .admin-table th {
          text-align: left; padding: .85rem 1rem;
          font-size: .75rem; font-weight: 700; text-transform: uppercase;
          letter-spacing: .05em; color: #64748b;
          background: #f8fafc; border-bottom: 1px solid #e2e8f0;
        }
        .admin-table td { padding: .9rem 1rem; border-bottom: 1px solid #f1f5f9; }
        .admin-table tr:last-child td { border-bottom: none; }
        .td-name { font-weight: 600; color: #0f172a; }
        .td-muted { color: #64748b; }
        .progress-bar-wrap { display: flex; align-items: center; gap: .5rem; }
        .progress-bar-wrap > div {
          height: 6px; background: #0c7ab8; border-radius: 99px;
          min-width: 4px; transition: width .3s ease;
        }
        .progress-bar-wrap span { font-size: .8rem; color: #64748b; white-space: nowrap; }
        .status-badge {
          display: inline-block; padding: .2rem .65rem; border-radius: 99px;
          font-size: .75rem; font-weight: 600; text-transform: capitalize;
        }
        .status-badge.active { background: #dcfce7; color: #15803d; }
        .status-badge.pending { background: #fef9c3; color: #a16207; }
        .row-btn {
          background: transparent; border: 1px solid #e2e8f0; border-radius: 5px;
          padding: .3rem .7rem; font-size: .8rem; font-weight: 500;
          color: #64748b; cursor: pointer; transition: all .15s; margin-right: .35rem;
        }
        .row-btn:hover { border-color: #0c7ab8; color: #0c7ab8; }
        .row-btn.danger:hover { border-color: #ef4444; color: #ef4444; }

        .modules-admin-grid {
          display: grid; grid-template-columns: repeat(3, 1fr); gap: 1rem;
        }
        .module-admin-card {
          background: #fff; border: 1px solid #e2e8f0; border-radius: 8px;
          padding: 1.25rem; box-shadow: 0 1px 3px rgba(0,0,0,.04);
        }
        .module-admin-num { font-family: "Fraunces", serif; font-size: 1.5rem; font-weight: 700; color: #cbd5e1; margin-bottom: .35rem; }
        .module-admin-title { font-weight: 600; font-size: .9rem; color: #0f172a; margin-bottom: .85rem; line-height: 1.4; }
        .module-admin-actions { display: flex; gap: .5rem; }

        @media (max-width: 1100px) {
          .modules-admin-grid { grid-template-columns: repeat(2, 1fr); }
        }
        @media (max-width: 900px) {
          .portal { grid-template-columns: 1fr; }
          .sidebar { display: none; }
          .portal-header-right { display: block; }
          .progress-grid { grid-template-columns: repeat(2, 1fr); }
          .modules-admin-grid { grid-template-columns: 1fr 1fr; }
        }
        @media (max-width: 500px) {
          .portal-main { padding: 1.25rem; }
          .progress-grid { grid-template-columns: 1fr 1fr; }
          .modules-admin-grid { grid-template-columns: 1fr; }
        }
      `}</style>
    </div>
  );
}
