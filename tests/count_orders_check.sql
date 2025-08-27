with orders as (
    select
        count(*) as count_of_orders
    from {{ ref('orders') }}
),

customers as(
    select
        sum(count_orders_last_90_days) as sum_orders_last_90_days
    from {{ ref('costumers') }}
),

joined as (
    select
        *
    from orders
    cross join customers
    where sum_orders_last_90_days > count_of_orders
)

select
    *
from joined