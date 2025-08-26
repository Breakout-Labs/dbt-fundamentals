with orders as (
    select
        count(*) as order_count
    from {{ ref('orders') }}
),
customers as (
    select
        sum(count_orders_last_90_days) as order_last_90_days_count     
    from {{ ref('customers') }}
)

select *
from orders
cross join customers
where order_last_90_days_count > orders.order_count