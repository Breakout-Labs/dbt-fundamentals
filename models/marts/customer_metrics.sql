SELECT
    customer_id,
    count_orders as customer_orders
from {{ ref('customers') }}