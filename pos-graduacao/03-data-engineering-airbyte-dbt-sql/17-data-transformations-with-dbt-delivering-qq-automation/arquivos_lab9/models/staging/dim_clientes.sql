# Lab 9 - Analytics Engineering e Linhagem de Dados com Python, DBT, BigQuery e Looker Studio

with
    dim_clientes as (
        select
            cliente_id AS id_cliente,
            nome AS nome_cliente,
            idade AS idade_cliente,
            genero AS genero_cliente
        from
            {{ source('dsastaging', 'stg_clientes') }}

    )

select * from dim_clientes