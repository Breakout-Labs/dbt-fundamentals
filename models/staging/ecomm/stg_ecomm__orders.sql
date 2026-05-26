select
    id as order_id,
    created_at as ordered_at,
    status as order_status,
    total_amount,
    customer_id,
    store_id,
    _synced_at
from
{{ source('ecomm', 'orders') }}