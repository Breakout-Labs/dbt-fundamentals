{{
    config(
        enabled=false
    )
}}

-- whitespace control (bonus)
select
{% for c in ['a','b','c'] %}
  {{ c }}{% if not loop.last %},{% endif %}
{% endfor %}
from t

select
{%- for obj in ['a','b','c'] %}
  {{ obj }}{% if not loop.last %},{% endif %}
{%- endfor %}
from t