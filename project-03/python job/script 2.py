# Se não houver instalado, instalar a biblioteca (pyodbc) para realizar a conexão com o banco de dados. Abra o prompt de comando e digite: pip install pyodbc.
# Se não houver instalado, instalar a biblioteca (pandas) para tratar o arquivo CSV. Abra o prompt de comando e digite: pip install pandas.
# Biblioteca (csv) é nativa do Python.
# Biblioteca (time) é nativa do Python.

# Importações de bibliotecas.
import pyodbc
import pandas as pd
import csv
import time

# Criação da conexão com o Microsoft SQL Server.
conexao = pyodbc.connect(
Driver='{SQL Server Native Client 11.0}',
Server='', # Insira o server.
Database='', # Insira o banco de dados. Neste job, insira o database (master) padrão do SQL Server, ou comente a linha com (#).
uid='', # Insira o usuário. É possível conectar por autentição do Windows.
pwd='', # Insira a senha. É possível conectar por autentição do Windows.
trusted_Connection='no', # Se o login no banco de dados é realizados com Autentição SQL Server, ou seja, com login e senha, deixe marcado como (no), caso contrário, retire o comando da linha de senha (pwd) e deixe este campo como (yes), informando que a conexão é por meio de Autentição Windows, ou seja, não necessita da senha.
autocommit=True  #Por padrão, o commit, que é a confirmação das transações no script SQL Server, principalmente para DDL, vem como (FALSE). Neste comando ele é alterado para (TRUE), visando fazer os scripts do SQL Server neste job do Python funcionarem e serem executados corretamente.
)
cursor = conexao.cursor() # Criação do cursor para executar comandos no banco de dados.

# Validando se o banco de dados existe.
# Caso o banco de dados exista, ele é dropado e recriado.
# Caso o banco de dados não exista, ele é criado.
conexao.execute("""
DECLARE @nome_banco_de_dados nvarchar(50)

SET @nome_banco_de_dados = N'MARKETING'

BEGIN

USE [master]

IF EXISTS (SELECT name FROM master.dbo.sysdatabases WHERE ('[' + name + ']' = @nome_banco_de_dados OR name = @nome_banco_de_dados))

	DROP DATABASE [MARKETING]

	WAITFOR DELAY '00:00:01'

	CREATE DATABASE [MARKETING]

	WAITFOR DELAY '00:00:01'

IF NOT EXISTS (SELECT name FROM master.dbo.sysdatabases WHERE ('[' + name + ']' = @nome_banco_de_dados OR name = @nome_banco_de_dados))

	CREATE DATABASE [MARKETING]

END
"""
)

# Pausar de um comando para o outro por 2 segundos.
time.sleep(1)

# Validando se o schema existe.
# Caso o schema exista, ele é dropado e recriado.
# Caso o schema não exista, ele é criado.
conexao.execute("""
BEGIN

USE [MARKETING]

IF EXISTS (SELECT * FROM sys.schemas WHERE name = 'MARKETING_ANALISE_CAMPANHA')

	DROP SCHEMA [MARKETING_ANALISE_CAMPANHA]

	WAITFOR DELAY '00:00:01'

	EXEC('CREATE SCHEMA MARKETING_ANALISE_CAMPANHA')

IF NOT EXISTS (SELECT * FROM sys.schemas WHERE name = 'MARKETING_ANALISE_CAMPANHA')

	EXEC('CREATE SCHEMA MARKETING_ANALISE_CAMPANHA')

	WAITFOR DELAY '00:00:01'

END
"""
)

# Pausar de um comando para o outro por 2 segundos.
time.sleep(1)

