-- Ad Performance Validation Queries (15 Essential Checks)
-- Designed to validate key insights and DAX measures from the Power BI dashboard.
-- Note: Assumes tables are named [ad_events], [ads], [users], [campaigns].

-- ** CRITICAL TIP: Always use CAST(... AS DECIMAL(18, 4)) before division to prevent
-- integer truncation and ensure accurate rate calculations (e.g., CTR, CR, CPA).

--------------------------------------------------------------------------------
-- 1. TOP-LEVEL FUNNEL EFFICIENCY (Validation for overall KPIs and Rates)
-- Validates the main metric cards (Impressions, Clicks, Purchases) and derived rates.
--------------------------------------------------------------------------------
SELECT
    COUNT(CASE WHEN ae.event_type = 'Impression' THEN 1 END) AS Total_Impressions,
    COUNT(CASE WHEN ae.event_type = 'Click' THEN 1 END) AS Total_Clicks,
    COUNT(CASE WHEN ae.event_type = 'Purchase' THEN 1 END) AS Total_Purchases,

    -- CTR (Click-Through Rate)
    CAST(COUNT(CASE WHEN ae.event_type = 'Click' THEN 1 END) AS DECIMAL(18, 4)) * 100 /
    NULLIF(COUNT(CASE WHEN ae.event_type = 'Impression' THEN 1 END), 0) AS CTR_Percentage,

    -- Conversion Rate (Purchases / Clicks)
    CAST(COUNT(CASE WHEN ae.event_type = 'Purchase' THEN 1 END) AS DECIMAL(18, 4)) * 100 /
    NULLIF(COUNT(CASE WHEN ae.event_type = 'Click' THEN 1 END), 0) AS ConversionRate_Percentage,

    -- Purchase Rate (Purchases / Impressions)
    CAST(COUNT(CASE WHEN ae.event_type = 'Purchase' THEN 1 END) AS DECIMAL(18, 4)) * 100 /
    NULLIF(COUNT(CASE WHEN ae.event_type = 'Impression' THEN 1 END), 0) AS PurchaseRate_Percentage
FROM
    ad_events AS ae;

--------------------------------------------------------------------------------
-- 2. PERFORMANCE BY PLATFORM (Validation for Facebook vs Instagram effectiveness)
-- Validates the primary split to identify the most effective platform based on PR.
--------------------------------------------------------------------------------
SELECT
    a.ad_platform,
    COUNT(CASE WHEN ae.event_type = 'Impression' THEN 1 END) AS Impressions,
    COUNT(CASE WHEN ae.event_type = 'Purchase' THEN 1 END) AS Purchases,
    -- Purchase Rate (The most crucial metric for platform comparison)
    CAST(COUNT(CASE WHEN ae.event_type = 'Purchase' THEN 1 END) AS DECIMAL(18, 4)) * 100 /
    NULLIF(COUNT(CASE WHEN ae.event_type = 'Impression' THEN 1 END), 0) AS PurchaseRate_Pct
FROM ad_events AS ae
JOIN ads_1 AS a 
ON ae.ad_id = a.ad_id
GROUP BY a.ad_platform
ORDER BY PurchaseRate_Pct DESC;

--------------------------------------------------------------------------------
-- 3. SEGMENTED PERFORMANCE BY AD TYPE (Validation for Video/Stories superiority)
-- Validates the insight used for budget reallocation (Video & Stories > Carousel/Image).
--------------------------------------------------------------------------------
SELECT
    a.ad_type,
    COUNT(CASE WHEN ae.event_type = 'Impression' THEN 1 END) AS Impressions,
    COUNT(CASE WHEN ae.event_type = 'Click' THEN 1 END) AS Clicks,
    COUNT(CASE WHEN ae.event_type = 'Purchase' THEN 1 END) AS Purchases,
    -- Conversion Rate (CR) Calculation is key here
    CAST(COUNT(CASE WHEN ae.event_type = 'Purchase' THEN 1 END) AS DECIMAL(18, 4)) * 100 /
    NULLIF(COUNT(CASE WHEN ae.event_type = 'Click' THEN 1 END), 0) AS ConversionRate_Percentage
FROM ad_events AS ae
JOIN ads_1 AS a 
ON ae.ad_id = a.ad_id
GROUP BY a.ad_type
ORDER BY ConversionRate_Percentage DESC;

--------------------------------------------------------------------------------
-- 4. NEW: ENGAGEMENT RATE BY AD TYPE (Detailed ER Check)
-- Isolates the Engagement Rate to confirm the 'content resonance' insight for each ad type.
--------------------------------------------------------------------------------
SELECT
    a.ad_type,
    COUNT(CASE WHEN ae.event_type = 'Impression' THEN 1 END) AS Impressions,
    COUNT(CASE WHEN ae.event_type IN ('Click', 'Like', 'Share', 'Comment') THEN 1 END) AS Total_Engagements,
    -- Engagement Rate: Total Engagements / Total Impressions
    CAST(COUNT(CASE WHEN ae.event_type IN ('Click', 'Like', 'Share', 'Comment') THEN 1 END) AS DECIMAL(18, 4)) * 100 /
    NULLIF(COUNT(CASE WHEN ae.event_type = 'Impression' THEN 1 END), 0) AS EngagementRate_Pct
FROM ad_events AS ae
JOIN ads_1 AS a 
ON ae.ad_id = a.ad_id
GROUP BY a.ad_type
ORDER BY EngagementRate_Pct DESC;

--------------------------------------------------------------------------------
-- 5. AUDIENCE ENGAGEMENT BY GENDER (Validation for Female vs Male engagement)
-- Validates the gender distribution of total engagements.
--------------------------------------------------------------------------------
SELECT
    u.user_gender,
    COUNT(CASE WHEN ae.event_type = 'Impression' THEN 1 END) AS Impressions,
    COUNT(CASE WHEN ae.event_type IN ('Click', 'Like', 'Share', 'Comment') THEN 1 END) AS Total_Engagements
FROM ad_events AS ae
JOIN users AS u 
ON ae.user_id = u.user_id
GROUP BY u.user_gender
ORDER BY Total_Engagements DESC;
