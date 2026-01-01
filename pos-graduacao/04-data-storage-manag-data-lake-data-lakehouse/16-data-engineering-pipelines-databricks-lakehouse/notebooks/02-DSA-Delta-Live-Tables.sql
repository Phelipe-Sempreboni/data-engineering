-- Data Science Academy
-- Armazenamento e Gestão de Dados com Data Lake e Data Lakehouse
-- Lab 7 - Delta Live Tables SQL Pipeline e Integração de Dados Batch e Streaming

-- Cria Bronze Live Table
CREATE LIVE TABLE dsa_mapeamento_tipo_cliente
COMMENT "Tabela Bronze para os tipos de clientes"
TBLPROPERTIES ("quality" = "bronze")
AS
SELECT *
FROM dsadlt.dsa_mapeamento_clientes;

-- Cria Bronze Streaming Table
CREATE OR REFRESH STREAMING TABLE dsa_clientes_diarios
COMMENT "Tabela Bronze para os dados dos clientes"
TBLPROPERTIES ("quality" = "bronze")
AS
SELECT *
FROM STREAM(dsadlt.dsa_fonte_clientes_diarios);

-- Cria Silver Streaming Table
CREATE OR REFRESH STREAMING TABLE dsa_dados_limpos_clientes(CONSTRAINT valid_data EXPECT (id_cliente IS NOT NULL and `nome` IS NOT NULL and idade IS NOT NULL and genero IS NOT NULL and `endereco` IS NOT NULL and numero_contato IS NOT NULL and data_cadastro IS NOT NULL) ON VIOLATION DROP ROW)
COMMENT "Tabela Silver com dados de tabelas bronze e restrições de qualidade de dados"
TBLPROPERTIES ("quality" = "silver")
AS
SELECT
    p.id_cliente,
    p.nome,
    p.idade,
    p.genero,
    p.endereco,
    p.numero_contato,
    p.data_cadastro,
    m.desc_tipo
FROM STREAM(live.dsa_clientes_diarios) p
LEFT JOIN live.dsa_mapeamento_tipo_cliente m
ON p.tipo_cliente = m.codigo_tipo;

-- Cria Gold Live Table 1
CREATE LIVE TABLE dsa_estatisticas_clientes
COMMENT "Tabela Gold com estatísticas gerais sobre os clientes"
TBLPROPERTIES ("quality" = "gold")
AS
SELECT
    desc_tipo,
    COUNT(id_cliente) AS total_clientes,
    ROUND(AVG(idade), 2) AS media_idade,
    COUNT(DISTINCT genero) AS count_genero_distinct,
    MIN(idade) AS menor_idade,
    MAX(idade) AS maior_idade
FROM live.dsa_dados_limpos_clientes
GROUP BY desc_tipo;

-- Cria Gold Live Table 2
CREATE LIVE TABLE dsa_estatisticas_clientes_por_genero
COMMENT "Tabela Gold com estatísticas sobre os clientes com base no gênero"
TBLPROPERTIES ("quality" = "gold")
AS
SELECT
    genero,
    COUNT(id_cliente) AS total_clientes,
    ROUND(AVG(idade), 2) AS media_idade,
    MIN(idade) AS menor_idade,
    MAX(idade) AS maior_idade
FROM live.dsa_dados_limpos_clientes
GROUP BY genero;


