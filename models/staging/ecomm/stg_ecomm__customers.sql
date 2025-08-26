
select 
id customer_id, 
first_name, 
last_name,
email, 
address, 
phone_number, 
created_at
from {{ source('ecomm', 'customers') }}