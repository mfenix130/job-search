# Company Research Skill

Research each target company and produce a structured context file that makes the resume review and tailoring role- and company-aware.

---

## Runtime Rules

- Always start with a fresh session on rerun.
- Only report what you can find. Do not invent culture signals or fabricate details.
- Mark speculative inferences clearly as `[inferred]`.
- Prioritize recent information (last 12–18 months) over older content.

---

## Purpose

A resume that scores well against a generic role rubric may still be a poor fit for a specific company. A "Risk Manager" resume for a scrappy Series B startup and for a globally regulated bank need to emphasize completely different things.

This skill surfaces the company-specific context that makes tailoring meaningful: regulatory environment, engineering culture, recent events, interview process reputation, and what kind of candidate actually gets hired there.

---

## Inputs

Accepted inputs (any combination):
- `company-targets.txt` — list of company names, one per line
- `role-requirements.md` — output from the job-ingestion skill (company names extracted automatically)
- Inline company names from the user

For each company, also accept an optional role title for more targeted research.

---

## Steps

### For Each Target Company

#### 1. Basic Profile
Search for and extract:
- Industry and business model (B2B SaaS, consumer fintech, regulated bank, defense contractor, etc.)
- Company size and stage (employees, public/private, funding stage)
- Geographic footprint (HQ, offices relevant to the role)
- Core product or service in plain language

#### 2. Technical and Operational Environment
Search for:
- Known tech stack (engineering blog, job postings, StackShare, GitHub org)
- Cloud provider(s), major infrastructure choices
- Any public engineering culture signals (open source contributions, eng blog cadence, conference talks)
- Scale signals (users, transactions, data volume — where publicly stated)

#### 3. Regulatory and Compliance Posture
If the company operates in a regulated domain (finance, healthcare, government, defense):
- Which regulations apply (SOC2, PCI-DSS, HIPAA, FedRAMP, GDPR, DORA, FFIEC, etc.)
- Any public compliance certifications or audit history
- Recent regulatory actions, fines, or consent orders
- Whether compliance is a cost center or a competitive differentiator at this company

#### 4. Recent News and Context
Search for news from the last 12–18 months:
- Layoffs, rapid hiring, reorgs — signals about team stability and growth trajectory
- Product launches, pivots, or major failures
- Security incidents, breaches, or public vulnerabilities (especially relevant for security/risk roles)
- M&A activity
- Leadership changes that affect the hiring function

#### 5. Interview Process Reputation
Search for:
- Glassdoor interview reviews for the target role or similar roles
- Blind, Reddit, or Levels.fyi posts about the interview process
- What the process typically tests (system design, behavioral, take-home, technical screen format)
- Red flags candidates report (ghosting, bait-and-switch, culture mismatch signals)
- Positive signals (fast process, strong offer, good technical bar)

#### 6. What This Company Values in This Role
Based on all findings, synthesize:
- What does success look like in this role at this company specifically?
- What would make a candidate stand out vs. be filtered out?
- What does the company's situation (growth stage, regulatory pressure, recent incidents) imply about what they urgently need?
- How should the resume emphasis shift for this company vs. the generic role requirements?

---

## Output

Write one file: `company-context.md`

```markdown
# Company Research

## Companies Researched
- [Company Name]
- ...

---

## [Company Name]

### Profile
- **Industry:** ...
- **Stage / Size:** ...
- **Business model:** ...

### Technical Environment
[tech stack, infrastructure choices, engineering culture signals]

### Regulatory Posture
[applicable regulations, compliance certifications, recent regulatory events — or "N/A" if not applicable]

### Recent Context (last 12–18 months)
[notable news, hiring signals, incidents, leadership changes]

### Interview Process
[format, what it tests, candidate-reported experience — note source reliability]

### What This Company Needs in This Role
[synthesis: given all above, what kind of candidate actually wins here and why]

---
[Repeat for each company]
```

---

## Source Quality Notes

At the end of the file, note any sources that were unavailable, behind a login, or likely outdated. The reviewer and tailor skills should factor in research gaps when making company-specific recommendations.
