with orders as (

    select
        order_id,
        order_date,
        customer_id,
        product_id,
        quantity,
        unit_price,
        line_amount,
        order_line_key
    from {{ ref('stg_orders') }}

),

customers as (

    select
        customer_id,
        customer_name,
        city,
        country,
        signup_date
    from {{ ref('stg_customers') }}

),

products as (

    select
        product_id,
        product_name,
        category,
        price
    from {{ ref('stg_products') }}

),

final as (

    select
        o.order_line_key,
        o.order_id,
        o.order_date,
        o.customer_id,
        c.customer_name,
        c.city,
        c.country,
        c.signup_date,
        o.product_id,
        p.product_name,
        p.category,
        o.quantity,
        o.unit_price,
        o.line_amount
    from orders o
    left join customers c
        on o.customer_id = c.customer_id
    left join products p
        on o.product_id = p.product_id

)

select *
from final