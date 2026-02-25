with customer_order_stats as (
    select *
    from {{ ref('int_marketing__customer_order_stats') }}
),

customers as (
    select *
    from {{ ref('customers') }}
),

joined as (
    select
        customers.customer_id,
        customers.first_name,
        customers.last_name,
        customer_order_stats.orders_ordered,
        customer_order_stats.orders_pending,
        customer_order_stats.orders_cancelled,
        customer_order_stats.orders_delivered,
        customer_order_stats.orders_total,
        customer_order_stats.avg_order_amount
    from customer_order_stats
    inner join
        customers
        on customer_order_stats.customer_id = customers.customer_id
)

select *
from joined
