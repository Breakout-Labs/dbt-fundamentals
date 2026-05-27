{% set days = [30,90,360] %}
with orders as (
    select *
        /*order_id,
        customer_id,
        ordered_at*/
    from {{ ref('stg_ecomm__orders') }}
), 

customers as (
    select
        *
    from {{ ref('stg_ecomm__customers') }}
),

customer_metrics as (
    select
        customer_id,
        count(*) as count_orders,
        {% for day in days %}
        count_if(ordered_at > current_date() - {{ day }} ) as count_orders_last_{{ day }}_days
        {% if not loop.last %},{% endif %}
        {% endfor %},
        min(ordered_at) as first_order_at,
        max(ordered_at) as most_recent_order_at
    from orders
    group by 1

),
customer_survey_responses as (
    select 
        customer_email, {# key #}
        survey_date,
        satisfaction_score
    from {{ ref('stg_sheets__customer_survey_responses') }}
),
joined as (
    select
        customers.*,
        customer_survey_responses.satisfaction_score,
        customer_survey_responses.survey_date,
        coalesce(customer_metrics.count_orders,0) as count_orders,
        customer_metrics.first_order_at,
        customer_metrics.most_recent_order_at,
        {% for day in days %}
        customer_metrics.count_orders_last_{{ day }}_days{% if not loop.last %},{% endif %}
        {% endfor %}
    from customers
    left join customer_metrics on (
        customers.customer_id = customer_metrics.customer_id
    )
    left join customer_survey_responses on (
        customer_survey_responses.customer_email=customers.email
    )
)

select
    *
from joined
