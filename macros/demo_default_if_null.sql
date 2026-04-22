{% macro default_if_null(column_name, default_value) %}
    coalesce({{ column_name }}, '{{ default_value }}')
{% endmacro %}