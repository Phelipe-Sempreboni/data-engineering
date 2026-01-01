# Modelagem, Implementação e Governança de Data Warehouses - Capítulo 3


-- Cria um schema de organização lógica de objetos no banco de dados
CREATE SCHEMA cap03 AUTHORIZATION dsa;


-- Instruções DDL (Data Definition Language)
-- CREATE, ALTER, DROP

-- Criação da tabela
CREATE TABLE cap03.funcionarios (
    id_funcionario SERIAL PRIMARY KEY,
    nome VARCHAR(50),
    departamento VARCHAR(50),
    salario DECIMAL(10, 2)
);

-- Alteração da tabela
ALTER TABLE cap03.funcionarios ADD COLUMN data_contratacao DATE;

-- Exclusão da tabela
DROP TABLE cap03.funcionarios;

-- Criação da tabela
CREATE TABLE cap03.funcionarios (
    id_funcionario INT PRIMARY KEY,
    nome VARCHAR(50),
    departamento VARCHAR(50),
    data_contratacao DATE,
    salario DECIMAL(10, 2)
);


-- Instruções DML (Data Manipulation Language)
-- SELECT, INSERT, UPDATE, DELETE

-- Inserção de dados
INSERT INTO cap03.funcionarios (id_funcionario, nome, departamento, data_contratacao, salario)
VALUES (100, 'José de Alencar', 'Engenharia de Dados - DSA', '2024-01-10', 25000.00);

INSERT INTO cap03.funcionarios (id_funcionario, nome, departamento, data_contratacao, salario)
VALUES (101, 'Machado de Assis', 'Data Science - DSA', '2024-02-10', 19000.00);

INSERT INTO cap03.funcionarios (id_funcionario, nome, departamento, data_contratacao, salario)
VALUES (102, 'Cecília Meireles', 'Engenharia de Dados - DSA', '2024-02-11', 22000.00);

INSERT INTO cap03.funcionarios (id_funcionario, nome, departamento, data_contratacao, salario)
VALUES (103, 'Carlos Drummond de Andrade', 'DataOps - DSA', '2024-02-12', 23400.00);

INSERT INTO cap03.funcionarios (id_funcionario, nome, departamento, data_contratacao, salario)
VALUES (104, 'Clarice Lispector', 'DataOps - DSA', '2024-02-13', 21800.00);

-- Seleção de dados
SELECT * 
FROM cap03.funcionarios;

-- Atualização de dados
UPDATE cap03.funcionarios 
SET salario = 26000.00 
WHERE nome = 'Machado de Assis';

-- Exclusão de dados
DELETE FROM cap03.funcionarios 
WHERE nome = 'Machado de Assis';

-- Exclusão da tabela
DROP TABLE cap03.funcionarios;


