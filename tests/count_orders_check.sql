with orders as (
    select count(*) as number_of_orders from {{ ref('orders') }}),

    ninty_days as (select sum(count_orders_last_90_days) as sum_90_days from {{ ref('customers') }}),

    joined as (
    select
        *
    from orders
    cross join ninty_days 
    where sum_90_days > number_of_orders
)

select
    *
from joined

    