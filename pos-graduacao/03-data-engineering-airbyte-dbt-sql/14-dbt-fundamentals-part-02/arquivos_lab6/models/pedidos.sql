{{ config(materialized='view') }}  -- Configura o modelo para ser materializado como uma "view" no banco de dados

WITH pedidos_base AS (  -- Criação de uma CTE (Common Table Expression) chamada "pedidos_base"
    SELECT
        id_pedido,  -- Seleciona a coluna "id_pedido" da tabela "tb_pedidos"
        id_cliente,  -- Seleciona a coluna "id_cliente" da tabela "tb_pedidos"
        data_pedido,  -- Seleciona a coluna "data_pedido" da tabela "tb_pedidos"
        valor_total  -- Seleciona a coluna "valor_total" da tabela "tb_pedidos"
    FROM tb_pedidos  -- Fonte dos dados: tabela "tb_pedidos"
    WHERE valor_total > 200  -- Filtra os pedidos com valor total maior que 200
)

SELECT
    id_pedido,  -- Seleciona a coluna "id_pedido" da CTE "pedidos_base"
    id_cliente,  -- Seleciona a coluna "id_cliente" da CTE "pedidos_base"
    data_pedido,  -- Seleciona a coluna "data_pedido" da CTE "pedidos_base"
    valor_total  -- Seleciona a coluna "valor_total" da CTE "pedidos_base"
FROM pedidos_base  -- Utiliza a CTE "pedidos_base" como a fonte dos dados
