SELECT 
    toStartOfDay(toDateTime(`date`)) AS `date_5fc732`, 
    `merchant_category` AS `merchant_category_2380d4`, 
    sum(`amount`) AS `SUM(amount)_b88524`
FROM (
    SELECT 
        amount, 
        transaction_count, 
        merchant_category, 
        merchant_type, 
        publisher, 
        date 
    FROM 
        cbn_data.gold_num_transactions_per_merchant_category_dist
    -- OLD
    /*
    WITH 
        terminals_live AS (
            SELECT 
                card_acceptor_terminal_id AS terminal_id, 
                publisher_name, 
                inserted_date AS last_active, 
                amount_transaction, 
                retrieval_reference_number,
                message_type, 
                processing_code, 
                merchant_type   
            FROM cbn_data.iso_transactions_v2_dist
        ),
        terminals_ptsp AS (
            SELECT 
                pos_terminal_id AS terminal_id, 
                NULL AS merchant_code, 
                publisher 
            FROM cbn_data.pos_terminal_ptsp_dist
        ),
        terminals_ptsa AS (
            SELECT 
                pos_terminal_id AS terminal_id, 
                NULL AS merchant_code, 
                publisher 
            FROM cbn_data.pos_terminal_ptsa_dist
        ),
        terminals_acquirer AS (
            SELECT 
                pos_terminal_id AS terminal_id, 
                merchant_code, 
                publisher 
            FROM cbn_data.pos_terminal_acq_bank_dist
        ),
        terminals_static AS (
            SELECT * FROM terminals_ptsp 
            UNION ALL 
            SELECT * FROM terminals_ptsa 
            UNION ALL 
            SELECT * FROM terminals_acquirer
        ),
        active_terminals AS (
            SELECT  
                terminals_live.terminal_id AS terminal_id, 
                terminals_live.publisher_name AS publisher, 
                terminals_live.message_type AS message_type, 
                terminals_live.processing_code AS processing_code,
                terminals_live.last_active AS last_active, 
                terminals_live.merchant_type, 
                terminals_live.retrieval_reference_number AS mid,
                terminals_live.amount_transaction AS transaction_amount, 
                terminals_static.merchant_code AS merchant_code
            FROM 
                terminals_live 
            INNER JOIN terminals_static 
                ON terminals_static.terminal_id = terminals_live.terminal_id 
                AND terminals_static.publisher = terminals_live.publisher_name
        ),
        terminal_purchases AS (
            SELECT  
                toStartOfDay(last_active) AS date,   
                merchant_type,
                sum(active_terminals.transaction_amount) AS transaction_volume, 
                count(active_terminals.mid) AS tid,
                publisher 
            FROM 
                active_terminals 
            WHERE 
                active_terminals.message_type = '0200'  
            GROUP BY 
                publisher, merchant_type, date
        )
    SELECT 
        sum(transaction_volume) AS amount, 
        sum(tid) AS transaction_count,
        CASE 
            WHEN merchant_type = '5300' THEN 'Wholesale Clubs'
            WHEN merchant_type = '5999' THEN 'Retail Purchases'
            WHEN merchant_type = '5541' THEN 'Service/Fuel Stations'
            WHEN merchant_type = '6012' THEN 'Financial Institutions – Merchandise, Services, and Debt Repayment'
            WHEN merchant_type = '5812' THEN 'Eating Places'
            WHEN merchant_type = '5039' THEN 'Construction Materials'
            WHEN merchant_type = '7011' THEN 'Lodging'
            WHEN merchant_type = '5411' THEN 'Grocery Stores'
        END AS merchant_category, 
        merchant_type,
        publisher, 
        date 
    FROM 
        terminal_purchases 
    GROUP BY 
        merchant_type, publisher, date
    */
) AS `virtual_table`
WHERE 
    `merchant_category` IS NOT NULL
GROUP BY 
    toStartOfDay(toDateTime(`date`)), 
    `merchant_category`
ORDER BY 
    `SUM(amount)_b88524` DESC;
