with seven_week_active_customers as(
    select * from {{ref('int_marketing__seven_week_active_customers')}}
),

orders_last_180_days as (
    select * from {{ref('int_marketing__customer_order_stats')}}
),

customers as (
    select * from {{ref('customers')}}
)

select
    customer_id,
    first_name,
    last_name,
    avg_order_amount,
    order_count
from customers
join orders_last_180_days using (customer_id)
join seven_week_active_customers using (customer_id)


