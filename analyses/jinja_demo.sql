select
    {% for name in ['simo', 'miguel'] %}
        {{ name }} {% if not loop.last %},{% endif %}
    {% endfor %}
from some_model