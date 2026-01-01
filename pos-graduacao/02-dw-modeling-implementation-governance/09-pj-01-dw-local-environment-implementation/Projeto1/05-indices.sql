-- Criação de índices em colunas para otimizar a geração de relatórios


-- Índice composto na tabela fato_venda
CREATE INDEX idx_fato_venda_produto_canal ON dw.fato_venda(sk_produto, sk_canal);


-- Índices nas dimensões Produto e Canal
CREATE INDEX idx_dim_produto ON dw.dim_produto(sk_produto);
CREATE INDEX idx_dim_canal ON dw.dim_canal(sk_canal);


-- Índice composto na tabela fato_venda
CREATE INDEX idx_fato_venda_cliente_data ON dw.fato_venda(sk_cliente, sk_data);


-- Índices nas dimensões Cliente e Data
CREATE INDEX idx_dim_cliente ON dw.dim_cliente(sk_cliente);
CREATE INDEX idx_dim_data ON dw.dim_data(sk_data);


-- Índice composto na tabela fato_venda
CREATE INDEX idx_fato_venda_produto_data ON dw.fato_venda(sk_produto, sk_data);


-- Índices nas dimensões Produto e Data
CREATE INDEX idx_dim_produto_categoria ON dw.dim_produto(categoria);
CREATE INDEX idx_dim_data_ano ON dw.dim_data(ano);


