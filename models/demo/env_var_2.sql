{{
    config(
        enabled=false
    )
}}

-- limit data in dev
select order_id, customer_id, order_amount, order_date
from {{ ref("demo_model_country") }}
{% if env_var("DBT_ENV", "dev") == "dev" %}
    where order_date >= dateadd(day, -7, current_date)
{% endif %}

-- redacting PII in dev
select
    customer_id,
    first_name,
    {% if env_var("DBT_ENV", "dev") == "prod" %} 
        email, 
        phone, 
        date_of_birth
    {% else %} 
        'REDACTED' as email, 
        'REDACTED' as phone, 
        null as date_of_birth
    {% endif %}
from {{ ref('demo_model_country') }}
