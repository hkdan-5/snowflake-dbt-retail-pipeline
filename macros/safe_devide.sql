{% macro safe_divide(numerator, denominator, scale=2) %}
    round({{ numerator }} / nullif({{ denominator }}, 0), {{ scale }})
{% endmacro %}