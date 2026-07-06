"use client";

import { useEffect, useState } from "react";
import { UserButton } from "@clerk/nextjs";
import { adminRequest } from "@/lib/admin-fetch";
import { ModuleDetailPanel } from "./ModuleDetailPanel";
import { EmailModal } from "./EmailModal";
import { StudentDetailPanel } from "./StudentDetailPanel";
import { BrandLogo } from "@/components/BrandLogo";

// ── Types ─────────────────────────────────────────────────────
interface Student {
  id: string; clerk_user_id: string | null; email: string;
  first_name: string | null; last_name: string | null;
  enrolled: boolean; enrolled_at: string | null; created_at: string;
  completed_modules: number; clinical_hours: number; quizzes_passed: number;
}
interface Module {
  id: number; title: string; description: string | null;
  order_num: number; lessons_count: number; duration_min: number; is_published: boolean;
}

type Tab = "overview" | "students" | "modules" | "clinical" | "comms";

// ── Sidebar ───────────────────────────────────────────────────
function Sidebar({ active, setTab }: { active: Tab; setTab: (t: Tab) => void }) {
  const links: { id: Tab; label: string; icon: React.ReactNode }[] = [
    { id: "overview", label: "Overview", icon: <svg viewBox="0 0 24 24" fill="none" stroke="currentColor" strokeWidth="2" strokeLinecap="round"><rect x="3" y="3" width="7" height="7"/><rect x="14" y="3" width="7" height="7"/><rect x="3" y="14" width="7" height="7"/><rect x="14" y="14" width="7" height="7"/></svg> },
    { id: "students", label: "Students", icon: <svg viewBox="0 0 24 24" fill="none" stroke="currentColor" strokeWidth="2" strokeLinecap="round"><path d="M17 21v-2a4 4 0 0 0-4-4H5a4 4 0 0 0-4 4v2"/><circle cx="9" cy="7" r="4"/><path d="M23 21v-2a4 4 0 0 0-3-3.87"/><path d="M16 3.13a4 4 0 0 1 0 7.75"/></svg> },
    { id: "modules",  label: "Modules",  icon: <svg viewBox="0 0 24 24" fill="none" stroke="currentColor" strokeWidth="2" strokeLinecap="round"><path d="M4 19.5A2.5 2.5 0 0 1 6.5 17H20"/><path d="M6.5 2H20v20H6.5A2.5 2.5 0 0 1 4 19.5v-15A2.5 2.5 0 0 1 6.5 2z"/></svg> },
    { id: "clinical", label: "Clinical",  icon: <svg viewBox="0 0 24 24" fill="none" stroke="currentColor" strokeWidth="2" strokeLinecap="round"><path d="M22 12h-4l-3 9L9 3l-3 9H2"/></svg> },
    { id: "comms", label: "Communications", icon: <svg viewBox="0 0 24 24" fill="none" stroke="currentColor" strokeWidth="2" strokeLinecap="round"><path d="M4 4h16c1.1 0 2 .9 2 2v12c0 1.1-.9 2-2 2H4c-1.1 0-2-.9-2-2V6c0-1.1.9-2 2-2z"/><polyline points="22,6 12,13 2,6"/></svg> },
  ];
  return (
    <aside className="sidebar">
      <BrandLogo href="/" className="sidebar-logo" height={150} variant="dark" />
      <div className="sidebar-badge">Admin Panel</div>
      <nav className="sidebar-nav">
        {links.map(l => (
          <button key={l.id} className={`sidebar-link${active === l.id ? " active" : ""}`} onClick={() => setTab(l.id)}>
            {l.icon}{l.label}
          </button>
        ))}
      </nav>
      <div className="sidebar-footer">
        <UserButton afterSignOutUrl="/" />
        <span className="sidebar-username">Admin</span>
      </div>
    </aside>
  );
}

// ── Overview Tab ──────────────────────────────────────────────
function Overview({ students, modules }: { students: Student[]; modules: Module[] }) {
  const active = students.filter(s => s.enrolled).length;
  const avgProgress = students.length
    ? Math.round(students.reduce((s, st) => s + (st.completed_modules / Math.max(modules.length, 1)) * 100, 0) / students.length)
    : 0;
  return (
    <div>
      <div className="progress-grid">
        {[
          { label: "Total Students", value: students.length, color: "sage" },
          { label: "Active Enrollments", value: active, color: "green" },
          { label: "Modules Published", value: modules.filter(m => m.is_published).length, color: "orange" },
          { label: "Avg Progress", value: avgProgress + "%", color: "sage-mid" },
        ].map(c => (
          <div className="progress-card" key={c.label}>
            <div className={`progress-icon ${c.color}`} />
            <div>
              <div className="progress-num">{c.value}</div>
              <div className="progress-label">{c.label}</div>
            </div>
          </div>
        ))}
      </div>
      <div className="section-head"><h2 className="portal-section-title">Recent Students</h2></div>
      <StudentTable students={students.slice(0, 5)} modules={modules} compact />
    </div>
  );
}

