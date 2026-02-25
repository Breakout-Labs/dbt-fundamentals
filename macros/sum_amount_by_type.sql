{% macro sum_amount_by_type(type_list) %}
    {%- for category in type_list %}
        sum(case 
            when type = '{{category}}' 
            then amount 
            else 0 
            end
            ) as {{category}}_amount
        {%-if notloop.last%},{%endif%}
        {%- endfor -%}
{% endmacro %}

