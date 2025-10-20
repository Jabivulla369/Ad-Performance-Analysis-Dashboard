--------------------------------------------------------------------------------
-- 11. NEW: COST PER ACQUISITION (CPA) BY PLATFORM (Deep Financial Metric)
-- Validates the true cost of acquiring a purchasing customer on Facebook vs. Instagram.
--------------------------------------------------------------------------------
SELECT
    a.ad_platform,
    SUM(c.total_budget) AS Platform_Budget,
    COUNT(CASE WHEN ae.event_type = 'Purchase' THEN 1 END) AS Total_Purchases,
    -- CPA (Cost Per Acquisition): Platform Budget / Total Purchases
    SUM(c.total_budget) / NULLIF(COUNT(CASE WHEN ae.event_type = 'Purchase' THEN 1 END), 0) AS Avg_CPA
FROM ad_events AS ae
JOIN ads_1 AS a 
ON ae.ad_id = a.ad_id
JOIN campaigns AS c 
ON a.campaign_id = c.campaign_id
GROUP BY a.ad_platform
ORDER BY Avg_CPA ASC; -- Lower CPA is better

--------------------------------------------------------------------------------
-- 12. CAMPAIGN PERFORMANCE RANKING (Identifying highest Purchase Rate campaigns)
-- Validates the list/ranking visualization used to determine most efficient campaigns.
--------------------------------------------------------------------------------
SELECT TOP 10
    c.name AS Campaign_Name,
    COUNT(CASE WHEN ae.event_type = 'Impression' THEN 1 END) AS Total_Impressions,
    COUNT(CASE WHEN ae.event_type = 'Purchase' THEN 1 END) AS Total_Purchases,

    -- Purchase Rate (Best measure of campaign success)
    CAST(COUNT(CASE WHEN ae.event_type = 'Purchase' THEN 1 END) AS DECIMAL(18, 4)) * 100 /
    NULLIF(COUNT(CASE WHEN ae.event_type = 'Impression' THEN 1 END), 0) AS PurchaseRate_Pct
FROM ad_events AS ae
JOIN ads_1 AS a 
ON ae.ad_id = a.ad_id
JOIN campaigns AS c 
ON a.campaign_id = c.campaign_id
GROUP BY c.name
HAVING -- Only include campaigns with significant activity (e.g., at least 500 impressions)
    COUNT(CASE WHEN ae.event_type = 'Impression' THEN 1 END) >= 500
ORDER BY PurchaseRate_Pct DESC;

--------------------------------------------------------------------------------
-- 13. NEW: CAMPAIGN DURATION VS. PURCHASE RATE
-- Validates if shorter, focused campaigns or longer, sustained campaigns yield better results.
--------------------------------------------------------------------------------
SELECT
    CASE
        WHEN c.duration_days <= 30 THEN 'Short (<=30 Days)'
        WHEN c.duration_days BETWEEN 31 AND 60 THEN 'Medium (31-60 Days)'
        ELSE 'Long (>60 Days)'
    END AS Campaign_Duration_Group,
    COUNT(DISTINCT c.campaign_id) AS Number_of_Campaigns,
    SUM(CASE WHEN ae.event_type = 'Impression' THEN 1 ELSE 0 END) AS Total_Impressions,
    SUM(CASE WHEN ae.event_type = 'Purchase' THEN 1 ELSE 0 END) AS Total_Purchases,

    CAST(SUM(CASE WHEN ae.event_type = 'Purchase' THEN 1 ELSE 0 END) AS DECIMAL(18, 4)) * 100 /
    NULLIF(SUM(CASE WHEN ae.event_type = 'Impression' THEN 1 ELSE 0 END), 0) AS PurchaseRate_Pct
FROM ad_events AS ae
JOIN ads_1 AS a 
ON ae.ad_id = a.ad_id
JOIN campaigns AS c 
ON a.campaign_id = c.campaign_id
GROUP BY
    CASE
        WHEN c.duration_days <= 30 THEN 'Short (<=30 Days)'
        WHEN c.duration_days BETWEEN 31 AND 60 THEN 'Medium (31-60 Days)'
        ELSE 'Long (>60 Days)'
    END
ORDER BY PurchaseRate_Pct DESC;

--------------------------------------------------------------------------------
-- 14. NEW: PERFORMANCE BY TARGET INTEREST (Top Performing Interests)
-- Validates the primary interest categories that drive the best Conversion Rate.
--------------------------------------------------------------------------------
-- Note: This assumes interests in the 'ads' table are stored as single values or a primary interest can be extracted.
-- If 'target_interests' is a comma-separated string, a more complex string parsing/unnesting function would be required.
SELECT
    a.target_interests,
    COUNT(CASE WHEN ae.event_type = 'Impression' THEN 1 END) AS Impressions,
    COUNT(CASE WHEN ae.event_type = 'Click' THEN 1 END) AS Clicks,
    COUNT(CASE WHEN ae.event_type = 'Purchase' THEN 1 END) AS Purchases,
    -- Conversion Rate: Purchases / Clicks
    CAST(COUNT(CASE WHEN ae.event_type = 'Purchase' THEN 1 END) AS DECIMAL(18, 4)) * 100 /
    NULLIF(COUNT(CASE WHEN ae.event_type = 'Click' THEN 1 END), 0) AS ConversionRate_Pct
FROM ad_events AS ae
JOIN ads_1 AS a 
ON ae.ad_id = a.ad_id
GROUP BY a.target_interests
HAVING
    COUNT(CASE WHEN ae.event_type = 'Click' THEN 1 END) >= 100 -- Filter for statistically significant data
ORDER BY ConversionRate_Pct DESC;

--------------------------------------------------------------------------------
-- 15. VALIDATION OF RETARGETING AUDIENCE (Users who clicked but did not purchase)
-- Identifies the size of the key audience segment for retargeting efforts.
--------------------------------------------------------------------------------
WITH Clicked_Users AS (
    SELECT DISTINCT user_id FROM ad_events WHERE event_type = 'Click'
),
Purchased_Users AS (
    SELECT DISTINCT user_id FROM ad_events WHERE event_type = 'Purchase'
)
SELECT
    COUNT(c.user_id) AS Users_Clicked_Not_Purchased -- This is the size of the retargeting pool
FROM Clicked_Users AS c
LEFT JOIN Purchased_Users AS p 
ON c.user_id = p.user_id
WHERE p.user_id IS NULL;
