-- Slowly Changing Dimension


-- SCD Tipo 2
-- Cria um novo registro para cada alteração, mantendo o histórico completo. 
-- Geralmente, inclui colunas para identificar as datas de início e término de validade ou uma flag.

-- Modificação da tabela Dim_Produto
ALTER TABLE dw.dim_produto ADD COLUMN data_inicio DATE;
ALTER TABLE dw.dim_produto ADD COLUMN data_fim DATE;
ALTER TABLE dw.dim_produto ADD COLUMN ativo BOOLEAN DEFAULT true;


-- O processo de carga para cada dimensão irá verificar se existem mudanças nos atributos que definem uma dimensão. 
-- Se houver mudança, o registro atual será fechado (ou seja, a data_fim será definida e ativo será definido como false) e um novo registro será inserido.

CREATE OR REPLACE FUNCTION dw.update_dim_produto(v_id_produto INT, v_nome VARCHAR, v_categoria VARCHAR, v_data_atual DATE)
RETURNS VOID AS $$
BEGIN
    -- Verificar se existe uma mudança
    IF EXISTS (
        SELECT 1 FROM dw.dim_produto 
        WHERE id_produto = v_id_produto AND ativo
        AND (nome <> v_nome OR categoria <> v_categoria)
    ) THEN
        -- Fechar o registro atual
        UPDATE dw.dim_produto 
        SET data_fim = v_data_atual, ativo = false
        WHERE id_produto = v_id_produto AND ativo;

        -- Inserir novo registro
        INSERT INTO dw.dim_produto (id_produto, nome, categoria, data_inicio, data_fim, ativo)
        VALUES (v_id_produto, v_nome, v_categoria, v_data_atual, NULL, true);
    END IF;
END;
$$ LANGUAGE plpgsql;


-- Exemplo de chamada da função
SELECT dw.update_dim_produto(10000, 'Mouse', 'Periféricos', CURRENT_DATE);
SELECT dw.update_dim_produto(6000, 'Suco Light', 'Bebidas', CURRENT_DATE);


-- Inserindo registros na Tabela Fato
INSERT INTO dw.fato_venda (sk_produto, sk_canal, sk_data, sk_cliente, quantidade, valor_venda)
VALUES (12, 2, 3, 5, 17, 234.00);
INSERT INTO dw.fato_venda (sk_produto, sk_canal, sk_data, sk_cliente, quantidade, valor_venda)
VALUES (12, 4, 5, 4, 9, 134.00);


-- Relatório
SELECT * FROM dw.vw_vendasporprodutocanal WHERE nome_produto IN ('Suco', 'Suco Light');





