{{
    config(
        materialized='ephemeral'
    )
}}

with seven_week_active_customers as (
    select 
        distinct customer_id
    from {{ ref('stg_ecomm__orders') }}
    where ordered_at > current_date - 49
)

select * from seven_week_active_customers