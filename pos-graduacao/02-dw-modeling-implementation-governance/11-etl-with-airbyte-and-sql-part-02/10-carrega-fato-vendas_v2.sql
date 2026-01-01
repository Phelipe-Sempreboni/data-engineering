-- Carrega a tabela fato_vendas

INSERT INTO schema3.fato_vendas (sk_produto, 
	                            sk_cliente, 
	                            sk_canal, 
	                            sk_data, 
	                            quantidade, 
	                            valor_venda, 
	                            custo_produto, 
	                            receita_vendas)
SELECT sk_produto,
	  sk_cliente,
	  sk_canal,
       sk_data, 
       ROUND(SUM(quantidade),2) AS quantidade, 
       ROUND(SUM(preco_venda),2) AS preco_venda, 
	  ROUND(SUM(custo_produto),2) AS custo_produto, 
	  SUM(ROUND((CAST(quantidade AS numeric) * CAST(preco_venda AS numeric)), 2)) AS receita_vendas
FROM schema2.st_ft_vendas tb1, 
     schema2.st_ft_clientes tb2, 
	schema2.st_ft_canais tb3, 
	schema2.st_ft_produtos tb4,
	schema3.dim_data tb5,
	schema3.dim_produto tb6,
	schema3.dim_canal tb7,
	schema3.dim_cliente tb8
WHERE tb2.id_cliente = tb1.id_cliente
AND tb3.id_canal = tb1.id_localizacao
AND tb4.id_produto = tb1.id_produto
AND tb1.data_transacao = tb5.data_completa
AND tb2.id_cliente = tb8.id_cliente
AND tb3.id_canal = tb7.id_canal
AND tb4.id_produto = tb6.id_produto
GROUP BY sk_produto, sk_cliente, sk_canal, sk_data;

