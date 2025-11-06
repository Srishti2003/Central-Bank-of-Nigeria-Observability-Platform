SELECT 
  toStartOfHour(toDateTime(`timestamp`)) AS `timestamp_d7e6d5`,
  `publisher_name` AS `publisher_name_186b9c`,
  SUM(`num_messages`) AS `SUM(num_messages)_2c8a3b`
FROM (
  SELECT 
    num_messages, 
    timestamp, 
    publisher_name
  FROM 
    cbn_data.gold_complete_transactions_msg_dist

  /*
  WITH transactions AS (
    SELECT 
      COUNT(1) AS num_messages,
      groupArray(message_type) AS typs,
      CASE 
        WHEN publisher = 'dd7cd8c45fe0abd335d2faebf4b5376851cf310d' THEN 'Interswitch'
        WHEN publisher = 'ddfb18fd0582a937b0bcbfcb016c08c3939e1608' THEN 'Global Accelerex'
        WHEN publisher = '11a66854c0ed7fd7fbaf5a561663c5dc867c9f19' THEN 'UP'
        WHEN publisher = 'e7b824efaf9e8a953a6e67b04326e30a1cf0219d' THEN 'Xpress Payments'
        WHEN publisher = 'e21cfa39b314aa785b113b04dae4206ccb6b7544' THEN 'First Bank'
        WHEN publisher = 'c9cf2b006414cd4518c3d9aedf6504955a63c240' THEN 'Access Bank'
        ELSE 'Unknown'
      END AS publisher_name,
      toStartOfDay(inserted_date) AS timestamp
    FROM cbn_data.iso_transactions_v2_dist 
    GROUP BY publisher_name, timestamp, system_trace_audit_number
  )
  
  SELECT 
    COUNT(1) AS num_messages, 
    timestamp, 
    publisher_name 
  FROM transactions 
  WHERE 
    (has(typs, '0200') AND has(typs, '0210')) 
    OR (has(typs, '1200') AND has(typs, '1210')) 
  GROUP BY publisher_name, timestamp
  */
) AS `virtual_table`
GROUP BY 
  toStartOfHour(toDateTime(`timestamp`)), 
  `publisher_name`
ORDER BY 
  `SUM(num_messages)_2c8a3b` DESC;
