{{ config(enabled=true) }}

with 

source as (

    select * from {{ source('ecomm', 'deliveries') }}

),

renamed as (

    select
        id,
        order_id,
        picked_up_at,
        delivered_at,
        status,
        _synced_at

    from source

)

select * from renamed
