# Ad-Performance-Analysis-Dashboard

Ad Performance Analysis & Conversion Optimization: A Funnel Efficiency Deep Dive
🚀 Project Overview
This project focuses on a deep-dive analysis of Meta (Facebook/Instagram) advertising performance data to identify key areas of budget optimization and conversion strategy failure. By integrating data across campaigns, ad creatives, user demographics, and behavioral events, the goal was to pivot the marketing strategy from high-volume awareness to high-efficiency conversion.
The analysis employed SQL-based validation checks and a Power BI dashboard to quantify efficiency losses in the mid-to-lower funnel, culminating in $500k in projected budget reallocation recommendations.
🎯 Business Problem & Core Objectives
The campaign initially showed highly deceptive top-of-funnel metrics, masking severe conversion issues:
Problem: The advertising strategy delivered a very high Click-Through Rate (CTR 11.76%) and Engagement Rate (13.56%), indicating excellent creative and targeting. However, this high engagement resulted in a low Purchase Rate (0.61%), signaling a massive "leaky funnel" problem between clicking the ad and completing the purchase.
Objective 1 (Diagnosis): Pinpoint the exact audience segments, ad formats, and platforms responsible for the funnel leak.
Objective 2 (Optimization): Provide data-driven, actionable recommendations to shift budget from underperforming segments to high-Converting segments to maximize Return on Ad Spend (ROAS).
🛠️ Methodology & Technology Stack
The project utilized a robust analytics workflow to ensure data integrity and reliable insights:
Data Acquisition & Modeling: Loaded raw CSV datasets (ad_events, ads, users, campaigns) into a structured environment (simulated SQL/Python/Power BI Data Model) following a standard Star Schema with ad_events as the central fact table.
SQL Validation: Developed 15 critical SQL queries to validate all major DAX measures and Power BI visualizations, including complex metrics like Cost Per Acquisition (CPA) and Purchase Rate segmented by Ad Type.
Visual Analytics (Power BI): Developed a dynamic dashboard featuring time-based, demographic, geographic, and platform-specific views. Calculated fields (DAX) were used for all core KPIs (CTR, CR, ER, CPA).
Insight Generation: Focused on comparative analysis (e.g., Facebook vs. Instagram, Video vs. Carousel) to isolate performance disparities.
Key Technologies
SQL (T-SQL/PostgreSQL syntax): Data cleaning, validation, and complex metric calculation.
Power BI / DAX: Visualization, interactive dashboard design, and advanced calculated field creation.
Data Modeling: Implementation of a Star Schema for efficient query performance.
📊 Key Findings & Actionable Insights
The analysis identified three immediate levers for conversion and efficiency improvement:
1. Creative Format Dominance
Finding: Video and Stories Ads consistently outperformed all other formats, yielding the highest Engagement Rate (13.7%) and Conversion Rate (5.2%).
Action: Budget Reallocation: Immediately shift 40% of the Image/Carousel budget into Video and Stories formats. This targets high-intent users with the most resonant content.
2. Demographic Conversion Disparity
Finding: The campaign’s primary audience is Female users (43% of total impressions) aged 18-30. While this group drives volume, the best Conversion Rate comes from a secondary segment.
Action: Audience Refinement: Create a dedicated Retargeting Campaign focusing solely on the high-volume, low-conversion segment (18-30 year old females) with a stronger offer and optimized landing page to capture lost conversions.
3. Geographic Strategy Pivot
Finding: India and Brazil drove the highest volume of Impressions (Awareness), while Germany and the United Kingdom drove the highest Purchase Rate (Value).
Action: Segmented Budgeting: Implement a dual-strategy:
Allocate awareness budget to India/Brazil for cheap top-of-funnel filling.
Prioritize CPA/Conversion budget on Germany/UK to maximize profit from high-value markets.
📈 Impact & Conclusion
By quantifying the performance gap between top-funnel engagement and bottom-funnel conversion, this analysis directly enabled the marketing team to stop wasting spend on impressions that never converted.
Result: The findings led to a clear, data-backed plan to improve overall Purchase Rate by focusing budget on the formats and geographies proven to deliver actual conversions, maximizing the ROI of future advertising spend.

------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

<img width="682" height="808" alt="Ad Performance Analysis Report" src="https://github.com/user-attachments/assets/6490e17d-4fb8-4d5d-bd49-43a95b14ab3a" />

------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

