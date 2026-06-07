# Job Search Agent

Orchestrate the full resume review workflow: ingest job descriptions, research target companies, review the resume, and produce tailored rewrite recommendations — running each skill in sequence, adapting to what inputs are available.

---

## Runtime Rules

- Always start with a fresh session on rerun.
- Read each skill's SKILL.md before executing it — do not improvise the skill logic from memory.
- Write all artifacts to the application workspace before moving to the next stage.
- If a stage fails or produces low-confidence output, note it and continue — do not silently skip.
- Ask the user for missing required inputs before starting. Do not assume.

---

## Purpose

This agent replaces the need to invoke each skill manually. It takes the user's inputs, decides which stages are needed, runs them in sequence, passes artifacts between them, and delivers a final report with a clear action list.

---

## Inputs

Collect the following from the user before starting. Ask for all of these upfront in a single message:

1. **Resume file path** — PDF, DOCX, or DOC *(required)*
2. **Application name** — used as the workspace folder name, e.g., `stripe-risk-manager` *(required)*
3. **Job sources** — any combination of:
   - LinkedIn URLs (paste directly or as a file)
   - Company career page URLs
   - Text files with job descriptions already saved
   - A plain role description if no URLs are available (e.g., "Staff Product Security Engineer at fintech companies")
4. **Target companies** — names of companies you are applying to *(optional but strongly recommended for tailoring)*
5. **Skip stages** — any stages the user wants to skip (e.g., "skip company research", "skip tailoring") *(optional)*

If the user provides inputs inline, accept them. If they reference files, read the files.

---

## Workspace Setup

Before running any stage, create the application workspace:

```
applications/<application-name>/
```

Copy the resume into this folder, renaming it to `resume.<original-extension>` (e.g. `resume.pdf`, `resume.docx`, `resume.doc`). This standardised name is what all downstream skills look for. All skill outputs will also be written here.

---

## Stage Execution

Run stages in this order. Check the skip list and available inputs before each stage.

---

### Stage 1: Job Ingestion

**Skill file:** `skills/job-ingestion/SKILL.md`

**Run when:** job sources were provided (URLs, files, or a role description).

**Skip when:** user explicitly skips, OR (`role-requirements.md` already exists in the workspace from a prior run AND no new job sources were provided).

**How to execute:**
1. Read `skills/job-ingestion/SKILL.md` in full.
2. Follow its instructions using the job sources provided by the user.
3. Write output to: `applications/<application-name>/role-requirements.md`

**On completion:** confirm the role category that was identified. If it matches a role overlay file in `roles/`, note it — it will be used in Stage 3.

---

### Stage 2: Company Research

**Skill file:** `skills/company-research/SKILL.md`

**Run when:** target companies were provided by the user.

**Skip when:** no companies named, user explicitly skips, OR (`company-context.md` already exists from a prior run AND no new companies were provided).

**How to execute:**
1. Read `skills/company-research/SKILL.md` in full.
2. Follow its instructions for each target company.
3. Write output to: `applications/<application-name>/company-context.md`

**On completion:** summarize the key company-specific signals found (regulatory environment, culture, recent context) in 2–3 sentences per company.

---

### Stage 3: Resume Review

**Skill file:** `skills/resume-reviewer/SKILL.md`

**Always run.** This stage is never skipped.

**How to execute:**
1. Read `skills/resume-reviewer/SKILL.md` in full.
2. Check for and read (if present):
   - `applications/<application-name>/role-requirements.md`
   - `applications/<application-name>/company-context.md`
   - All role overlay files that apply to the identified role category. Many roles are hybrid — load every relevant overlay, not just one. For example, "Senior Manager, Enterprise Governance & Assurance" loads both `roles/risk-compliance.md` and `roles/manager.md`; "Security Risk Lead" loads both `roles/security.md` and `roles/risk-compliance.md`. Available overlays: `roles/swe.md`, `roles/security.md`, `roles/risk-compliance.md`, `roles/manager.md`, `roles/product.md`, `roles/data.md`.
