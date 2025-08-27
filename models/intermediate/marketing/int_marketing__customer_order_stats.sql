select 
        customer_id,
        count(*) as order_count,
        round(avg(total_amount),2) as average_order_amount 
    from {{ ref('orders') }}
    group by 1