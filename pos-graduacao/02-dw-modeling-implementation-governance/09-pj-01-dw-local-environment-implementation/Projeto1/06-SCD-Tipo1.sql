-- Slowly Changing Dimension

-- SCD Tipo 1
-- Substitui os dados antigos com os dados mais recentes, sem manter histórico. 
-- Ideal para casos onde o histórico não é necessário.


SELECT * FROM dw.dim_cliente;


UPDATE dw.dim_cliente
SET 
    cidade = 'Recife',
    estado = 'Pernambuco',
    pais = 'Brasil'
WHERE id_cliente = 1010;


SELECT * FROM dw.dim_cliente;
