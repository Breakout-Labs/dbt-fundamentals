{% macro country_code_mapping(code) %}
    case 
        when {{ code }} = 'US' then 'United States'
        when {{ code }} = 'UK' then 'United Kingdom'
        when {{ code }} = 'CA' then 'Canada'
        when {{ code }} = 'IN' then 'India'
        when {{ code }} = 'AU' then 'Australia'
    else {{ code }} end
{% endmacro %}