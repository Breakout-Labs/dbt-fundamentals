{% macro count_orders_last_N_days(list, column_name) %}

    {% for Ndays in list %}
         count_if( case when {{column_name}} > CURRENT_DATE() - {{Ndays}} then true end) as count_orders_last_{{Ndays}}_days

        {% if not loop.last %}
            ,
        {% endif %}
    {% endfor %}

{% endmacro %}