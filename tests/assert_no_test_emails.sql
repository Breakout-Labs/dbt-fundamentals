-- Fails if any customer has a test/dummy email address
SELECT
    customer_id,
    email
FROM {{ ref('demo_model_customer') }}
WHERE email LIKE '%test%'
   OR email LIKE '%dummy%'