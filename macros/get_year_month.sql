{% macro get_year_month(date_col) %}
    to_char({{ date_col }}, 'YYYY-MM')
{% endmacro %}