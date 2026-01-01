{{ config(materialized='view') }}  -- Configura o modelo para ser materializado como uma "view" no banco de dados

WITH clientes_base_sudeste AS (  
    SELECT *
    FROM {{ ref('clientes') }}
    WHERE estado IN ('SP', 'RJ', 'MG', 'ES')
)

SELECT
    cliente_id,  
    nome, 
    cidade,  
    estado
FROM clientes_base_sudeste  
