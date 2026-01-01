-- Cria o Modelo Físico

CREATE SCHEMA schema3 AUTHORIZATION dbadmin;

-- Tabela Dimensão Cliente
CREATE TABLE schema3.dim_cliente (
    sk_cliente SERIAL PRIMARY KEY,
    id_cliente INT,
    nome VARCHAR(255),
    tipo VARCHAR(255),
    cidade VARCHAR(255),
    estado VARCHAR(50),
    pais VARCHAR(255)
);

-- Tabela Dimensão Produto
CREATE TABLE schema3.dim_produto (
  sk_produto SERIAL PRIMARY KEY,
  id_produto INT NOT NULL,
  nome VARCHAR(50) NOT NULL,
  categoria VARCHAR(50) NOT NULL
);

-- Tabela Dimensão Canal
CREATE TABLE schema3.dim_canal (
    sk_canal SERIAL PRIMARY KEY,
    id_canal INT,
    nome VARCHAR(255),
    regiao VARCHAR(255)
);

-- Tabela Dimensão Data
CREATE TABLE schema3.dim_data (
    sk_data SERIAL PRIMARY KEY,
    data_completa DATE,
    dia INT,
    mes INT,
    ano INT
);

-- Tabela Fato de Vendas
CREATE TABLE schema3.fato_vendas (
  sk_produto INT NOT NULL,
  sk_cliente INT NOT NULL,
  sk_canal INT NOT NULL,
  sk_data INT NOT NULL,
  quantidade INT NOT NULL,
  valor_venda DECIMAL(10,2) NOT NULL,
  custo_produto DECIMAL(10,2) NOT NULL,
  receita_vendas DECIMAL(10,2) NOT NULL,
  PRIMARY KEY (sk_produto, sk_cliente, sk_canal, sk_data),
  FOREIGN KEY (sk_produto) REFERENCES schema3.dim_produto (sk_produto),
  FOREIGN KEY (sk_cliente) REFERENCES schema3.dim_cliente (sk_cliente),
  FOREIGN KEY (sk_canal) REFERENCES schema3.dim_canal (sk_canal),
  FOREIGN KEY (sk_data) REFERENCES schema3.dim_data (sk_data)
);





