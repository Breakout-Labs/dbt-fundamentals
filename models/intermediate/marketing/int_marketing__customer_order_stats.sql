with customer as (
    select *
    from {{ ref('customers') }}
),

order_status as (
    select
        customer_id,
        sum(case when order_status = 'ordered' then 1 else 0 end) as orders_ordered,
        sum(case when order_status = 'pending' then 1 else 0 end) as orders_pending,
        sum(case when order_status = 'cancelled' then 1 else 0 end) as orders_cancelled,
        sum(case when order_status = 'delivered' then 1 else 0 end) as orders_delivered,
        count(*) as orders_total,
        round(avg(total_amount), 2) as avg_order_amount
    from {{ ref('orders') }}
    group by customer_id
),

joined as (
    select
        customer_id,
        first_name,
        last_name,
        orders_ordered,
        orders_pending,
        orders_cancelled,
        orders_delivered,
        orders_total,
        avg_order_amount
    from {{ ref('customers') }} 
    inner join order_status using (customer_id)
)
select * from joined