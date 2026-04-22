with
    seed as (
        select
            1 as customer_id,
            'Alice' as name,
            'alice@example.com' as email,
            'active' as status,
            'US' as country_code
        union all
        select
            2 as customer_id,
            'Bob' as name,
            'bob@example.com' as email,
            'active' as status,
            'UK' as country_code
        union all
        select
            3 as customer_id,
            'Charlie' as name,
            'charlie@example.com' as email,
            'inactive' as status,
            'US' as country_code
        union all
        select
            4 as customer_id,
            'Diana' as name,
            'diana@example.com' as email,
            'pending' as status,
            'CA' as country_code
        union all
        select
            5 as customer_id,
            'Tom' as name,
            'tom@example.com' as email,
            'pending' as status,
            'AU' as country_code
        union all
        select
            6 as customer_id,
            'Sarah' as name,
            'sarah@example.com' as email,
            'active' as status,
            'IN' as country_code
    ),

    transformed as (
        select 
        customer_id, 
        email, 
        status, 
        country_code 
        from seed
    )

select *
from transformed