# Dropar/deletar a tabela se ela já existir e recria-lá com os critérios validados.
conexao.execute("""
DROP TABLE IF EXISTS [MARKETING].[MARKETING_ANALISE_CAMPANHA].[TBL_DADOS_CAMPANHA];

CREATE TABLE [MARKETING].[MARKETING_ANALISE_CAMPANHA].[TBL_DADOS_CAMPANHA] (
	 ID INT -- Tipo do dado da coluna validado.
	,YEAR_BIRTH FLOAT -- Tipo do dado da coluna validado.
	,EDUCATION VARCHAR (20) -- Tipo do dado da coluna validado.
	,MARITAL_STATUS VARCHAR (20) -- Tipo do dado da coluna validado.
	,INCOME FLOAT -- Tipo do dado da coluna validado.
	,KIDHOME FLOAT -- Tipo do dado da coluna validado.
	,TEENHOME FLOAT -- Tipo do dado da coluna validado.
	,DT_CUSTOMER DATE -- Tipo do dado da coluna validado.
	,RECENCY FLOAT -- Tipo do dado da coluna validado.
	,MNT_WINES FLOAT -- Tipo do dado da coluna validado.
	,MNT_FRUITS FLOAT -- Tipo do dado da coluna validado.
	,MNT_MEAT_PRODUCTS FLOAT -- Tipo do dado da coluna validado.
	,MNT_FISH_PRODUCTS FLOAT -- Tipo do dado da coluna validado.
	,MNT_SWEET_PRODUCTS FLOAT -- Tipo do dado da coluna validado.
	,MNT_GOLD_PRODS FLOAT -- Tipo do dado da coluna validado.
	,NUM_DEALS_PURCHASES FLOAT -- Tipo do dado da coluna validado.
	,NUM_WEB_PURCHASES FLOAT -- Tipo do dado da coluna validado.
	,NUM_CATALOG_PURCHASES FLOAT -- Tipo do dado da coluna validado.
	,NUM_STORE_PURCHASES FLOAT -- Tipo do dado da coluna validado.
	,NUM_WEB_VISITS_MONTH FLOAT -- Tipo do dado da coluna validado.
	,ACCEPTED_CMP3 FLOAT -- Tipo do dado da coluna validado.
	,ACCEPTED_CMP4 FLOAT -- Tipo do dado da coluna validado.
	,ACCEPTED_CMP5 FLOAT -- Tipo do dado da coluna validado.
	,ACCEPTED_CMP1 FLOAT -- Tipo do dado da coluna validado.
	,ACCEPTED_CMP2 FLOAT -- Tipo do dado da coluna validado.
	,COMPLAIN FLOAT -- Tipo do dado da coluna validado.
	,Z_COST_CONTACT FLOAT -- Tipo do dado da coluna validado.
	,Z_REVENUE FLOAT -- Tipo do dado da coluna validado.
	,RESPONSE FLOAT -- Tipo do dado da coluna validado.
	,CONSTRAINT PK_ID PRIMARY KEY CLUSTERED (ID) -- Chave primária criada para não duplicar dados e facilitar em buscas com índice clusterizado.
);
"""
)

# Pausar de um comando para o outro por 2 segundos.
time.sleep(1)

# Manipulação do arquivo CSV.
df = pd.read_csv(r'') # Realiza a leitura. Insira o caminho de repositório do CSV.
df.to_csv(r'', header=False, index=False) # Retirado o cabeçalho e possíveis index criados na leitura da linha de comando acima. Insira o caminho de repositório do CSV.

# Pausar de um comando para o outro por 2 segundos.
time.sleep(1)

# Inserção dos dados do arquivo CSV na tabela criada no banco de dados.
with open(r'', encoding="utf8") as csv_file: # Insira o caminho de repositório do CSV.
    csv_reader = csv.reader(csv_file, delimiter=",")
    for row in csv_reader:
        to_db = [(row[0]), (row[1]), (row[2]), (row[3]), (row[4]), (row[5]), (row[6]), (row[7]), (row[8]), (row[9]), (row[10]), (row[11]), (row[12]), (row[13]), (row[14]), (row[15]), (row[16]), (row[17]), (row[18]), (row[19]), (row[20]), (row[21]), (row[22]), (row[23]), (row[24]), (row[25]), (row[26]), (row[27]), (row[28])]
        conexao.execute(
        """
        INSERT INTO [MARKETING].[MARKETING_ANALISE_CAMPANHA].[TBL_DADOS_CAMPANHA] (
        ID
        ,YEAR_BIRTH
        ,EDUCATION
        ,MARITAL_STATUS
        ,INCOME
        ,KIDHOME
        ,TEENHOME
        ,DT_CUSTOMER
        ,RECENCY
        ,MNT_WINES
        ,MNT_FRUITS
        ,MNT_MEAT_PRODUCTS
        ,MNT_FISH_PRODUCTS
        ,MNT_SWEET_PRODUCTS
        ,MNT_GOLD_PRODS
        ,NUM_DEALS_PURCHASES
        ,NUM_WEB_PURCHASES
        ,NUM_CATALOG_PURCHASES
        ,NUM_STORE_PURCHASES
        ,NUM_WEB_VISITS_MONTH
        ,ACCEPTED_CMP3
        ,ACCEPTED_CMP4
        ,ACCEPTED_CMP5
        ,ACCEPTED_CMP1
        ,ACCEPTED_CMP2
        ,COMPLAIN
        ,Z_COST_CONTACT
        ,Z_REVENUE
        ,RESPONSE
        ) 
        VALUES 
        (
        ?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?
        );
        """
        ,to_db
        )

