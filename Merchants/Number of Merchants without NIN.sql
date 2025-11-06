SELECT 
    `publisher` AS `publisher_52aded`, 
    count(DISTINCT `merchant_code`) AS `COUNT_DISTINCT(merchant_code)_cc604b`
FROM (
    SELECT * 
    FROM cbn_data.merchant_details_dist
) AS `virtual_table`
WHERE `merchant_NIN` IS NULL 
GROUP BY `publisher`
ORDER BY `COUNT_DISTINCT(merchant_code)_cc604b` DESC;
