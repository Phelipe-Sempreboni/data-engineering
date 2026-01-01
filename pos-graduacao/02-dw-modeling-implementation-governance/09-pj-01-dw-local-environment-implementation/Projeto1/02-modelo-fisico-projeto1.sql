-- Criação do schema
CREATE SCHEMA dw AUTHORIZATION dsaadmin;

-- Criação da tabela Dim_Produto
CREATE TABLE dw.dim_produto (
    sk_produto SERIAL PRIMARY KEY,
    id_produto INT,
    nome VARCHAR(255),
    categoria VARCHAR(255)
);

-- Criação da tabela Dim_Canal
CREATE TABLE dw.dim_canal (
    sk_canal SERIAL PRIMARY KEY,
    id_canal INT,
    nome VARCHAR(255),
    regiao VARCHAR(255)
);

-- Criação da tabela Dim_Data
CREATE TABLE dw.dim_data (
    sk_data SERIAL PRIMARY KEY,
    data_completa DATE,
    dia INT,
    mes INT,
    ano INT
);

-- Criação da tabela Dim_Cliente
CREATE TABLE dw.dim_cliente (
    sk_cliente SERIAL PRIMARY KEY,
    id_cliente INT,
    nome VARCHAR(255),
    tipo VARCHAR(255),
    cidade VARCHAR(255),
    estado VARCHAR(50),
    pais VARCHAR(255)
);

-- Criação da tabela Fato de Vendas
CREATE TABLE dw.fato_venda (
  sk_produto INT NOT NULL,
  sk_cliente INT NOT NULL,
  sk_canal INT NOT NULL,
  sk_data INT NOT NULL,
  quantidade INT NOT NULL,
  valor_venda DECIMAL(10,2) NOT NULL,
  PRIMARY KEY (sk_produto, sk_cliente, sk_canal, sk_data),
  FOREIGN KEY (sk_produto) REFERENCES dw.dim_produto (sk_produto),
  FOREIGN KEY (sk_cliente) REFERENCES dw.dim_cliente (sk_cliente),
  FOREIGN KEY (sk_canal) REFERENCES dw.dim_canal (sk_canal),
  FOREIGN KEY (sk_data) REFERENCES dw.dim_data (sk_data)
);