// ── Student Table ─────────────────────────────────────────────
function StudentTable({
  students,
  modules,
  compact,
  onEmail,
  onManage,
}: {
  students: Student[];
  modules: Module[];
  compact?: boolean;
  onEmail?: (s: Student) => void;
  onManage?: (s: Student) => void;
}) {
  return (
    <div className="table-wrap">
      <table className="admin-table">
        <thead><tr>
          <th>Name</th><th>Email</th>
          {!compact && <th>Enrolled</th>}
          <th>Modules</th><th>Quizzes</th><th>Clinical Hrs</th><th>Status</th>
          {onEmail && !compact && <th>Actions</th>}
        </tr></thead>
        <tbody>
          {students.map(s => (
            <tr key={s.id}>
              <td className="td-name">{[s.first_name, s.last_name].filter(Boolean).join(" ") || "—"}</td>
              <td className="td-muted">{s.email}</td>
              {!compact && <td className="td-muted">{s.enrolled_at ? new Date(s.enrolled_at).toLocaleDateString() : "—"}</td>}
              <td>
                <div className="progress-bar-wrap">
                  <div className="progress-bar" style={{ width: `${Math.round((s.completed_modules / Math.max(modules.length, 1)) * 100)}%` }} />
                  <span>{s.completed_modules}/{modules.length}</span>
                </div>
              </td>
              <td className="td-muted">{s.quizzes_passed ?? 0} passed</td>
              <td className="td-muted">{s.clinical_hours} / 16 hrs</td>
              <td><span className={`status-badge ${s.enrolled ? "active" : "pending"}`}>{s.enrolled ? "active" : "pending"}</span></td>
              {onEmail && !compact && (
                <td>
                  <button type="button" className="admin-btn small" onClick={() => onManage?.(s)}>Manage</button>
                  <button type="button" className="row-btn" onClick={() => onEmail(s)} disabled={!s.email}>Email</button>
                </td>
              )}
            </tr>
          ))}
          {students.length === 0 && <tr><td colSpan={onEmail && !compact ? 8 : 6} style={{ textAlign: "center", color: "#8a9691", padding: "2rem" }}>No students yet.</td></tr>}
        </tbody>
      </table>
    </div>
  );
}

