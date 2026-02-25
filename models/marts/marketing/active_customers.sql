with
    customers as (select * from {{ ref("customers") }}),

    -- Customer order stats calculations
    customer_order_stats as (
        select * from {{ ref("int_marketing__customer_order_stats") }}
    ),

    -- -now joining grouped stats with customer
    joined as (
        select
            customer_id,
            customers.first_name,
            customers.last_name,
            customer_order_stats.* exclude (customer_id)
        from customers
        inner join customer_order_stats using (customer_id)
    )

select *
from joined
