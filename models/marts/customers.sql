with customers as (
    select
        *
    from {{ ref('int__customers') }}
),

select
    *
from customers