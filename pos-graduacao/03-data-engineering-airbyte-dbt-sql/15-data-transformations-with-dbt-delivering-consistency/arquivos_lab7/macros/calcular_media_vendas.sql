{% macro calcular_media_vendas(valor) %}
    AVG(CASE WHEN {{ valor }} < 450 THEN {{ valor }} ELSE NULL END)
{% endmacro %}
