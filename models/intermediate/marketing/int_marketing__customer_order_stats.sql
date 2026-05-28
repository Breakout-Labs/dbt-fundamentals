select
          customer_id,                                                                                                                                                                                                                                                                                                 
          count(*) as total_orders,
          count(case when order_status = 'delivered' then 1 end) as orders_delivered,
          round(avg(total_amount), 2) as avg_order_amount                                                                                                                                                                                                                                                              
      from {{ ref('orders') }}
      group by customer_id 