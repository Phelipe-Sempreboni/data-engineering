-- Slowly Changing Dimension


-- SCD Tipo 3
-- Armazena apenas a versão atual e a anterior dos dados.

-- Seleciona os dados
SELECT * FROM dw.dim_canal;

-- Adiciona uma coluna à tabela
ALTER TABLE dw.dim_canal
ADD COLUMN regiao_anterior VARCHAR(255);

-- Atualização da tabela com o valor antigo
UPDATE dw.dim_canal
SET regiao_anterior = 'América Latina'
WHERE id_canal = 109;

-- Atualização da tabela com o valor novo
UPDATE dw.dim_canal
SET regiao = 'LATAM'
WHERE id_canal = 109;

-- Seleciona os dados
SELECT * FROM dw.dim_canal;









