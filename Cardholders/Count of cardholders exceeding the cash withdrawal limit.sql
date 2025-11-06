SELECT 
    toStartOfDay(toDateTime(`date`)) AS `date_5fc732`,
    `publisher` AS `publisher_52aded`,
    count(DISTINCT `primary_account_number`) AS `COUNT_DISTINCT(primary_account_number)_82b667`
FROM (
    --SELECT sum(amount_transaction) as amount_transaction, primary_account_number, publisher_name as publisher, toStartOfDay(inserted_date) as date 
    --FROM cbn_data.iso_transactions_v2_dist 
    --GLOBAL INNER JOIN cbn_data.card_holder_dist  
    --ON iso_transactions_v2_dist.primary_account_number = card_holder_dist.account_number 
    --GROUP BY primary_account_number, date, publisher

    SELECT *
    FROM cbn_data.gold_card_holder_account_daily_transactions_dist
) AS `virtual_table`
WHERE `amount_transaction` > 100000
GROUP BY toStartOfDay(toDateTime(`date`)), `publisher`
ORDER BY `COUNT_DISTINCT(primary_account_number)_82b667` DESC;
