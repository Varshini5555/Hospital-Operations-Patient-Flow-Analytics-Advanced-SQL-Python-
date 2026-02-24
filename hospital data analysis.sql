describe dim_hospitals

-- ==========================================================
-- 6. COUNT OF HOSPITALS PER STATE
-- Purpose:
--   1. Understand state-wise hospital coverage
--   2. Identify states with high/low hospital count
-- ==========================================================

SELECT
    sname,                      -- State name
    COUNT(*) AS hospital_count  -- Number of hospitals in state

FROM dim_hospitals

GROUP BY sname                  -- Aggregate per state

ORDER BY hospital_count DESC;   -- Highest first

-- ==========================================================
-- 7.RANK STATES BY HOSPITAL COUNT
-- ==========================================================

SELECT
    sname,
    COUNT(*) AS hospital_count,

    RANK() OVER (
        ORDER BY COUNT(*) DESC
    ) AS state_rank

FROM dim_hospitals

GROUP BY sname

ORDER BY state_rank;

-- ==========================================================
-- 8.CHECK FOR DUPLICATE HOSPITAL IDs
-- Purpose:
--   Ensure hospital_id is unique
-- ==========================================================

SELECT
    hospital_id,
    COUNT(*) AS occurrences

FROM dim_hospitals

GROUP BY hospital_id

HAVING COUNT(*) > 1;

-- ==========================================================
-- 9.STATE SHARE OF TOTAL HOSPITALS
-- Purpose:
--   Calculate % contribution per state
-- ==========================================================

SELECT
    sname,
    COUNT(*) AS hospital_count,

    ROUND(
        COUNT(*) * 100.0 / SUM(COUNT(*)) OVER (),
        2
    ) AS percentage_share

FROM dim_hospitals

GROUP BY sname

ORDER BY percentage_share DESC;