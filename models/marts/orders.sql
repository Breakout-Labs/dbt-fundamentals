with orders as (
    select
        *
    from {{ ref('int__orders') }}
), 

select
  *
from orders