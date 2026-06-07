# job-search

Claude skills and an orchestrator agent for the full job search workflow: ingest job postings, research target companies, review your resume against a specific role, and get concrete rewrite recommendations.

Works for any role type — software engineering, security, risk & compliance, engineering management, and more.

---

## Getting Started

**Requirements:** [Claude Code](https://claude.ai/code), `pandoc`, `pdftotext` (poppler), `python3`

```bash
git clone <this-repo>
cd job-search
./install.sh
claude
```

`install.sh` installs system dependencies (`pandoc`, `pdftotext`, `python-docx`) needed for resume extraction. The agent and skills are plain files in this repo — no separate installation or registration needed. Once you open the project with `claude`, Claude Code loads `CLAUDE.md` automatically and the agent is available immediately.

To use the agent, type its invocation in the **Claude Code chat** (not in your terminal). See [How to Use](#how-to-use) below.

---

## How to Use

This section walks through a complete example from scratch. If you are new to Claude Code, start here.

### What this tool does

You give it your resume and one or more job postings. It:

1. Reads the job postings and figures out what the role actually requires
2. Researches the target company (culture, tech stack, regulatory environment, interview process)
3. Reviews your resume against those requirements — bluntly, the way a hiring manager would
4. Rewrites your weakest bullets into honest, concrete ones that hold up in an interview
5. Delivers a score, a coverage map of the JD requirements, and a prioritised action list

Everything stays on your machine. Your resume and all output files are in `applications/` which is never committed to Git.

---

### Step 1 — Install and open the project

If you haven't already:

```bash
./install.sh   # installs pandoc, pdftotext, python-docx
claude         # opens Claude Code in this directory
```

Claude Code will open a chat interface in your terminal. You will see it load the project context automatically.

---

### Step 2 — Prepare your files

**Your resume**

Put your resume somewhere accessible. PDF, DOCX, and DOC formats all work. You will provide the full path when invoking the agent.

**Job postings**

Collect one or more of the following for the role you are applying to:
- LinkedIn job URLs (e.g. `https://www.linkedin.com/jobs/view/1234567890/`)
- Company career page URLs (e.g. `https://stripe.com/jobs/listing/...`)
- A text file with the job description pasted in (save it as `job.txt`)

Using 3–5 postings for the same role across different companies gives the agent a much stronger picture of what the role really requires — better than any single posting alone.

---

### Step 3 — Choose an application name

Pick a short slug that identifies this application. You will use it again if you re-run any stage later.

Good examples:
- `netflix-grc-manager`
- `fastly-security-risk-lead`
- `stripe-senior-swe`

Avoid spaces. Use hyphens.

---

### Step 4 — Invoke the agent

In the Claude Code chat, type:

```
Use the job-search agent for:
- Resume: /path/to/your/resume.pdf
- Application name: netflix-grc-manager
- Job sources: https://www.linkedin.com/jobs/view/4353469810/ , https://netflix.com/jobs/...
- Target companies: Netflix
```

Replace each value with your actual resume path, application name, URLs, and companies.

**If you only have one job posting**, that is fine — just provide one URL.

**If you saved the job description as a text file** instead of a URL:

```
- Job sources: applications/netflix-grc-manager/job.txt
```

**If you do not have a URL or a file** and just know the role:

```
- Job sources: Senior Manager, Enterprise Governance & Assurance at large tech companies
```

The agent will work with whatever you give it and note any limitations.

---

### Step 5 — Watch it run

The agent runs up to five stages in sequence. You will see it working through each one:

| Stage | What it does | Time |
|---|---|---|
| Job Ingestion | Fetches and reads all job postings, synthesises requirements | ~1–2 min |
| Company Research | Web searches the target company for context | ~1–2 min |
| Resume Review | Reads your resume, scores it, maps it against requirements | ~2–3 min |
| Resume Tailor | Rewrites your weakest bullets | ~1–2 min |

Total: roughly 5–10 minutes depending on how many job postings and companies you provided.

If a URL fails to load, the agent notes it and continues with whatever it could fetch.

---

### Step 6 — Read the output

All output files land in `applications/<your-name>/`. Open them in this order:

#### 1. `agent-summary.md` — start here

The one-page summary. Contains:
- The score (0–100)
- Fit assessment in plain language
- Top 3 issues to fix
- Top 3 highest-impact bullet rewrites
- Numbered next actions

Read this first to understand the overall picture before going into detail.

#### 2. `hm-recommendations.txt` — the full review

The detailed hiring-manager audit. The first line is always the score:

```
Score: 74/100
```

Key sections to focus on:
- **JD Requirements Coverage Map** — a table showing which role requirements your resume covers, partially covers, or misses entirely. This tells you exactly where the gaps are.
- **Biggest Red Flags** — the most damaging credibility problems. Fix these first.
- **Most Damaging Lines** — specific quotes from your resume that hurt you. Rewrite or cut these.
- **Score Deductions** — what prevented a higher score and what evidence would remove each deduction.

#### 3. `tailored-bullets.md` — the rewrites

Before/after rewrites for your weakest bullets. Each rewrite has:
- The original bullet (quoted exactly)
- The rewritten version
- One sentence explaining what changed and why it is stronger

**Important:** Every rewrite is based on what you already claimed. Before adding a suggested new bullet (marked `[NEW — verify before adding]`), confirm you actually have that experience. Never add something that is not true — it will come up in the interview.

#### 4. `role-requirements.md` and `company-context.md` — optional reading

Background context the agent used. Useful if you want to understand what the role really requires or prepare for the interview.

---

### Step 7 — Apply the changes

1. Open your resume in Word, Google Docs, or your editor of choice
2. Work through `tailored-bullets.md` top to bottom
3. For each rewrite: read the original, read the rewrite, check it is accurate, then apply it
4. For `[NEW]` bullets: only add them if you genuinely have that experience
5. For the "What to Cut" section: remove or shorten anything flagged there
6. Re-read `hm-recommendations.txt` → **Most Credible Lines** to understand what is already working — do not change those

---

### Re-running a single stage

If you update your resume and want a fresh review without re-running everything:

```
Use the resume-reviewer skill on applications/netflix-grc-manager.
```

If you want to research an additional company:

```
Use the company-research skill for Alphabet.
Output to applications/netflix-grc-manager.
```

The agent and skills always write to the same workspace folder, so artifacts from earlier stages are preserved and reused.

---

### Applying for multiple roles

Use a separate application name for each role. Each gets its own workspace:

```
applications/
├── netflix-grc-manager/
├── fastly-security-risk-lead/
└── stripe-senior-swe/
```

Nothing is shared between workspaces.

---

## Repository Layout

```
job-search/
├── CLAUDE.md                     # Project context — auto-loaded by Claude Code every session
├── install.sh                    # Dependency installer (macOS + Debian/Ubuntu)
├── requirements.txt              # Python dependencies (python-docx)
├── .claude/
│   └── settings.json             # Tool permissions for the workflow
├── agent/
│   └── SKILL.md                  # Orchestrator — runs the full workflow end-to-end
├── skills/
│   ├── job-ingestion/
│   │   └── SKILL.md              # Fetch JDs from URLs/files, synthesize role requirements
│   ├── company-research/
│   │   └── SKILL.md              # Web search for company context, culture, regulatory posture
│   ├── resume-reviewer/
│   │   └── SKILL.md              # Blunt hiring-manager audit, role-aware, multi-format resume
│   └── resume-tailor/
│       └── SKILL.md              # Rewrite weak bullets, surface hidden depth, suggest cuts
├── roles/
│   ├── swe.md                    # SWE / backend / infra / platform overlay
│   ├── security.md               # Security engineer / AppSec / product security overlay
│   ├── risk-compliance.md        # Risk manager / GRC / compliance officer overlay
│   ├── manager.md                # Engineering manager / director / VP overlay
│   ├── product.md                # Product manager / director of product / VP product overlay
│   └── data.md                   # Data engineer / data scientist / ML engineer overlay
├── applications/                 # Private per-application workspaces; ignored by Git
├── .gitignore
└── README.md
```

---

## Privacy

`applications/` is never committed. Your resume, job descriptions, and all output files stay on your machine.

---

## How It Works

### The Workflow

```
Job URLs / JD files
        │
        ▼
┌─────────────────┐
│  job-ingestion  │ → role-requirements.md
└─────────────────┘
        │
        ▼
┌──────────────────────┐
│  company-research    │ → company-context.md
└──────────────────────┘
        │
        ▼
┌─────────────────────────────────────────┐
│  resume-reviewer                        │
│  + role-requirements.md                 │
│  + company-context.md                   │ → hm-recommendations.txt
│  + roles/<category>.md (overlay)        │
└─────────────────────────────────────────┘
        │
        ▼
┌─────────────────┐
│  resume-tailor  │ → tailored-bullets.md
└─────────────────┘
        │
        ▼
    agent-summary.md
```

Each skill produces an artifact the next stage consumes. Skills can be run individually or chained through the orchestrator agent.

---

## Skills Reference

### `job-ingestion`

Fetches and synthesises job requirements from URLs and text files.

- Accepts: LinkedIn URLs, company career page URLs, saved `.txt` JD files, or a plain role description
- Extracts and deduplicates requirements across multiple postings
- Identifies role category, seniority signals, and implied requirements JDs do not state
- Flags resume theater patterns specific to this role type
- Output: `role-requirements.md`

### `company-research`

Web searches each target company for context that shapes what "good fit" means.

- Covers: tech stack, engineering culture, regulatory posture, recent news, interview process reputation
- Synthesises what the company actually needs given its current stage and situation
- Output: `company-context.md`

### `resume-reviewer`

Blunt hiring-manager audit of the resume against role requirements.

- Accepts: PDF, DOCX, DOC resume formats
- Uses `role-requirements.md` if present, falls back to a raw `job.txt` file
- Loads role overlay (`roles/<category>.md`) for role-specific theater detection
- Factors in `company-context.md` for company-aware scoring
- Produces: score (0–100), JD requirements coverage map, evidence classification, interview questions, tailoring recommendations
- Output: `hm-recommendations.txt`

### `resume-tailor`

Rewrites weak bullets into honest, specific bullets that hold up in an interview.

- Only rewrites what already exists — never fabricates experience
- Distinguishes between "fixable now", "surfaceable", and "real gaps"
- Produces: bullet rewrites with before/after, suggested new bullets (flagged for verification), what to cut, summary rewrite
- Output: `tailored-bullets.md`

---

## Role Overlays

The `roles/` directory contains supplemental context loaded by the reviewer and agent for known role categories. Each overlay adds:

- What strong resumes in this role actually show
- Common resume theater patterns with probe questions
- Seniority calibration (what "senior" vs. "staff" vs. "director" means in this role)

| File | Covers |
|------|--------|
| `roles/swe.md` | SWE, backend, infrastructure, platform engineering |
| `roles/security.md` | AppSec, product security, security architect, pen testing |
| `roles/risk-compliance.md` | Risk manager, GRC, compliance officer, internal audit |
| `roles/manager.md` | Engineering manager, director, VP engineering |
| `roles/product.md` | Product manager, director of product, VP product, CPO |
| `roles/data.md` | Data engineer, data scientist, ML engineer, MLOps |

Hybrid roles (e.g. "Senior Manager, Enterprise Governance & Assurance") load multiple overlays simultaneously. New overlays can be added as new role categories come up.

---

## Resume Formats Supported

| Format | How extracted |
|--------|--------------|
| PDF | `pdftotext` (poppler) |
| DOCX | `pandoc -f docx -t plain` (falls back to python-docx) |
| DOC | `pandoc -f doc -t plain`, then `libreoffice --headless --convert-to txt` as fallback (LibreOffice not installed by default) |

---

## Adding New Skills

Each skill gets its own folder under `skills/`:

```
skills/
└── <skill-name>/
    └── SKILL.md
```

Then add a stage for it in `agent/SKILL.md`.

---

## Planned Skills

- **interview-prep** — role-specific deep technical prep guide from `role-requirements.md` and `hm-recommendations.txt`
- **cover-letter-writer** — targeted cover letter from resume + role requirements + company context
- **ats-screener** — estimate ATS keyword match rate and surface gaps before applying
- **job-fit-evaluator** — score how well a role matches your personal criteria (comp, scope, tech, culture)
