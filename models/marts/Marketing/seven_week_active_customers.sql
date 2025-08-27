with customers as (
  select
    *
  from {{ ref('customers') }}
),

Recent_customers as (
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
    customer_orders.avg_order_amount,
    customer_orders.order_count
from customers
inner join customer_orders on (
    customers.customer_id = customer_orders.customer_id
)
inner join Recent_customers on (
    customers.customer_id = Recent_customers.customer_id
)