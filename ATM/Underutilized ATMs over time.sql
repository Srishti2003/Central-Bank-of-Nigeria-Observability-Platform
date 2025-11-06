SELECT 
    toStartOfHour(toDateTime(`timestamp`)) AS `timestamp_d7e6d5`, 
    `publisher` AS `publisher_52aded`, 
    count(DISTINCT `atm_id`) AS `COUNT_DISTINCT(atm_id)_49ce20`
FROM (
    SELECT 
        toDateTime(date_and_time) AS timestamp, 
        cash_dispensed / cash_replenishment AS cash_ratio, 
        *
    FROM cbn_data.atm_cash_management_dist
) AS `virtual_table`
WHERE `cash_ratio` < 0.4
GROUP BY 
    toStartOfHour(toDateTime(`timestamp`)), 
    `publisher`
ORDER BY 
    `COUNT_DISTINCT(atm_id)_49ce20` DESC;
