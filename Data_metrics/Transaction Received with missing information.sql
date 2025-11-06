SELECT 
  toStartOfDay(toDateTime(`timestamp`)) AS `timestamp_d7e6d5`,
  `publisher_name` AS `publisher_name_186b9c`,
  SUM(`num_messages`) AS `SUM(num_messages)_2c8a3b`
FROM (
  SELECT 
    COUNT(1) AS num_messages,
    CASE 
      WHEN publisher = 'dd7cd8c45fe0abd335d2faebf4b5376851cf310d' THEN 'Interswitch'
      WHEN publisher = 'ddfb18fd0582a937b0bcbfcb016c08c3939e1608' THEN 'Global Accelerex'
      WHEN publisher = '11a66854c0ed7fd7fbaf5a561663c5dc867c9f19' THEN 'UP'
      WHEN publisher = 'e7b824efaf9e8a953a6e67b04326e30a1cf0219d' THEN 'Xpress Payments'
      WHEN publisher = 'e21cfa39b314aa785b113b04dae4206ccb6b7544' THEN 'First Bank'
      WHEN publisher = 'c9cf2b006414cd4518c3d9aedf6504955a63c240' THEN 'Access Bank'
      ELSE 'Unknown'
    END AS publisher_name,
    toStartOfHour(inserted_date) AS timestamp
  FROM cbn_data.iso_transactions_v2_dist
  WHERE 
    transaction_timestamp IS NULL 
    OR toYear(transaction_timestamp) != 2025
    OR system_trace_audit_number IS NULL
    OR retrieval_reference_number IS NULL
    OR (amount_transaction IS NULL AND amount_settlement IS NULL)
    OR (
      (date_local_transaction IS NULL OR time_local_transaction IS NULL) 
      AND transmission_date_and_time IS NULL
    )
  GROUP BY 
    publisher_name, 
    timestamp
) AS `virtual_table`
GROUP BY 
  toStartOfDay(toDateTime(`timestamp`)), 
  `publisher_name`
ORDER BY 
  `SUM(num_messages)_2c8a3b` DESC;
