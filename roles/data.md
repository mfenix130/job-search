# Role Overlay: Data Engineer / Data Scientist / ML Engineer

Supplemental signals and theater patterns for data and ML roles.
Includes: Data Engineer, Analytics Engineer, Data Scientist, ML Engineer, MLOps Engineer.
Load this file alongside the resume-reviewer or resume-tailor skill when the role category is Data or ML.

---

## What Strong Data/ML Resumes Actually Show

- **Pipeline ownership:** designed, built, and operated data pipelines — not just ran queries on someone else's
- **Data quality thinking:** how bad data was detected, handled, and prevented — schema validation, nulls, late-arriving data, duplicate handling
- **Scale specifics:** row counts, throughput, latency — not just "large-scale" or "petabyte-scale"
- **Modelling decisions:** why this model, what alternatives were considered, how it was evaluated offline and online
- **Feature engineering depth:** what features were built, why, how they were computed and served
- **Production ML:** model serving, latency constraints, drift detection, retraining triggers, rollback strategy
- **Tooling depth:** built or configured the tools — not just used them as black boxes
- **Business impact:** what decision or product the data or model actually powered — not just "built a model"

## What Weak Data/ML Resumes Do

- List Spark, Airflow, dbt, Snowflake, etc. without showing how they were used or configured
- Describe Jupyter notebook work as production data science
- Claim "built ML model" without showing training data, evaluation, or deployment
- Use accuracy metrics (95% accuracy) without showing they understood the right metric for the problem
- Describe data pipelines with no mention of failure handling, monitoring, or SLAs
- Claim ownership of a data platform they ran queries on
- List every framework and tool without showing depth in any of them

## Theater Patterns to Aggressively Flag

| Phrase | What to probe |
|--------|--------------|
| "Built ML model achieving 95% accuracy" | Accuracy on what dataset? What was the baseline? What's the class imbalance? Is accuracy even the right metric? |
| "Built scalable data pipeline" | What was the scale? What happened when upstream data was late or malformed? What's the SLA? |
| "Used Spark / Airflow / dbt / Snowflake" | What did you configure or build? What went wrong in production? What did you debug? |
| "Improved model performance by X%" | Improved which metric? Compared to what baseline? How was it measured? What changed in the model? |
| "Implemented end-to-end ML pipeline" | What does the feature store look like? How is the model served? How is drift detected? |
| "Analysed large datasets to derive insights" | What was the question? What did you find? What changed because of the insight? |
| "Deployed model to production" | What's the serving infrastructure? What's the P95 latency? What's the rollback strategy? |
| "Leveraged LLMs / GenAI for X" | What prompt engineering? What evaluation framework? How is hallucination or quality monitored? |

## Seniority Calibration

**Data Analyst / Junior Data Scientist:**
- Runs analyses and builds reports within existing infrastructure
- Should show: SQL depth, specific analytical questions answered, business decisions influenced

**Data Engineer / Data Scientist (mid):**
- Builds and owns pipelines, models, or datasets used by others
- Should show: pipeline ownership, data quality handling, production exposure, tooling depth

**Senior Data Engineer / Senior Data Scientist:**
- Designs the data architecture or ML system for a product area
- Makes technology and modelling decisions, influences data strategy
- Should show: architecture decisions, tradeoffs, production failure handling, cross-team impact

**Staff / Principal / ML Tech Lead:**
- Sets data or ML platform direction for the org
- Defines best practices, mentors others, makes technology bets
- Should show: org-level decisions, platform impact, ML maturity improvements, multi-team influence

## Key Evaluation Areas

**Data Engineering:**
Pipeline reliability (SLAs, alerting, failure recovery), data quality (validation, anomaly detection), schema evolution, orchestration depth, warehouse/lake architecture, cost management at scale

**Data Science:**
Problem framing and metric choice, feature engineering rationale, model selection with alternatives considered, evaluation methodology (offline + online), production monitoring, business impact chain

**ML Engineering / MLOps:**
Feature store design, model serving infrastructure, inference latency management, drift detection, retraining pipelines, A/B testing framework, rollback strategy

**GenAI / LLM Engineering:**
Prompt engineering methodology, evaluation framework, RAG architecture (chunking, retrieval, re-ranking), context management, hallucination handling, latency vs. quality tradeoffs, cost management
