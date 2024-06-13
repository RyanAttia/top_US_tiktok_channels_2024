/*

1. Define the variables
2. Create a CTE that rounds the average likes per upload
3. Select the columns that are required for the analysis
4. Filter the results by the Tik Tok channels with the highest follower bases
5. Order by net_profit (from highest to lowest


*/


-- 1.
DECLARE @conversionRate FLOAT = 0.02;      -- The conversion rate @ 2%
DECLARE @productCost MONEY = 7.5;          -- The product cost @ $7.5
DECLARE @campaignCost MONEY = 75000.0;     -- The campaign cost @ %75,000



-- 2. 
WITH ChannelData AS (
	SELECT CHANNEL_NAME, TOTAL_LIKES, TOTAL_UPLOADS, 
	CASE 
        WHEN TOTAL_UPLOADS = 0 THEN 0 
        ELSE ROUND((CAST(TOTAL_LIKES as FLOAT) / TOTAL_UPLOADS), -4) 
	END AS ROUNDED_AVG_LIKES_PER_UPLOAD,
	CASE 
        WHEN TOTAL_UPLOADS = 0 THEN 0 
        ELSE (TOTAL_LIKES/ TOTAL_UPLOADS)
	END AS ORIGINAL_AVG_LIKES_PER_UPLOAD

	FROM tiktok_db.dbo.view_us_tiktok_users_2024
	)



-- 3.
SELECT 
	CHANNEL_NAME,
	ROUNDED_AVG_LIKES_PER_UPLOAD, 
	(ROUNDED_AVG_LIKES_PER_UPLOAD *@conversionRate) AS POTENTIAL_UNITS_SOLD_PER_UPLOAD, 
	(ROUNDED_AVG_LIKES_PER_UPLOAD *@conversionRate * @productCost) AS POTENTIAL_REVENUE_PER_UPLOAD,  
	(ROUNDED_AVG_LIKES_PER_UPLOAD *@conversionRate * @productCost) - @campaignCost AS net_profit

FROM ChannelData

-- 4.
WHERE CHANNEL_NAME IN ('charli d’amelio ','MrBeast ','Bella Poarch ','Addison Rae ','Zach King ')

-- 5.
ORDER BY net_profit DESC


