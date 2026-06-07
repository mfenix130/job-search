# Role Overlay: Security Engineer / Product Security

Supplemental signals and theater patterns for security engineering roles.
Includes: AppSec, Product Security, Security Architect, Staff Security Engineer, Penetration Tester.
Load this file alongside the resume-reviewer or resume-tailor skill when the role category is Security.

---

## What Strong Security Engineering Resumes Actually Show

- **Vulnerability lifecycle ownership:** finding, triaging, severity assessment, remediation tracking, disclosure — not just "identified vulnerabilities"
- **Threat modeling specificity:** which methodology (STRIDE, PASTA, attack trees), what system, what was found, what changed
- **Bug class depth:** not just "found XSS" but understanding of root cause, variant coverage, fix review
- **Secure design involvement:** was the candidate in the design review, or called in after the fact?
- **Tooling depth:** built, configured, or tuned tools — not just ran them and read output
- **Scale of impact:** how many engineers were served, how many codebases, what coverage percentage
- **Regulatory and compliance posture where relevant:** pentest scoping, compliance assessment depth, audit evidence quality
- **Red team / offensive work:** scope, methodology, rules of engagement, what the findings drove
- **Developer trust:** evidence that security work was absorbed, not resisted — how was the relationship with engineering managed?

## What Weak Security Resumes Do

- List certifications (OSCP, CEH, CISSP) as a substitute for demonstrated work
- Claim "implemented security best practices" with no specifics
- Describe running automated scanners as if it were security engineering
- Conflate compliance checkbox work with real security improvement
- Use "zero-trust architecture" without describing what specifically changed
- Claim ownership of a security program they contributed one feature to
- List CVEs without explaining what the candidate's specific contribution was

## Theater Patterns to Aggressively Flag

| Phrase | What to probe |
|--------|--------------|
| "Implemented zero-trust architecture" | What specifically changed? Network segmentation? Identity-aware proxy? What was the before state? |
| "Conducted security assessments" | What methodology? What did you find? What was fixed? Who owned remediation? |
| "Improved security posture" | Measured how? Against what baseline? What changed operationally? |
| "Managed vulnerability remediation program" | What was the SLA? What % was meeting it before vs. after? What was your escalation path? |
| "Led security awareness training" | How many people? What changed in behavior metrics? How was phishing click rate tracked? |
| "Implemented SIEM/SOAC" | Which product? What rules did you write? What alert volume, false positive rate? |
| "Performed penetration testing" | External or internal? Black/gray/white box? What tools? What was in scope? What did you find? |
| "Achieved SOC2 / ISO 27001 compliance" | Did you run the program or prepare evidence for an audit someone else designed? |

## Seniority Calibration

**Security Engineer (IC):**
- Executes reviews, assessments, and tooling within a defined security program
- Should show: specific vulnerability classes, tool configuration depth, remediation tracking, clear scope

**Senior Security Engineer:**
- Designs the security program for a product area, not just executes within one
- Influences engineering practices (secure-by-default patterns, threat model integration in SDLC)
- Should show: program ownership, developer relationships, measurable coverage improvement

**Staff / Principal Security Engineer:**
- Sets security architecture direction for the company or a major product line
- Drives org-wide secure design patterns
- Works with legal, compliance, and external researchers/auditors
- Should show: architecture decisions, cross-functional influence, measurable risk reduction with methodology

## Key Evaluation Areas by Sub-Role

**AppSec / Product Security:**
SAST/DAST tooling depth, code review process integration, threat model cadence, bug bar definition, secure SDLC integration, developer enablement approach

**Penetration Testing:**
Methodology, scope definition, reporting quality, finding retest ownership, tool chaining, custom tooling, rules of engagement handling

**Security Architecture:**
Design review process, security principles in architecture decisions, data flow analysis, trust boundary documentation, tradeoff reasoning

**GRC-adjacent Security:**
Audit readiness vs. actual security improvement — probe whether the work produced paper compliance or real risk reduction
