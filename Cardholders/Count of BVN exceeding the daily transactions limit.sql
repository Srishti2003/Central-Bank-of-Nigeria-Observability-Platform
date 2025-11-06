SELECT 
    toStartOfDay(toDateTime(`transaction_day`)) AS `transaction_day_9905f3`,
    count(DISTINCT `card_holder_bvn`) AS `COUNT_DISTINCT(card_holder_bvn)_7cbab3`
FROM (
    SELECT 
        card_holder_bvn,
        sum(transaction_amount) AS transaction_amount,
        toStartOfDay(transaction_hour) AS transaction_day
    FROM cbn_data.card_holder_total_transactions_amount_dist
    WHERE transaction_hour != 0
    GROUP BY card_holder_bvn, toStartOfDay(transaction_hour)
) AS `virtual_table`
WHERE 
    `transaction_day` >= toDateTime('2025-08-06 00:00:00')
    AND `transaction_day` < toDateTime('2025-11-06 00:00:00')
    AND (`card_holder_bvn` NOT IN ('787188ffa5cca48212ed291e62cb03e11c1f8279df07feb1d2b0e02e0e4aa9e4'))
    AND `transaction_amount` > 100000
GROUP BY toStartOfDay(toDateTime(`transaction_day`))
ORDER BY `COUNT_DISTINCT(card_holder_bvn)_7cbab3` DESC;
