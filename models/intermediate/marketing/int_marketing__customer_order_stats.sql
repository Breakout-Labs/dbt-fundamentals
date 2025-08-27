{{
    config(
        materialized='ephemeral'
    )
}}

with customer_orders as (
    select 
        customer_id,
        round(avg(total_amount),2) as avg_order_value,
        count(*) as order_count
    from {{ ref('stg_ecomm__orders') }}
    where ordered_at > current_date - 180
    group by customer_id
)

select * from customer_orders