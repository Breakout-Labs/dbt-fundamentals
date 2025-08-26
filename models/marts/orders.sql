with orders as (
  select * from {{ ref('stg_ecomm__orders') }}
),

deliveries as (
  select * from {{ ref('stg_ecomm__deliveries') }}
),

deliveries_filtered as (
  select * from deliveries
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
    datediff(minute, orders.ordered_at, deliveries_filtered.delivered_at) as delivery_time_from_order,
    datediff(minute, deliveries_filtered.picked_up_at, deliveries_filtered.delivered_at) as delivery_time_from_collection
    from orders
    left join deliveries_filtered on (orders.order_id = deliveries_filtered.order_id)
  -- Calculate delivery_time_from_order as datediff (in minutes) between ordered_at (orders) and delivered_at (deliveries_filtered)
  -- Calculate delivery_time_from_collection as datediff (in minutes) between picked_up_at (deliveries_filtered) and delivered_at (deliveries_filtered)
  -- Do a left join between orders and deliveries_filtered using order_id
)

select
  *
from joined