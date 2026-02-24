with orders as (
    select *
    from {{ ref('stg_ecomm__orders') }}
),

deliveries as 
    (select *
    from {{ ref('stg_ecomm__deliveries') }}
),
deliveries_filtered as (
    select *
    from deliveries
    where delivery_status like 'delivered'
),
joined as (
    select 
    orders.order_id, 
    customer_id, 
    ordered_at, 
    order_status, 
    total_amount,
    store_id,
    datediff('minute', orders.ordered_at, deliveries_filtered.delivered_at) as delivery_time_from_order,
    datediff('minute', deliveries_filtered.picked_up_at, deliveries_filtered.delivered_at) as delivery_time_from_collection
    from orders

left join deliveries_filtered on (orders.order_id = deliveries_filtered.order_id)
)

select
  *
from joined
