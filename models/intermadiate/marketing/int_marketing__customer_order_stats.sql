-- models/intermediate/marketing/int_marketing__customer_order_stats.sql

with customer_order_stats as (
    select
        customer_id,
        count(case when order_status = 'ordered' then 1 end) as orders_ordered,
        count(case when order_status = 'pending' then 1 end) as orders_pending,
        count(case when order_status = 'cancelled' then 1 end) as orders_cancelled,
        count(case when order_status = 'delivered' then 1 end) as orders_delivered,
        count(*) as orders_total,
        round(avg(total_amount), 2) as avg_order_amount
    from {{ ref('int__orders') }}
    group by customer_id
)

select * from customer_order_stats