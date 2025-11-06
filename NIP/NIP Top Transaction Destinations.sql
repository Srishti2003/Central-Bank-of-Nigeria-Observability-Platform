SELECT 
    `publisher_name` AS `publisher_name_186b9c`, 
    `destination_institution_code` AS `destination_institution_code_47980f`, 
    `num_transactions` AS `num_transactions_4ab16b`
FROM (
    SELECT 
        publisher, 
        destination_institution_code, 
        COUNT(destination_institution_code) AS num_transactions,
        CASE 
            WHEN publisher = 'dd7cd8c45fe0abd335d2faebf4b5376851cf310d' THEN 'Interswitch'
            WHEN publisher = 'ddfb18fd0582a937b0bcbfcb016c08c3939e1608' THEN 'Global Accelerex'
            WHEN publisher = '11a66854c0ed7fd7fbaf5a561663c5dc867c9f19' THEN 'UP'
            WHEN publisher = 'e7b824efaf9e8a953a6e67b04326e30a1cf0219d' THEN 'Xpress Payments'
            WHEN publisher = 'e21cfa39b314aa785b113b04dae4206ccb6b7544' THEN 'First Bank'
            WHEN publisher = 'c9cf2b006414cd4518c3d9aedf6504955a63c240' THEN 'Access Bank'
            ELSE 'Unknown'
        END AS publisher_name
    FROM cbn_data.nip_transactions_dist
    GROUP BY 
        publisher, 
        publisher_name, 
        destination_institution_code
    ORDER BY num_transactions DESC
) AS `virtual_table`;
