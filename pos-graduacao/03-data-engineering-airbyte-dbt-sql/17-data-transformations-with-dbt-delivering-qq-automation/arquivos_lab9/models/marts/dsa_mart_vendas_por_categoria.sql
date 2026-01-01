# Lab 9 - Analytics Engineering e Linhagem de Dados com Python, DBT, BigQuery e Looker Studio

with
    vendas_por_categoria as (
        select
            p.categoria_produto,
            sum(v.quantidade_venda) as quantidade_vendida,
            round(sum(v.valor_total_venda), 2) as valor_total_vendas
        from
            {{ ref('fato_vendas') }} v
        join
            {{ ref('dim_produtos') }} p on v.id_produto = p.id_produto
        group by
            p.categoria_produto
    )

select * from vendas_por_categoria
