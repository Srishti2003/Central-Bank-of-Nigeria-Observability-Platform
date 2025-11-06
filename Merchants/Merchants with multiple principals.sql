SELECT 
    `number_of_principles` AS `number_of_principles_415576`, 
    `merchant_bvn` AS `merchant_bvn_c3c4e6`, 
    `principles` AS `principles_0fc6de`
FROM (
    SELECT 
        count(DISTINCT publisher) AS number_of_principles, 
        SHA256(merchant_bvn) AS merchant_bvn, 
        groupArray(DISTINCT publisher) AS principles
    FROM cbn_data.merchant_details_dist
    WHERE merchant_bvn != '0'
    GROUP BY merchant_bvn
    ORDER BY number_of_principles DESC
) AS `virtual_table`
ORDER BY `number_of_principles` DESC
