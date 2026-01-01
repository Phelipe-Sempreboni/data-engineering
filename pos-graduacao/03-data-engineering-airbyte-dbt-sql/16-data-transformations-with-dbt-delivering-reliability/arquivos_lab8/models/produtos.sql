-- Configura o modelo de produtos para ser materializado como uma "view" no banco de dados

{{ config(materialized='view') }}  

WITH produtos_base AS (  
    SELECT *
    FROM tb_produtos  
)

SELECT
    produto_id,  
    nome, 
    preco
FROM produtos_base  
