# Job Ingestion Skill

Fetch and synthesize job requirements from one or more sources into a structured `role-requirements.md` file.

---

## Runtime Rules

- Always start with a fresh session on rerun.
- Do not invent job description content. If a URL fails to load, state the failure and skip.
- If only one JD is available, note that the synthesis is based on a single data point.
- Synthesize across all sources — do not just summarize the first one.

---

## Purpose

This skill answers the question: **what does this role actually require?**

A single job posting is often incomplete, inflated, or poorly written. Ingesting 3–5 postings for the same role across different companies reveals the real signal — what every serious employer in this space actually wants.

---

## Inputs

The user provides any combination of:
- **URLs** — LinkedIn job posts, company career pages, Greenhouse/Lever/Workday postings (in a text file, one URL per line, or pasted directly)
- **Text files** — saved job description `.txt` files
- **Role name** — optional fallback if no JDs are provided ("Staff Product Security Engineer at fintech companies")

Accepted input file: `jd-sources.txt` (one URL or file path per line) or inline input.

---

## Steps

### Step 1: Fetch All Sources

For each URL in the input:
- Fetch the page using available web tools
- Extract the raw job description text — strip navigation, ads, sidebars, apply buttons
- If the page requires authentication or fails to load, note it and skip
- Save extracted text internally — do not write intermediate files

For each text file in the input:
- Read the file directly

### Step 2: Identify Role Category

Based on the JD content, classify the role into one of these categories (or note if it spans multiple):

- **SWE** — Software Development Engineer, Backend, Frontend, Full-Stack, Platform, Infrastructure
- **Security** — Security Engineer, AppSec, Product Security, Penetration Tester, Security Architect
- **Risk & Compliance** — Risk Manager, Compliance Officer, GRC, Audit, Regulatory Affairs
- **Engineering Manager** — EM, Director of Engineering, VP Engineering, Tech Lead Manager
- **Product** — Product Manager, Product Owner, Director of Product
- **Data** — Data Engineer, Data Scientist, ML Engineer, Analytics Engineer
- **Other** — describe explicitly

If a role spans categories (e.g., "Staff Product Security Engineer" is Security + IC leadership), note both.

### Step 3: Synthesize Requirements

Analyze all JDs together and extract:

#### Hard Requirements
Skills, experience, or qualifications explicitly marked as required or that appear in the majority of postings. Mark confidence:
- `[universal]` — appears in all or nearly all postings
- `[common]` — appears in most postings
- `[occasional]` — appears in some postings

#### Preferred / Bonus Requirements
Explicitly marked as nice-to-have, or mentioned in fewer than half the postings.

#### Seniority Signals
What ownership, scope, and decision-making level do these postings expect?
- Who does this person influence or report to?
- Do they own individual work, team output, or org-level outcomes?
- Are they expected to define strategy or execute it?
- What does "senior" or "staff" mean in this role's context?

#### Domain Context
What industry, regulatory, or technical domain knowledge is assumed?
- Regulated industries (finance, healthcare, government)?
- Specific technology domains (cloud, embedded, SaaS)?
- Customer type (enterprise, consumer, internal)?

#### Key Technologies and Frameworks
List all tools, platforms, languages, and frameworks mentioned across postings.
Group into: core (mentioned in most), supplementary (mentioned in some).

#### What the Postings Are Hiding
Based on patterns across postings, identify requirements that are implied but not stated:
- What would someone in this role actually face that the JDs don't say?
- What soft skills or domain depth is assumed but unwritten?
- What does the interview process for this role typically test that the JD omits?

#### Resume Theater for This Role
Based on the role category and requirements, what does resume inflation look like here?
What phrases or claims would a skeptical interviewer immediately question?

---

## Output

Write one file: `role-requirements.md`

```markdown
# Role Requirements

## Role Category
[category] — [brief description of the role type]

## Sources Analyzed
- [URL or filename] — [company name if identifiable]
- ...
N sources total. [Note any that failed to load.]

## Hard Requirements
### Universal
- [requirement] `[universal]`
...

### Common
- [requirement] `[common]`
...

### Occasional
- [requirement] `[occasional]`
...

## Preferred / Bonus Requirements
- ...

## Seniority Signals
[prose description of expected ownership level, scope, decision authority]

## Domain Context
[industry, regulatory, or technical domain assumptions]

## Key Technologies
**Core:** [comma-separated list]
**Supplementary:** [comma-separated list]

## What the Postings Are Hiding
[implied requirements, assumed depth, interview focus areas not in JD]

## Resume Theater Patterns for This Role
[what inflated claims look like here — role-specific]
```

---

## Tone

Be analytical, not enthusiastic. The goal is to produce an accurate, high-signal requirements map — not a summary of what the JDs say they want. Read between the lines.
