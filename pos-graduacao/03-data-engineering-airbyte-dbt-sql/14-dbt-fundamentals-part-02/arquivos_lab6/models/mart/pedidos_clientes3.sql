{{ config(materialized='incremental', unique_key='data') }}  
-- Configura o modelo para ser materializado de forma "incremental".
-- A chave única (unique_key) definida é 'data', o que significa que o DBT usará essa coluna para identificar e atualizar os registros.
-- No modo incremental, apenas os registros novos ou modificados serão processados e inseridos na tabela, em vez de reconstruir a tabela inteira.

WITH ultima_data AS (
    SELECT MAX(data) AS max_data
    FROM {{ this }}  
    -- Esta CTE (Common Table Expression) seleciona a data mais recente ('MAX(data)') da tabela que está sendo materializada atualmente.
    -- '{{ this }}' se refere à tabela que está sendo incrementada.
)

SELECT
    DATE(data_pedido) AS data,  -- Converte a data do pedido para o formato de data (sem hora) e a renomeia como 'data'.
    SUM(valor_total) AS total_vendas  -- Soma o valor total das vendas para cada data e o renomeia como 'total_vendas'.
FROM {{ ref('pedidos') }}  
-- Refere-se à tabela 'pedidos' dentro do projeto DBT. A função 'ref' permite referenciar outros modelos no DBT.

{% if is_incremental() %}  
    -- Este bloco condicional será executado apenas se o modelo estiver sendo materializado de forma incremental.
    WHERE data_pedido > (SELECT max_data FROM ultima_data)  
    -- Filtra para incluir apenas registros onde 'data_pedido' é maior que a última data já processada, garantindo que apenas os novos dados sejam considerados.
{% endif %}

GROUP BY 1  -- Agrupa os resultados pela primeira coluna selecionada, que é 'data'.
