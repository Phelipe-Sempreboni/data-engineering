-- Carrega a tabela fato_vendas


-- Query para retornar os dados para a tabela

SELECT sk_produto,
	     sk_cliente,
	     sk_canal,
       sk_data, 
       quantidade, 
       ROUND(preco_venda, 2) AS preco_venda, 
	     ROUND(custo_produto, 2) AS custo_produto, 
	     ROUND((CAST(quantidade AS numeric) * CAST(preco_venda AS numeric)), 2) AS receita_vendas
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
AND tb4.id_produto = tb6.id_produto;


-- Carga de dados:

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
       quantidade, 
       ROUND(preco_venda, 2) AS preco_venda, 
	     ROUND(custo_produto, 2) AS custo_produto, 
	     ROUND((CAST(quantidade AS numeric) * CAST(preco_venda AS numeric)), 2) AS receita_vendas
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
AND tb4.id_produto = tb6.id_produto;


# Recria a tabela fato sem constraints

CREATE TABLE schema3.fato_vendas (
  sk_produto INT NOT NULL,
  sk_cliente INT NOT NULL,
  sk_canal INT NOT NULL,
  sk_data INT NOT NULL,
  quantidade INT NOT NULL,
  valor_venda DECIMAL(10,2) NOT NULL,
  custo_produto DECIMAL(10,2) NOT NULL,
  receita_vendas DECIMAL(10,2) NOT NULL
);


-- Key (sk_produto, sk_cliente, sk_canal, sk_data)=(1, 10, 4, 739)

-- Check - Obs: Os códigos abaixo podem ser diferentes no seu ambiente

SELECT * FROM schema3.fato_vendas where sk_data = 739 and sk_cliente = 10 order by 1;

-- Check - Obs: Os códigos abaixo podem ser diferentes no seu ambiente

SELECT sk_produto,
	     sk_cliente,
	     sk_canal,
       sk_data,
	     SUM(quantidade) AS quantidade, 
       SUM(valor_venda) AS valor_venda, 
	     SUM(custo_produto) AS custo_produto, 
	     SUM(ROUND((CAST(quantidade AS numeric) * CAST(valor_venda AS numeric)), 2)) AS receita_vendas
FROM schema3.fato_vendas 
WHERE sk_data = 738 AND sk_cliente = 3
GROUP BY sk_produto, sk_cliente, sk_canal, sk_data;


-- Recria a tabela fato com as constraints

CREATE TABLE schema3.fato_vendas (
  sk_produto INT NOT NULL,
  sk_cliente INT NOT NULL,
  sk_canal INT NOT NULL,
  sk_data INT NOT NULL,
  quantidade INT NOT NULL,
  valor_venda DECIMAL(10,2) NOT NULL,
  custo_produto DECIMAL(10,2) NOT NULL,
  receita_vendas DECIMAL(10,2) NOT NULL,
  PRIMARY KEY (sk_produto, sk_cliente, sk_canal, sk_data),
  FOREIGN KEY (sk_produto) REFERENCES schema3.dim_produto (sk_produto),
  FOREIGN KEY (sk_cliente) REFERENCES schema3.dim_cliente (sk_cliente),
  FOREIGN KEY (sk_canal) REFERENCES schema3.dim_canal (sk_canal),
  FOREIGN KEY (sk_data) REFERENCES schema3.dim_data (sk_data)
);


