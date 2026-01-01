-- Lab 5 - Analytics Engineering - Python, SQL e LLM Para Extrair Insights em Pipelines de Engenharia de Dados
-- SQL - Criação do Banco de Dados

-- Deleta o schema se já existir
DROP SCHEMA IF EXISTS lab5 CASCADE;

-- Cria o schema
CREATE SCHEMA lab5 AUTHORIZATION dsa;

-- Cria as tabelas

CREATE TABLE lab5.clientes (
    id_cliente SERIAL PRIMARY KEY,
    nome VARCHAR(100),
    email VARCHAR(101),
    criado_em TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

CREATE TABLE lab5.produtos (
    id_produto SERIAL PRIMARY KEY,
    nome VARCHAR(100),
    preco DECIMAL(10, 2)
);

CREATE TABLE lab5.compras (
    id_compra SERIAL PRIMARY KEY,
    id_cliente INTEGER REFERENCES lab5.clientes(id_cliente),
    id_produto INTEGER REFERENCES lab5.produtos(id_produto),
    data_compra TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);
