select distinct customer_id
    from {{ ref('orders') }}
    where orders.ordered_at > current_date - 49