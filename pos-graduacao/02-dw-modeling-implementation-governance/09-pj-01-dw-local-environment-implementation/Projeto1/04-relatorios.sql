-- Views para os relatórios


-- Relatório de vendas por produto e canal.
CREATE VIEW dw.VW_VendasPorProdutoCanal AS
SELECT 
    dp.nome AS Nome_Produto,
    dc.nome AS Nome_Canal,
    SUM(fv.valor_venda) AS Total_Vendas,
    SUM(fv.quantidade) AS Total_Quantidade
FROM 
    dw.fato_venda fv
JOIN 
    dw.dim_produto dp ON fv.sk_produto = dp.sk_produto
JOIN 
    dw.dim_canal dc ON fv.sk_canal = dc.sk_canal
GROUP BY 
    dp.nome, dc.nome;


-- Executa o relatório
SELECT * FROM dw.vw_vendasporprodutocanal ORDER BY nome_produto;


-- Relatório de vendas para cada cliente em cada mês e ano.
CREATE VIEW dw.VW_VendasPorClientePeriodo AS
SELECT 
    dc.nome AS Nome_Cliente,
    dd.ano,
    dd.mes,
    SUM(fv.valor_venda) AS Total_Vendas,
    SUM(fv.quantidade) AS Total_Quantidade
FROM 
    dw.fato_venda fv
JOIN 
    dw.dim_cliente dc ON fv.sk_cliente = dc.sk_cliente
JOIN 
    dw.dim_data dd ON fv.sk_data = dd.sk_data
GROUP BY 
    dc.nome, dd.ano, dd.mes;


-- Executa o relatório
SELECT * FROM dw.vw_vendasporclienteperiodo ORDER BY nome_cliente;


-- View materializada
CREATE MATERIALIZED VIEW dw.MV_RelatorioVendasResumido
AS
SELECT 
    dp.categoria AS Categoria,
    SUM(fv.valor_venda) AS Total_Vendas,
    SUM(fv.quantidade) AS Total_Quantidade,
    dd.Ano
FROM 
    dw.fato_venda fv
JOIN 
    dw.dim_produto dp ON fv.sk_produto = dp.sk_produto
JOIN 
    dw.dim_data dd ON fv.sk_data = dd.sk_data
GROUP BY 
    dp.categoria, dd.ano
ORDER BY 
    dd.ano;


-- Executa o relatório
SELECT * FROM dw.mv_relatoriovendasresumido ORDER BY ano;


-- Atualização da MView
REFRESH MATERIALIZED VIEW dw.MV_RelatorioVendasResumido;


-- Funcão para retornar relatório de vendas tendo cliente e ano como parâmetro de entrada
CREATE OR REPLACE FUNCTION dw.RelatorioVendasPorCliente(cliente_nome VARCHAR DEFAULT NULL, relatorio_ano INT DEFAULT NULL)
RETURNS TABLE (
    categoria VARCHAR,
    nome_produto VARCHAR,
    ano INT,
    mes INT,
    total_valor_Venda DECIMAL(10, 2),
    total_quantidade INT
)
LANGUAGE plpgsql
AS $$
BEGIN
    RETURN QUERY
    SELECT 
        dp.categoria,
        dp.nome AS nome_produto,
        dd.ano,
        dd.mes,
        SUM(fv.valor_venda) AS total_valor_Venda,
        CAST(SUM(fv.quantidade) AS INTEGER) AS total_quantidade
    FROM 
        dw.fato_venda fv
    JOIN 
        dw.dim_produto dp ON fv.sk_produto = dp.sk_produto
    JOIN 
        dw.dim_data dd ON fv.sk_data = dd.sk_data
    JOIN 
        dw.dim_cliente dc ON fv.sk_cliente = dc.sk_cliente
    WHERE 
        (cliente_nome IS NULL OR dc.nome = cliente_nome) AND
        (relatorio_ano IS NULL OR dd.ano = relatorio_ano)
    GROUP BY 
        dp.categoria, dp.nome, dd.ano, dd.mes
    ORDER BY 
        dp.categoria, dp.nome, dd.ano, dd.mes;
END;
$$;


-- Executando a função:
SELECT * FROM dw.RelatorioVendasPorCliente();
SELECT * FROM dw.RelatorioVendasPorCliente('João Silva');
SELECT * FROM dw.RelatorioVendasPorCliente('João Silva', 2024);
SELECT * FROM dw.RelatorioVendasPorCliente(NULL, 2024);



