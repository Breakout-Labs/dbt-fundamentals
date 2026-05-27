{% macro parse_date(args) %}
coalesce(
  try_to_date({{args}}, 'MM/DD/YY'),
  try_to_date({{args}}, 'MM/DD/YYYY'),
  try_to_date({{args}}, 'YYYY-MM-DD')
)
{% endmacro %}