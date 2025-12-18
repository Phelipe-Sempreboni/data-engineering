# Modelagem, Implementação e Governança de Data Warehouses - Capítulo 3


-- Criação da tabela
CREATE TABLE cap03.funcionarios (
    id_funcionario INT PRIMARY KEY,
    nome VARCHAR(50),
    departamento VARCHAR(50),
    data_contratacao DATE,
    salario DECIMAL(10, 2)
);

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


-- Funções de Agregação e Agrupamento

-- Mínimo, Máximo, Média, Soma e Contagem
SELECT MIN(salario), MAX(salario), AVG(salario), SUM(salario), COUNT(salario)
FROM cap03.funcionarios;

-- Mínimo, Máximo, Média, Soma e Contagem com função ROUND()
SELECT MIN(salario), MAX(salario), ROUND(AVG(salario), 2), SUM(salario), COUNT(salario)
FROM cap03.funcionarios;

-- Média salarial geral
SELECT ROUND(AVG(salario), 2) AS media_salario
FROM cap03.funcionarios;

-- Média salarial por departamento
SELECT departamento, ROUND(AVG(salario), 2) AS media_salario
FROM cap03.funcionarios
GROUP BY departamento;

-- Média salarial por departamento ordenado por departamento
SELECT departamento, ROUND(AVG(salario), 2) AS media_salario
FROM cap03.funcionarios
GROUP BY departamento
ORDER BY departamento;

-- Média salarial por departamento somente se a média for maior do que 20000, ordenado por departamento
SELECT departamento, ROUND(AVG(salario), 2) AS media_salario
FROM cap03.funcionarios
GROUP BY departamento
HAVING ROUND(AVG(salario), 2) > 20000
ORDER BY departamento;

-- Média salarial por departamento somente se a média for maior do que 20000 e somente se o nome do departamento tiver a palavra 'Engenharia'
-- Ordenado por departamento
SELECT departamento, ROUND(AVG(salario), 2) AS media_salario
FROM cap03.funcionarios
WHERE departamento LIKE '%Engenharia%'
GROUP BY departamento
HAVING ROUND(AVG(salario), 2) > 20000
ORDER BY departamento;


-- Junções (JOINs)
-- INNER, LEFT, RIGHT, FULL

-- Tabela de projetos
CREATE TABLE cap03.projetos (
    id_projeto INT PRIMARY KEY,
    nome_projeto VARCHAR(100),
    func_id INT REFERENCES cap03.funcionarios(id_funcionario)
);

INSERT INTO cap03.projetos (id_projeto, nome_projeto, func_id)
VALUES (6001, 'Análise de Dados em Tempo Real', 101);

INSERT INTO cap03.projetos (id_projeto, nome_projeto, func_id)
VALUES (6002, 'Pipelines de CI/CD', 103);

INSERT INTO cap03.projetos (id_projeto, nome_projeto, func_id)
VALUES (6003, 'Extração de Dados de Bancos Transacionais', 104);

INSERT INTO cap03.projetos (id_projeto, nome_projeto, func_id)
VALUES (6004, 'Backup de Dados', 102);

INSERT INTO cap03.projetos (id_projeto, nome_projeto, func_id)
VALUES (6005, 'Levantamento de Requisitos', null);

-- Seleção de dados
SELECT * 
FROM cap03.projetos;

-- INNER JOIN - Nome e salário dos funcionários alocados em projetos
SELECT e.nome, e.salario, p.nome_projeto
FROM cap03.funcionarios e
INNER JOIN cap03.projetos p ON e.id_funcionario = p.func_id;

-- LEFT JOIN - Nome e salário de todos os funcionários independente de estarem alocados em projetos
SELECT e.nome, e.salario, p.nome_projeto
FROM cap03.funcionarios e
LEFT JOIN cap03.projetos p ON e.id_funcionario = p.func_id;

-- Alternativa mais elegante para o resultado anterior
SELECT e.nome, e.salario, COALESCE(p.nome_projeto, 'Não Alocado em Projeto')
FROM cap03.funcionarios e
LEFT JOIN cap03.projetos p ON e.id_funcionario = p.func_id;

-- RIGHT JOIN - Nome de todos os funcionários alocados em projetos e os projetos sem funcionários alocados
SELECT COALESCE(e.nome, 'Sem Funcionário Alocado') AS nome_funcionario, p.nome_projeto
FROM cap03.funcionarios e
RIGHT JOIN cap03.projetos p ON e.id_funcionario = p.func_id;

-- FULL JOIN - Nome de todos os funcionários alocados ou não em projetos e todos os projetos sem funcionários alocados
SELECT COALESCE(e.nome, 'Sem Funcionário Alocado') AS nome_funcionario, COALESCE(p.nome_projeto, 'Não Alocado em Projeto')
FROM cap03.funcionarios e
FULL JOIN cap03.projetos p ON e.id_funcionario = p.func_id;

-- INNER JOIN - Média de salário dos departamentos com funcionários alocados em projetos
SELECT departamento, ROUND(AVG(salario), 2) AS media_salario
FROM cap03.funcionarios e
INNER JOIN cap03.projetos p ON e.id_funcionario = p.func_id
GROUP BY departamento;

-- INNER JOIN - Média de salário dos departamentos com funcionários alocados em projetos, cuja data de contratação do funcionário tenha sido no dia 10 de qualquer mês ou ano
SELECT departamento, ROUND(AVG(salario), 2) AS media_salario
FROM cap03.funcionarios e
INNER JOIN cap03.projetos p ON e.id_funcionario = p.func_id
WHERE EXTRACT(DAY FROM data_contratacao) = 10
GROUP BY departamento;


-- CTE
-- Funcionários com salário maior do que 21900
WITH funcionarios_salarios_mais_altos AS (
    SELECT nome, salario
    FROM cap03.funcionarios
    WHERE salario > 21900
)
SELECT * 
FROM funcionarios_salarios_mais_altos;

-- Funcionários com salário maior do que 21900 contratados no dia 10 (por que esta query apresenta erro?)
WITH funcionarios_salarios_mais_altos AS (
    SELECT nome, salario
    FROM cap03.funcionarios
    WHERE salario > 21900
)
SELECT * 
FROM funcionarios_salarios_mais_altos
WHERE EXTRACT(DAY FROM data_contratacao) = 10;

-- Seleção de dados
SELECT * 
FROM cap03.funcionarios;

-- CTE
-- Funcionários com salário maior do que 21900 contratados no dia 10
WITH funcionarios_salarios_mais_altos AS (
    SELECT nome, salario, data_contratacao
    FROM cap03.funcionarios
    WHERE salario > 21900
)
SELECT * 
FROM funcionarios_salarios_mais_altos
WHERE EXTRACT(DAY FROM data_contratacao) = 10;


-- Subconsulta
-- Considerando os funcionários contratados no mês de Fevereiro, retorne nome e departamento de quem tem o maior salário

-- Observe que o agrupamento por nome e departamento vai retornar o resultado muito granular (muito detalhado)
SELECT nome, departamento, MAX(salario)
FROM cap03.funcionarios
WHERE EXTRACT(MONTH FROM data_contratacao) = 2
GROUP BY nome, departamento;

-- Solução com subconsulta
SELECT nome, departamento
FROM cap03.funcionarios
WHERE salario = (SELECT MAX(salario) FROM cap03.funcionarios WHERE EXTRACT(MONTH FROM data_contratacao) = 2);






