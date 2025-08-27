<<<<<<< HEAD
with source as (
    select * from {{ source('ecomm', 'deliveries') }}
),

renamed as (
    select
        id as delivery_id,
        order_id,
        picked_up_at,
        delivered_at,
        status as delivery_status,
        _synced_at
    from source
)

select * from renamed
=======
{{ config(enabled=false) }}

with source as (
    select * from {{ source('ecomm', 'deliveries') }}
),

renamed as (
    select
        id as delivery_id,
        order_id,
        picked_up_at,
        delivered_at,
        status as delivery_status,
        _synced_at
    from source
)

select * from renamed
>>>>>>> 6cc19d6e822eca6ec3317478cea686b15966eaa0
