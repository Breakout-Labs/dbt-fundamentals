{% macro sum_amount_by_type(types) %}
    {% for item in types %}
        sum(case when type = '{{ item}}' then amount)
    {% endfor %}
{% endmacro %}

