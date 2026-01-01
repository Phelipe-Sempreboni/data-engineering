{{ config(materialized='view') }}  -- Configura o modelo para ser materializado como uma "view" no banco de dados

WITH clientes_base AS (  -- Criação de uma CTE (Common Table Expression) chamada "clientes_base"
    SELECT *
    FROM tb_clientes  -- Seleciona todos os campos da tabela "tb_clientes"
)

SELECT
    id,  -- Seleciona a coluna "id" do cliente
    nome,  -- Seleciona a coluna "nome" do cliente
    email,  -- Seleciona a coluna "email" do cliente
    status,  -- Seleciona a coluna "status" do cliente
    data_cadastro  -- Seleciona a coluna "data_cadastro" do cliente
FROM clientes_base  -- Utiliza a CTE "clientes_base" como a fonte dos dados
