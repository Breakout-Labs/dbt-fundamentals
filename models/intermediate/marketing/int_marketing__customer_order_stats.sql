select
    customer_id,
    count (*) as orders_total,
    round(avg(total_amount),2) as avg_order_amount,
    sum(case when order_status = 'ordered' then 1 else 0 end) as orders_ordered,
    sum(case when order_status = 'pending' then 1 else 0 end) as orders_pending,
    sum (case when order_status = 'cancelled' then 1 else 0 end) as orders_cancelled,
    sum (case when order_status = 'delivered' then 1 else 0 end) as orders_delivered
    from {{ ref('orders') }}
group by 1