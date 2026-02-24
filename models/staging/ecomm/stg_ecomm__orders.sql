select
*,
id as order_id,
created_at as ordered_at,
status as order_status
FROM {{ source('ecomm', 'orders') }}