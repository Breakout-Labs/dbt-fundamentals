{{
    config(
        materialized='table'
    )
}}

with
    customers as (select * from {{ ref("customers") }}),

    active_customers as (
        select 
        *
       from {{ ref('int_marketing__seven_week_active_customers') }}
    ),

    metrics as ( 
    select 
    *
    from {{ ref('int_marketing__customer_order_stats') }}
    ),

    joined as (
        select
        customer_id,
        customers.first_name,
        customers.last_name,
        metrics.avg_order_amount,
        metrics.order_count
        from customers
        inner join metrics using (customer_id)
        inner join active_customers using (customer_id)
    )

    select
    * 
    from joined