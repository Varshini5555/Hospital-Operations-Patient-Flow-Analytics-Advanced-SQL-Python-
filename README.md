Hospital Operations & Patient Flow Analytics

📌 Project Overview

This project analyzes hospital operational data from the Online Registration System (ORS) to identify patient flow patterns, infrastructure distribution imbalance, peak load hours, demand volatility, and operational risks using advanced SQL and statistical techniques.
The analysis follows a data warehousing approach using fact and dimension modeling principles.

🎯 Business Problem

Hospital systems face:

Patient load fluctuations
Uneven infrastructure distribution
Peak-hour congestion
Unexpected demand spikes and drops
Limited visibility into operational risks
This project converts raw operational data into actionable insights for capacity planning and system optimization.

🛠 Tech Stack

SQL (Window Functions, CTEs, Ranking, Statistical Methods)
Python (API Data Extraction using requests)
Data Modeling (Fact & Dimension Tables)
Statistical Analysis (Z-Score Anomaly Detection)

📥 Data Collection

Data was extracted from the ORS API using Python.

Key endpoints used:

Day Dashboard
Hour Dashboard
Hospital Master Data

Example extraction:

import requests

url = "https://ors.gov.in/api/dayDashboard"

headers = {
    "User-Agent": "Mozilla/5.0",
    "Accept": "application/json"
}

response = requests.get(url, headers=headers)
data = response.json()

🗂 Data Model

Fact Tables:

day_dashboard_snapshot
hour_dashboard
system_kpi_snapshot

Dimension Tables

dim_hospitals

Schema follows a star-model design for scalable analytics.

📊 Key Analytical Modules
1️⃣ Day-over-Day Growth Analysis

Used LAG() to calculate:

Previous day total
Absolute growth
Percentage growth

2️⃣ 7-Day Moving Average

Implemented rolling window smoothing using:

AVG(total) OVER (
    ORDER BY date
    ROWS BETWEEN 6 PRECEDING AND CURRENT ROW
)
3️⃣ Anomaly Detection

Applied statistical Z-score method:

Z=(value−mean)/standarddeviation

Flagged statistically significant abnormal booking days.

4️⃣ Hourly Distribution & Peak Load

Percentage share per hour
Cumulative distribution
Peak booking window identification

5️⃣ State-wise Infrastructure Analysis

Hospital count per state
Percentage contribution
Ranking using RANK()

Infrastructure concentration risk

🔍 Key Insights

✔ Strong regional infrastructure concentration
✔ Evening-heavy booking behavior (5PM–8PM peak)
✔ Mid-month demand spike
✔ One significant anomaly date
✔ Long-tail state distribution pattern

🚀 Operational Recommendations

Scale server capacity during evening peak hours
Expand hospital onboarding in underrepresented states
Investigate anomaly dates
Align outreach strategies with demand cycles

📈 Skills Demonstrated

Advanced SQL analytical thinking
Window functions mastery

Statistical anomaly detection

Data warehouse modeling

Operational data storytelling
