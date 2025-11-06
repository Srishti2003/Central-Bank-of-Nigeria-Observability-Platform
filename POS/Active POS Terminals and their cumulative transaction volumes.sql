SELECT 
    `terminal_id` AS `terminal_id_d6d2c6`, 
    `last_active` AS `last_active_8b18cb`, 
    `merchant_code` AS `merchant_code_4322e3`, 
    `merchant_type` AS `merchant_type_aa9fdd`, 
    `transaction_volume` AS `transaction_volume_9b81a7`, 
    `publisher` AS `publisher_52aded`
FROM (
    WITH 
        terminals_live AS (
            SELECT 
                card_acceptor_terminal_id AS terminal_id, 
                publisher_name, 
                inserted_date AS last_active, 
                amount_transaction,
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
                terminals_live.amount_transaction AS transaction_amount, 
                terminals_static.merchant_code AS merchant_code
            FROM terminals_live 
            INNER JOIN terminals_static 
                ON terminals_static.terminal_id = terminals_live.terminal_id 
               AND terminals_static.publisher = terminals_live.publisher_name
        ),
        terminal_purchases AS (
            SELECT 
                terminal_id, 
                MAX(last_active) AS last_active, 
                MAX(merchant_code) AS merchant_code, 
                MAX(merchant_type) AS merchant_type,
                SUM(active_terminals.transaction_amount) AS transaction_volume,
                publisher 
            FROM active_terminals 
            WHERE active_terminals.message_type = '0200'  
            GROUP BY publisher, terminal_id
        )
    SELECT * 
    FROM terminal_purchases
) AS `virtual_table`
ORDER BY `transaction_volume` DESC;
