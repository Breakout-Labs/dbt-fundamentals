with orders as (
    select count(*) as count_orders
    from {{ ref('orders') }}
), 

customers as (
    select
        count_orders_last_90_days
    from {{ ref('customers') }}
),

joined as (
    select *
    from orders 
    cross join customers
    where customers.count_orders_last_90_days > orders.count_orders
)

select *
from joined