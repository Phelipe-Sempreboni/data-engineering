-- Configura o modelo de clientes para ser materializado como uma "view" no banco de dados

{{ config(materialized='view') }}  

WITH clientes_base AS (  
    SELECT *
    FROM tb_clientes  
)

SELECT
    cliente_id,  
    nome, 
    email,  
    cidade
FROM clientes_base  
