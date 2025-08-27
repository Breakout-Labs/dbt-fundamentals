select 
    customer_id,
    count_orders_last_90_days,
    count_orders
from {{ ref('customers') }}
where customers.count_orders_last_90_days > count_orders