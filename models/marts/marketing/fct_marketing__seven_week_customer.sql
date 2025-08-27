/*
select
    customer_id,
    first_name,
    last_name,
    (select round(avg(total_amount),2) from {{ ref('orders') }} 
    where orders.customer_id = customers.customer_id and ordered_at > current_date - 180) as avg_order_amount,
    (select count(*) from {{ ref('orders') }} 
    where orders.customer_id = customers.customer_id and ordered_at > current_date - 180) as order_count
from {{ ref('customers') }}
where customer_id in (
  select
    distinct customer_id
  from {{ ref('orders') }}
  where ordered_at > current_date - 49
)
*/
with customers as (
  select *
  from {{ ref('customers') }}
),

seven_week_active_customers as (
  select *
  from {{ ref('int_marketing__seven_week_active_customers') }}
),

customer_order_stats as (
  select *
  from {{ ref('int_marketing__customer_order_stats') }}
)

select
    customers.customer_id,
    customers.first_name,
    customers.last_name,
    customer_order_stats.avg_order_amount,
    customer_order_stats.order_count
from customers
left join customer_order_stats on (
    customers.customer_id = customer_order_stats.customer_id
)
inner join seven_week_active_customers on (
    customers.customer_id = seven_week_active_customers.customer_id
)