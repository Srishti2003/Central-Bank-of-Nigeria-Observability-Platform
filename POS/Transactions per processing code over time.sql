SELECT toStartOfHour(toDateTime(`timestamp`)) AS `timestamp_d7e6d5`, `processing_code_description` AS `processing_code_description_36ff7f`, sum(`amount_transaction`) AS `SUM(amount_transaction)_a74034` 
FROM (SELECT count(distinct(system_trace_audit_number)) as cnt,  sum(amount_transaction) as amount_transaction,  toStartOfDay(transaction_timestamp) as timestamp, message_type,
CASE 
        WHEN publisher = 'dd7cd8c45fe0abd335d2faebf4b5376851cf310d' THEN 'Interswitch'
        WHEN publisher = 'ddfb18fd0582a937b0bcbfcb016c08c3939e1608' THEN 'Global Accelerex'
        WHEN publisher = '11a66854c0ed7fd7fbaf5a561663c5dc867c9f19' THEN 'UP'
        WHEN publisher = 'e7b824efaf9e8a953a6e67b04326e30a1cf0219d' THEN 'Xpress Payments'
        WHEN publisher = 'e21cfa39b314aa785b113b04dae4206ccb6b7544' THEN 'First Bank'
        WHEN publisher = 'c9cf2b006414cd4518c3d9aedf6504955a63c240' THEN 'Access Bank'
        ELSE 'Unknown'
    END AS publisher,
CASE 
        WHEN processing_code='00' THEN 'Purchase'
        WHEN processing_code='01' THEN 'Cash Advance'
        WHEN processing_code='20' THEN 'Refund/Return'
        WHEN processing_code='21' THEN 'Deposit'
        WHEN processing_code='40' THEN 'Fund Transfer'
    END as processing_code_description
from cbn_data.iso_transactions_v2_dist where transaction_timestamp!=0 and publisher_name!='Xpress Payments' group by processing_code, message_type, publisher , timestamp
) AS `virtual_table` 
WHERE `timestamp` >= toDateTime('2025-06-01 00:00:00') AND `timestamp` < toDateTime('2025-11-06 06:27:58') AND `processing_code_description` IS NOT NULL GROUP BY toStartOfHour(toDateTime(`timestamp`)), `processing_code_description` ORDER BY `SUM(amount_transaction)_a74034` DESC;
