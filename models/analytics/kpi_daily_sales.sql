with base_orders as (

    -- Select the core measures needed for daily sales reporting
    select
        order_date,
        order_id,
        quantity,
        line_amount
    from {{ ref('fct_orders') }}

),

daily_sales as (

    -- Aggregate order activity to the daily level
    select
        order_date,
        count(distinct order_id) as total_orders,
        sum(quantity) as total_units,
        sum(line_amount) as total_revenue
    from base_orders
    group by
        order_date

),

final as (

    -- Calculate average order value using macro
    select
        order_date,
        total_orders,
        total_units,
        total_revenue,
        {{ safe_divide('total_revenue', 'total_orders', 2) }} as average_order_value
    from daily_sales

)

select
    order_date,
    total_orders,
    total_units,
    total_revenue,
    average_order_value
from final
order by
    order_date