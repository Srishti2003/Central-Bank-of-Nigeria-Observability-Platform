SELECT 
    `publisher_name` AS `publisher_name_186b9c`, 
    `processing_time` AS `processing_time_270206`
FROM (
    SELECT 
        processing_time, 
        amount, 
        publisher, 
        publisher_name, 
        request_timestamp, 
        response_timestamp, 
        retrieval_reference_number, 
        system_trace_audit_number
    FROM cbn_data.gold_iso_processing_time_dist
) AS `virtual_table`
WHERE 
    `processing_time` > 0 
    AND `processing_time` < 1000
    AND `request_timestamp` >= toDateTime('2025-06-01 00:00:00') 
    AND `request_timestamp` < toDateTime('2025-11-06 06:22:10');
