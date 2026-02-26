import Image from "next/image";

function img(name: string) {
  return `/images/${encodeURIComponent(name)}`;
}

function CheckIcon() {
  return (
    <svg viewBox="0 0 24 24" fill="none" stroke="currentColor" strokeWidth="2.5" strokeLinecap="round">
      <polyline points="20 6 9 17 4 12" />
    </svg>
  );
}

function MobileNav() {
  return (
    <nav className="mobile-nav" aria-label="Mobile navigation">
      <a href="#careers" className="mobile-nav-item">
        <svg viewBox="0 0 24 24" fill="none" stroke="currentColor" strokeWidth="2" strokeLinecap="round" strokeLinejoin="round">
          <rect x="2" y="7" width="20" height="14" rx="2" />
          <path d="M16 7V5a2 2 0 0 0-2-2h-4a2 2 0 0 0-2 2v2" />
        </svg>
        <span>Careers</span>
      </a>
      <a href="#different" className="mobile-nav-item">
        <svg viewBox="0 0 24 24" fill="none" stroke="currentColor" strokeWidth="2" strokeLinecap="round" strokeLinejoin="round">
          <circle cx="12" cy="12" r="10" />
          <path d="M12 8v4M12 16h.01" />
        </svg>
        <span>About</span>
      </a>
      <a href="/enroll" className="mobile-nav-cta">
        <div className="mobile-nav-cta-bubble">
          <svg viewBox="0 0 24 24" fill="none" stroke="currentColor" strokeWidth="2.5" strokeLinecap="round" strokeLinejoin="round">
            <path d="M5 12h14M12 5l7 7-7 7" />
          </svg>
        </div>
        <span>Enroll</span>
      </a>
      <a href="#program" className="mobile-nav-item">
        <svg viewBox="0 0 24 24" fill="none" stroke="currentColor" strokeWidth="2" strokeLinecap="round" strokeLinejoin="round">
          <rect x="3" y="4" width="18" height="18" rx="2" />
          <line x1="16" y1="2" x2="16" y2="6" />
          <line x1="8" y1="2" x2="8" y2="6" />
          <line x1="3" y1="10" x2="21" y2="10" />
        </svg>
        <span>Program</span>
      </a>
      <a href="#tuition" className="mobile-nav-item">
        <svg viewBox="0 0 24 24" fill="none" stroke="currentColor" strokeWidth="2" strokeLinecap="round" strokeLinejoin="round">
          <circle cx="12" cy="12" r="10" />
          <path d="M9.09 9a3 3 0 0 1 5.83 1c0 2-3 3-3 3" />
          <path d="M12 17h.01" />
        </svg>
        <span>Tuition</span>
      </a>
    </nav>
  );
}

function Nav() {
  return (
    <nav className="nav">
      <div className="nav-inner">
        <a href="#" className="nav-logo">
          Nurse <span>Rocky</span>
        </a>
        <ul className="nav-links">
          <li><a href="#careers">Careers</a></li>
          <li><a href="#different">About</a></li>
          <li><a href="#program">Program</a></li>
          <li><a href="#tuition">Tuition</a></li>
        </ul>
        <a href="/enroll" className="nav-cta">Enroll Now</a>
      </div>
    </nav>
  );
}

