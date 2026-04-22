{{
    config(
        enabled=false
    )
}}

-- loops
{% for fruit in ['apple', 'banana', 'cherry'] %}
{{ fruit }}
{%- endfor %}

-- loops with index
{% for fruit in ['apple', 'banana', 'cherry'] %}
{{ loop.index }}. {{ fruit }}
{%- endfor %}

