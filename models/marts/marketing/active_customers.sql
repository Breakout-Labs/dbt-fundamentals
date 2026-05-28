with order_status  as (
         select
          customer_id,                                                                                                                                                                                                                                                                                                 
          count(*) as total_orders,
          count(case when order_status = 'delivered' then 1 end) as orders_delivered,
          round(avg(total_amount), 2) as avg_order_amount                                                                                                                                                                                                                                                              
      from {{ ref('orders') }}
      group by customer_id  
)

select
      c.customer_id,
      c.first_name,
      c.last_name,                                                                                                                                                                                                                                                                                                     
      order_stats.total_orders,
      order_stats.orders_delivered,                                                                                                                                                                                                                                                                                    
      order_stats.avg_order_amount
  from {{ ref('customers') }} c
  join order_status  on c.customer_id = order_status.customer_id