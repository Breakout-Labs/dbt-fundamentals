{% macro sum_amount_by_type(column_list) %}
    {% for type in column_list -%}
        sum(case when type = '{{type}}' then amount end) as {{type}}_amount
        {%- if not loop.last %}
            ,
        {% endif %}
    {%endfor%}
{% endmacro %}

{# ['tax','product', 'shipping', 'adjustment'] #}