# ------------------------------------------------------------------------------------------------------------------------------------ #

USE dm_presidencia;

# ------------------------------------------------------------------------------------------------------------------------------------ #

CREATE TABLE Dim_Organizacional (
                ID_Vendedor INT NOT NULL,
                Cod_Vendedor NVARCHAR(50) NOT NULL,
                Desc_Vendedor NVARCHAR(250) NOT NULL,
                Cod_Gerente NVARCHAR(50) NOT NULL,
                Desc_Gerente NVARCHAR(250) NOT NULL,
                Cod_Diretor NVARCHAR(50) NOT NULL,
                Desc_Diretor NVARCHAR(250) NOT NULL,
                PRIMARY KEY (ID_Vendedor)
);

ALTER TABLE Dim_Organizacional COMMENT 'Tabela da dimensão Organizacional do modelo de OLAP da Presidência.';


CREATE TABLE Dim_Produto (
                ID_Produto INT NOT NULL,
                Cod_Produto NVARCHAR(50) NOT NULL,
                Desc_Produto NVARCHAR(250) NOT NULL,
                Cod_Marca NVARCHAR(50) NOT NULL,
                Atr_Tamanho NVARCHAR(250) NOT NULL,
                Atr_Sabor NVARCHAR(250) NOT NULL,
                Cod_Categoria NVARCHAR(50) NOT NULL,
                Desc_Marca NVARCHAR(250) NOT NULL,
                Desc_Categoria NVARCHAR(250) NOT NULL,
                PRIMARY KEY (ID_Produto)
);

ALTER TABLE Dim_Produto COMMENT 'Tabela da dimensão Produto do modelo de OLAP da Presidência.';


CREATE TABLE Dim_Cliente (
                ID_Cliente INT NOT NULL,
                Cod_Cliente NVARCHAR(50) NOT NULL,
                Desc_Cliente NVARCHAR(250) NOT NULL,
                Cod_Cidade NVARCHAR(50) NOT NULL,
                Desc_Cidade NVARCHAR(250) NOT NULL,
                Cod_Estado NVARCHAR(50) NOT NULL,
                Desc_Estado NVARCHAR(250) NOT NULL,
                Cod_Regiao NVARCHAR(50) NOT NULL,
                Desc_Regiao NVARCHAR(250) NOT NULL,
                Cod_Segmento NVARCHAR(50) NOT NULL,
                Desc_Segmento NVARCHAR(250) NOT NULL,
                PRIMARY KEY (ID_Cliente)
);

ALTER TABLE Dim_Cliente COMMENT 'Tabela da dimensão Cliente do modelo de OLAP da Presidência.';


CREATE TABLE Dim_Tempo (
                ID_Tempo INT NOT NULL,
                Cod_Tempo NVARCHAR(50) NOT NULL,
                Data DATE NOT NULL,
                Numero_Dia_Semana NVARCHAR(50) NOT NULL,
                Numero_mes NVARCHAR(50) NOT NULL,
                Numero_Ano NVARCHAR(50) NOT NULL,
                Nome_Mes NVARCHAR(250) NOT NULL,
                Numero_Trimestre NVARCHAR(50) NOT NULL,
                Nome_Trimestre NVARCHAR(250) NOT NULL,
                Numero_Semestre NVARCHAR(50) NOT NULL,
                Nome_Semestre NVARCHAR(250) NOT NULL,
                PRIMARY KEY (ID_Tempo)
);

ALTER TABLE Dim_Tempo COMMENT 'Tabela da dimensão Tempo do modelo de OLAP da Presidência.';


CREATE TABLE Dim_Fabrica (
                ID_Fabrica INT NOT NULL,
                Cod_Fabrica NVARCHAR(50) NOT NULL,
                Desc_Fabrica NVARCHAR(250) NOT NULL,
                PRIMARY KEY (ID_Fabrica)
);

ALTER TABLE Dim_Fabrica COMMENT 'Tabela de dimensão Fábrica do modelo de OLAP da Presidência.';


CREATE TABLE Fato_Presidencia (
                ID_Fabrica INT NOT NULL,
                ID_Tempo INT NOT NULL,
                ID_Vendedor INT NOT NULL,
                ID_Cliente INT NOT NULL,
                ID_Produto INT NOT NULL,
                Faturamento DOUBLE PRECISION NOT NULL,
                Unidade_Vendida DOUBLE PRECISION NOT NULL,
                Quantidade_Vendida DOUBLE PRECISION NOT NULL,
                Imposto DOUBLE PRECISION NOT NULL,
                Custo_Variavel DOUBLE PRECISION NOT NULL,
                Custo_Frete DOUBLE PRECISION NOT NULL,
                Custo_Fixo DOUBLE PRECISION NOT NULL,
                Meta_Faturamento DOUBLE PRECISION NOT NULL,
                Meta_Custo DOUBLE PRECISION NOT NULL,
                PRIMARY KEY (ID_Fabrica, ID_Tempo, ID_Vendedor, ID_Cliente, ID_Produto)
);

ALTER TABLE Fato_Presidencia COMMENT 'Tabela de fato da Presidência.';


ALTER TABLE Fato_Presidencia ADD CONSTRAINT dim_organizacional_fato_presidencia_fk
FOREIGN KEY (ID_Vendedor)
REFERENCES Dim_Organizacional (ID_Vendedor)
ON DELETE NO ACTION
ON UPDATE NO ACTION;

ALTER TABLE Fato_Presidencia ADD CONSTRAINT produto_fato_presidencia_fk
FOREIGN KEY (ID_Produto)
REFERENCES Dim_Produto (ID_Produto)
ON DELETE NO ACTION
ON UPDATE NO ACTION;

ALTER TABLE Fato_Presidencia ADD CONSTRAINT cliente_fato_presidencia_fk
FOREIGN KEY (ID_Cliente)
REFERENCES Dim_Cliente (ID_Cliente)
ON DELETE NO ACTION
ON UPDATE NO ACTION;

ALTER TABLE Fato_Presidencia ADD CONSTRAINT tempo_fato_presidencia_fk
FOREIGN KEY (ID_Tempo)
REFERENCES Dim_Tempo (ID_Tempo)
ON DELETE NO ACTION
ON UPDATE NO ACTION;

ALTER TABLE Fato_Presidencia ADD CONSTRAINT fabrica_fato_presidencia_fk
FOREIGN KEY (ID_Fabrica)
REFERENCES Dim_Fabrica (ID_Fabrica)
ON DELETE NO ACTION
ON UPDATE NO ACTION;

# ------------------------------------------------------------------------------------------------------------------------------------ #