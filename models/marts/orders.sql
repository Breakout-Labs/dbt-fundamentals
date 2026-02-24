-- models/marts/orders.sql

with orders as (
  select
    *
  from {{ ref('stg_ecomm__orders') }}
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
    o.order_id,
    o.customer_id,
    o.ordered_at,
    o.order_status,
    o.total_amount,
    o.store_id,
    datediff('minutes', df.picked_up_at, df.delivered_at) as delivery_time_from_collection,
    datediff('minutes', o.ordered_at, df.delivered_at) as delivery_time_from_order
  from orders as o
  left join deliveries_filtered as df
    on o.order_id = df.order_id
)

select
  *
from joined