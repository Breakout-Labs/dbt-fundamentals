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

joined as (
    select
        customers.*,
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
)

select
    *
from joined
