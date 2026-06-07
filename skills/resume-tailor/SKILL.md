# Resume Tailor Skill

Rewrite and restructure resume content to better align with a specific role and company — without fabricating experience.

---

## Runtime Rules

- Always start with a fresh session on rerun.
- Do not invent experience, tools, or outcomes the candidate did not claim.
- Only surface and sharpen what already exists. Every rewrite must be traceable to original resume content.
- If a requirement gap is real (the candidate genuinely lacks it), say so — do not paper over it.

---

## Purpose

The resume reviewer identifies what is weak or missing. This skill fixes it.

The goal is not to make the resume sound impressive — it is to make real domain depth legible to a skeptical hiring manager in 30 seconds. That means: concrete details, honest ownership scope, defensible outcomes, and language that matches how this specific role and company talk about the work.

---

## Inputs

Required:
- `resume.pdf` / `resume.docx` / `resume.doc` — the original resume (standardised filename set by the agent; if run standalone, look for any `*.pdf`, `*.docx`, or `*.doc` in the workspace)
- `hm-recommendations.txt` — output from the resume-reviewer skill

Optional (improves output significantly):
- `role-requirements.md` — output from job-ingestion skill
- `company-context.md` — output from company-research skill

If optional files are not present, tailor against the review findings alone.

---

## Resume Extraction

Before tailoring, extract the resume text:

- **PDF:** `pdftotext <filename> -` via bash
- **DOCX:** `pandoc -f docx -t plain <filename>` via bash; fall back to python-docx if pandoc is unavailable
- **DOC (legacy binary format):** try `pandoc -f doc -t plain <filename>`; if that fails, try `libreoffice --headless --convert-to txt <filename>`; if neither is available, state the limitation explicitly
- If extraction is partial or degraded, note which sections were unclear — do not guess at content

---

## Steps

### Step 1: Parse the Review Findings

From `hm-recommendations.txt`, extract:
- The score and primary score caps that applied
- Every item in "Score Deductions"
- Every item in "Most Damaging Lines"
- Every item in "Tailoring Recommendations for This JD"
- JD Requirements Coverage Map entries marked Partial or Missing

Group into:
- **Fixable now** — the candidate has the experience but the bullet is weak or vague
- **Surfaceable** — the candidate likely has the depth but it isn't on the resume
- **Real gaps** — the candidate genuinely lacks this and cannot honestly claim it

Only work on "Fixable now" and "Surfaceable" items.

### Step 2: Bullet Rewrites

For each bullet in the "Fixable now" category:

**Before rewriting, ask:**
- What did the candidate actually build? (extract from context)
- What decision did they make and why?
- What went wrong and how did they fix it?
- What was the measurable or observable outcome?
- What would a skeptical senior interviewer for this role ask about this?

**Rewrite rules:**
- Lead with the action or decision, not the outcome ("Designed the schema for..." not "Improved query performance by..."; "Defined the risk appetite framework for..." not "Improved risk posture")
- Name specific implementation choices: the data structure, the protocol, the tradeoff made
- State scope honestly: "for a team of 5" not "at scale", "on a 3-month project" not "in production"
- Replace meaningless metrics with honest scope ("reduced P95 latency from 800ms to 200ms on the payment confirmation endpoint, measured via Datadog" not "improved performance by 75%")
- Cut buzzwords that add no information ("leveraged", "spearheaded", "synergized", "cloud-native")
- If a claim cannot be made concrete without fabricating, cut it

**Format:**
```
ORIGINAL:
"[original bullet]"

REWRITE:
"[rewritten bullet]"

WHY: [one sentence on what changed and why it's stronger]
```

### Step 3: Surface Hidden Depth

For items in the "Surfaceable" category:

These are requirements the reviewer flagged as Partial or Missing but where the candidate's existing bullets suggest they may have relevant experience that isn't captured.

For each:
- Identify which existing bullet or role is the closest match
- Suggest a new bullet or an addition to an existing one
- Flag it clearly: `[NEW — only include if you actually did this]`
- The candidate must verify before adding

### Step 4: Summary Section Recommendations

If the resume has a summary/objective section (or lacks one and should have one):
- Rewrite or draft a 2–3 line summary targeting the role category and seniority level
- No buzzwords. No generic claims. State what the candidate actually does and at what level.

### Step 5: Structure and Ordering Recommendations

Based on the role requirements:
- Should any sections be reordered to front-load the most relevant experience?
- Are any sections (skills list, education, certifications) hurting or helping for this role?
- Is the resume the right length for the seniority level being targeted?

### Step 6: What to Cut

Identify content that actively hurts the application for this specific role:
- Experience that signals misalignment with the target seniority or domain
- Projects that look like tutorials or demos rather than real work
- Skills that are irrelevant to this role and dilute the signal
- Anything that invites a question the candidate would struggle to answer

---

## Output

Write one file: `tailored-bullets.md`

```markdown
# Tailored Resume Content

## Score Context
Original score: [XX/100]
Primary caps that applied: [list]
Target improvement: [what would change with these rewrites]

---

## Bullet Rewrites

### [Company / Role / Project Name]

ORIGINAL:
"..."

REWRITE:
"..."

WHY: ...

[Repeat for each rewrite]

---

## Suggested New Bullets
[Only for surfaceable gaps — each flagged with [NEW — verify before adding]]

---

## Summary Section
[Rewritten or drafted summary]

---

## Structure Recommendations
[Reordering, section changes, length]

---

## What to Cut
[Specific bullets, sections, or entries to remove for this role]

---

## Real Gaps (Cannot Fix Without Fabricating)
[Requirements the candidate genuinely lacks — no rewrites provided, noted for awareness]
```

---

## Tone

Direct and specific. This is editorial work, not cheerleading. If a bullet cannot be made honest and concrete, say so. The candidate's credibility in a technical interview is more important than a polished-looking resume.
