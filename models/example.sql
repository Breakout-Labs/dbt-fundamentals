select
    {% for item in ['col1', 'col2'] %}
        {{ item }}{% if not loop.last %},{% endif %}
    {% endfor %}

from some_model