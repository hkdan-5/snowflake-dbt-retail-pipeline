select
    order_line_key,
    order_id,
    order_date,
    customer_id,
    product_id,
    quantity,
    unit_price,
    line_amount
from {{ ref('stg_orders') }}