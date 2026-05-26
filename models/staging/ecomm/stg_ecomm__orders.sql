with source as (
    select * from {{ source('ecomm', 'orders') }}
),

renamed as (
    select
        id as order_id,
        created_at as ordered_at,
        status as order_status,
        customer_id,
        store_id,
        total_amount,
        _synced_at
    from source
)

select * from renamed