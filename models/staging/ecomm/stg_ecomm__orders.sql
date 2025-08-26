
select 
id as order_id,
customer_id,
store_id,
total_amount,
status order_status,
created_at as ordered_at,
_synced_at
 from 
{{ source('ecomm', 'orders_us') }}