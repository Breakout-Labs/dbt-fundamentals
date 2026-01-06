with 

source as (

    select * from {{ source('banking', 'customers') }}

),

renamed as (

    select
        id,
        bank_id,
        first_name,
        last_name,
        email,
        date_of_birth,
        zipcode,
        country,
        created_ts,
        updated_ts,
        _synced_ts

    from source

)

select * from renamed