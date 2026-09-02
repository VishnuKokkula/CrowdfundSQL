# CrowdfundSQL

A data analytics project exploring what factors are associated with Kickstarter campaign success using SQL and SQLite.

## V1 — SQL Analysis

The first version analyzes the Kickstarter Projects dataset (`ks-projects-201801.csv`) containing 378,661 campaigns.

For the primary analysis, only campaigns with resolved outcomes were included:

- `successful`
- `failed`

This resulted in 331,675 campaigns.

### Analysis

V1 investigates four questions:

1. Which Kickstarter categories have the highest success rates?
2. How does funding goal size relate to campaign success?
3. How does campaign duration relate to success?
4. Does launch month show meaningful differences in success rates?

### Key Findings

- Campaigns with goals below **$1K** had a **55.1%** success rate, compared with **3.4%** for campaigns with goals of **$500K+**.
- **Dance** had the highest observed category success rate at **65.4%**, while **Technology** had the lowest at **23.8%**.
- Campaigns lasting **8–14 days** had the highest observed duration-based success rate at **54.0%**.
- Launch-month success rates varied from **36.5% in July** to **42.7% in March**, showing relatively limited seasonality.

These findings represent **associations, not causal relationships**.

### Project Structure

```text
CrowdfundSQL/
├── v1-sql-analysis/
│   ├── analysis.sql
│   ├── findings.md
│   ├── raw-data/
│   │   └── ks-projects-201801.csv
│   └── results/
│       ├── category_success.csv
│       ├── goal_success.csv
│       ├── duration_success.csv
│       └── monthly_success.csv
├── v2-pipeline/
├── v3-nl-to-sql-app/
├── README.md
└── .gitignore
