SELECT 
    toStartOfMonth(toDateTime(`issuing_date`)) AS `issuing_date_89be74`,
    `publisher` AS `publisher_52aded`,
    count(`account_number`) AS `COUNT(account_number)_22365c`
FROM (
    SELECT * 
    FROM cbn_data.card_holder_dist
) AS `virtual_table`
WHERE `issuing_date` >= toDate('2020-11-06') 
  AND `issuing_date` < toDate('2025-11-06')
GROUP BY toStartOfMonth(toDateTime(`issuing_date`)), `publisher`
ORDER BY `COUNT(account_number)_22365c` DESC;
