{{
    config(
        materialized='ephemeral'
    )
}}

with orders_last_180_days as (
    select 
        customer_id,
        round(avg(total_amount),2) as avg_order_amount,
        count(*) as order_count
    from {{ref('stg_ecomm__orders')}}
    where ordered_at > current_date - 180
    group by customer_id
)

select * from orders_last_180_days