with 

source as (

    select * from {{ source('sheets', 'customer_survey_responses') }}

),

renamed as (

    select
        customer_email,
        satisfaction_score,
        {{ parse_date('survey_date') }} as survey_date,
        feedback

    from source

)

select * from renamed