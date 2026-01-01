# Lab 9 - Analytics Engineering e Linhagem de Dados com Python, DBT, BigQuery e Looker Studio

with
    fato_vendas as (
        select
            data_id AS id_data,
            cliente_id AS id_cliente,
            localidade_id AS id_localidade,
            produto_id AS id_produto,
            quantidade AS quantidade_venda,
            total_venda AS valor_total_venda
        from
            {{ source('dsastaging', 'stg_vendas') }}
    )

select * from fato_vendas
