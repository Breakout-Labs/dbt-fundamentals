{{
    config(
        enabled=false
    )
}}

{% set score = 75 %}

select
{%- if score >= 90 %}
    'A' as grade
{%- elif score >= 80 %}
    'B' as grade
{%- elif score >= 70 %}
    'C' as grade
{%- else %}
    'F' as grade
{%- endif %}