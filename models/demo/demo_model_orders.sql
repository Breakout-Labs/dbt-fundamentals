select
    1 as order_id,
    101 as customer_id,
    5 as quantity,
    49.99 as order_amount,
    0 as discount_pct,
    0 as quantity_returned,
    '2025-01-15' as order_date
union all
select
    2 as order_id,
    102 as customer_id,
    2 as quantity,
    19.50 as order_amount,
    10 as discount_pct,
    1 as quantity_returned,
    '2025-02-03' as order_date
union all
select
    3 as order_id,
    103 as customer_id,
    1 as quantity,
    199.00 as order_amount,
    25 as discount_pct,
    0 as quantity_returned,
    '2025-02-20' as order_date
union all
select
    4 as order_id,
    104 as customer_id,
    10 as quantity,
    599.00 as order_amount,
    15 as discount_pct,
    2 as quantity_returned,
    '2025-03-08' as order_date
union all
select
    5 as order_id,
    105 as customer_id,
    3 as quantity,
    89.00 as order_amount,
    50 as discount_pct,
    3 as quantity_returned,
    '2025-03-22' as order_date
