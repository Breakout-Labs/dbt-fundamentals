-- models/marts/marketing/active_customers.sql
with order_stats as (
    select * from {{ ref('int_marketing__customer_order_stats') }}
),

active_customers as (
    select
        customers.customer_id,
        customers.first_name,
        customers.last_name,
        order_stats.total_orders,
        order_stats.orders_delivered,
        order_stats.avg_order_amount
    from {{ ref('customers') }} as customers
    join order_stats on customers.customer_id = order_stats.customer_id
)

select * from active_customers