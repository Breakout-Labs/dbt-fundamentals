with source as (
    select * from {{ source('ecomm', 'orders') }}
),

orders as (
    select
        id as order_id,
        created_at as ordered_at,
        status as order_status,
        total_amount,
        store_id,
        customer_id,
        _synced_at
    from source
)

select * from orders