-- CrowdfundSQL v1.0
-- Kickstarter Campaign Success Analysis
--
-- Primary analysis population:
-- Only campaigns with state = 'successful' or 'failed'.
--
-- Excluded states:
-- canceled  -> completed but not a clean success/failure outcome
-- suspended -> platform intervention; not directly comparable
-- live      -> campaign outcome not yet resolved
-- undefined -> ambiguous outcome
--
-- Dataset:
-- Kickstarter Projects, ks-projects-201801.csv
-- Total campaigns: 378,661
-- Primary analysis population: 331,675


-- ============================================================
-- DATA QUALITY CHECKS
-- ============================================================

-- Check total number of campaigns.
SELECT COUNT(*) AS total_campaigns
FROM campaigns;


-- Check the distribution of campaign states.
SELECT
    state,
    COUNT(*) AS campaign_count
FROM campaigns
GROUP BY state
ORDER BY campaign_count DESC;


-- ============================================================
-- QUERY 1: SUCCESS RATE BY MAIN CATEGORY
-- ============================================================
--
-- Business question:
-- Which Kickstarter main categories have the highest
-- success rates among campaigns with resolved outcomes?
--
-- Only successful and failed campaigns are included.
-- Campaign count is included so small samples are visible.

SELECT
    main_category,
    COUNT(*) AS total_campaigns,
    SUM(CASE WHEN state = 'successful' THEN 1 ELSE 0 END)
        AS successful_campaigns,
    ROUND(
        100.0 * SUM(CASE WHEN state = 'successful' THEN 1 ELSE 0 END)
        / COUNT(*),
        1
    ) AS success_rate_pct
FROM campaigns
WHERE state IN ('successful', 'failed')
GROUP BY main_category
ORDER BY success_rate_pct DESC;


-- ============================================================
-- QUERY 2: SUCCESS RATE BY CAMPAIGN GOAL
-- ============================================================
--
-- Business question:
-- How does the size of the funding goal relate to campaign
-- success among campaigns with resolved outcomes?
--
-- Goal buckets:
-- < $1K
-- $1K-$5K
-- $5K-$10K
-- $10K-$25K
-- $25K-$50K
-- $50K-$100K
-- $100K-$500K
-- >= $500K
--
-- Campaign count is included to provide context for each rate.

SELECT
    CASE
        WHEN usd_goal_real < 1000 THEN '< $1K'
        WHEN usd_goal_real < 5000 THEN '$1K-$5K'
        WHEN usd_goal_real < 10000 THEN '$5K-$10K'
        WHEN usd_goal_real < 25000 THEN '$10K-$25K'
        WHEN usd_goal_real < 50000 THEN '$25K-$50K'
        WHEN usd_goal_real < 100000 THEN '$50K-$100K'
        WHEN usd_goal_real < 500000 THEN '$100K-$500K'
        ELSE '>= $500K'
    END AS goal_bucket,

    COUNT(*) AS total_campaigns,

    SUM(
        CASE
            WHEN state = 'successful' THEN 1
            ELSE 0
        END
    ) AS successful_campaigns,

    ROUND(
        100.0 *
        SUM(
            CASE
                WHEN state = 'successful' THEN 1
                ELSE 0
            END
        ) / COUNT(*),
        1
    ) AS success_rate_pct

FROM campaigns

WHERE state IN ('successful', 'failed')

GROUP BY goal_bucket

ORDER BY
    CASE goal_bucket
        WHEN '< $1K' THEN 1
        WHEN '$1K-$5K' THEN 2
        WHEN '$5K-$10K' THEN 3
        WHEN '$10K-$25K' THEN 4
        WHEN '$25K-$50K' THEN 5
        WHEN '$50K-$100K' THEN 6
        WHEN '$100K-$500K' THEN 7
        WHEN '>= $500K' THEN 8
    END;


-- ============================================================
-- QUERY 3: SUCCESS RATE BY CAMPAIGN DURATION
-- ============================================================
--
-- Business question:
-- Does campaign duration relate to Kickstarter success?
--
-- Duration is calculated as:
-- deadline - launched
--
-- Buckets:
-- <= 7 days
-- 8-14 days
-- 15-30 days
-- 31-60 days
-- 61-90 days
-- > 90 days

WITH campaign_duration AS (
    SELECT
        state,
        julianday(deadline) - julianday(launched) AS duration_days
    FROM campaigns
    WHERE state IN ('successful', 'failed')
)

SELECT
    CASE
        WHEN duration_days <= 7 THEN '<= 7 days'
        WHEN duration_days <= 14 THEN '8-14 days'
        WHEN duration_days <= 30 THEN '15-30 days'
        WHEN duration_days <= 60 THEN '31-60 days'
        WHEN duration_days <= 90 THEN '61-90 days'
        ELSE '> 90 days'
    END AS duration_bucket,

    COUNT(*) AS total_campaigns,

    SUM(
        CASE
            WHEN state = 'successful' THEN 1
            ELSE 0
        END
    ) AS successful_campaigns,

    ROUND(
        100.0 *
        SUM(
            CASE
                WHEN state = 'successful' THEN 1
                ELSE 0
            END
        ) / COUNT(*),
        1
    ) AS success_rate_pct

FROM campaign_duration

GROUP BY duration_bucket

ORDER BY
    CASE duration_bucket
        WHEN '<= 7 days' THEN 1
        WHEN '8-14 days' THEN 2
        WHEN '15-30 days' THEN 3
        WHEN '31-60 days' THEN 4
        WHEN '61-90 days' THEN 5
        WHEN '> 90 days' THEN 6
    END;


-- ============================================================
-- QUERY 4: SUCCESS RATE BY LAUNCH MONTH
-- ============================================================
--
-- Business question:
-- Does the month in which a campaign launches correspond
-- with different success rates?
--
-- Months are aggregated across all campaign years.
-- This identifies seasonality patterns but does not establish
-- that launch month causes success.

SELECT
    CAST(strftime('%m', launched) AS INTEGER) AS launch_month_number,

    CASE strftime('%m', launched)
        WHEN '01' THEN 'January'
        WHEN '02' THEN 'February'
        WHEN '03' THEN 'March'
        WHEN '04' THEN 'April'
        WHEN '05' THEN 'May'
        WHEN '06' THEN 'June'
        WHEN '07' THEN 'July'
        WHEN '08' THEN 'August'
        WHEN '09' THEN 'September'
        WHEN '10' THEN 'October'
        WHEN '11' THEN 'November'
        WHEN '12' THEN 'December'
    END AS launch_month,

    COUNT(*) AS total_campaigns,

    SUM(
        CASE
            WHEN state = 'successful' THEN 1
            ELSE 0
        END
    ) AS successful_campaigns,

    ROUND(
        100.0 *
        SUM(
            CASE
                WHEN state = 'successful' THEN 1
                ELSE 0
            END
        ) / COUNT(*),
        1
    ) AS success_rate_pct

FROM campaigns

WHERE state IN ('successful', 'failed')

GROUP BY
    strftime('%m', launched)

ORDER BY launch_month_number;