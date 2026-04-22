{{
    config(
        enabled=false
    )
}}

select
order_id,
order_amount,
ordered_at
{%- for type in ['tax', 'product', 'shipping', 'adjustment'] %}
   sum(case when type = '{{ type }}' then amount end) as {{ type }}_amount
   {%- if not loop.last %},{% endif -%}
{% endfor %}
from orders