// ── Modules Tab ───────────────────────────────────────────────
function ModulesTab({ modules, reload, onManage }: { modules: Module[]; reload: () => void; onManage: (id: number) => void }) {
  const [editing, setEditing] = useState<Module | null>(null);
  const [adding, setAdding] = useState(false);
  const [form, setForm] = useState({ title: "", description: "", order_num: modules.length + 1, lessons_count: 0, duration_min: 0, is_published: true });
  const [saving, setSaving] = useState(false);
  const [saveError, setSaveError] = useState("");

  async function save() {
    setSaving(true);
    setSaveError("");
    const result = await adminRequest("/api/admin/modules", {
      method: editing ? "PUT" : "POST",
      body: JSON.stringify(editing ? { id: editing.id, ...form } : form),
    });
    setSaving(false);
    if (result.ok === false) {
      setSaveError(result.error);
      return;
    }
    setEditing(null);
    setAdding(false);
    reload();
  }

  async function remove(id: number) {
    if (!confirm("Delete this module? This cannot be undone.")) return;
    const result = await adminRequest("/api/admin/modules", {
      method: "DELETE",
      body: JSON.stringify({ id }),
    });
    if (result.ok === false) {
      setSaveError(result.error);
      return;
    }
    reload();
  }

  async function togglePublish(mod: Module) {
    const result = await adminRequest("/api/admin/modules", {
      method: "PUT",
      body: JSON.stringify({ id: mod.id, is_published: !mod.is_published }),
    });
    if (result.ok === false) {
      setSaveError(result.error);
      return;
    }
    reload();
  }

  function startEdit(mod: Module) {
    setEditing(mod);
    setForm({ title: mod.title, description: mod.description ?? "", order_num: mod.order_num, lessons_count: mod.lessons_count, duration_min: mod.duration_min, is_published: mod.is_published });
    setAdding(false);
  }

  function startAdd() {
    setAdding(true); setEditing(null);
    setForm({ title: "", description: "", order_num: modules.length + 1, lessons_count: 0, duration_min: 0, is_published: true });
  }

  return (
    <div>
      <div className="section-head">
        <h2 className="portal-section-title">Modules</h2>
        <button className="admin-btn" onClick={startAdd}>+ Add Module</button>
      </div>
      {saveError && <p className="admin-error-banner">{saveError}</p>}

      {(adding || editing) && (
        <div className="form-card">
          <h3 className="form-title">{editing ? "Edit Module" : "New Module"}</h3>
          <div className="form-grid">
            <label className="form-label">Title
              <input className="form-input" value={form.title} onChange={e => setForm(f => ({ ...f, title: e.target.value }))} placeholder="Module title" />
            </label>
            <label className="form-label">Order #
              <input className="form-input" type="number" value={form.order_num} onChange={e => setForm(f => ({ ...f, order_num: +e.target.value }))} />
            </label>
            <label className="form-label" style={{ gridColumn: "1 / -1" }}>Description
              <textarea className="form-input" rows={3} value={form.description} onChange={e => setForm(f => ({ ...f, description: e.target.value }))} placeholder="Brief description of this module" />
            </label>
            <label className="form-label">Lessons Count
              <input className="form-input" type="number" value={form.lessons_count} onChange={e => setForm(f => ({ ...f, lessons_count: +e.target.value }))} />
            </label>
            <label className="form-label">Duration (min)
              <input className="form-input" type="number" value={form.duration_min} onChange={e => setForm(f => ({ ...f, duration_min: +e.target.value }))} />
            </label>
            <label className="form-label" style={{ display: "flex", alignItems: "center", gap: ".5rem", flexDirection: "row" }}>
              <input type="checkbox" checked={form.is_published} onChange={e => setForm(f => ({ ...f, is_published: e.target.checked }))} />
              Published (visible to students)
            </label>
          </div>
          <div className="form-actions">
            <button className="admin-btn" onClick={save} disabled={saving || !form.title}>{saving ? "Saving…" : "Save Module"}</button>
            <button className="row-btn" onClick={() => { setEditing(null); setAdding(false); }}>Cancel</button>
          </div>
        </div>
      )}

      <div className="modules-admin-grid">
        {modules.map(mod => (
          <div className={`module-admin-card${mod.is_published ? "" : " unpublished"}`} key={mod.id}>
            <div className="module-admin-num">0{mod.order_num}</div>
            <div className="module-admin-title">{mod.title}</div>
            <div className="module-admin-meta">{mod.lessons_count} lessons · {mod.duration_min} min</div>
            {mod.description && <div className="module-admin-desc">{mod.description}</div>}
            <div className="module-admin-footer">
              <span className={`status-badge ${mod.is_published ? "active" : "pending"}`}>{mod.is_published ? "Published" : "Draft"}</span>
              <div className="module-admin-actions">
                <button type="button" className="admin-btn small" onClick={() => onManage(mod.id)}>Manage</button>
                <button type="button" className="row-btn" onClick={() => startEdit(mod)}>Edit</button>
                <button type="button" className="row-btn" onClick={() => togglePublish(mod)}>{mod.is_published ? "Unpublish" : "Publish"}</button>
                <button type="button" className="row-btn danger" onClick={() => remove(mod.id)}>Delete</button>
              </div>
            </div>
          </div>
        ))}
      </div>
    </div>
  );
}

