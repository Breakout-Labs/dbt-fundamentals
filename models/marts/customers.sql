with orders as (
    select *
    from {{ ref('orders') }} 
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
        min(ordered_at) as first_order_at,
        max(ordered_at) as most_recent_order_at,
        avg(delivery_time_from_collection) as average_delivery_time_from_collection,
        avg(delivery_time_from_order) as average_delivery_time_from_order,
        {% for item in [30, 90, 360] %}
        count_if(ordered_at > current_date() - {{item}}) as count_orders_last_{{ item }}_days {% if not loop.last %}, 
        {% endif %} 
        {% endfor %}
    from orders
    group by 1

),

survey as (
    select
        *
    from {{ ref('stg_sheets__customer_survey_responses') }}
),


joined as (
    select
        customers.*,
        coalesce(customer_metrics.count_orders,0) as count_orders,
        customer_metrics.first_order_at,
        customer_metrics.most_recent_order_at,
        average_delivery_time_from_collection,
        average_delivery_time_from_order,
        survey.survey_date,
        survey.satisfaction_score,
        {% for item in ['count_orders_last_30_days', 'count_orders_last_90_days', 'count_orders_last_360_days'] %}
        {{item}} {% if not loop.last %}, 
        {% endif %} 
        {% endfor %}
    from customers
    left join customer_metrics on (
        customers.customer_id = customer_metrics.customer_id
    )
    left join survey on (
        customers.email = survey.customer_email
    )
)

select
    *
from joined
