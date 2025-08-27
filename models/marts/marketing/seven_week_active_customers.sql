with customers as (
    select * from {{ ref('customers') }}
),

seven_week_active_customers as (
    select * from {{ ref('int_marketing__seven_week_active_customers') }}
), 

average_order_amount as (
    select 
        customer_id,
        avg_order_amount,
        order_count
    from {{ ref('int_marketing__customer_order_stats') }}
)

select 
    customers.customer_id, 
    customers.first_name, 
    customers.last_name, 
    average_order_amount.avg_order_amount,
    average_order_amount.order_count
from customers
inner join average_order_amount on customers.customer_id = average_order_amount.customer_id
inner join seven_week_active_customers on customers.customer_id = seven_week_active_customers.customer_id