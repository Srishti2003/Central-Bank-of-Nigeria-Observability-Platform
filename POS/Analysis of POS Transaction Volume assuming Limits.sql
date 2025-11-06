SELECT 
  toStartOfDay(toDateTime(`date`)) AS `date_5fc732`,
  `publisher` AS `publisher_52aded`,
  COUNT(`terminal_id`) AS `COUNT(terminal_id)_03433e`
FROM (
  SELECT 
    terminal_id,
    `date`,
    merchant_code,
    merchant_type,
    transaction_volume,
    transaction_type,
    publisher
  FROM cbn_data.edit_dataset_pos_terminal_transactions_categorized_dist

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
        terminals_live.inserted_date AS inserted_date, 
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
        toStartOfDay(inserted_date) AS date, 
        MAX(merchant_code) AS merchant_code, 
        MAX(merchant_type) AS merchant_type,
        SUM(active_terminals.transaction_amount) AS transaction_volume, 
        CASE 
          WHEN active_terminals.processing_code = '00' THEN 'Purchase' 
          WHEN active_terminals.processing_code = '01' THEN 'Cash Withdrawal' 
        END AS transaction_type,
        publisher 
      FROM active_terminals 
      WHERE 
        active_terminals.message_type = '0200' 
        AND (active_terminals.processing_code = '00' OR active_terminals.processing_code = '01')
      GROUP BY publisher, terminal_id, date, processing_code
    )

  SELECT * FROM terminal_purchases
  */
) AS `virtual_table`
WHERE 
  `transaction_type` IN ('Purchase') 
  AND `transaction_volume` > 1000000
GROUP BY 
  toStartOfDay(toDateTime(`date`)), 
  `publisher`
ORDER BY 
  SUM(`transaction_volume`) DESC;
