select 1001 as order_id, 'product' as type, 45.00 as amount
union all
select 1001 as order_id, 'tax' as type, 3.60 as amount
union all
select 1001 as order_id, 'shipping' as type, 5.99 as amount
union all
select 1002 as order_id, 'product' as type, 28.50 as amount
union all
select 1002 as order_id, 'tax' as type, 2.28 as amount
union all
select 1002 as order_id, 'adjustment' as type, -4.00 as amount