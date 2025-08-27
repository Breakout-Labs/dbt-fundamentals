with customers as (
    select
        *
    from {{ ref('customers') }}
),

seven_week_active_customers as (
    select 
        * 
    from {{ ref('int_marketing__seven_week_active_customers') }}
),

customer_orders as (
    select 
        * 
    from {{ ref('int_marketing__customer_order_stats') }}
),

final as (
    select
        customers.customer_id,
        customers.first_name,
        customers.last_name,
        customer_orders.avg_order_value,
        customer_orders.order_count
    from customers
    inner join seven_week_active_customers using (customer_id)
    inner join customer_orders using (customer_id)
)

select * from final