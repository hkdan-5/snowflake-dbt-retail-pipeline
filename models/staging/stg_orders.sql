select
    order_id,
    cast(order_date as date) as order_date,
    customer_id,
    product_id,
    cast(quantity as integer) as quantity,
    cast(unit_price as number(10,2)) as unit_price,
    {{ calculate_revenue('quantity', 'unit_price') }} as line_amount,
    {{ generate_order_line_key('order_id', 'product_id') }} as order_line_key
from {{ ref('raw_orders') }}