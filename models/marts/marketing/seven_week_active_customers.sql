-- #### rewritten
with customers as (
    select *
    from {{ ref('customers') }}
),

customer_order_stats as (
    select *
    from {{ ref('int_marketing__customer_order_stats') }}
),

active_customers as (
    select *
    from {{ ref('int_marketing__seven_week_active_customers') }}
),

joined_customer_stats as (
    select
        customers.customer_id,
        customers.first_name,
        customers.last_name,
        customer_order_stats.avg_order_amount,
        customer_order_stats.order_count
    from customers
    inner join
        active_customers using (customer_id)
        -- on customers.customer_id = active_customers.customer_id
    inner join customer_order_stats using (customer_id)
)

select *
from joined_customer_stats
