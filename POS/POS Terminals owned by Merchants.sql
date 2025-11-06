SELECT 
    `merchant_code` AS `merchant_code_4322e3`, 
    `publisher` AS `publisher_52aded`, 
    `number_of_pos_terminals` AS `number_of_pos_terminals_9e1bf5`
FROM (
    SELECT 
        COUNT(DISTINCT(pos_terminal_id)) AS number_of_pos_terminals, 
        merchant_code, 
        publisher 
    FROM cbn_data.pos_terminal_acq_bank_dist 
    GROUP BY publisher, merchant_code
) AS `virtual_table`
ORDER BY `number_of_pos_terminals` DESC;
