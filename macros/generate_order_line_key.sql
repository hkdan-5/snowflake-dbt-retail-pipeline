{% macro generate_order_line_key(order_id_col, product_id_col) %}
    {{ order_id_col }} || '-' || {{ product_id_col }}
{% endmacro %}