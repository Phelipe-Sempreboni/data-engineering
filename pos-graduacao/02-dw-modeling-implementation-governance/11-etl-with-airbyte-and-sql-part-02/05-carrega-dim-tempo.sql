-- Carrega a tabela dim_data (tempo)

INSERT INTO schema3.dim_data (ano, mes, dia, data_completa)
SELECT EXTRACT(YEAR FROM d)::INT, 
       EXTRACT(MONTH FROM d)::INT, 
       EXTRACT(DAY FROM d)::INT, d::DATE
FROM generate_series('2020-01-01'::DATE, '2025-12-31'::DATE, '1 day'::INTERVAL) d;
