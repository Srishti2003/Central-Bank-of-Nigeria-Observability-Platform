SELECT `merchant_code` AS `merchant_code_4322e3`, `publisher` AS `publisher_52aded`, `amount` AS `amount_e9f40e` 
FROM (SELECT amount, merchant_code, publisher
FROM cbn_data.gold_merchant_transaction_volumes_dist 

/*WITH 
 terminals_live as (select card_acceptor_terminal_id as terminal_id, publisher_name, inserted_date as last_active, amount_transaction,
 message_type, processing_code, merchant_type   from cbn_data.iso_transactions_v2_dist),
 terminals_ptsp as (select pos_terminal_id as terminal_id, Null as merchant_code, publisher from cbn_data.pos_terminal_ptsp_dist),
terminals_ptsa as (select pos_terminal_id as terminal_id, Null as merchant_code, publisher from cbn_data.pos_terminal_ptsa_dist),
terminals_acquirer as (select pos_terminal_id as terminal_id, merchant_code, publisher from cbn_data.pos_terminal_acq_bank_dist),
terminals_static as (select * from terminals_ptsp union all ( select * from terminals_ptsa union all ( select * from terminals_acquirer))),
active_terminals as (select  terminals_live.terminal_id as terminal_id, terminals_live.publisher_name as publisher, terminals_live.message_type as message_type, 
 terminals_live.processing_code as processing_code,terminals_live.last_active as last_active, terminals_live.merchant_type,
 terminals_live.amount_transaction as transaction_amount, terminals_static.merchant_code as merchant_code
  from terminals_live inner join terminals_static 
    on terminals_static.terminal_id=terminals_live.terminal_id and terminals_static.publisher=terminals_live.publisher_name),
terminal_purchases as (select terminal_id, max(last_active) as last_active, max(merchant_code) as merchant_code, max(merchant_type) as merchant_type,
sum(active_terminals.transaction_amount) as transaction_volume
  , publisher from active_terminals where active_terminals.message_type='0200'  group by publisher, terminal_id)
  -- terminal_deposits as (select terminal_id, max(last_active) as last_active,  sum(active_terminals.transaction_amount) as transaction_volume,
  -- publisher from active_terminals where active_terminals.message_type='0200' and active_terminals.processing_code='21' group by publisher, terminal_id)
SELECT sum(transaction_volume) as amount, merchant_code, publisher from terminal_purchases group by merchant_code, publisher
*/
) AS `virtual_table` ORDER BY `amount` DESC;
