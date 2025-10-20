--------------------------------------------------------------------------------
-- 6. AUDIENCE ENGAGEMENT BY AGE GROUP (Validation for 18-30 being the core audience)
-- Validates which age bracket drives the majority of high-funnel activity (Impressions/Purchases).
--------------------------------------------------------------------------------
SELECT
    u.age_group,
    COUNT(CASE WHEN ae.event_type = 'Impression' THEN 1 END) AS Impressions,
    COUNT(CASE WHEN ae.event_type = 'Purchase' THEN 1 END) AS Purchases
FROM ad_events AS ae
JOIN users AS u 
ON ae.user_id = u.user_id
GROUP BY u.age_group
ORDER BY Impressions DESC;

--------------------------------------------------------------------------------
-- 7. NEW: USER CONVERSION RATE BY AGE GROUP (Deep Funnel Demographics)
-- Validates the conversion efficiency (Clicks -> Purchase) across age groups to confirm value.
--------------------------------------------------------------------------------
SELECT
    u.age_group,
    COUNT(CASE WHEN ae.event_type = 'Click' THEN 1 END) AS Clicks,
    COUNT(CASE WHEN ae.event_type = 'Purchase' THEN 1 END) AS Purchases,
    -- Conversion Rate: Purchases / Clicks
    CAST(COUNT(CASE WHEN ae.event_type = 'Purchase' THEN 1 END) AS DECIMAL(18, 4)) * 100 /
    NULLIF(COUNT(CASE WHEN ae.event_type = 'Click' THEN 1 END), 0) AS ConversionRate_Pct
FROM ad_events AS ae
JOIN users AS u 
ON ae.user_id = u.user_id
GROUP BY u.age_group
ORDER BY ConversionRate_Pct DESC;

--------------------------------------------------------------------------------
-- 8. GEOGRAPHIC SEGMENTATION (Volume vs. Value Countries)
-- Validates the split between high-volume (Impressions) and high-value (Purchases/PR) regions.
--------------------------------------------------------------------------------
SELECT
    u.country,
    COUNT(CASE WHEN ae.event_type = 'Impression' THEN 1 END) AS Total_Impressions,
    COUNT(CASE WHEN ae.event_type = 'Purchase' THEN 1 END) AS Total_Purchases,
    CAST(COUNT(CASE WHEN ae.event_type = 'Purchase' THEN 1 END) AS DECIMAL(18, 4)) * 100 /
    NULLIF(COUNT(CASE WHEN ae.event_type = 'Impression' THEN 1 END), 0) AS PurchaseRate_Pct
FROM ad_events AS ae
JOIN users AS u 
ON ae.user_id = u.user_id
GROUP BY u.country
HAVING -- Filter for countries with at least a meaningful number of impressions
    COUNT(CASE WHEN ae.event_type = 'Impression' THEN 1 END) > 500
ORDER BY Total_Purchases DESC;

--------------------------------------------------------------------------------
-- 9. TIME-BASED VALIDATION (Daily Trend - Day of Week)
-- Validates the daily performance pattern (e.g., higher activity on weekends or weekdays).
--------------------------------------------------------------------------------
SELECT
    ae.day_of_week, -- Field assumed to exist in ad_events
    COUNT(CASE WHEN ae.event_type = 'Impression' THEN 1 END) AS Total_Impressions,
    COUNT(CASE WHEN ae.event_type = 'Purchase' THEN 1 END) AS Total_Purchases
FROM ad_events AS ae
GROUP BY
    ae.day_of_week
-- Ensure days are ordered correctly (e.g., using a CASE statement or DATEPART if needed)
ORDER BY
    CASE ae.day_of_week
        WHEN 'Sunday' THEN 1 WHEN 'Monday' THEN 2 WHEN 'Tuesday' THEN 3 WHEN 'Wednesday' THEN 4
        WHEN 'Thursday' THEN 5 WHEN 'Friday' THEN 6 WHEN 'Saturday' THEN 7 END;

--------------------------------------------------------------------------------
-- 10. COST PER METRIC (Financial Validation for CPC & CPM)
-- Validates the cost efficiency measures. Requires joining to the [campaigns] table.
--------------------------------------------------------------------------------
SELECT
    SUM(c.total_budget) AS Total_Ad_Budget,
    COUNT(CASE WHEN ae.event_type = 'Impression' THEN 1 END) AS Total_Impressions,
    COUNT(CASE WHEN ae.event_type = 'Click' THEN 1 END) AS Total_Clicks,

    -- CPC (Cost Per Click): Total Budget / Total Clicks
    SUM(c.total_budget) / NULLIF(COUNT(CASE WHEN ae.event_type = 'Click' THEN 1 END), 0) AS Avg_CPC,

    -- CPM (Cost Per Mille/1000 Impressions): (Total Budget / Total Impressions) * 1000
    (SUM(c.total_budget) / NULLIF(COUNT(CASE WHEN ae.event_type = 'Impression' THEN 1 END), 0)) * 1000 AS Avg_CPM
FROM ad_events AS ae
JOIN ads_1 AS a 
ON ae.ad_id = a.ad_id
JOIN campaigns AS c 
ON a.campaign_id = c.campaign_id;