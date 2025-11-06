SELECT 
    `processing_code_description` AS `processing_code_description_36ff7f`, 
    `message_type` AS `message_type_ce11ea`, 
    `amount_transaction` AS `amount_transaction_7a0e17`, 
    `publisher` AS `publisher_52aded`
FROM (
    SELECT 
        COUNT(DISTINCT(system_trace_audit_number)) AS `cnt`,  
        SUM(amount_transaction) AS `amount_transaction`,  
        MAX(transaction_timestamp) AS `timestamp`, 
        message_type,
        CASE 
            WHEN publisher = 'dd7cd8c45fe0abd335d2faebf4b5376851cf310d' THEN 'Interswitch'
            WHEN publisher = 'ddfb18fd0582a937b0bcbfcb016c08c3939e1608' THEN 'Global Accelerex'
            WHEN publisher = '11a66854c0ed7fd7fbaf5a561663c5dc867c9f19' THEN 'UP'
            WHEN publisher = 'e7b824efaf9e8a953a6e67b04326e30a1cf0219d' THEN 'Xpress Payments'
            WHEN publisher = 'e21cfa39b314aa785b113b04dae4206ccb6b7544' THEN 'First Bank'
            WHEN publisher = 'c9cf2b006414cd4518c3d9aedf6504955a63c240' THEN 'Access Bank'
            ELSE 'Unknown'
        END AS `publisher`,
        CASE 
            WHEN processing_code = '00' THEN 'Purchase'
            WHEN processing_code = '01' THEN 'Cash Advance'
            WHEN processing_code = '20' THEN 'Refund/Return'
            WHEN processing_code = '21' THEN 'Deposit'
            WHEN processing_code = '40' THEN 'Fund Transfer'
        END AS `processing_code_description`
    FROM cbn_data.iso_transactions_v2_dist
    WHERE transaction_timestamp != 0 
      AND publisher_name != 'Xpress Payments'
    GROUP BY processing_code, message_type, publisher
) AS `virtual_table`
WHERE `processing_code_description` IS NOT NULL
ORDER BY `amount_transaction` DESC;
