# job-search

Job search workflow repo. Skills and an orchestrator agent for resume review, role research, and tailoring — across any role type (SWE, security, risk/compliance, management, etc.).

## Invoking the Agent

Run the full workflow end-to-end:

```
Use the job-search agent for:
- Resume: <path to resume.pdf / .docx / .doc>
- Application name: <company-role-slug>
- Job sources: <LinkedIn URLs, career page URLs, or .txt JD files>
- Target companies: <company names for research>
```

The agent reads `agent/AGENT.md`, runs all stages in sequence, and writes all output to `applications/<name>/`.

## Skills (run individually if needed)

| Skill | Invoke with | Output |
|---|---|---|
| `job-ingestion` | "Use the job-ingestion skill on [sources], output to applications/[name]" | `role-requirements.md` |
| `company-research` | "Use the company-research skill for [companies], output to applications/[name]" | `company-context.md` |
| `resume-reviewer` | "Use the resume-reviewer skill on applications/[name]" | `hm-recommendations.txt` |
| `resume-tailor` | "Use the resume-tailor skill on applications/[name]" | `tailored-bullets.md` |

Each skill's full instructions are in `skills/<name>/SKILL.md`. Read the skill file before executing it — do not improvise from memory.

## Role Overlays

Load the matching file(s) from `roles/` when running the reviewer or agent. Roles are often hybrid — load all that apply, not just one.

| File | Covers |
|---|---|
| `roles/swe.md` | Software engineer, backend, infra, platform |
| `roles/security.md` | AppSec, product security, pen testing |
| `roles/risk-compliance.md` | GRC, risk manager, compliance officer, audit |
| `roles/manager.md` | Engineering manager, director, VP engineering |
| `roles/product.md` | Product manager, director of product, VP product |
| `roles/data.md` | Data engineer, data scientist, ML engineer, MLOps |

## Workspace Layout

All output goes in `applications/<name>/` (gitignored). Never write to `skills/`, `roles/`, `agent/`, or any root markdown files.

```
applications/<name>/
├── role-requirements.md    ← job-ingestion output
├── company-context.md      ← company-research output
├── hm-recommendations.txt  ← resume-reviewer output (line 1: Score: XX/100)
├── tailored-bullets.md     ← resume-tailor output
└── agent-summary.md        ← agent final report
```

## Resume Formats

PDF → `pdftotext`. DOCX → `pandoc -f docx -t plain` (fall back to python-docx). DOC (legacy) → `pandoc -f doc -t plain`, then `libreoffice --headless --convert-to txt` as fallback. Always extract before reviewing — never read a binary file directly.
