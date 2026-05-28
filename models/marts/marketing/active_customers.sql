with order_status  as (
         select * from {{ ref('int_marketing__customer_order_stats') }}
),
 active_customers as (
    select
      c.customer_id,
      c.first_name,
      c.last_name,                                                                                                                                                                                                                                                                                                     
      order_status.total_orders,
      order_status.orders_delivered,                                                                                                                                                                                                                                                                                    
      order_status.avg_order_amount
  from {{ ref('customers') }} c
  join order_status  on c.customer_id = order_status.customer_id
 )
    select
      *
    from active_customers