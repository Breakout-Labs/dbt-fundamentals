select
    customer_id,
    first_name,
    last_name,
    
    -- Customer order stats calculations
    (select count(*) from {{ ref('orders') }} o where o.customer_id = c.customer_id and o.order_status = 'ordered') as orders_ordered,
    (select count(*) from {{ ref('orders') }} o where o.customer_id = c.customer_id and o.order_status = 'pending') as orders_pending,
    (select count(*) from {{ ref('orders') }} o where o.customer_id = c.customer_id and o.order_status = 'cancelled') as orders_cancelled,
    (select count(*) from {{ ref('orders') }} o where o.customer_id = c.customer_id and o.order_status = 'delivered') as orders_delivered,
    (
        select count(*)
        from {{ ref('orders') }} o where o.customer_id = c.customer_id
    ) as orders_total,
    (select round(avg(total_amount),2) from {{ ref('orders') }} o where o.customer_id = c.customer_id) as avg_order_amount
    
from {{ ref('customers') }} as c
where customer_id in (
    select
        distinct customer_id
    from orders
)