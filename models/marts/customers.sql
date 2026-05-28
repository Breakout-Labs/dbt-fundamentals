
{% set days=[30,90,360] %}
with orders as (
        select
        *
        from {{ ref('stg_ecomm__orders') }}
    ),

customer_survey_responses as (select * from {{ref("stg_sheets__customer_survey_responses")}}),

customers as (
    select
        *
    from {{ ref('stg_ecomm__customers') }}
),
customer_metrics as (
        select
            customer_id,
            count(*) as count_orders,
            min(ordered_at) as first_order_at,
              {% for day in days %}
                count_if(ordered_at > current_date() - {{day}}) as count_orders_last_{{day}}_days,
            {% endfor %}
            max(ordered_at) as most_recent_order_at
          
        from orders
        group by 1
    ),

joined as (
    select
        customers.*,
        coalesce(customer_metrics.count_orders,0) as count_orders,
        customer_metrics.first_order_at,
        customer_metrics.most_recent_order_at,
        customer_survey_responses.satisfaction_score,
        customer_survey_responses.survey_date,        
        customer_metrics.count_orders_last_30_days,     
        customer_metrics.count_orders_last_90_days,
        customer_metrics.count_orders_last_360_days            
    from customers
    left join customer_metrics on (
        customers.customer_id = customer_metrics.customer_id
         )
    left join customer_survey_responses on (
        customers.email=customer_survey_responses.customer_email
        )
)

select
    *
from joined
