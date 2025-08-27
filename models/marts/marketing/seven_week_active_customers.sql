-- Refactor
with customers as (
    select
        *
    from {{ ref('customers') }}
),

active_customers as (
    select
        *
    from {{ ref('int_marketing__seven_week_active_customers') }}
),

customer_order_stats as (
    select 
        *
    from {{ ref('int_marketing__customer_order_stats') }}
)

select 
    customers.customer_id,
    customers.first_name,
    customers.last_name,
    customers.email,
    customers.address,
    customers.phone_number,
    customers.created_at,
    customer_order_stats.order_count,
    customer_order_stats.average_order_amount
from 
customers 
inner join active_customers
on (customers.customer_id = active_customers.customer_id)
inner join customer_order_stats 
on (customers.customer_id = customer_order_stats.customer_id)








