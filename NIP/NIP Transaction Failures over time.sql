SELECT 
    toStartOfHour(toDateTime(`request_time`)) AS `request_time_ece3cd`, 
    `publisher_name` AS `publisher_name_186b9c`, 
    COUNT(`status`) AS `COUNT(status)_252ce2`
FROM (
    SELECT 
        request_time, 
        response_time,  
        delta, 
        session_id, 
        publisher_name, 
        publisher, 
        reqresp, 
        status
    FROM cbn_data.gold_nip_transactions_dist  
    WHERE _processed_at = '2025-07-03 01:39:43'
) AS `virtual_table`
WHERE `status` IN ('FAIL')
GROUP BY 
    toStartOfHour(toDateTime(`request_time`)), 
    `publisher_name`
ORDER BY `COUNT(status)_252ce2` DESC;
