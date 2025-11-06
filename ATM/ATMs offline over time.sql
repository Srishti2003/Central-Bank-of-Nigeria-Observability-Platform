SELECT 
    toStartOfHour(toDateTime(`date_and_time`)) AS `date_and_time_757578`, 
    COUNT(DISTINCT `atm_id`) AS `COUNT_DISTINCT(atm_id)_49ce20`
FROM (
    SELECT * 
    FROM cbn_data.atm_device_status_dist
) AS `virtual_table`
WHERE `network_connectivity` IN ('Offline')
GROUP BY toStartOfHour(toDateTime(`date_and_time`))
ORDER BY `COUNT_DISTINCT(atm_id)_49ce20` DESC;
