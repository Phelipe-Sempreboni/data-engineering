-- Carrega a tabela dim_cliente no DW a partir da Staging Area

INSERT INTO schema3.dim_cliente (id_cliente, nome, tipo, cidade, estado, pais)
SELECT
    c.id_cliente,
    c.nome_cliente AS nome,
    t.nome_tipo AS tipo,
    ci.nome_cidade AS cidade,
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
    ca.pais
FROM
    schema2.st_ft_clientes c
JOIN
    schema2.st_ft_tipo_cliente t ON c.id_tipo = t.id_tipo
JOIN
    schema2.st_ft_cidades ci ON c.id_cidade = ci.id_cidade
JOIN
    schema2.st_ft_canais ca ON ci.id_cidade = ca.id_cidade
WHERE NOT EXISTS (
    SELECT 1 FROM schema3.dim_cliente d WHERE d.id_cliente = c.id_cliente
);


-- Nota: Primeiro, vamos verificar se já existe alguma entrada na dim_cliente. Se não, então vamos inserir.
