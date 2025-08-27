
with customers as(
    select
    *
    from{{ ref('customers') }}
),

active_customers as(
    select distinct customer_id
    from{{ ref('orders') }}
    where orders.ordered_at > currentdate -49

),

customer_orders_stats as(
    select
    customer_id,
    count(*) as order_count,
    round(avg(total_amount),2) as average_order_amount
    from{{ ref('orders') }}
    group by 1
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
    customer_order_stats.average_order_amount,


from 
customers 
inner join active_customers
on (customers.customer_id = active_customers.customers_id)
inner join customer_orders_stats
on (customers.customer_id = customer_orders_stats.customer_id)
