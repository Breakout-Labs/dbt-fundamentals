with customer_order_stats as (
    select *
    from {{ ref('int_marketing__customer_order_stats') }}
)

select
    c.customer_id,
    c.first_name,
    c.last_name,
    coalesce(cos.orders_ordered, 0) as orders_ordered,
    coalesce(cos.orders_pending, 0) as orders_pending,
    coalesce(cos.orders_cancelled, 0) as orders_cancelled,
    coalesce(cos.orders_delivered, 0) as orders_delivered,
    coalesce(cos.orders_total, 0) as orders_total,
    coalesce(cos.avg_order_amount, 0) as avg_order_amount
from {{ ref('int__customers') }} as c
left join customer_order_stats as cos on c.customer_id = cos.customer_id
where c.customer_id in (
    select distinct customer_id from {{ ref('int__orders') }}
)