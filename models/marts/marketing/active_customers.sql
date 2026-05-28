with
    order_stats as (select * from {{ ref("int_marketing__customer_order_stats") }}),
    active_customers as (
        select
            c.customer_id,
            c.first_name,
            c.last_name,
            order_stats.total_orders,
            order_stats.orders_delivered,
            order_stats.avg_order_amount
        from {{ ref("customers") }} c
        join order_stats on c.customer_id = order_stats.customer_id
    )
select *
from active_customers