// ── Clinical Tab ──────────────────────────────────────────────
function ClinicalTab({ students }: { students: Student[] }) {
  const [form, setForm] = useState({ student_id: "", hours: "", date: new Date().toISOString().split("T")[0], notes: "" });
  const [saving, setSaving] = useState(false);
  const [done, setDone] = useState(false);

  async function log() {
    setSaving(true);
    await fetch("/api/admin/clinical", { method: "POST", headers: { "Content-Type": "application/json" }, body: JSON.stringify({ ...form, hours: parseFloat(form.hours) }) });
    setSaving(false); setDone(true); setForm(f => ({ ...f, hours: "", notes: "" }));
    setTimeout(() => setDone(false), 3000);
  }

  return (
    <div>
      <div className="section-head"><h2 className="portal-section-title">Log Clinical Hours</h2></div>
      <div className="form-card" style={{ maxWidth: 540 }}>
        <div className="form-grid">
          <label className="form-label" style={{ gridColumn: "1 / -1" }}>Student
            <select className="form-input" value={form.student_id} onChange={e => setForm(f => ({ ...f, student_id: e.target.value }))}>
              <option value="">— Select a student —</option>
              {students.filter(s => s.enrolled).map(s => (
                <option key={s.id} value={s.id}>{[s.first_name, s.last_name].filter(Boolean).join(" ") || s.email}</option>
              ))}
            </select>
          </label>
          <label className="form-label">Hours
            <input className="form-input" type="number" step="0.5" min="0.5" max="16" value={form.hours} onChange={e => setForm(f => ({ ...f, hours: e.target.value }))} placeholder="e.g. 4" />
          </label>
          <label className="form-label">Date
            <input className="form-input" type="date" value={form.date} onChange={e => setForm(f => ({ ...f, date: e.target.value }))} />
          </label>
          <label className="form-label" style={{ gridColumn: "1 / -1" }}>Notes (optional)
            <textarea className="form-input" rows={2} value={form.notes} onChange={e => setForm(f => ({ ...f, notes: e.target.value }))} placeholder="Location, supervisor, notes…" />
          </label>
        </div>
        <div className="form-actions">
          <button className="admin-btn" onClick={log} disabled={saving || !form.student_id || !form.hours}>{saving ? "Saving…" : "Log Hours"}</button>
          {done && <span style={{ color: "#6b9e8e", fontWeight: 600, fontSize: ".9rem" }}>✓ Hours logged</span>}
        </div>
      </div>

      <div className="section-head" style={{ marginTop: "2rem" }}><h2 className="portal-section-title">Clinical Summary</h2></div>
      <div className="table-wrap">
        <table className="admin-table">
          <thead><tr><th>Student</th><th>Hours Logged</th><th>Required</th><th>Status</th></tr></thead>
          <tbody>
            {students.filter(s => s.enrolled).map(s => (
              <tr key={s.id}>
                <td className="td-name">{[s.first_name, s.last_name].filter(Boolean).join(" ") || s.email}</td>
                <td>{s.clinical_hours}</td>
                <td className="td-muted">16</td>
                <td><span className={`status-badge ${s.clinical_hours >= 16 ? "active" : "pending"}`}>{s.clinical_hours >= 16 ? "Complete" : "In Progress"}</span></td>
              </tr>
            ))}
          </tbody>
        </table>
      </div>
    </div>
  );
}

