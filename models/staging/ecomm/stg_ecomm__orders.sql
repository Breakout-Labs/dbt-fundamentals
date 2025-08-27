/* Selecting all orders
(keeping in mind that original table is orders_us in SF)
*/
with

source as (select * from {{ source("ecomm", "orders") }}),

renamed as (
    select
        *,
        id as order_id,
        created_at as ordered_at,
        status as order_status
    from source
)

select *
from renamed
