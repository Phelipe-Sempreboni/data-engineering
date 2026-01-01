{{ config(materialized='table') }}  -- Configura o modelo para ser materializado como uma "table" no banco de dados, criando uma tabela física com os resultados.

SELECT
    c.id AS cliente_id,  -- Seleciona o ID do cliente e o renomeia como "cliente_id"
    c.nome,  -- Seleciona o nome do cliente
    c.email,  -- Seleciona o email do cliente
    COUNT(p.id_pedido) AS numero_pedidos,  -- Conta o número de pedidos associados ao cliente e renomeia como "numero_pedidos"
    SUM(p.valor_total) AS valor_total_pedidos  -- Soma o valor total dos pedidos do cliente e renomeia como "valor_total_pedidos"
FROM clientes c  -- Fonte dos dados: tabela "clientes" com alias "c"
LEFT JOIN pedidos p  -- Realiza uma junção à esquerda com a tabela "pedidos" usando alias "p"
    ON c.id = p.id_cliente  -- Condição de junção: relaciona clientes aos seus pedidos pelo ID do cliente
GROUP BY c.id, c.nome, c.email  -- Agrupa os resultados por ID, nome e email do cliente
