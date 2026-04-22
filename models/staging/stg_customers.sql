select
    customer_id,
    customer_name,
    city,
    country,
    cast(signup_date as date) as signup_date
from {{ ref('raw_customers') }}