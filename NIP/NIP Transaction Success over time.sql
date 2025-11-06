SELECT 
    `status` AS `status_9acb44`, 
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
GROUP BY `status`
ORDER BY `COUNT(status)_252ce2` DESC;
