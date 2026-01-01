-- ETL

-- Carrega dim_produto
INSERT INTO dw.dim_produto (id_produto, nome, categoria)
VALUES 
    (1000, 'Laptop', 'Eletrônicos'),
    (2000, 'Tablet', 'Eletrônicos'),
    (3000, 'Café', 'Alimentos'),
    (4000, 'Smartphone', 'Eletrônicos'),
    (5000, 'Refrigerante', 'Bebidas'),
    (6000, 'Suco', 'Bebidas'),
    (7000, 'Livro', 'Educação'),
    (8000, 'Fone de Ouvido', 'Eletrônicos'),
    (9000, 'Notebook', 'Eletrônicos'),
    (10000, 'Mouse', 'Acessórios');

-- Carrega dim_canal
INSERT INTO dw.dim_canal (id_canal, nome, regiao)
VALUES 
    (100, 'E-commerce', 'Global'),
    (101, 'Loja Física', 'América do Norte'),
    (102, 'Revendedor', 'Europa'),
    (103, 'Distribuidor', 'Ásia'),
    (104, 'Marketplace', 'América do Sul'),
    (105, 'Atacado', 'África'),
    (106, 'Varejo', 'Oceania'),
    (107, 'Vendas Diretas', 'América do Norte'),
    (108, 'Parcerias', 'Europa'),
    (109, 'Telemarketing', 'América Latina');

-- Carrega dim_cliente
INSERT INTO dw.dim_cliente (id_cliente, nome, tipo, cidade, estado, pais)
VALUES 
    (1001, 'Empresa Alpha', 'Corporativo', 'São Paulo', 'SP', 'Brasil'),
    (1002, 'João Silva', 'Individual', 'Rio de Janeiro', 'RJ', 'Brasil'),
    (1003, 'Maria Oliveira', 'Individual', 'Lisboa', 'NA', 'Portugal'),
    (1004, 'Empresa Beta', 'Corporativo', 'Porto Alegre', 'RS', 'Brasil'),
    (1005, 'Carlos Mendez', 'Individual', 'Madri', 'NA', 'Espanha'),
    (1006, 'Empresa Gamma', 'Corporativo', 'Buenos Aires', '', 'Argentina'),
    (1007, 'Ana Pereira', 'Individual', 'Santiago', 'NA', 'Chile'),
    (1008, 'Empresa Delta', 'Corporativo', 'Nova York', 'NY', 'Estados Unidos'),
    (1009, 'James Brown', 'Individual', 'Londres', 'NA', 'Reino Unido'),
    (1010, 'Empresa Epsilon', 'Corporativo', 'Sydney', 'NA', 'Austrália');

-- Carrega dim_data com datas passadas e futuras
CREATE OR REPLACE PROCEDURE dw.sp_popula_dim_data()
LANGUAGE plpgsql
AS $$
DECLARE
    v_data_atual DATE := '2021-01-01';
    v_data_final DATE := '2031-12-31';
BEGIN
    -- Loop para gerar e inserir as datas
    WHILE v_data_atual <= v_data_final LOOP
        INSERT INTO dw.dim_data (dia, mes, ano, data_completa)
        VALUES (
            EXTRACT(DAY FROM v_data_atual),
            EXTRACT(MONTH FROM v_data_atual),
            EXTRACT(YEAR FROM v_data_atual),
            v_data_atual
        );
        
        -- Incrementa a data 
        v_data_atual := v_data_atual + INTERVAL '1 day';
    END LOOP;
END;
$$;

-- Executa a SP
CALL dw.sp_popula_dim_data();

-- Carrega tabela FATO
CREATE OR REPLACE PROCEDURE dw.sp_carrega_tabela_fato()
LANGUAGE plpgsql
AS $$
DECLARE
    i INT := 1;
    v_sk_produto INT;
    v_sk_canal INT;
    v_sk_data INT;
    v_sk_cliente INT;
BEGIN
    WHILE i <= 1000 LOOP
        -- Seleciona IDs aleatórios válidos das tabelas de dimensão
        v_sk_produto := (SELECT sk_produto FROM dw.dim_produto ORDER BY RANDOM() LIMIT 1);
        v_sk_canal := (SELECT sk_canal FROM dw.dim_canal ORDER BY RANDOM() LIMIT 1);
        v_sk_data := (SELECT sk_data FROM dw.dim_data WHERE ano <= 2025 ORDER BY RANDOM() LIMIT 1);
        v_sk_cliente := (SELECT sk_cliente FROM dw.dim_cliente ORDER BY RANDOM() LIMIT 1);

        BEGIN
            -- Tenta inserir um registro com uma combinação única de chaves
            INSERT INTO dw.fato_venda (sk_produto, sk_canal, sk_data, sk_cliente, quantidade, valor_venda)
            VALUES (
                v_sk_produto,
                v_sk_canal,
                v_sk_data,
                v_sk_cliente,
                FLOOR(1 + RANDOM() * 125),   -- Quantidade
                ROUND(CAST(RANDOM() * 1000 AS numeric), 2)  -- Valor: Aleatório até 1000 com duas casas decimais
            );
            i := i + 1;  -- Incrementa o contador apenas em caso de sucesso
        EXCEPTION WHEN unique_violation THEN
            -- Se ocorrer um erro de violação de unicidade, continua o loop sem incrementar 'i'
            CONTINUE;
        END;
    END LOOP;
END;
$$;

-- Executa a SP
CALL dw.sp_carrega_tabela_fato();
