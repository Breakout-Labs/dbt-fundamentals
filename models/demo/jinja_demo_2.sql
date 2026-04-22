{{
    config(
        enabled=false
    )
}}

-- variables
{% set table_name = "orders" %}
select * from {{ table_name }}