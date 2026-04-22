with customer_orders as (

    -- Combine order facts with customer attributes
    select
        f.customer_id,
        c.customer_name,
        f.order_id,
        f.order_date,
        f.line_amount
    from {{ ref('fct_orders') }} as f
    left join {{ ref('dim_customers') }} as c
        on f.customer_id = c.customer_id

),

customer_kpis as (

    -- Aggregate customer-level performance metrics
    select
        customer_id,
        customer_name,
        count(distinct order_id) as orders_count,
        sum(line_amount) as lifetime_value,
        min(order_date) as first_order_date,
        max(order_date) as last_order_date
    from customer_orders
    group by
        customer_id,
        customer_name

),

final as (

    -- Final customer KPI output
    select
        customer_id,
        customer_name,
        orders_count,
        lifetime_value,
        first_order_date,
        last_order_date
    from customer_kpis

)

select
    customer_id,
    customer_name,
    orders_count,
    lifetime_value,
    first_order_date,
    last_order_date
from final
order by
    lifetime_value desc