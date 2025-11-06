SELECT 
    `number_of_principles` AS `number_of_principles_415576`,
    `agent_BVN` AS `agent_BVN_f185e6`,
    `principles` AS `principles_0fc6de`
FROM (
    SELECT 
        count(DISTINCT publisher) AS number_of_principles,
        agent_BVN,
        groupArray(publisher) AS principles
    FROM cbn_data.agent_bank_details_dist
    GROUP BY agent_BVN
    ORDER BY number_of_principles DESC
) AS `virtual_table`
ORDER BY `number_of_principles` DESC;
