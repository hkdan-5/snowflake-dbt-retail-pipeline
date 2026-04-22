with dates as (

    select distinct
        order_date
    from {{ ref('stg_orders') }}

),

final as (

    select
        order_date as date_day,
        extract(year from order_date) as year_number,
        extract(month from order_date) as month_number,
        to_char(order_date, 'Mon') as month_name,
        extract(quarter from order_date) as quarter_number,
        {{ get_year_month('order_date') }} as year_month
    from dates

)

select *
from final