{% macro parse_date(column) %}
    try_to_date({{ column }}, 'MM/DD/YY'),
    try_to_date({{ column }}, 'MM/DD/YYYY'),
    try_to_date({{ column }}, 'YYYY-MM-DD')
{% endmacro %}