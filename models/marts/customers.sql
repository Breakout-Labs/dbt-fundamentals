{% set day_list = [30, 90, 360] %}

with orders as (
    select
        *
    from {{ref("orders")}}
), 

customers as (
    select
        customer_id,
        first_name,
        last_name,
        email,
        address,
        phone_number
    from {{ref("stg_ecomm__customers")}}
),

customer_survey as (
    select * from {{ref("stg_sheets__customer_survey_responses")}}   
),

customer_metrics as (
    select
        customer_id,
        count(*) as count_orders,
        min(ordered_at) as first_order_at,
        max(ordered_at) as most_recent_order_at,
        avg(delivery_time_from_order) as average_delivery_time_from_order,
        avg(delivery_time_from_collection) as average_delivery_time_from_collection,
        
        {% for days in day_list %}
            count(case when ordered_at > dateadd("days", -{{ days }}, current_date()) then 1 end) as count_orders_last_{{days}}_days,
        {% endfor %}
    from orders
    group by 1

),

joined as (
    select
        customers.*,
        coalesce(customer_metrics.count_orders,0) as count_orders,
        customer_metrics.first_order_at,
        customer_metrics.most_recent_order_at,
        average_delivery_time_from_collection,
        average_delivery_time_from_order,
        {% for days in day_list %}
            count_orders_last_{{days}}_days,   
        {% endfor %}
        survey_date,
        satisfaction_score
    from customers
    left join customer_metrics using (customer_id)
    left join customer_survey on (customer_survey.customer_email = customers.email)
)

select
    *
from joined
