with source as (
    select * from {{ source('ecomm', 'orders') }}
    ),

orders as (
    select
        id as order_id,
        total_amount,
        status as order_status,
        store_id,
        _synced_at,
        customer_id,
        created_at as ordered_at
    from source
)

select * from orders