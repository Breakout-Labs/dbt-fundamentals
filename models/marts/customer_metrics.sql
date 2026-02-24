select
    customer_id,
    count_orders as count_orders
from {{ ref('customers') }}