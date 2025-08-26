select 
    sum(count_orders) as total_orders, 
    sum(count_orders_last_90_days) as total_orders_90_days
from {{ref('customers')}}
having sum(count_orders_last_90_days) > sum(count_orders)