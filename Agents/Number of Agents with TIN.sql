SELECT 
    `publisher` AS `publisher_52aded`, 
    count(DISTINCT `agent_code`) AS `COUNT_DISTINCT(agent_code)_324dd3`
FROM (
    WITH agents AS (
        SELECT * 
        FROM cbn_data.agent_bank_details_dist
        UNION ALL
        SELECT * 
        FROM cbn_data.agent_bank_details_hashed_dist
    )
    SELECT * 
    FROM agents
) AS `virtual_table`
WHERE 
    `agent_TIN` IS NOT NULL
GROUP BY 
    `publisher`
ORDER BY 
    `COUNT_DISTINCT(agent_code)_324dd3` DESC;
