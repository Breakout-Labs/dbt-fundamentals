select 
    customer_id,
    round(avg(total_amount),2) as average_total_amount_rounded,
    count(*) as order_count
from {{ ref('orders') }}
where ordered_at > current_date - 180
group by 1