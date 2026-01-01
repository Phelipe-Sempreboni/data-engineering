{% macro calcular_total_vendas(valor) %}
    SUM({{ valor }})
{% endmacro %}
