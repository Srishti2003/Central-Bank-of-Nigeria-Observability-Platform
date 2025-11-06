SELECT 
    `publisher` AS `publisher_52aded`,
    count(DISTINCT `account_number`) AS `COUNT_DISTINCT(account_number)_b703a8`
FROM (
    SELECT * 
    FROM cbn_data.card_holder_dist
) AS `virtual_table`
GROUP BY `publisher`
ORDER BY `COUNT_DISTINCT(account_number)_b703a8` DESC;
