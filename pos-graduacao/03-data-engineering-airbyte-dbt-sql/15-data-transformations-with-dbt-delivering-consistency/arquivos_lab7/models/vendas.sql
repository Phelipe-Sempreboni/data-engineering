{{ config(materialized='view') }}  -- Configura o modelo para ser materializado como uma "view" no banco de dados

WITH vendas_base AS (  
    SELECT *
    FROM tb_vendas 
    WHERE valor < 500
)

SELECT
    venda_id,  
    cliente_id, 
    data_venda,  
    valor
FROM vendas_base  

