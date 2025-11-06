SELECT 
    `number_of_agent_registrations` AS `number_of_agent_registrations_24c55e`,
    `bank_name` AS `bank_name_7499d2`,
    `agent_BVN` AS `agent_BVN_f185e6`
FROM (
    SELECT 
        count(DISTINCT agent_code) AS number_of_agent_registrations,
        publisher AS bank_name,
        agent_BVN
    FROM cbn_data.agent_bank_details_dist
    GROUP BY agent_BVN, publisher
    HAVING number_of_agent_registrations < 300
) AS `virtual_table`
ORDER BY `number_of_agent_registrations` DESC;