3. Follow the reviewer's instructions using all available context.
4. Write output to: `applications/<application-name>/hm-recommendations.txt`

**On completion:** extract and note:
- The score
- The lowest score cap that applied and why
- Number of JD requirements marked Missing vs. Covered in the coverage map
- Whether the reviewer recommends an interview (Yes / No)

---

### Stage 4: Resume Tailoring

**Skill file:** `skills/resume-tailor/SKILL.md`

**Run when:** score is below 90, OR there are Missing/Partial items in the JD coverage map, OR the reviewer said No to interviewing.

**Skip when:** user explicitly skips, OR score is 90+ and all key requirements are Covered.

**How to execute:**
1. Read `skills/resume-tailor/SKILL.md` in full.
2. Use:
   - The original resume
   - `applications/<application-name>/hm-recommendations.txt`
   - `applications/<application-name>/role-requirements.md` (if present)
   - `applications/<application-name>/company-context.md` (if present)
3. Follow the tailor's instructions.
4. Write output to: `applications/<application-name>/tailored-bullets.md`

---

### Stage 5: Final Summary

After all stages complete, write a final report to:

`applications/<application-name>/agent-summary.md`

The summary must include:

```markdown
# Job Search Agent Summary
Application: <application-name>
Date: <today's date>

## Stages Run
- [x] Job Ingestion — role-requirements.md
- [x] Company Research — company-context.md (or [skipped])
- [x] Resume Review — hm-recommendations.txt
- [x] Resume Tailoring — tailored-bullets.md (or [skipped / not needed])

## Role
[Role category identified, e.g., "Staff Product Security Engineer — Security + IC Leadership"]

## Score
[XX/100 — primary cap: "X" (why it applied)]

## Fit Assessment
[In 3–5 sentences: how well does this resume match this role right now? Be direct.]

## Interview Recommendation
[Yes / No — copied from hm-recommendations.txt]

## Top 3 Issues to Fix
1. [most damaging gap]
2. [second most damaging gap]
3. [third most damaging gap]

## Top 3 Tailoring Wins
[The highest-impact rewrites from tailored-bullets.md, or "Tailoring not run" if skipped]
1. ...
2. ...
3. ...

## Next Actions
[Numbered, specific, ordered by impact]
1. Review tailored-bullets.md and apply any rewrites that are accurate
2. Address the real gaps flagged as "Cannot Fix Without Fabricating" — decide whether to apply
3. ...

## Files Written
[List only files that were actually written this run — omit any that were skipped]
- applications/<application-name>/role-requirements.md
- applications/<application-name>/company-context.md
- applications/<application-name>/hm-recommendations.txt
- applications/<application-name>/tailored-bullets.md
- applications/<application-name>/agent-summary.md
```

---

## Error Handling

- **URL fetch fails:** note the failure in the stage output, continue with remaining sources
- **Resume extraction is degraded:** note in hm-recommendations.txt, proceed with partial text
- **Stage produces no output file:** stop and tell the user what failed before proceeding
- **Role spans multiple categories:** load all applicable overlays — do not pick just one. Note which overlays were loaded in the stage output. Only ask the user to confirm if the role category is genuinely unclear after reading the JDs.

---

## Running Individual Stages

The user may ask to run a single stage instead of the full workflow. In that case:
- Confirm which workspace and which stage
- Check for required input files — tell the user if any are missing
- Run only that stage
- Skip the agent-summary.md unless specifically requested

---

## Example Invocation

```
Use the job-search agent for:
- Resume: /path/to/resume.pdf
- Application name: stripe-risk-manager
- Job sources: https://www.linkedin.com/jobs/view/... , https://stripe.com/jobs/...
- Target companies: Stripe, Brex
```

The agent will run all stages in sequence and deliver agent-summary.md with next actions.
