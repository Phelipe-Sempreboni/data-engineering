-- Macro

-- Inicia a definição da macro com parâmetros: model, column_name, min_value e max_value
{% macro test_accepted_range(model, column_name, min_value, max_value) %}

-- Cria uma CTE (Common Table Expression) chamada 'validation' para armazenar os valores que não passam no teste de faixa
WITH validation AS (
    SELECT
        {{ column_name }} AS value             -- Seleciona os valores da coluna especificada
    FROM {{ model }}                           -- Seleciona a partir do modelo/tabela especificado
    WHERE {{ column_name }} < {{ min_value }}  -- Condição: seleciona valores menores que o valor mínimo
       OR {{ column_name }} > {{ max_value }}  -- Condição: seleciona valores maiores que o valor máximo
)

-- Contabiliza os registros que falharam no teste (que estão fora do intervalo)
SELECT COUNT(*) AS failures  -- Conta o número de falhas (valores fora do intervalo) na CTE 'validation'
FROM validation              -- Realiza a contagem dos registros inválidos

HAVING COUNT(*) > 0  -- O teste falha se houver pelo menos uma linha fora do intervalo

{% endmacro %}
