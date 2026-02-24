with orders as (
  -- Select everything from stg_ecomm__orders model
  select * from {{ ref('stg_ecomm__orders') }}
),

deliveries as (
  -- Select everything from stg_ecomm__deliveries model
    select * from {{ ref('stg_ecomm__deliveries') }}
),

deliveries_filtered as (
  -- Select everything from the deliveries CTE
  -- Include only deliveries with delivery_status ='delivered'
      select * from deliveries
      where delivery_status = 'delivered'
),

joined as (
  -- Select order_id, customer_id, ordered_at, order_status, total_amount and store_id from orders
  -- Calculate two delivery metrics: delivery_time_from_order, delivery_time_from_collection

  Select 
  orders.order_id, 
  orders.customer_id, 
  orders.ordered_at, 
  orders.order_status, 
  orders.total_amount,
  orders.store_id, 
  datediff('minute', orders.ordered_at, deliveries_filtered.delivered_at) as delivery_time_from_order,
  datediff('minute', deliveries_filtered.picked_up_at, deliveries_filtered.delivered_at) as delivery_time_from_collection
  from orders
  left join deliveries_filtered on (orders.order_id = deliveries_filtered.order_id)
)

select
*
from joined