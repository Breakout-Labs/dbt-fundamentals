with source as (

    select * from {{ source('ecomm', 'orders') }}

),

renamed as (

    select
        *,
        id as order_id,
        status as order_status,
        created_at as ordered_at
    from source

),

final as (
    select *
    from renamed
)

select *
from final
