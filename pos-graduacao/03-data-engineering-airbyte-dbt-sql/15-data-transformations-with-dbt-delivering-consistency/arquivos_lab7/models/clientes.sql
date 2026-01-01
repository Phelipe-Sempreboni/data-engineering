{{ config(materialized='view') }}  -- Configura o modelo para ser materializado como uma "view" no banco de dados

WITH clientes_base AS (  
    SELECT *
    FROM tb_clientes  
)

SELECT
    cliente_id,  
    nome, 
    cidade,  
    estado
FROM clientes_base  
