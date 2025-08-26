with src as (select * from {{ source('ecomm', 'customers') }}),

renamed as (
    select 
        *
        rename( 
            id as customer_id
        )
    from src
)

select * from renamed