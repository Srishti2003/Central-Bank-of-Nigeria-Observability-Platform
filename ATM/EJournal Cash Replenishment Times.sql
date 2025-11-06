SELECT 
    `id` AS `id_b80bb7`, 
    `type` AS `type_599dcc`, 
    `category` AS `category_c4ef35`, 
    `module` AS `module_22884d`, 
    `text` AS `text_1cb251`, 
    `date` AS `date_5fc732`, 
    `publisher_id` AS `publisher_id_2604cb`, 
    `publisher` AS `publisher_52aded`
FROM (
    -- Example of potential lead-in-frame query:
    -- SELECT 
    --     leadInFrame(text) OVER (ROWS BETWEEN CURRENT ROW AND UNBOUNDED FOLLOWING) AS nt
    -- FROM cbn_data.journal_dist 
    -- WHERE match(text, 'SYSTEM ')

    SELECT * 
    FROM cbn_data.journal_dist 
    WHERE match(text, 'ATM OPEN')
) AS `virtual_table`;
