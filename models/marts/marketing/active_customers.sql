with customers as (
    select
        *
    from {{ ref('customers') }}
),

customer_order_stats as (
    select
    *
    from {{ ref('int_marketing__customer_order_stats') }}

),

joined as (
    select
        customer_id,
        customers.first_name,
        customers.last_name,
        customer_order_stats.* exclude (customer_id)
        --customer_order_stats.orders_ordered,
        --customer_order_stats.orders_pending,
        --customer_order_stats.orders_cancelled,
        --customer_order_stats.orders_delivered,
        --customer_order_stats.avg_order_amount,
        --customer_order_stats.orders_total
    from customers
    inner join customer_order_stats using (customer_id)
)

select
    *
from joined