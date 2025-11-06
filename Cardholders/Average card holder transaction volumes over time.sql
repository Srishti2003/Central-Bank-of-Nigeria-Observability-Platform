SELECT `primary_account_number` AS `primary_account_number_e7e815`, `date` AS `date_5fc732`, AVG(`amount_transaction`) AS `AVG(amount_transaction)_4fa8a5` 
FROM (--SELECT sum(amount_transaction) as amount_transaction, primary_account_number, publisher_name as publisher, toStartOfDay(inserted_date) as date from cbn_data.iso_transactions_v2_dist global inner join cbn_data.card_holder_dist  on iso_transactions_v2_dist.primary_account_number=card_holder_dist.account_number group by primary_account_number, date, publisher
SELECT *
FROM cbn_data.gold_card_holder_account_daily_transactions_dist
) AS `virtual_table` 
WHERE `amount_transaction` < 1000000000 GROUP BY `primary_account_number`, `date`;
