SELECT 
    `acquirer` AS `acquirer_4cb3ff`, 
    AVG(`num_pos_terminals`) AS `AVG(num_pos_terminals)_a7daac`
FROM (
    SELECT 
        publisher AS acquirer, 
        COUNT(DISTINCT pos_terminal_id) AS num_pos_terminals 
    FROM cbn_data.pos_terminal_ptsp_dist 
    GROUP BY publisher
) AS `virtual_table`
GROUP BY `acquirer`
ORDER BY `AVG(num_pos_terminals)_a7daac` DESC;
