with 

sum_orders_90_days as (
    select
        sum(count_orders_last_90_days) as day_90_sum
    from {{ ref('customers') }}
),

sum_all_orders as (
    select
        count(*) as orders_sum
    from {{ ref('orders') }}
),

joined as (
    select 
        *
    from sum_orders_90_days
    cross join sum_all_orders
    where sum_orders_90_days.day_90_sum > sum_all_orders.orders_sum
)

select 
    * 
from joined