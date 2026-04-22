{{
    config(
        enabled=false
    )
}}

-- putting it all together
{% set prefix = "report_" %}
{% for year in ['2023', '2024', '2025'] %}
select 
    *, 
    {{ year }} as source_year 
from {{ source('raw', prefix ~ year) }}
{% if not loop.last %}union all{% endif %}
{% endfor %}