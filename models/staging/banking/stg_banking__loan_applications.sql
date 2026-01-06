with 

source as (

    select * from {{ source('banking', 'loan_applications') }}

),

renamed as (

    select
        id,
        customer_id,
        requested_amount,
        currency,
        loan_type,
        loan_status,
        loan_term_months,
        submitted_ts,
        updated_ts,
        _synced_ts

    from source

)

select * from renamed