// ── Communications Tab ────────────────────────────────────────
function CommunicationsTab() {
  const [announcements, setAnnouncements] = useState<{ id: string; title: string; body: string; is_active: boolean }[]>([]);
  const [resources, setResources] = useState<{ id: string; title: string; url: string; description: string | null; module_id: number | null }[]>([]);
  const [annForm, setAnnForm] = useState({ title: "", body: "", is_active: true });
  const [resForm, setResForm] = useState({ title: "", url: "", description: "" });
  const [reminderResult, setReminderResult] = useState("");
  const [busy, setBusy] = useState(false);

  async function loadComms() {
    const [aRes, rRes] = await Promise.all([
      adminRequest<typeof announcements>("/api/admin/announcements"),
      adminRequest<typeof resources>("/api/admin/resources"),
    ]);
    if (aRes.ok) setAnnouncements(aRes.data);
    if (rRes.ok) setResources(rRes.data);
  }

  useEffect(() => { loadComms(); }, []);

  async function createAnnouncement() {
    setBusy(true);
    const result = await adminRequest("/api/admin/announcements", {
      method: "POST",
      body: JSON.stringify(annForm),
    });
    setBusy(false);
    if (result.ok) {
      setAnnForm({ title: "", body: "", is_active: true });
      loadComms();
    }
  }

  async function toggleAnnouncement(id: string, is_active: boolean) {
    await adminRequest("/api/admin/announcements", {
      method: "PUT",
      body: JSON.stringify({ id, is_active }),
    });
    loadComms();
  }

  async function createResource() {
    setBusy(true);
    const result = await adminRequest("/api/admin/resources", {
      method: "POST",
      body: JSON.stringify(resForm),
    });
    setBusy(false);
    if (result.ok) {
      setResForm({ title: "", url: "", description: "" });
      loadComms();
    }
  }

  async function sendReminders() {
    setBusy(true);
    setReminderResult("");
    const result = await adminRequest<{ sent: number; error?: string }>("/api/admin/send-reminders", {
      method: "POST",
      body: "{}",
    });
    setBusy(false);
    if (result.ok === false) {
      setReminderResult(result.error);
    } else {
      setReminderResult(`Sent ${result.data.sent} reminder email(s).`);
    }
  }

  return (
    <div>
      <div className="form-card">
        <div className="form-title">Student announcements</div>
        <div className="form-grid">
          <label className="form-label">Title
            <input className="form-input" value={annForm.title} onChange={(e) => setAnnForm((f) => ({ ...f, title: e.target.value }))} />
          </label>
          <label className="form-label">Active
            <select className="form-input" value={annForm.is_active ? "1" : "0"} onChange={(e) => setAnnForm((f) => ({ ...f, is_active: e.target.value === "1" }))}>
              <option value="1">Yes — show on dashboard</option>
              <option value="0">No — draft</option>
            </select>
          </label>
          <label className="form-label" style={{ gridColumn: "1 / -1" }}>Message
            <textarea className="form-input" rows={3} value={annForm.body} onChange={(e) => setAnnForm((f) => ({ ...f, body: e.target.value }))} />
          </label>
        </div>
        <div className="form-actions">
          <button className="admin-btn" disabled={busy || !annForm.title || !annForm.body} onClick={createAnnouncement}>Post announcement</button>
        </div>
      </div>

      {announcements.length > 0 && (
        <div className="table-wrap" style={{ marginBottom: "2rem" }}>
          <table className="admin-table">
            <thead><tr><th>Title</th><th>Status</th><th>Action</th></tr></thead>
            <tbody>
              {announcements.map((a) => (
                <tr key={a.id}>
                  <td className="td-name">{a.title}</td>
                  <td>{a.is_active ? "Active" : "Draft"}</td>
                  <td>
                    <button type="button" className="row-btn" onClick={() => toggleAnnouncement(a.id, !a.is_active)}>
                      {a.is_active ? "Deactivate" : "Activate"}
                    </button>
                  </td>
                </tr>
              ))}
            </tbody>
          </table>
        </div>
      )}

      <div className="form-card">
        <div className="form-title">Course resources</div>
        <div className="form-grid">
          <label className="form-label">Title
            <input className="form-input" value={resForm.title} onChange={(e) => setResForm((f) => ({ ...f, title: e.target.value }))} />
          </label>
          <label className="form-label">URL
            <input className="form-input" value={resForm.url} onChange={(e) => setResForm((f) => ({ ...f, url: e.target.value }))} placeholder="/policies or https://…" />
          </label>
          <label className="form-label" style={{ gridColumn: "1 / -1" }}>Description
            <input className="form-input" value={resForm.description} onChange={(e) => setResForm((f) => ({ ...f, description: e.target.value }))} />
          </label>
        </div>
        <div className="form-actions">
          <button className="admin-btn" disabled={busy || !resForm.title || !resForm.url} onClick={createResource}>Add resource</button>
        </div>
      </div>

      {resources.length > 0 && (
        <div className="table-wrap" style={{ marginBottom: "2rem" }}>
          <table className="admin-table">
            <thead><tr><th>Title</th><th>URL</th></tr></thead>
            <tbody>
              {resources.map((r) => (
                <tr key={r.id}>
                  <td className="td-name">{r.title}</td>
                  <td className="td-muted">{r.url}</td>
                </tr>
              ))}
            </tbody>
          </table>
        </div>
      )}

      <div className="form-card">
        <div className="form-title">Inactive student reminders</div>
        <p className="section-hint">Email enrolled students who have not accessed lessons in 7+ days (requires RESEND_API_KEY).</p>
        <div className="form-actions">
          <button className="admin-btn" disabled={busy} onClick={sendReminders}>Send reminders</button>
          {reminderResult && <span style={{ fontSize: ".9rem", color: "#4a5c55" }}>{reminderResult}</span>}
        </div>
      </div>
    </div>
  );
}

