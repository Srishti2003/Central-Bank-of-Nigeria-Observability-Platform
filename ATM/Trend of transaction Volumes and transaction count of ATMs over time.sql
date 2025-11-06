SELECT 
    toStartOfDay(toDateTime(`date`)) AS `date_5fc732`, 
    count(DISTINCT `terminal_id`) AS `COUNT_DISTINCT(terminal_id)_f3439a`
FROM (
    SELECT 
        terminal_id, 
        `date`, 
        address, 
        transaction_volume, 
        publisher 
    FROM cbn_data.gold_atm_transaction_vol_count_dist

    -- ORIGINAL QUERY
    /*
    WITH 
        terminals_live AS (
            SELECT 
                card_acceptor_terminal_id AS terminal_id, 
                publisher_name, 
                inserted_date, 
                amount_transaction, 
                message_type, 
                processing_code  
            FROM cbn_data.iso_transactions_v2_dist
        ),
        terminals_static AS (
            SELECT 
                atm_id AS terminal_id, 
                publisher, 
                physical_address 
            FROM cbn_data.atm_inventory_dist
        ),
        active_terminals AS (
            SELECT  
                terminals_live.terminal_id AS terminal_id, 
                terminals_live.publisher_name AS publisher, 
                terminals_live.message_type AS message_type, 
                terminals_live.processing_code AS processing_code,
                terminals_live.inserted_date AS inserted_date, 
                physical_address, 
                terminals_live.amount_transaction AS transaction_amount
            FROM terminals_live 
            INNER JOIN terminals_static 
                ON terminals_static.terminal_id = terminals_live.terminal_id 
               AND terminals_static.publisher = terminals_live.publisher_name
        ),
        terminal_withdrawals AS (
            SELECT 
                terminal_id, 
                toStartOfDay(inserted_date) AS date, 
                MAX(physical_address) AS address, 
                SUM(active_terminals.transaction_amount) AS transaction_volume,
                publisher 
            FROM active_terminals 
            WHERE active_terminals.message_type = '0200' 
              AND active_terminals.processing_code = '01' 
            GROUP BY publisher, terminal_id, date
        ),
        terminal_deposits AS (
            SELECT 
                terminal_id, 
                toStartOfDay(inserted_date), 
                MAX(physical_address) AS address, 
                SUM(active_terminals.transaction_amount) AS transaction_volume,
                publisher 
            FROM active_terminals 
            WHERE active_terminals.message_type = '0200' 
              AND active_terminals.processing_code = '21' 
            GROUP BY publisher, terminal_id, date
        )

    SELECT * 
    FROM terminal_withdrawals
    */
) AS `virtual_table` 
GROUP BY toStartOfDay(toDateTime(`date`)) 
ORDER BY `COUNT_DISTINCT(terminal_id)_f3439a` DESC;
