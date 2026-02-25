
with customer_orders_stats as(
    select
    *
    from
    {{ ref('int_marketing__customer_order_stats') }}
),

customer_info as(
    select
    * 
    from 
    {{ref("customers")}}
    
),

joined as(
    select 
    customer_info.customer_id, 
    customer_info.first_name, 
    customer_info.last_name, 
    customer_orders_stats.orders_ordered,
    customer_orders_stats.orders_pending,
    customer_orders_stats.orders_cancelled,
    customer_orders_stats.orders_delivered,
    customer_orders_stats.orders_total,
    customer_orders_stats.avg_order_amount
    from customer_orders_stats
    inner join customer_info using (customer_id)


)

select 
* 
from joined
