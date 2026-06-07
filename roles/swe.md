# Role Overlay: Software Development Engineer

Supplemental signals and theater patterns for SWE / backend / infrastructure / platform roles.
Load this file alongside the resume-reviewer or resume-tailor skill when the role category is SWE.

---

## What Strong SWE Resumes Actually Show

- **Implementation specificity:** schema design choices, protocol decisions, data structure selection with rationale
- **Ownership boundaries:** what exactly the candidate owned vs. contributed to vs. was present for
- **Production exposure:** on-call, incident response, postmortems, rollbacks, debugging under pressure
- **Testing depth:** unit, integration, contract, load — not just "wrote tests"
- **Operational thinking:** observability design, alerting strategy, runbook ownership
- **Architecture decisions:** why this approach over alternatives — real tradeoffs, not just technology names
- **Debugging stories:** complex bugs, multi-system failures, root cause analysis
- **Delivery with quality:** code review, CI/CD ownership, deployment strategy, rollback handling

## What Weak SWE Resumes Do

- List technology stacks without showing how they were used or why chosen
- Claim ownership of systems they implemented features within
- State outcomes ("improved performance") without measurement methodology
- Describe tutorials or class projects as production systems
- Use distributed systems vocabulary without any implementation depth
- Inflate internship contributions to match full-time IC scope

## Theater Patterns to Aggressively Flag

| Phrase | What to probe |
|--------|--------------|
| "Built end-to-end microservices architecture" | How many services? Who owns them in prod? What's the deployment model? |
| "Improved system performance by X%" | What was the baseline? How was it measured? What changed? |
| "Implemented Kubernetes orchestration" | Did you write the manifests? Own the cluster? Or run `kubectl apply`? |
| "Designed scalable distributed system" | What's the consistency model? How does it handle partitions? |
| "Led development of ML pipeline" | What does the feature engineering look like? How is drift detected? |
| "Integrated CI/CD pipeline" | Which tools? What's the deployment strategy? Who owns failures? |
| "Contributed to open source" | What specifically? Accepted PR? Docs? One-liner fix? |
| "Worked on high-scale platform serving millions" | What was your blast radius if your code shipped a bug? |

## Seniority Calibration

**Mid-level (SWE II / SWE III):**
- Owns features end-to-end within a service someone else designed
- Gets code reviewed and iterates; reviews peers
- Handles oncall for their feature area
- Should show: concrete implementation depth, some debugging, growing system knowledge

**Senior SWE:**
- Owns services or significant systems components
- Makes architecture decisions within their scope, influences across teams
- Drives reliability improvements, not just feature delivery
- Should show: architecture tradeoffs, operational maturity, cross-team impact, mentorship evidence

**Staff / Principal:**
- Owns technical direction for a product area or cross-cutting concern
- Defines the problems worth solving, not just how to solve them
- Work has multi-quarter or multi-team impact
- Should show: org-level technical decisions, before/after improvement narratives, writing/doc/design artifacts
