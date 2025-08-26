with orders as (
  -- Select everything from stg_ecomm__orders
  select
  *
  from {{ ref('stg_ecomm__orders') }}
),

deliveries as (
  -- Select everything from stg_ecomm__deliveries
  select
  *
  from {{ ref('stg_ecomm__deliveries') }}
),

deliveries_filtered as (
  -- Select everything from deliveries
  select
  *
  from deliveries
  where delivery_status = 'delivered'
  -- Include only deliveries with the 'delivered' status
),

joined as (
  -- Select order_id, customer_id, ordered_at, order_status, total_amount and store_id from orders
  select
    orders.order_id,
    orders.customer_id,
    orders.ordered_at,
    orders.order_status,
    orders.total_amount,
    orders.store_id,
    -- Calculate delivery_time_from_order as datediff (in minutes) between ordered_at (orders) and delivered_at (deliveries_filtered)
    datediff('minutes', orders.ordered_at, deliveries_filtered.delivered_at) as delivery_time_from_order,
      -- Calculate delivery_time_from_collection as datediff (in minutes) between picked_up_at (deliveries_filtered) and delivered_at (deliveries_filtered)
    datediff('minutes', deliveries_filtered.picked_up_at, deliveries_filtered.delivered_at) as delivery_time_from_collection
    from orders
  -- Do a left join between orders and deliveries_filtered using order_id
    left join deliveries_filtered on (orders.order_id = deliveries_filtered.order_id)
)

select
  *
from joined