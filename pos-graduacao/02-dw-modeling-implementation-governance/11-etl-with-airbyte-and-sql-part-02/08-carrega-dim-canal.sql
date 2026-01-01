-- Carrega a tabela dim_canal no DW a partir da Staging Area

INSERT INTO schema3.dim_canal (id_canal, nome, regiao)
SELECT
    c.id_canal,
    ci.nome_cidade AS nome,
    c.regiao
FROM
    schema2.st_ft_canais c
JOIN
    schema2.st_ft_cidades ci ON c.id_cidade = ci.id_cidade
WHERE NOT EXISTS (
    SELECT 1 FROM schema3.dim_canal dc WHERE dc.id_canal = c.id_canal
);


-- Nota: Primeiro, vamos verificar se já existe alguma entrada na dim_canal. Se não, então vamos inserir.