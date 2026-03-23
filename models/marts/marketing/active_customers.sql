with order_stats as (
    select
        customer_id,
        count(*) as total_orders,
        count(case when order_status = 'delivered' then 1 end) as orders_delivered,
        round(avg(total_amount), 2) as avg_order_amount
    from {{ ref('orders') }}
    group by customer_id
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