# Pausar de um comando para o outro por 2 segundos.
time.sleep(1)

# Setar o database (MARKETING) para utilização.
conexao.execute("USE [MARKETING]")

# Excluir a view caso ela já exista no banco de dados, garantindo que não haverá erros no processo.
conexao.execute("DROP VIEW IF EXISTS [MARKETING_ANALISE_CAMPANHA].[TBL_DADOS_CAMPANHA_VW]")

# Pausar de um comando para o outro por 2 segundos.
time.sleep(1)

# Setar o database (MARKETING) para utilização.
conexao.execute("USE [MARKETING]")

# Criação da view, que espelha as informações da tabela origem.
conexao.execute("""
CREATE VIEW [MARKETING_ANALISE_CAMPANHA].[TBL_DADOS_CAMPANHA_VW]
AS
WITH [TBL_DADOS_CAMPANHA_MKT] AS
(
SELECT
       [ID]
      ,[YEAR_BIRTH]
      ,[EDUCATION]
      ,[MARITAL_STATUS]
      ,[INCOME]
      ,[KIDHOME]
      ,[TEENHOME]
      ,[DT_CUSTOMER]
      ,[RECENCY]
      ,[MNT_WINES]
      ,[MNT_FRUITS]
      ,[MNT_MEAT_PRODUCTS]
      ,[MNT_FISH_PRODUCTS]
      ,[MNT_SWEET_PRODUCTS]
      ,[MNT_GOLD_PRODS]
      ,[NUM_DEALS_PURCHASES]
      ,[NUM_WEB_PURCHASES]
      ,[NUM_CATALOG_PURCHASES]
      ,[NUM_STORE_PURCHASES]
      ,[NUM_WEB_VISITS_MONTH]
      ,[COMPLAIN]
      ,[Z_COST_CONTACT]
      ,[Z_REVENUE]
      ,[ACCEPTED_CMP1]
      ,[ACCEPTED_CMP2]
      ,[ACCEPTED_CMP3]
      ,[ACCEPTED_CMP4]
      ,[ACCEPTED_CMP5]
      ,[RESPONSE]
      ,
      CASE
      WHEN [YEAR_BIRTH] NOT IN ('') THEN (YEAR(GETDATE()) - [YEAR_BIRTH])
      WHEN [YEAR_BIRTH] IN ('') THEN 0
      WHEN [YEAR_BIRTH] IN (0) THEN 0
      END AS [YEARS_OLD]
      ,
      CASE
      WHEN [INCOME] NOT IN ('') THEN ROUND(([INCOME] / 12), 0)
      WHEN [INCOME] IN ('') THEN 0
      WHEN [INCOME] IN (0) THEN 0
      END AS [MONTHLY_INCOME]
      ,
      CASE
      WHEN [DT_CUSTOMER] NOT IN ('') THEN (YEAR(GETDATE()) - YEAR([DT_CUSTOMER]))
      END AS [REGISTERED_CUSTOMER_TIME]

FROM [MARKETING].[MARKETING_ANALISE_CAMPANHA].[TBL_DADOS_CAMPANHA]
),
[TBL_DADOS_CAMPANHA] AS
(
SELECT
      [ID]
     ,[YEAR_BIRTH]
     ,[YEARS_OLD]
     ,[EDUCATION]
     ,[MARITAL_STATUS]
     ,[MONTHLY_INCOME]
     ,[INCOME]
     ,[KIDHOME]
     ,[TEENHOME]
     ,[DT_CUSTOMER]
     ,[REGISTERED_CUSTOMER_TIME]
     ,[RECENCY]
     ,[MNT_WINES]
     ,[MNT_FRUITS]
     ,[MNT_MEAT_PRODUCTS]
     ,[MNT_FISH_PRODUCTS]
     ,[MNT_SWEET_PRODUCTS]
     ,[MNT_GOLD_PRODS]
     ,[NUM_DEALS_PURCHASES]
     ,[NUM_WEB_PURCHASES]
     ,[NUM_CATALOG_PURCHASES]
     ,[NUM_STORE_PURCHASES]
     ,[NUM_WEB_VISITS_MONTH]
     ,[COMPLAIN]
     ,[Z_COST_CONTACT]
     ,[Z_REVENUE]
     ,[ACCEPTED_CMP1]
     ,[ACCEPTED_CMP2]
     ,[ACCEPTED_CMP3]
     ,[ACCEPTED_CMP4]
     ,[ACCEPTED_CMP5]
     ,[RESPONSE]
 
FROM [TBL_DADOS_CAMPANHA_MKT]
)
SELECT * FROM [TBL_DADOS_CAMPANHA]
"""
)
print('Processo finalizado.')