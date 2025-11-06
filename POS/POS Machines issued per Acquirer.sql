SELECT `publisher` AS `publisher_52aded`, 
       sum(`number_of_pos_terminals`) AS `SUM(number_of_pos_terminals)_3adb77`
FROM (
    SELECT count(DISTINCT(pos_terminal_id)) AS number_of_pos_terminals, 
           merchant_code, 
           publisher 
    FROM cbn_data.pos_terminal_acq_bank_dist 
    GROUP BY publisher, merchant_code
) AS `virtual_table` 
GROUP BY `publisher` 
ORDER BY `SUM(number_of_pos_terminals)_3adb77` DESC;
