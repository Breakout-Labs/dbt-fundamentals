with source as (
  select
    *
  from {{ source('ecomm', 'orders') }} --#why requesting both? because they are hierarchaly under each other 
),

renamed as (
  select
    id as order_id,
    *, --selecting also all other columns, but putting id first 
    created_at as ordered_at,
    status as order_status
  from source
),

final as (
  select
    *
  from renamed
)

select
  *
from final