{{
    config(
        materialized='table',
        schema='ecommerce'
    )
}}

select 
    customer_id, 
    count_orders as customer_orders,
from {{ ref('customers') }}