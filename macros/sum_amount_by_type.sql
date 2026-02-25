{% macro sum_amount_by_type(type_list) %}
    {% for type in type_list %}
        sum(case when type = '{{ type }}') then amount end) as {{ type }}_amount{% if not loop.last %},{% endif %}
    {% endfor %}
{% endmacro %}