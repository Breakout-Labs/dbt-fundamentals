

-- Rewrite --
with customers as (
    select 
        *
    from {{ ref('customers') }}
),

recent_customers as (
    select
        *
    from {{ ref('int_marketing__seven_week_active_customers') }}
),

customer_orders as (
    select
        *
    from {{ ref('int_marketing__customer_order_stats') }}
)

select
    customers.customer_id,
    customers.first_name, 
    customers.last_name,
    customer_orders.average_total_amount_rounded,
    customer_orders.order_count
from customers
inner join customer_orders on (customers.customer_id = customer_orders.customer_id)
inner join recent_customers on (customers.customer_id = recent_customers.customer_id)
