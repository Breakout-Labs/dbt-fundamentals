{% test valid_email(model, column_name) %}

SELECT {{ column_name }}
FROM {{ model }}
WHERE {{ column_name }} NOT LIKE '%_@_%._%'
   OR {{ column_name }} IS NULL

{% endtest %}