// ── Main Page ─────────────────────────────────────────────────
export default function AdminDashboard() {
  const [tab, setTab] = useState<Tab>("overview");
  const [students, setStudents] = useState<Student[]>([]);
  const [modules, setModules] = useState<Module[]>([]);
  const [loading, setLoading] = useState(true);
  const [managingModuleId, setManagingModuleId] = useState<number | null>(null);
  const [managingStudentId, setManagingStudentId] = useState<string | null>(null);
  const [emailTarget, setEmailTarget] = useState<{ student_id?: string; student_ids?: string[]; all_enrolled?: boolean; label: string } | null>(null);
  const [systemStatus, setSystemStatus] = useState<{
    ready: boolean;
    supabase: { configured: boolean; reachable: boolean; schemaReady: boolean; configError: string | null; hint: string | null };
    admin: boolean;
    adminError: string | null;
    canWrite: boolean;
    writeError: string | null;
  } | null>(null);
  const [loadError, setLoadError] = useState("");

  async function load() {
    const statusRes = await fetch("/api/admin/status");
    if (statusRes.ok) {
      setSystemStatus(await statusRes.json());
    }

    const [sRes, mRes] = await Promise.all([
      fetch("/api/admin/students"),
      fetch("/api/admin/modules"),
    ]);

    if (!sRes.ok || !mRes.ok) {
      const errBody = await (sRes.ok ? mRes : sRes).json().catch(() => ({}));
      setLoadError(
        errBody.error === "Unauthorized"
          ? 'Cannot load course data — your account is not recognized as admin. In Clerk Dashboard set public metadata { "role": "admin" } and add "metadata": {{user.public_metadata}} to the session token, then sign out and back in.'
          : errBody.error ?? "Failed to load admin data"
      );
    } else {
      setLoadError("");
      setStudents(await sRes.json());
      setModules(await mRes.json());
    }
    setLoading(false);
  }

  useEffect(() => { load(); }, []);

  return (
    <div className="portal">
      <Sidebar active={tab} setTab={setTab} />
      <main className="portal-main">
        <header className="portal-header">
          <div>
            <h1 className="portal-welcome">
              {managingModuleId ? "Manage Module" : managingStudentId ? "Manage Student" : tab === "overview" && "Overview"}
              {!managingModuleId && !managingStudentId && tab === "students" && "Students"}
              {!managingModuleId && !managingStudentId && tab === "modules" && "Course Modules"}
              {!managingModuleId && !managingStudentId && tab === "clinical" && "Clinical Hours"}
              {!managingModuleId && !managingStudentId && tab === "comms" && "Communications"}
            </h1>
            <p className="portal-subtitle">Nurse Rocky Admin Panel</p>
          </div>
          <div className="portal-header-actions">
            <UserButton afterSignOutUrl="/" />
          </div>
        </header>

        {systemStatus && !systemStatus.ready && (
          <div className="admin-error-banner" role="alert">
            {!systemStatus.supabase.configured || !systemStatus.supabase.reachable ? (
              <>
                <strong>Supabase not connected.</strong>{" "}
                {systemStatus.supabase.configError ?? systemStatus.supabase.hint ?? "Check .env.local and restart npm run dev."}
              </>
            ) : !systemStatus.admin ? (
              <>
                <strong>Admin access required.</strong>{" "}
                {systemStatus.adminError === "Unauthorized"
                  ? "Set role: admin in Clerk public metadata and add metadata to your session token, then sign out and back in."
                  : systemStatus.adminError}
              </>
            ) : !systemStatus.canWrite ? (
              <>
                <strong>Cannot write to database.</strong> {systemStatus.writeError}
              </>
            ) : null}
          </div>
        )}

        {loadError && (
          <div className="admin-error-banner" role="alert">{loadError}</div>
        )}

        {systemStatus?.ready && (
          <p className="admin-ok-banner">✓ Connected to Supabase — course edits save for all students.</p>
        )}

        {loading ? (
          <div className="loading">Loading…</div>
        ) : managingStudentId ? (
          <StudentDetailPanel
            studentId={managingStudentId}
            onBack={() => setManagingStudentId(null)}
            onEmail={(label) => setEmailTarget({ student_id: managingStudentId, label })}
            onUpdated={load}
          />
        ) : managingModuleId ? (
          <ModuleDetailPanel
            moduleId={managingModuleId}
            onBack={() => setManagingModuleId(null)}
            onSaved={load}
          />
        ) : (
          <>
            {tab === "overview"  && <Overview students={students} modules={modules} />}
            {tab === "students"  && (
              <>
                <div className="section-head">
                  <p className="section-hint" style={{ margin: 0 }}>Manage progress, allow quiz retakes, or email students.</p>
                  <button
                    type="button"
                    className="admin-btn"
                    onClick={() => setEmailTarget({ all_enrolled: true, label: "all enrolled students" })}
                    disabled={!students.some((s) => s.enrolled)}
                  >
                    Email all enrolled
                  </button>
                </div>
                <StudentTable
                  students={students}
                  modules={modules}
                  onManage={(s) => setManagingStudentId(s.id)}
                  onEmail={(s) => setEmailTarget({
                    student_id: s.id,
                    label: [s.first_name, s.last_name].filter(Boolean).join(" ") || s.email,
                  })}
                />
              </>
            )}
            {tab === "modules"   && <ModulesTab modules={modules} reload={load} onManage={setManagingModuleId} />}
            {tab === "clinical"  && <ClinicalTab students={students} />}
            {tab === "comms"     && <CommunicationsTab />}
          </>
        )}

        {emailTarget && (
          <EmailModal target={emailTarget} onClose={() => setEmailTarget(null)} />
        )}
      </main>

      <style>{`
        .portal { display: grid; grid-template-columns: 400px 1fr; min-height: 100vh; font-family: "DM Sans", system-ui, sans-serif; background: #f4f8f6; }
        .sidebar { background: #0f1a17; display: flex; flex-direction: column; padding: 1.75rem 1.25rem; position: sticky; top: 0; height: 100vh; }
        .sidebar-logo.brand-logo { display: block; margin-bottom: 0.75rem; }
        .sidebar-badge { display: inline-block; font-size: .7rem; font-weight: 700; text-transform: uppercase; letter-spacing: .08em; color: #c3d9d2; border: 1px solid rgba(147,183,169,.35); border-radius: 99px; padding: .15rem .6rem; margin: .5rem 0 2rem; }
        .sidebar-nav { display: flex; flex-direction: column; gap: .25rem; flex: 1; }
        .sidebar-link { display: flex; align-items: center; gap: .75rem; padding: .65rem .9rem; border-radius: 6px; color: #8a9691; font-size: .9rem; font-weight: 500; background: none; border: none; cursor: pointer; width: 100%; text-align: left; transition: all .15s; }
        .sidebar-link svg { width: 18px; height: 18px; flex-shrink: 0; }
        .sidebar-link:hover { background: rgba(255,255,255,.07); color: #d8e4df; }
        .sidebar-link.active { background: rgba(147,183,169,.25); color: #c3d9d2; }
        .sidebar-footer { display: flex; align-items: center; gap: .75rem; padding-top: 1.5rem; border-top: 1px solid rgba(255,255,255,.08); }
        .sidebar-username { color: #8a9691; font-size: .85rem; }
        .portal-main { padding: 2rem; overflow-y: auto; }
        .portal-header { display: flex; justify-content: space-between; align-items: flex-start; margin-bottom: 2rem; }
        .portal-welcome { font-family: "Fraunces", serif; font-size: 1.75rem; font-weight: 700; color: #0f1a17; letter-spacing: -.02em; }
        .portal-subtitle { color: #5c6b66; font-size: .95rem; margin-top: .2rem; }
        .loading { color: #5c6b66; padding: 3rem; text-align: center; }
        .progress-grid { display: grid; grid-template-columns: repeat(4, 1fr); gap: 1rem; margin-bottom: 2.5rem; }
        .progress-card { background: #fff; border: 1px solid #d8e4df; border-radius: 8px; padding: 1.25rem; display: flex; align-items: center; gap: 1rem; box-shadow: 0 1px 3px rgba(0,0,0,.06); }
        .progress-icon { width: 44px; height: 44px; border-radius: 8px; flex-shrink: 0; }
        .progress-icon.sage { background: #e8f2ef; } .progress-icon.green { background: #e8f2ef; } .progress-icon.orange { background: #ffedd5; } .progress-icon.sage-mid { background: #dceee8; color: #6b9e8e; }
        .progress-num { font-family: "Fraunces", serif; font-size: 1.3rem; font-weight: 700; color: #0f1a17; line-height: 1; }
        .progress-label { font-size: .78rem; color: #5c6b66; margin-top: .2rem; }
        .section-head { display: flex; justify-content: space-between; align-items: center; margin-bottom: 1rem; gap: 1rem; flex-wrap: wrap; }
        .section-hint { font-size: .85rem; color: #5c6b66; }
        .admin-error-banner { background: #fef2f2; border: 1px solid #fecaca; color: #991b1b; padding: .85rem 1rem; border-radius: 8px; margin-bottom: 1.25rem; font-size: .875rem; line-height: 1.5; }
        .admin-ok-banner { background: #e8f2ef; border: 1px solid #c3d9d2; color: #6b9e8e; padding: .65rem 1rem; border-radius: 8px; margin-bottom: 1.25rem; font-size: .85rem; }
        .portal-section-title { font-family: "Fraunces", serif; font-size: 1.2rem; font-weight: 700; color: #0f1a17; }
        .table-wrap { overflow-x: auto; border-radius: 8px; border: 1px solid #d8e4df; }
        .admin-table { width: 100%; border-collapse: collapse; background: #fff; font-size: .875rem; }
        .admin-table th { text-align: left; padding: .85rem 1rem; font-size: .75rem; font-weight: 700; text-transform: uppercase; letter-spacing: .05em; color: #5c6b66; background: #f4f8f6; border-bottom: 1px solid #d8e4df; }
        .admin-table td { padding: .9rem 1rem; border-bottom: 1px solid #eef3f0; }
        .admin-table tr:last-child td { border-bottom: none; }
        .td-name { font-weight: 600; color: #0f1a17; } .td-muted { color: #5c6b66; }
        .progress-bar-wrap { display: flex; align-items: center; gap: .5rem; }
        .progress-bar-wrap > div { height: 6px; background: linear-gradient(180deg, #c0d9d2 0%, #93b7a9 100%); border-radius: 99px; min-width: 4px; }
        .progress-bar-wrap span { font-size: .8rem; color: #5c6b66; white-space: nowrap; }
        .status-badge { display: inline-block; padding: .2rem .65rem; border-radius: 99px; font-size: .75rem; font-weight: 600; text-transform: capitalize; }
        .status-badge.active { background: #e8f2ef; color: #6b9e8e; } .status-badge.pending { background: #fef9c3; color: #a16207; }
        .admin-btn { background: linear-gradient(180deg, #c0d9d2 0%, #93b7a9 100%); color: #fff; border: none; border-radius: 6px; padding: .5rem 1rem; font-size: .85rem; font-weight: 600; cursor: pointer; transition: background .15s; }
        .admin-btn:hover:not(:disabled) { background: linear-gradient(180deg, #aaccc4 0%, #7aab9b 100%); } .admin-btn:disabled { opacity: .5; cursor: not-allowed; }
        .admin-btn.small { padding: .35rem .75rem; font-size: .78rem; }
        .row-btn { background: transparent; border: 1px solid #d8e4df; border-radius: 5px; padding: .3rem .7rem; font-size: .8rem; font-weight: 500; color: #5c6b66; cursor: pointer; transition: all .15s; margin-right: .35rem; }
        .row-btn:hover { border-color: #93b7a9; color: #93b7a9; } .row-btn.danger:hover { border-color: #ef4444; color: #ef4444; }
        .modules-admin-grid { display: grid; grid-template-columns: repeat(3, 1fr); gap: 1rem; }
        .module-admin-card { background: #fff; border: 1px solid #d8e4df; border-radius: 8px; padding: 1.25rem; box-shadow: 0 1px 3px rgba(0,0,0,.04); }
        .module-admin-card.unpublished { opacity: .65; border-style: dashed; }
        .module-admin-num { font-family: "Fraunces", serif; font-size: 1.5rem; font-weight: 700; color: #b8c9c2; margin-bottom: .25rem; }
        .module-admin-title { font-weight: 600; font-size: .9rem; color: #0f1a17; line-height: 1.4; }
        .module-admin-meta { font-size: .78rem; color: #8a9691; margin: .2rem 0 .5rem; }
        .module-admin-desc { font-size: .82rem; color: #5c6b66; line-height: 1.5; margin-bottom: .75rem; }
        .module-admin-footer { display: flex; justify-content: space-between; align-items: center; flex-wrap: wrap; gap: .5rem; margin-top: .75rem; padding-top: .75rem; border-top: 1px solid #eef3f0; }
        .module-admin-actions { display: flex; }
        .form-card { background: #fff; border: 1px solid #d8e4df; border-radius: 8px; padding: 1.5rem; margin-bottom: 1.5rem; box-shadow: 0 1px 3px rgba(0,0,0,.06); }
        .form-title { font-family: "Fraunces", serif; font-size: 1.05rem; font-weight: 700; color: #0f1a17; margin-bottom: 1.25rem; }
        .form-grid { display: grid; grid-template-columns: 1fr 1fr; gap: 1rem; }
        .form-label { display: flex; flex-direction: column; gap: .35rem; font-size: .85rem; font-weight: 600; color: #374151; }
        .form-input { padding: .55rem .75rem; border: 1px solid #d8e4df; border-radius: 6px; font-size: .9rem; font-family: inherit; color: #0f1a17; transition: border-color .15s; outline: none; width: 100%; }
        .form-input:focus { border-color: #93b7a9; box-shadow: 0 0 0 3px rgba(147,183,169,.12); }
        textarea.form-input { resize: vertical; }
        .form-actions { display: flex; align-items: center; gap: 1rem; margin-top: 1.25rem; }
        @media (max-width: 1100px) { .modules-admin-grid { grid-template-columns: 1fr 1fr; } }
        @media (max-width: 900px) { .portal { grid-template-columns: 1fr; } .sidebar { display: none; } .progress-grid { grid-template-columns: 1fr 1fr; } .modules-admin-grid { grid-template-columns: 1fr 1fr; } .form-grid { grid-template-columns: 1fr; } }
        @media (max-width: 500px) { .portal-main { padding: 1.25rem; } .modules-admin-grid { grid-template-columns: 1fr; } }
      `}</style>
    </div>
  );
}
