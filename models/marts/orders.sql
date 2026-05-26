{{ config(materialized='table') }}

with orders as (
  select 
    order_id,
    customer_id,
    ordered_at,
    order_status,
    total_amount,
    store_id
  /*
    Didn't have the staging model ready yet.
    Replace the raw table ref with dbt ref to stg_ecomm__orders, will ya?
    Remember to adjust the select statement, the renaming is already handled in the staging model.
    Cheers, Leo
  */
  from {{ ref('stg_ecomm__orders') }}   -- TODO: Replace with dbt ref to staging model
),

deliveries as (
  select
    *
  from {{ ref('stg_ecomm__deliveries') }}
),

deliveries_filtered as (
  select 
    *
  from deliveries
  where delivery_status = 'delivered'
),

joined as (
  select
    orders.order_id,
    orders.customer_id,
    orders.ordered_at,
    orders.order_status,
    orders.total_amount,
    orders.store_id,
    datediff('minutes', orders.ordered_at, deliveries_filtered.delivered_at) as delivery_time_from_order,
    datediff('minutes', deliveries_filtered.picked_up_at, deliveries_filtered.delivered_at) as delivery_time_from_collection
  from orders
  left join deliveries_filtered on (
    orders.order_id = deliveries_filtered.order_id
  )
)


select
  *
from joined