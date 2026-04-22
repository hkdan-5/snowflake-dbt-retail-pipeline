with product_sales as (

    -- Combine order facts with product attributes
    select
        f.product_id,
        p.product_name,
        p.category,
        f.order_id,
        f.quantity,
        f.line_amount
    from {{ ref('fct_orders') }} as f
    left join {{ ref('dim_products') }} as p
        on f.product_id = p.product_id

),

product_kpis as (

    -- Aggregate product-level sales and revenue metrics
    select
        product_id,
        product_name,
        category,
        count(distinct order_id) as orders_count,
        sum(quantity) as units_sold,
        sum(line_amount) as revenue
    from product_sales
    group by
        product_id,
        product_name,
        category

),

final as (

    -- Final product KPI output
    select
        product_id,
        product_name,
        category,
        orders_count,
        units_sold,
        revenue
    from product_kpis

)

select
    product_id,
    product_name,
    category,
    orders_count,
    units_sold,
    revenue
from final
order by
    revenue desc