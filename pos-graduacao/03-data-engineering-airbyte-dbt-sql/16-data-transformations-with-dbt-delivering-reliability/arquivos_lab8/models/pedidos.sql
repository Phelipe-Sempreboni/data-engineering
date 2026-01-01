-- Configura o modelo de pedidos para ser materializado como uma "table" no banco de dados

{{ config(materialized='table') }}  

WITH pedidos_base AS (  
    SELECT *
    FROM tb_pedidos
)

SELECT
    pedido_id,  
    cliente_id, 
    produto_id,  
    quantidade,
    data_pedido
FROM pedidos_base  
