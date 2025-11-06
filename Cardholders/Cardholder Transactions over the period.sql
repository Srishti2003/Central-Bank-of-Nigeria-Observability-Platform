SELECT 
    toStartOfHour(toDateTime(`transaction_hour`)) AS `transaction_hour_1e1bc1`,
    sum(`transaction_amount`) AS `SUM(transaction_amount)_74bd16`
FROM (
    SELECT * 
    FROM cbn_data.card_holder_total_transactions_amount_dist
    WHERE transaction_hour != 0
) AS `virtual_table`
GROUP BY toStartOfHour(toDateTime(`transaction_hour`))
ORDER BY `SUM(transaction_amount)_74bd16` DESC;
