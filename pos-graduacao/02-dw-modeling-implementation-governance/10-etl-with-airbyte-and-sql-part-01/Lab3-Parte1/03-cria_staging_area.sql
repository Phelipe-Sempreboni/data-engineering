-- Criação da Staging Area

-- Acompanhe as aulas sobre como usar o Airbyte para mover os dados da fonte para a stating area

-- Seleciona os dados para a dimensão cliente

-- Campos necessários: id_cliente, nome, tipo

-- Query:
SELECT id_cliente, 
       nome_cliente, 
       nome_tipo
FROM schema2.st_ft_clientes tb1, schema2.st_ft_tipo_cliente tb2
WHERE tb2.id_tipo = tb1.id_tipo;



-- Seleciona os dados para a dimensão produto

-- Campos necessários: id_produto, nome_produto, categoria, subcategoria

-- Query:
SELECT id_produto, 
       nome_produto, 
       nome_categoria
FROM schema2.st_ft_produtos tb1, schema2.st_ft_subcategorias tb2, schema2.st_ft_categorias tb3
WHERE tb3.id_categoria = tb2.id_categoria
AND tb2.id_subcategoria = tb1.id_subcategoria;



-- Seleciona os dados para a dimensão canal

-- Campos necessários: id_canal, pais, regiao, estado, cidade 

-- Query:
SELECT id_canal, 
       pais, 
       regiao, 
       CASE
        WHEN nome_cidade = 'Natal' THEN 'Rio Grande do Norte'
        WHEN nome_cidade = 'Rio de Janeiro' THEN 'Rio de Janeiro'
        WHEN nome_cidade = 'Belo Horizonte' THEN 'Minas Gerais'
        WHEN nome_cidade = 'Salvador' THEN 'Bahia'
        WHEN nome_cidade = 'Blumenau' THEN 'Santa Catarina'
        WHEN nome_cidade = 'Curitiba' THEN 'Paraná'
        WHEN nome_cidade = 'Fortaleza' THEN 'Ceará'
        WHEN nome_cidade = 'Recife' THEN 'Pernambuco'
        WHEN nome_cidade = 'Porto Alegre' THEN 'Rio Grande do Sul'
        WHEN nome_cidade = 'Manaus' THEN 'Amazonas'
       END estado, 
       nome_cidade
FROM schema2.st_ft_canais tb1, schema2.st_ft_cidades tb2
WHERE tb2.id_cidade = tb1.id_cidade;



-- Seleciona os dados para a dimensão tempo

-- Campos necessários: id_tempo, ano, mes, dia 

-- Query:
SELECT EXTRACT(YEAR FROM d)::INT, 
       EXTRACT(MONTH FROM d)::INT, 
       EXTRACT(DAY FROM d)::INT, d::DATE
FROM generate_series('2020-01-01'::DATE, '2024-12-31'::DATE, '1 day'::INTERVAL) d;






