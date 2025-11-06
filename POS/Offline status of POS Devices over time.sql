SELECT 
    toStartOfDay(toDateTime(`timestamp`)) AS `timestamp_d7e6d5`, 
    `publisher` AS `publisher_52aded`, 
    COUNT(DISTINCT `terminal_id`) AS `COUNT_DISTINCT(terminal_id)_f3439a`
FROM (
    SELECT 
        toDateTime(latest_date) AS `timestamp`, 
        * 
    FROM cbn_data.pos_net_log_dist
) AS `virtual_table`
WHERE `device_status` IN ('offline')
GROUP BY 
    toStartOfDay(toDateTime(`timestamp`)), 
    `publisher`
ORDER BY 
    `COUNT_DISTINCT(terminal_id)_f3439a` DESC;
