-- Lab 5 - Analytics Engineering - Python, SQL e LLM Para Extrair Insights em Pipelines de Engenharia de Dados
-- SQL - Consulta para obter o total de compra por cliente

SELECT 
    c.nome,
    COUNT(p.id_compra) AS total_compras,
    SUM(pr.preco) AS total_gasto
FROM 
    lab5.clientes c
JOIN 
    lab5.compras p ON c.id_cliente = p.id_cliente
JOIN 
    lab5.produtos pr ON p.id_produto = pr.id_produto
GROUP BY 
    c.nome;