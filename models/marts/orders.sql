with orders as (
  -- Select everything from stg_ecomm__orders
  select *
  from {{ ref('stg_ecomm__orders') }}
),

deliveries as (
  -- Select everything from stg_ecomm__deliveries
  select *
  from {{ ref('stg_ecomm__deliveries') }}
),

deliveries_filtered as (
    select * from deliveries
    where delivery_status = 'status'
  -- Select everything from deliveries
  -- Include only deliveries with the 'delivered' status
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
  left join deliveries_filtered on (orders.order_id = deliveries_filtered.order_id)
  -- Alternatively, you can use the following syntax:
  -- left join deliveries_filtered using (order_id)
)

select
  *
from joined