export default function Home() {
  return (
    <>
      <Nav />

      {/* ── Hero ─────────────────────────────────── */}
      <section className="hero">
        <div className="container">
          <div className="hero-content">
            <div className="hero-badge">
              <svg width="10" height="10" viewBox="0 0 10 10" fill="currentColor">
                <circle cx="5" cy="5" r="4" />
              </svg>
              Enrolling Now · 30–45 Day Program
            </div>
            <h1>Start Your <em>CNA Career</em> Today</h1>
            <p className="hero-sub">
              Become a Certified Nursing Assistant with hands-on training,
              state exam prep, and career support, all in under 45 days.
            </p>
            <div className="hero-actions">
              <a href="/enroll" className="btn btn-primary">Enroll Now</a>
              <a href="#program" className="btn btn-outline">View Program</a>
            </div>
          </div>
          <div className="hero-media">
            <div className="hero-img-wrap">
              <Image
                src={img("Nurse Rocky Image 2.jpg")}
                alt="CNA helping a patient"
                width={560}
                height={420}
                priority
                sizes="(max-width: 900px) 100vw, 50vw"
              />
            </div>
          </div>
        </div>
      </section>

      {/* ── Stats Bar ────────────────────────────── */}
      <div className="stats-bar">
        <div className="container">
          <div className="stats-inner">
            <div className="stat-item">
              <div className="stat-num">30–45</div>
              <div className="stat-label">Days to Certification</div>
            </div>
            <div className="stat-item">
              <div className="stat-num">100%</div>
              <div className="stat-label">Hands-on Clinical Practice</div>
            </div>
            <div className="stat-item">
              <div className="stat-num">State</div>
              <div className="stat-label">Exam Prep Included</div>
            </div>
            <div className="stat-item">
              <div className="stat-num">$</div>
              <div className="stat-label">Flexible Payment Plans</div>
            </div>
          </div>
        </div>
      </div>

      {/* ── Career Opportunities ──────────────────── */}
      <section className="career-section" id="careers">
        <div className="container">
          <div className="section-header">
            <span className="section-tag">Career Paths</span>
            <h2 className="section-title">CNA Career Opportunities</h2>
            <p className="section-body">
              Launch your healthcare career as a Certified Nursing Assistant.
              Work in hospitals, long-term care, rehab, and home health,
              with strong job demand and competitive pay.
            </p>
          </div>
          <div className="card-grid">
            <div className="card">
              <div className="card-icon">
                {/* Hospital building with medical cross */}
                <svg viewBox="0 0 24 24" fill="none" stroke="currentColor" strokeWidth="2" strokeLinecap="round" strokeLinejoin="round">
                  <path d="M3 21h18" />
                  <rect x="5" y="7" width="14" height="14" />
                  <path d="M10 7V4h4v3" />
                  <path d="M12 12v4" />
                  <path d="M10 14h4" />
                </svg>
              </div>
              <h3>Hospital &amp; Acute Care</h3>
              <p>Work alongside nurses and doctors in fast-paced hospital environments providing essential patient care.</p>
            </div>
            <div className="card">
              <div className="card-icon">
                <svg viewBox="0 0 24 24" fill="none" stroke="currentColor" strokeWidth="2">
                  <path d="M3 9l9-7 9 7v11a2 2 0 0 1-2 2H5a2 2 0 0 1-2-2z" />
                  <polyline points="9 22 9 12 15 12 15 22" />
                </svg>
              </div>
              <h3>Home Health</h3>
                  <p>Provide one-on-one care in the comfort of patients&apos; homes, a growing and rewarding field.</p>
            </div>
            <div className="card">
              <div className="card-icon">
                {/* Person walking / physical therapy */}
                <svg viewBox="0 0 24 24" fill="none" stroke="currentColor" strokeWidth="2" strokeLinecap="round" strokeLinejoin="round">
                  <circle cx="12" cy="4" r="2" />
                  <path d="M9 12l3-4 3 4" />
                  <path d="M12 8v5" />
                  <path d="M9 21l1.5-5" />
                  <path d="M15 21l-1.5-5" />
                  <path d="M7 14h10" />
                </svg>
              </div>
              <h3>Rehab &amp; Long-Term Care</h3>
              <p>Support patients through recovery and help residents maintain quality of life in care facilities.</p>
            </div>
          </div>
          <div className="section-cta">
            <a href="#program" className="btn btn-primary">Learn More About Career Paths</a>
          </div>
        </div>
      </section>

      {/* ── What Makes Us Different ───────────────── */}
      <section className="different-section" id="different">
        <div className="container">
          <div className="section-header">
            <span className="section-tag">Why Nurse Rocky</span>
            <h2 className="section-title">What Makes Us Different</h2>
            <p className="section-body">
              We don&apos;t just prep you for the exam. We prepare you for a real
              healthcare career with confidence, skills, and support.
            </p>
          </div>
          <div className="card-grid">
            <div className="card">
              <div className="card-icon">
                <svg viewBox="0 0 24 24" fill="none" stroke="currentColor" strokeWidth="2">
                  <path d="M22 10v6M2 10l10-5 10 5-10 5z" />
                  <path d="M6 12v5c3 3 9 3 12 0v-5" />
                </svg>
              </div>
              <h3>Expert-Led Training</h3>
              <p>Learn from experienced healthcare professionals who bring real-world knowledge to every lesson.</p>
            </div>
            <div className="card">
              <div className="card-icon">
                <svg viewBox="0 0 24 24" fill="none" stroke="currentColor" strokeWidth="2">
                  <path d="M14 2H6a2 2 0 0 0-2 2v16a2 2 0 0 0 2 2h12a2 2 0 0 0 2-2V8z" />
                  <polyline points="14 2 14 8 20 8" />
                  <line x1="16" y1="13" x2="8" y2="13" />
                  <line x1="16" y1="17" x2="8" y2="17" />
                </svg>
              </div>
              <h3>Flexible Online + Clinical</h3>
              <p>Complete online modules on your schedule, then master hands-on skills in supervised clinical settings.</p>
            </div>
            <div className="card">
              <div className="card-icon">
                <svg viewBox="0 0 24 24" fill="none" stroke="currentColor" strokeWidth="2">
                  <path d="M17 21v-2a4 4 0 0 0-4-4H5a4 4 0 0 0-4 4v2" />
                  <circle cx="9" cy="7" r="4" />
                  <path d="M23 21v-2a4 4 0 0 0-3-3.87" />
                  <path d="M16 3.13a4 4 0 0 1 0 7.75" />
                </svg>
              </div>
              <h3>Career Support</h3>
              <p>From your first class to your first job, our team is with you every step of the way.</p>
            </div>
          </div>
          <div className="section-cta">
            <a href="#program" className="btn btn-primary">See Why We&apos;re Different</a>
          </div>
        </div>
      </section>

      {/* ── Program Structure — one photo ─────────── */}
      <section className="program-section" id="program">
        <div className="container">
          <div className="section-header">
            <span className="section-tag">The Program</span>
            <h2 className="section-title">Certified in 30–45 Days</h2>
            <p className="section-body">
              Our accelerated, structured program takes you from enrollment
              to career-ready in under 45 days.
            </p>
          </div>
          <div className="program-card">
            <div className="program-card-content">
              <div className="steps-track">
                <div className="step-node">
                  <div className="step-circle">
                    <svg viewBox="0 0 24 24" fill="none" stroke="currentColor" strokeWidth="2">
                      <rect x="3" y="4" width="18" height="18" rx="2" />
                      <line x1="16" y1="2" x2="16" y2="6" />
                      <line x1="8" y1="2" x2="8" y2="6" />
                      <line x1="3" y1="10" x2="21" y2="10" />
                    </svg>
                  </div>
                  <div className="step-body">
                    <div className="step-name">Enrollment</div>
                    <div className="step-desc">Sign up and get immediate access to your student portal.</div>
                  </div>
                </div>
                <div className="step-node">
                  <div className="step-circle">
                    <svg viewBox="0 0 24 24" fill="none" stroke="currentColor" strokeWidth="2">
                      <rect x="2" y="3" width="20" height="14" rx="2" />
                      <line x1="8" y1="21" x2="16" y2="21" />
                      <line x1="12" y1="17" x2="12" y2="21" />
                    </svg>
                  </div>
                  <div className="step-body">
                    <div className="step-name">Online Learning</div>
                    <div className="step-desc">Complete self-paced modules covering CNA fundamentals.</div>
                  </div>
                </div>
                <div className="step-node">
                  <div className="step-circle">
                    <svg viewBox="0 0 24 24" fill="none" stroke="currentColor" strokeWidth="2">
                      <path d="M14 2H6a2 2 0 0 0-2 2v16a2 2 0 0 0 2 2h12a2 2 0 0 0 2-2V8z" />
                      <polyline points="14 2 14 8 20 8" />
                      <line x1="16" y1="13" x2="8" y2="13" />
                    </svg>
                  </div>
                  <div className="step-body">
                    <div className="step-name">Clinical Practice</div>
                    <div className="step-desc">Apply skills hands-on in supervised healthcare settings.</div>
                  </div>
                </div>
                <div className="step-node">
                  <div className="step-circle">
                    <svg viewBox="0 0 24 24" fill="none" stroke="currentColor" strokeWidth="2">
                      <path d="M9 11l3 3L22 4" />
                      <path d="M21 12v7a2 2 0 0 1-2 2H5a2 2 0 0 1-2-2V5a2 2 0 0 1 2-2h11" />
                    </svg>
                  </div>
                  <div className="step-body">
                    <div className="step-name">State Exam</div>
                    <div className="step-desc">Take the certification exam with our full prep support.</div>
                  </div>
                </div>
                <div className="step-node">
                  <div className="step-circle">
                    <svg viewBox="0 0 24 24" fill="none" stroke="currentColor" strokeWidth="2">
                      <circle cx="12" cy="12" r="10" />
                      <polyline points="12 6 12 12 16 14" />
                    </svg>
                  </div>
                  <div className="step-body">
                    <div className="step-name">Career Launch</div>
                    <div className="step-desc">Start working as a certified CNA in under 45 days.</div>
                  </div>
                </div>
              </div>
              <div style={{ marginTop: "2.5rem" }}>
                <a href="#tuition" className="btn btn-primary">View Program Details</a>
              </div>
            </div>
            <div className="program-card-photo">
              <Image
                src={img("Nurse Rocky Image 9.jpg")}
                alt="Program in action"
                fill
                sizes="(max-width: 860px) 100vw, 40vw"
                style={{ objectFit: "cover" }}
              />
            </div>
          </div>
        </div>
      </section>

      {/* ── Tuition — one photo ───────────────────── */}
      <section className="tuition-section" id="tuition">
        <div className="container">
          <div className="tuition-card">
            <div className="tuition-img">
              <Image
                src={img("Nurse Rocky Image.jpg")}
                alt="Nurse Rocky training"
                fill
                sizes="40vw"
                style={{ objectFit: "cover" }}
              />
            </div>
            <div className="tuition-info">
              <span className="section-tag">Tuition &amp; Payment</span>
              <h2 className="section-title">Affordable &amp; Accessible</h2>
              <p className="section-body">
                Training is designed to fit your life and your budget. Everything
                you need to become a CNA is included.
              </p>
              <ul className="tuition-features">
                <li><CheckIcon />Online lessons &amp; clinical hours included</li>
                <li><CheckIcon />State exam preparation materials</li>
                <li><CheckIcon />Flexible payment plans available</li>
                <li><CheckIcon />Upfront enrollment discounts</li>
                <li><CheckIcon />Financial aid options available</li>
              </ul>
              <div>
                <a href="/enroll" className="btn btn-primary">Check Payment Plans</a>
              </div>
            </div>
          </div>
        </div>
      </section>

      {/* ── CTA ──────────────────────────────────── */}
      <section className="cta-section">
        <div className="container">
          <div className="cta-inner">
            <div className="cta-text">
              <p className="cta-eyebrow">Start Today</p>
              <h2>Ready to Launch Your CNA Career?</h2>
              <p className="cta-body">
                Join Nurse Rocky and become a Certified Nursing Assistant in 30–45 days.
                Online modules, hands-on clinical training, and full state exam prep — everything
                in one program.
              </p>
              <ul className="cta-list">
                <li>
                  <svg viewBox="0 0 20 20" fill="currentColor" width="16" height="16"><path fillRule="evenodd" d="M16.707 5.293a1 1 0 010 1.414l-8 8a1 1 0 01-1.414 0l-4-4a1 1 0 011.414-1.414L8 12.586l7.293-7.293a1 1 0 011.414 0z" clipRule="evenodd"/></svg>
                  One-time payment, lifetime access
                </li>
                <li>
                  <svg viewBox="0 0 20 20" fill="currentColor" width="16" height="16"><path fillRule="evenodd" d="M16.707 5.293a1 1 0 010 1.414l-8 8a1 1 0 01-1.414 0l-4-4a1 1 0 011.414-1.414L8 12.586l7.293-7.293a1 1 0 011.414 0z" clipRule="evenodd"/></svg>
                  State exam prep included
                </li>
                <li>
                  <svg viewBox="0 0 20 20" fill="currentColor" width="16" height="16"><path fillRule="evenodd" d="M16.707 5.293a1 1 0 010 1.414l-8 8a1 1 0 01-1.414 0l-4-4a1 1 0 011.414-1.414L8 12.586l7.293-7.293a1 1 0 011.414 0z" clipRule="evenodd"/></svg>
                  Career support after graduation
                </li>
              </ul>
            </div>
            <div className="cta-card">
              <div className="cta-price-label">One-Time Tuition</div>
              <div className="cta-price">$1,499</div>
              <p className="cta-price-sub">Full program. No hidden fees.</p>
              <a href="/enroll" className="cta-enroll-btn">Enroll Now</a>
              <p className="cta-secure">
                <svg viewBox="0 0 20 20" fill="currentColor" width="13" height="13"><path fillRule="evenodd" d="M5 9V7a5 5 0 0110 0v2a2 2 0 012 2v5a2 2 0 01-2 2H5a2 2 0 01-2-2v-5a2 2 0 012-2zm8-2v2H7V7a3 3 0 016 0z" clipRule="evenodd"/></svg>
                Secured by Stripe
              </p>
            </div>
          </div>
        </div>
      </section>

      {/* ── Footer ───────────────────────────────── */}
      <footer className="footer">
        <div className="container">
          <div className="footer-grid">
            <div className="footer-brand">
              <div className="logo">Nurse <span>Rocky</span></div>
              <p>Providing accelerated CNA training with hands-on clinical experience and career support.</p>
            </div>
            <div className="footer-col">
              <h4>Program</h4>
              <ul>
                <li><a href="#program">Overview</a></li>
                <li><a href="#program">Online Learning</a></li>
                <li><a href="#program">Clinical Practice</a></li>
                <li><a href="#program">State Exam Prep</a></li>
              </ul>
            </div>
            <div className="footer-col">
              <h4>Careers</h4>
              <ul>
                <li><a href="#careers">Hospital</a></li>
                <li><a href="#careers">Home Health</a></li>
                <li><a href="#careers">Rehab</a></li>
                <li><a href="#careers">Long-Term Care</a></li>
              </ul>
            </div>
            <div className="footer-col">
              <h4>Enroll</h4>
              <ul>
                <li><a href="#tuition">Tuition</a></li>
                <li><a href="#tuition">Payment Plans</a></li>
                <li><a href="#tuition">Financial Aid</a></li>
                <li><a href="/enroll">Apply Now</a></li>
              </ul>
            </div>
          </div>
          <div className="footer-bottom">
            <p>© {new Date().getFullYear()} Nurse Rocky. All rights reserved.</p>
            <p>Empowering the next generation of healthcare professionals.</p>
          </div>
        </div>
      </footer>

      <MobileNav />
    </>
  );
}
