with 

source as (

    select * from {{ source('banking', 'loan_decisions') }}

),

renamed as (

    select
        id,
        application_id,
        underwriter_id,
        decision_status,
        approved_amount,
        reason,
        decision_ts,
        updated_ts,
        _synced_ts

    from source

)

select * from renamed