SELECT 
    `transaction_amount` AS `transaction_amount_1f1de0`,
    `transaction_week` AS `transaction_week_036107`,
    `card_holder_bvn` AS `card_holder_bvn_6d54ae`
FROM (
    SELECT 
        card_holder_bvn, 
        SUM(transaction_amount) AS transaction_amount, 
        toStartOfWeek(transaction_hour) AS transaction_week
    FROM cbn_data.card_holder_total_transactions_amount_dist
    WHERE transaction_hour != 0
    GROUP BY card_holder_bvn, toStartOfWeek(transaction_hour)
) AS `virtual_table`
ORDER BY `transaction_amount` DESC;
