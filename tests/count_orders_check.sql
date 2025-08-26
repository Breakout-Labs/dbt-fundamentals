with orders as (
    select count(*) as order_count 
    from {{ ref('orders') }}
),

customers as (
    select sum(count_orders_last_90_days) as count_orders_last_90_days_count
    from {{ ref('customers') }}
),

joined as (
    select * from orders join customers 
    where count_orders_last_90_days_count > order_count
)

select * from joined




