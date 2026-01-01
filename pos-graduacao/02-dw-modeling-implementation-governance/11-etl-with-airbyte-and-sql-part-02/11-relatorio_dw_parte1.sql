-- Relatório 1
-- Total de receita por estado, categoria e tipo de cliente

CREATE OR REPLACE VIEW schema3.vw_receita_total
AS
SELECT estado, 
       categoria, 
       tipo AS tipo_cliente, 
       SUM(receita_vendas) AS receita_total
FROM schema3.dim_produto AS tb1, 
     schema3.dim_cliente AS tb2, 
     schema3.dim_canal AS tb3, 
     schema3.dim_data AS tb4, 
     schema3.fato_vendas AS tb5
WHERE tb5.sk_produto = tb1.sk_produto
AND tb5.sk_cliente = tb2.sk_cliente
AND tb5.sk_canal = tb3.sk_canal
AND tb5.sk_data = tb4.sk_data
GROUP BY estado, categoria, tipo
ORDER BY estado, categoria, tipo;


SELECT * FROM schema3.vw_receita_total;