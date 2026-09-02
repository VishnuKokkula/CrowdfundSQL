# Kickstarter Campaign Success Analysis — V1.0

## Business Question

What factors in Kickstarter campaign setup are associated with campaign success?

This analysis examines the relationship between campaign success and:

- Main category
- Funding goal
- Campaign duration
- Launch month

## Data

Dataset: Kickstarter Projects (`ks-projects-201801.csv`)

Total campaigns: 378,661

For the primary analysis, only campaigns with a resolved outcome were included:

- `successful`
- `failed`

This resulted in 331,675 campaigns.

The following states were excluded:

- `canceled` — campaign did not end in a clean success/failure outcome
- `suspended` — campaign was removed or interrupted by the platform
- `live` — campaign outcome had not yet been resolved
- `undefined` — outcome was not clearly classified

This filtering was applied consistently across the four success-rate analyses.

## Data Quality

The dataset passed the primary quality checks:

- 378,661 total rows
- 378,661 distinct campaign IDs
- No missing IDs
- No missing main categories
- No missing campaign states
- No missing `usd_goal_real` values
- No missing launch dates
- No missing deadlines
- No non-positive goals among successful/failed campaigns
- No campaigns where the deadline occurred before launch

## Key Findings

### 1. Funding goal has the strongest observed relationship with success

Campaign success rates declined consistently as funding goals increased.

Campaigns with goals below $1K had a 55.1% success rate, compared with only 3.4% for campaigns with goals of $500K or more.

This represents a 51.7 percentage-point difference.

The pattern was consistent across all eight goal ranges.

### 2. Success rates varied substantially across categories

Dance campaigns had the highest observed success rate at 65.4%, followed by Theater at 63.8% and Comics at 59.1%.

Technology had the lowest success rate at 23.8%, followed by Journalism at 24.4%.

The gap between Dance and Technology was 41.6 percentage points.

These results show a strong association between campaign category and observed success, but they do not establish that category itself causes success.

### 3. Campaign duration showed a less consistent relationship

Campaigns lasting 8–14 days had the highest observed success rate at 54.0%.

Campaigns lasting more than 90 days had a 30.6% success rate.

However, the relationship was not monotonic: campaigns lasting 15–30 days had a 40.2% success rate, compared with 39.5% for 31–60 days.

Duration therefore appears to be a weaker and less straightforward factor than funding goal.

### 4. Launch month showed limited seasonality

Success rates ranged from 36.5% in July to 42.7% in March.

The 6.2 percentage-point difference is relatively small compared with the differences observed across funding-goal buckets and campaign categories.

Launch timing therefore appears to have a comparatively modest relationship with campaign success in this analysis.

## Recommendation

For prospective Kickstarter campaigns, keep the funding goal realistic and aligned with the amount required to deliver the project.

The strongest pattern in this analysis is the sharp decline in observed success rate as the funding goal increases: campaigns below $1K succeeded at 55.1%, while campaigns at $500K or above succeeded at only 3.4%.

However, this analysis is observational and does not prove that lowering a goal will cause a campaign to succeed. Campaign type, audience, creator experience, project quality, and other factors may also influence the result.

## Limitations

This analysis identifies associations rather than causal relationships.

The analysis does not control for:

- Creator experience
- Number of backers
- Campaign popularity
- Project quality
- Country
- Currency
- Category interactions
- Changes in Kickstarter over time

The launch-month analysis also combines campaigns across different years, so broader changes in the Kickstarter platform or market are not isolated.

## Files

- `analysis.sql` — SQL queries used for the analysis
- `results/category_success.csv` — success rate by category
- `results/goal_success.csv` — success rate by funding goal
- `results/duration_success.csv` — success rate by campaign duration
- `results/monthly_success.csv` — success rate by launch month