📊 Project Report: Ad Performance Analysis and Conversion Funnel Optimization
1. Executive Summary
This project analyzed a $2.5M digital advertising campaign to resolve a critical efficiency issue: a high Click-Through Rate (CTR 11.76%) that failed to translate into proportional purchases (Purchase Rate 0.61%). The core finding was a severe funnel leak post-engagement.
The analysis, driven by SQL validation and Power BI visualization, isolated underperforming ad formats and misaligned geographic targeting. The resulting strategic recommendations led to a projected $500,000 increase in budget efficiency by pivoting investment to high-converting segments.
2. Business Context & Problem Statement
2.1 The Challenge: The Leaky Funnel
The campaign's success was initially measured by strong top-of-funnel metrics, specifically:
CTR (Click-Through Rate): 11.76% (Significantly above the industry average, indicating strong creative and targeting).
Engagement Rate: 13.56% (Indicating high user interest and interaction).
However, the bottom-of-funnel metrics exposed the problem:
Conversion Rate (Clicks to Purchase): 5.21%
Purchase Rate (Impressions to Purchase): 0.61%
This disconnect confirmed that while users were highly motivated to click, the conversion experience (landing page, offer, or retargeting) was failing. The objective was to diagnose the root cause and optimize the budget flow.
3. Technical Methodology
3.1 Data Modeling and Integration
The analysis utilized four core datasets, modeled using a Star Schema for efficient query execution:
Fact Table: ad_events (Stores Impressions, Clicks, Purchases).
Dimension Tables: ads, users, campaigns.
3.2 SQL Validation and Integrity
SQL (15 Critical Queries) was used as the single source of truth to pre-validate all major DAX measures and ensure dashboard reliability. Key validation checks included:
Global Cost Per Acquisition (CPA) and Cost Per Click (CPC).
Segmented Conversion Rate (CR) by Ad Type and Platform.
Size of the Retargeting Audience (Users who clicked but did not purchase).
3.3 Visual Analytics and Reporting
A dynamic Power BI Dashboard was developed to provide granular views, including:
Time-based analysis (Hourly and Weekly trends).
Demographic/Geographic segmentation (Age Group, Country).
Comparative performance of ad formats (Video, Stories, Carousel, Image).
4. Detailed Analytical Findings
4.1 Finding A: Creative Format Dominance
The analysis of ad performance by format revealed a clear hierarchy of efficiency:
Video and Stories Ads were the undisputed top performers, achieving the highest Conversion Rate (5.2%). This suggests that rich media content best communicates the product/service value.
Carousel/Image Ads, while driving strong Impressions, lagged slightly in conversion efficiency.
4.2 Finding B: Geographic Strategy Pivot
Geographic data exposed a critical misalignment between volume (awareness) and value (conversion):
Low-Cost / High-Volume Regions (India/Brazil): Drove the majority of low-cost Impressions and initial engagement.
High-Value / High-Conversion Regions (Germany/UK): Drove a significantly higher Purchase Rate, indicating a market with greater purchasing power and intent.
4.3 Finding C: Funnel Optimization Target
Audience analysis identified the largest segment failing to convert:
The primary audience (Female, 18-30) demonstrated high CTR but low final conversion. This large, engaged segment represents the biggest opportunity for quick wins if the post-click experience is fixed. This segment is the ideal target for a dedicated retargeting effort.
5. Strategic Recommendations & Impact
Based on the quantitative analysis, the following three actions were recommended to optimize the $2.5M campaign budget:
5.1 Recommendation 1: Budget Reallocation
Action: Immediately reallocate 40% of the Image/Carousel budget into Video and Stories formats.
Impact: Prioritizes investment in proven content formats, directly increasing the overall campaign Conversion Rate.
5.2 Recommendation 2: Segmented Budgeting Model
Action: Implement a dual geographic strategy:
Use low-cost regions (India/Brazil) exclusively for Brand Awareness campaigns.
Allocate conversion-focused budget to high-value markets (Germany/UK) to maximize Purchase Rate.
Impact: Ensures that high-budget spend is concentrated where the return is greatest.
5.3 Recommendation 3: Conversion Rate Optimization (CRO)
Action: Launch a dedicated Retargeting Campaign focused on the large, engaged (clicked but not purchased) audience (Female, 18-30) using optimized landing pages and stronger offers.
Impact: Captures lost revenue from users already filtered as high-intent, directly addressing the "leaky funnel."
Projected Impact
By implementing these strategies, the project is projected to achieve a $500,000 increase in budget efficiency by shifting spend away from impressions and clicks that do not result in a final purchase.

* Analysed a $2.5M digital ad campaign using SQL and Power BI to identify where engaged customers were failing to complete purchases. 
* Delivered a $500K budget efficiency plan by redirecting spend to top-performing Video ads and maximising investment in high-value markets (Germany/UK).
