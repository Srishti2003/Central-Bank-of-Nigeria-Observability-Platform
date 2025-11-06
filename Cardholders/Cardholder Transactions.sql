SELECT 
    `transaction_amount` AS `transaction_amount_1f1de0`,
    `transaction_hour` AS `transaction_hour_1e1bc1`,
    `card_holder_bvn` AS `card_holder_bvn_6d54ae`
FROM (
    SELECT *
    FROM cbn_data.card_holder_total_transactions_amount_dist
    WHERE transaction_hour != 0
) AS `virtual_table`
ORDER BY `transaction_amount` DESC;
