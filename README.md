# CrowdfundSQL

A data analytics project exploring the factors associated with **Kickstarter campaign success** using **SQL and SQLite**.

---

## 📌 Current Version: v1 — SQL Analysis

### Project Overview

The first version analyzes the **Kickstarter Projects dataset** from `ks-projects-201801.csv`. The dataset contains **378,661 campaigns**.

For the main analysis, I included only campaigns with a resolved outcome:

- `successful`

- `failed`

After filtering out campaigns without a resolved outcome, the analysis included **331,675 campaigns**.

---

## 🔍 Analysis Questions

V1 focuses on four questions:

1. Which Kickstarter categories have the highest success rates?

1. How is funding goal size associated with campaign success?

1. How is campaign duration associated with success?

1. Does the launch month show meaningful differences in success rates?

---

## 📊 Key Findings

| Area | Finding |
| --- | --- |
| Funding goal | Campaigns with goals below **$1K** had a **55.1%** success rate, compared with **3.4%** for campaigns with goals of **$500K+**. |
| Category | **Dance** had the highest observed success rate at **65.4%**, while **Technology** had the lowest at **23.8%**. |
| Campaign duration | Campaigns lasting **8–14 days** had the highest observed duration-based success rate at **54.0%**. |
| Launch month | Success rates ranged from **36.5% in July** to **42.7% in March**, suggesting relatively limited seasonality. |

> These findings describe **associations, not causal relationships**. They show how campaign characteristics are related to success in the dataset, but they do not prove that one factor directly caused another.

---

## 🧩 Project Structure

```
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
```

The project is organized by version so that the SQL analysis can later be extended into a reusable data pipeline and a natural-language-to-SQL application.

---

## 🛠️ Tools Used

- **SQL** for filtering, grouping, and analyzing campaign data

- **SQLite** for local database analysis

- **CSV files** for raw data and exported results

- **Git and GitHub** for version control and project documentation

---

## 🚀 Project Roadmap

| Version | Focus | Status |
| --- | --- | --- |
| **v1** | SQL analysis of Kickstarter campaign success | ✅ Complete |
| **v2** | Reusable data pipeline | Planned |
| **v3** | Natural-language-to-SQL analytics application | Planned |

---

*Project documentation for v1 — SQL Analysis.*
