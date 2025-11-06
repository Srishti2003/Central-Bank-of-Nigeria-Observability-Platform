SELECT 
    toStartOfDay(toDateTime(`on_boarding_date`)) AS `on_boarding_date_c01ee6`, 
    `publisher` AS `publisher_52aded`, 
    count(DISTINCT `merchant_code`) AS `COUNT_DISTINCT(merchant_code)_cc604b`
FROM (
    SELECT * 
    FROM cbn_data.merchant_details_dist
) AS `virtual_table`
WHERE 
    `merchant_NIN` IS NULL 
    AND `on_boarding_date` >= toDate('2024-11-06') 
    AND `on_boarding_date` < toDate('2025-11-06')
GROUP BY 
    toStartOfDay(toDateTime(`on_boarding_date`)), 
    `publisher`
ORDER BY 
    `COUNT_DISTINCT(merchant_code)_cc604b` DESC;
