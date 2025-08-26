with orders as (
    select
        count(*) as orders_count -- total number of orders in our orders model
    from {{ ref('orders') }}
),

customers as (
    select
        sum(count_orders_last_90_days) as count_orders_90_days -- sum of the count_orders_last_90_days column in the customers model
    from {{ ref('customers') }}
),

joined as (
    select
        *
    from orders
    cross join customers  -- The cross join is only one possible way
    -- check if the sum of the count_orders_last_90_days column in the customers model
    --  is greater than the total number of orders in the orders model
    where customers.count_orders_90_days > orders.orders_count
)

select
    *
from joined