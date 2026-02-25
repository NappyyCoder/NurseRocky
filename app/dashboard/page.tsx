import { auth, currentUser } from "@clerk/nextjs/server";
import { redirect } from "next/navigation";
import { UserButton } from "@clerk/nextjs";
import { supabaseAdmin } from "@/lib/supabase";
import type { Module, StudentProgress } from "@/lib/types";

export default async function StudentDashboard() {
  const { userId } = await auth();
  if (!userId) redirect("/sign-in");

  const user = await currentUser();
  const firstName = user?.firstName ?? "Student";

  // Fetch modules and this student's progress from Supabase
  const [{ data: modules }, { data: student }] = await Promise.all([
    supabaseAdmin
      .from("modules")
      .select("*")
      .eq("is_published", true)
      .order("order_num"),
    supabaseAdmin
      .from("students")
      .select("id, enrolled")
      .eq("clerk_user_id", userId)
      .single(),
  ]);

  const studentId = student?.id ?? null;

  const { data: progress } = studentId
    ? await supabaseAdmin
        .from("student_progress")
        .select("module_id, completed")
        .eq("student_id", studentId)
        .eq("completed", true)
    : { data: [] };

  const completedModuleIds = new Set(
    (progress ?? []).map((p: StudentProgress) => p.module_id)
  );

  const { data: clinicalData } = studentId
    ? await supabaseAdmin
        .from("clinical_hours")
        .select("hours")
        .eq("student_id", studentId)
    : { data: [] };

  const totalClinical = (clinicalData ?? []).reduce(
    (sum: number, r: { hours: number }) => sum + Number(r.hours), 0
  );

  const allModules: Module[] = modules ?? [];
  const completedCount = completedModuleIds.size;
  const overallPct = allModules.length
    ? Math.round((completedCount / allModules.length) * 100)
    : 0;

  return (
    <div className="portal">

      {/* ── Sidebar ─────────────────────────────── */}
      <aside className="sidebar">
        <a href="/" className="sidebar-logo">Nurse <span>Rocky</span></a>
        <nav className="sidebar-nav">
          <a href="/dashboard" className="sidebar-link active">
            <svg viewBox="0 0 24 24" fill="none" stroke="currentColor" strokeWidth="2" strokeLinecap="round"><rect x="3" y="3" width="7" height="7"/><rect x="14" y="3" width="7" height="7"/><rect x="3" y="14" width="7" height="7"/><rect x="14" y="14" width="7" height="7"/></svg>
            Dashboard
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
          <span className="sidebar-username">{firstName}</span>
        </div>
      </aside>

      {/* ── Main Content ─────────────────────────── */}
      <main className="portal-main">

        {/* Header */}
        <header className="portal-header">
          <div>
            <h1 className="portal-welcome">Welcome back, {firstName}</h1>
            <p className="portal-subtitle">Continue your CNA certification journey</p>
          </div>
          <div className="portal-header-right">
            <UserButton afterSignOutUrl="/" />
          </div>
        </header>

        {/* Progress cards */}
        <div className="progress-grid">
          <div className="progress-card">
            <div className="progress-icon blue">
              <svg viewBox="0 0 24 24" fill="none" stroke="currentColor" strokeWidth="2" strokeLinecap="round"><path d="M4 19.5A2.5 2.5 0 0 1 6.5 17H20"/><path d="M6.5 2H20v20H6.5A2.5 2.5 0 0 1 4 19.5v-15A2.5 2.5 0 0 1 6.5 2z"/></svg>
            </div>
            <div>
              <div className="progress-num">{completedCount} / {allModules.length}</div>
              <div className="progress-label">Modules Complete</div>
            </div>
          </div>
          <div className="progress-card">
            <div className="progress-icon green">
              <svg viewBox="0 0 24 24" fill="none" stroke="currentColor" strokeWidth="2" strokeLinecap="round"><path d="M9 11l3 3L22 4"/><path d="M21 12v7a2 2 0 0 1-2 2H5a2 2 0 0 1-2-2V5a2 2 0 0 1 2-2h11"/></svg>
            </div>
            <div>
              <div className="progress-num">0 / {allModules.length}</div>
              <div className="progress-label">Quizzes Passed</div>
            </div>
          </div>
          <div className="progress-card">
            <div className="progress-icon orange">
              <svg viewBox="0 0 24 24" fill="none" stroke="currentColor" strokeWidth="2" strokeLinecap="round"><path d="M22 12h-4l-3 9L9 3l-3 9H2"/></svg>
            </div>
            <div>
              <div className="progress-num">{totalClinical} / 16</div>
              <div className="progress-label">Clinical Hours</div>
            </div>
          </div>
          <div className="progress-card">
            <div className="progress-icon purple">
              <svg viewBox="0 0 24 24" fill="none" stroke="currentColor" strokeWidth="2" strokeLinecap="round"><circle cx="12" cy="8" r="6"/><path d="M15.477 12.89L17 22l-5-3-5 3 1.523-9.11"/></svg>
            </div>
            <div>
              <div className="progress-num">{overallPct}%</div>
              <div className="progress-label">Overall Progress</div>
            </div>
          </div>
        </div>

        {/* Modules */}
        <section id="modules" className="portal-section">
          <h2 className="portal-section-title">Course Modules</h2>
          <div className="modules-list">
            {allModules.map((mod: Module, idx: number) => {
              const isComplete = completedModuleIds.has(mod.id);
              const isAvailable = idx === 0 || completedModuleIds.has(allModules[idx - 1].id);
              return (
                <div key={mod.id} className={`module-card ${isAvailable ? "available" : "locked"}`}>
                  <div className="module-num">{String(mod.order_num).padStart(2, "0")}</div>
                  <div className="module-info">
                    <div className="module-title">{mod.title}</div>
                    <div className="module-meta">{mod.lessons_count} lessons · {mod.duration_min} min</div>
                    <div className="module-desc">{mod.description}</div>
                  </div>
                  <div className="module-action">
                    {isComplete ? (
                      <span className="module-done">
                        <svg viewBox="0 0 24 24" fill="none" stroke="currentColor" strokeWidth="2.5" width="16" height="16" strokeLinecap="round"><polyline points="20 6 9 17 4 12"/></svg>
                        Done
                      </span>
                    ) : isAvailable ? (
                      <button className="module-btn start">Start →</button>
                    ) : (
                      <span className="module-locked">
                        <svg viewBox="0 0 24 24" fill="none" stroke="currentColor" strokeWidth="2" width="16" height="16"><rect x="3" y="11" width="18" height="11" rx="2"/><path d="M7 11V7a5 5 0 0 1 10 0v4"/></svg>
                        Locked
                      </span>
                    )}
                  </div>
                </div>
              );
            })}
            {allModules.length === 0 && (
              <p style={{ color: "#64748b", textAlign: "center", padding: "2rem" }}>
                No modules published yet. Check back soon.
              </p>
            )}
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

        /* Sidebar */
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
          margin-bottom: 2.5rem;
          display: block;
        }
        .sidebar-logo span { color: #ffffff; }
        .sidebar-nav { display: flex; flex-direction: column; gap: .25rem; flex: 1; }
        .sidebar-link {
          display: flex;
          align-items: center;
          gap: .75rem;
          padding: .65rem .9rem;
          border-radius: 6px;
          color: #94a3b8;
          font-size: .9rem;
          font-weight: 500;
          text-decoration: none;
          transition: all .15s ease;
        }
        .sidebar-link svg { width: 18px; height: 18px; flex-shrink: 0; }
        .sidebar-link:hover { background: rgba(255,255,255,.07); color: #e2e8f0; }
        .sidebar-link.active { background: rgba(12,122,184,.25); color: #bae6fd; }
        .sidebar-footer {
          display: flex;
          align-items: center;
          gap: .75rem;
          padding-top: 1.5rem;
          border-top: 1px solid rgba(255,255,255,.08);
        }
        .sidebar-username { color: #94a3b8; font-size: .85rem; }

        /* Main */
        .portal-main { padding: 2rem; overflow-y: auto; }
        .portal-header {
          display: flex;
          justify-content: space-between;
          align-items: flex-start;
          margin-bottom: 2rem;
        }
        .portal-header-right { display: none; }
        .portal-welcome {
          font-family: "Fraunces", serif;
          font-size: 1.75rem;
          font-weight: 700;
          color: #0f172a;
          letter-spacing: -.02em;
        }
        .portal-subtitle { color: #64748b; font-size: .95rem; margin-top: .2rem; }

        /* Progress cards */
        .progress-grid {
          display: grid;
          grid-template-columns: repeat(4, 1fr);
          gap: 1rem;
          margin-bottom: 2.5rem;
        }
        .progress-card {
          background: #ffffff;
          border: 1px solid #e2e8f0;
          border-radius: 8px;
          padding: 1.25rem;
          display: flex;
          align-items: center;
          gap: 1rem;
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

        /* Modules */
        .portal-section { margin-bottom: 2.5rem; }
        .portal-section-title {
          font-family: "Fraunces", serif;
          font-size: 1.2rem;
          font-weight: 700;
          color: #0f172a;
          margin-bottom: 1rem;
        }
        .modules-list { display: flex; flex-direction: column; gap: .75rem; }
        .module-card {
          background: #ffffff;
          border: 1px solid #e2e8f0;
          border-radius: 8px;
          padding: 1.25rem 1.5rem;
          display: flex;
          align-items: center;
          gap: 1.25rem;
          box-shadow: 0 1px 3px rgba(0,0,0,.04);
          transition: box-shadow .15s ease;
        }
        .module-card.available { border-left: 3px solid #0c7ab8; }
        .module-card.locked { opacity: .7; }
        .module-card:hover { box-shadow: 0 4px 12px rgba(0,0,0,.08); }
        .module-num {
          font-family: "Fraunces", serif;
          font-size: 1.4rem;
          font-weight: 700;
          color: #cbd5e1;
          width: 40px;
          flex-shrink: 0;
        }
        .module-card.available .module-num { color: #0c7ab8; }
        .module-info { flex: 1; }
        .module-title { font-weight: 600; color: #0f172a; font-size: .95rem; margin-bottom: .2rem; }
        .module-meta { font-size: .8rem; color: #94a3b8; margin-bottom: .3rem; }
        .module-desc { font-size: .85rem; color: #64748b; line-height: 1.5; }
        .module-action { flex-shrink: 0; }
        .module-btn.start {
          background: #0c7ab8; color: #fff;
          border: none; border-radius: 6px;
          padding: .5rem 1.1rem; font-size: .85rem; font-weight: 600;
          cursor: pointer; transition: background .15s;
        }
        .module-btn.start:hover { background: #085d8c; }
        .module-locked {
          display: flex; align-items: center; gap: .35rem;
          font-size: .8rem; color: #94a3b8; font-weight: 500;
        }
        .module-done {
          display: flex; align-items: center; gap: .35rem;
          font-size: .8rem; color: #16a34a; font-weight: 600;
        }

        /* Responsive */
        @media (max-width: 900px) {
          .portal { grid-template-columns: 1fr; }
          .sidebar { display: none; }
          .portal-header-right { display: block; }
          .progress-grid { grid-template-columns: repeat(2, 1fr); }
        }
        @media (max-width: 500px) {
          .progress-grid { grid-template-columns: 1fr 1fr; }
          .module-card { flex-wrap: wrap; }
          .portal-main { padding: 1.25rem; }
        }
      `}</style>
    </div>
  );
}
