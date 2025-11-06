SELECT 
    toStartOfHour(toDateTime(`recorded_timestamp`)) AS `recorded_timestamp_f7ed8c`, 
    `publisher` AS `publisher_52aded`, 
    sum(`avg_cash_replenishment`) AS `SUM(avg_cash_replenishment)_c81044`, 
    sum(`avg_cash_dispensed`) AS `SUM(avg_cash_dispensed)_dd15b6`
FROM (
    SELECT 
        publisher, 
        atm_id, 
        avg(cash_replenishment) AS avg_cash_replenishment, 
        avg(cash_dispensed) AS avg_cash_dispensed,  
        toStartOfDay(toDateTime(date_and_time)) AS recorded_timestamp  
    FROM cbn_data.atm_cash_management_dist 
    GROUP BY recorded_timestamp, publisher, atm_id
) AS `virtual_table`
GROUP BY 
    toStartOfHour(toDateTime(`recorded_timestamp`)), 
    `publisher` 
ORDER BY 
    `SUM(avg_cash_replenishment)_c81044` DESC;
