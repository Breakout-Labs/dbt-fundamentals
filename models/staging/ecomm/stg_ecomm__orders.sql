SELECT

    id AS order_id,
    total_amount,
    status AS order_status,
    created_at AS ordered_at,
    customer_id,
    store_id,
    _synced_at

FROM {{ source('ecomm', 'orders') }}
