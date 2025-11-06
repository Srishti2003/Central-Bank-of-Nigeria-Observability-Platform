SELECT 
    toStartOfMonth(toDateTime(`onboarding_date`)) AS `onboarding_date_fabd8e`,
    `publisher` AS `publisher_52aded`,
    count(DISTINCT `agent_code`) AS `COUNT_DISTINCT(agent_code)_324dd3`
FROM (
    SELECT *, toDate(onboarding_date) AS ob_date 
    FROM cbn_data.agent_bank_details_dist
) AS `virtual_table`
GROUP BY 
    toStartOfMonth(toDateTime(`onboarding_date`)),
    `publisher`
ORDER BY 
    `COUNT_DISTINCT(agent_code)_324dd3` DESC;
