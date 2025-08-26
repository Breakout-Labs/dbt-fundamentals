-- Parse dates

{% macro parse_date(column) %}

coalesce(
    try_to_date(survey_date, 'MM/DD/YY'),
    try_to_date(survey_date, 'MM/DD/YYYY'),
    try_to_date(survey_date, 'YYYY-MM-DD')
)

{% endmacro %}