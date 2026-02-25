

with orders_count as (
    select
        count(*) as orders_count_90_days
    from {{ ref('orders') }}

),

customer_order_count as (
    select 
        sum(count_orders_last_90_days) as customers_orders_last_90_days_count
    from {{ ref('customers') }}

),

joined as (
    select
        *
    from orders_count
    cross join customer_order_count  
    where customers_orders_last_90_days_count > orders_count_90_days
)


select
    *
from joined