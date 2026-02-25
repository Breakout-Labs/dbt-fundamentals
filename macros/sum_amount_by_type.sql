{% macro sum_amount_by_type(type_list) %}
    {%- for category in type_list -%}
        sum(case when type = '{{ category }}' then amount end) as {{ category }}_amount
        {% if not loop.last %},{% endif %}
    {%- endfor -%}
{% endmacro %}