-- ================================================
-- 1. DAILY GROWTH ANALYSIS
-- Purpose:
--   1. Compare each day's total with previous day
--   2. Calculate absolute growth
--   3. Calculate percentage growth
-- ================================================

SELECT
    date,                    -- Current day
    
    total,                   -- Total bookings for current day

    -- LAG() gets value from previous row based on ORDER
    LAG(total) OVER (
        ORDER BY date
    ) AS previous_day_total,

    -- Absolute Growth = Today - Yesterday
    total - LAG(total) OVER (
        ORDER BY date
    ) AS absolute_growth,

    -- Percentage Growth
    ROUND(
        (
            (total - LAG(total) OVER (ORDER BY date))
            / LAG(total) OVER (ORDER BY date)
        ) * 100,
        2
    ) AS percentage_growth

FROM day_dashboard_snapshot

ORDER BY date;

-- ==================================================
-- 2.7-DAY MOVING AVERAGE
-- Purpose:
--   Smooth daily fluctuations
--   Identify trend direction
-- ==================================================

SELECT
    date,
    total,

    -- AVG() over last 7 rows including current row
    AVG(total) OVER (
        ORDER BY date
        ROWS BETWEEN 6 PRECEDING AND CURRENT ROW
    ) AS moving_avg_7_days

FROM day_dashboard_snapshot

ORDER BY date;

-- ==================================================
-- 3. ANOMALY DETECTION USING Z-SCORE
-- Purpose:
--   Detect unusually high or low booking days
-- ==================================================

WITH stats AS (
    -- Step 1: Calculate overall average and standard deviation
    SELECT
        AVG(total) AS avg_total,
        STDDEV(total) AS std_dev_total
    FROM day_dashboard_snapshot
)

SELECT
    d.date,
    d.total,

    s.avg_total,
    s.std_dev_total,

    -- Z-score formula
    (d.total - s.avg_total) / s.std_dev_total AS z_score,

    -- Flag anomaly if Z-score > 2 or < -2
    CASE
        WHEN ABS((d.total - s.avg_total) / s.std_dev_total) > 2
        THEN 'ANOMALY'
        ELSE 'NORMAL'
    END AS anomaly_flag

FROM day_dashboard_snapshot d
CROSS JOIN stats s

ORDER BY d.date;

-- ==================================================
-- 4. HOURLY DISTRIBUTION ANALYSIS
-- ==================================================

SELECT
    hour,

    total,

    -- Percentage of total bookings per hour
    ROUND(
        total * 100.0 / SUM(total) OVER (),
        2
    ) AS percentage_share,

    -- Cumulative running total (used for Pareto analysis)
    SUM(total) OVER (
        ORDER BY hour
    ) AS cumulative_total

FROM hour_dashboard_snapshot

ORDER BY hour;

-- ==================================================
-- 5. RANK DAYS BY TOTAL BOOKINGS
-- ==================================================

SELECT
    date,
    total,

    RANK() OVER (
        ORDER BY total DESC
    ) AS booking_rank

FROM day_dashboard_snapshot

ORDER BY booking_rank;