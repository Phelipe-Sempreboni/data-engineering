-- Carrega a tabela dim_produto no DW a partir da Staging Area

INSERT INTO schema3.dim_produto (id_produto, nome, categoria)
SELECT
    p.id_produto,
    p.nome_produto AS nome,
    c.nome_categoria AS categoria
FROM
    schema2.st_ft_produtos p
JOIN
    schema2.st_ft_subcategorias s ON p.id_subcategoria = s.id_subcategoria
JOIN
    schema2.st_ft_categorias c ON s.id_categoria = c.id_categoria
WHERE NOT EXISTS (
    SELECT 1 FROM schema3.dim_produto dp WHERE dp.id_produto = p.id_produto
);


-- Nota: Primeiro, vamos verificar se já existe alguma entrada na dim_produto. Se não, então vamos inserir.