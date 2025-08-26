{% macro parse_date(date_string) %}
    coalesce(
    try_to_date({{date_string}}, 'MM/DD/YY'),
    try_to_date({{date_string}}, 'MM/DD/YYYY'),
    try_to_date({{date_string}}, 'YYYY-MM-DD')
)
{% endmacro %}