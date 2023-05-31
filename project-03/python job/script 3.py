# Se não houver instalado, instalar a biblioteca (pyodbc) para realizar a conexão com o banco de dados. Abra o prompt de comando e digite: pip install pyodbc.
# Se não houver instalado, instalar a biblioteca (pandas) para tratar o arquivo CSV. Abra o prompt de comando e digite: pip install pandas.
# Biblioteca (csv) é nativa do Python.
# Biblioteca (time) é nativa do Python.

# ----- # ----- # ----- # ----- # ----- # ----- # ----- # ----- # ----- # ----- # ----- # ----- # ----- # ----- # ----- # ----- # ----- # ----- # ----- # ----- # ----- # ----- # ----- # ----- # ----- # ----- # ----- # ----- # ----- # ----- # ----- # ----- #

# COnfigurações:

# Instalar a biblioteca de conexão do Python com o banco de dados: pip install pyodbc
# Instalar a biblioteca para manipulação dos dados chamada pandas: pip install pandas
# Instalar a biblioteca, por precaução, para leitura de arquivos Excel, chamada openpyxl: pip install openpyxl

# Preencha as seguintes linhas do código com as informações do banco de dados:
# linha: 39.
# linha: 40.
# linha: 41.
# linha: 42.

# Preencha as seguintes linhas com o caminho do arquivo csv que é a base para a análise:
# linha: 153.
# linha: 154.
# linha: 160.

# Preencha a seguinte linha que realiza a importação do arquivo excel:
# linha: 449.

# ----- # ----- # ----- # ----- # ----- # ----- # ----- # ----- # ----- # ----- # ----- # ----- # ----- # ----- # ----- # ----- # ----- # ----- # ----- # ----- # ----- # ----- # ----- # ----- # ----- # ----- # ----- # ----- # ----- # ----- # ----- # ----- #

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

# Pausar de um comando para o outro por 2 segundos.
time.sleep(1)

# Setar o database (MARKETING) para utilização.
conexao.execute("USE [MARKETING]")

# Execução do script no banco de dados que gera a tabela da análise final e detalhada.
query = ("""
DECLARE @NUMBER_CLIENTS FLOAT = (SELECT COUNT([ID]) FROM [MARKETING].[MARKETING_ANALISE_CAMPANHA].[TBL_DADOS_CAMPANHA_VW]);

WITH [TBL_DATA]
AS
(
SELECT 
       COUNT([ID]) AS [NUMBER_CLIENTS]
      ,[EDUCATION]
      ,[MARITAL_STATUS]
      ,ROUND(AVG([YEARS_OLD]),0) AS [AVG_YEARS_OLD]
      ,ROUND(AVG([MONTHLY_INCOME]),0) AS [AVG_MONTHLY_INCOME]
      ,ROUND(AVG([INCOME]),0) AS [AVG_INCOME]
      ,SUM([KIDHOME]) AS [SUM_KIDHOME]
      ,ROUND(AVG([KIDHOME]),2) AS [AVG_KIDHOME]
      ,SUM([TEENHOME]) AS [SUM_TEENHOME]
      ,ROUND(AVG([TEENHOME]),2) AS [AVG_TEENHOME]
      ,AVG([REGISTERED_CUSTOMER_TIME]) AS [AVG_REG_CUSTOMER_TIME]
      ,ROUND(AVG([RECENCY]),0) AS [AVG_RECENCY]
      ,SUM([NUM_DEALS_PURCHASES]) AS [SUM_NUM_DEALS_PURCHASES]
      ,ROUND(AVG([NUM_DEALS_PURCHASES]),0) AS [AVG_NUM_DEALS_PURCHASES]
      ,SUM([NUM_WEB_PURCHASES]) AS [SUM_WEB_PURCHASES]
      ,ROUND(AVG([NUM_WEB_PURCHASES]),0) AS [AVG_WEB_PURCHASES]
      ,SUM([NUM_CATALOG_PURCHASES]) AS [SUM_CATALOG_PURCHASES]
      ,ROUND(AVG([NUM_CATALOG_PURCHASES]),0) AS [AVG_CATALOG_PURCHASES]
      ,SUM([NUM_STORE_PURCHASES]) AS [SUM_STORE_PURCHASES]
      ,ROUND(AVG([NUM_STORE_PURCHASES]),0) AS [AVG_STORE_PURCHASES]
      ,SUM([NUM_WEB_VISITS_MONTH]) AS [SUM_NUM_WEB_VISITS_MONTH]
      ,ROUND(AVG([NUM_WEB_VISITS_MONTH]),0) AS [AVG_NUM_WEB_VISITS_MONTH]
      ,SUM([MNT_WINES]) AS [TOTAL_WINES]
      ,SUM([MNT_FRUITS]) AS [TOTAL_FRUITS]
      ,SUM([MNT_MEAT_PRODUCTS]) AS [TOTAL_MNT_MEAT_PRODUCTS]
      ,SUM([MNT_FISH_PRODUCTS]) AS [TOTAL_MNT_FISH_PRODUCTS]
      ,SUM([MNT_SWEET_PRODUCTS]) AS [TOTAL_MNT_SWEET_PRODUCTS]
      ,SUM([MNT_GOLD_PRODS]) AS [TOTAL_MNT_GOLD_PRODUCTS]

FROM [MARKETING].[MARKETING_ANALISE_CAMPANHA].[TBL_DADOS_CAMPANHA_VW]

GROUP BY
       [EDUCATION]
      ,[MARITAL_STATUS]
)
SELECT
       CONCAT(RANK() OVER (ORDER BY [TOTAL_WINES] + [TOTAL_FRUITS] + [TOTAL_MNT_MEAT_PRODUCTS] + [TOTAL_MNT_FISH_PRODUCTS] + [TOTAL_MNT_SWEET_PRODUCTS] + [TOTAL_MNT_GOLD_PRODUCTS] DESC), ' ', 'º') AS [RANKING_PERFIL_CLIENTE]
      ,[NUMBER_CLIENTS] AS [QTDE_CLIENTES]
      ,[EDUCATION] AS [NIVEL_EDUCACAO]
      ,[MARITAL_STATUS] AS [ESTADO_CIVIL]
      ,ROUND(([NUMBER_CLIENTS] * 100)/(@NUMBER_CLIENTS),2) AS [PORCENTAGEM_CLIENTES]
      ,[AVG_YEARS_OLD] AS [IDADE_MEDIA]
      ,[AVG_MONTHLY_INCOME] AS [RENDA_MEDIA_MENSAL_FAMILIAR]
      ,[AVG_INCOME] AS [RENDA_MEDIA_ANUAL_FAMILIAR]
      ,[SUM_KIDHOME] AS [TOTAL_CRIANCAS]
      ,[AVG_KIDHOME] AS [MEDIA_CRIANCAS]
      ,[SUM_TEENHOME] AS [TOTAL_ADOLESCENTES]
      ,[AVG_TEENHOME] AS [MEDIA_ADOLESCENTES]
      ,[AVG_REG_CUSTOMER_TIME] AS [MEDIA_TEMPO_CLIENTE_REGISTRADO_EMPRESA]
      ,[AVG_RECENCY] AS [MEDIA_DIAS_DESDE_ULT_COMPRA]
      ,[SUM_NUM_DEALS_PURCHASES] AS [TOTAL_COMPRAS_COM_DESCONTO]
      ,[AVG_NUM_DEALS_PURCHASES] AS [MEDIA_COMPRAS_COM_DESCONTO]
      ,[SUM_WEB_PURCHASES] AS [TOTAL_COMPRAS_SITE]
      ,[AVG_WEB_PURCHASES] AS [MEDIA_COMPRAS_SITE]
      ,[SUM_CATALOG_PURCHASES] AS [TOTAL_COMPRAS_CATALOGO]
      ,[AVG_CATALOG_PURCHASES] AS [MEDIA_COMPRAS_CATALOGO]
      ,[SUM_STORE_PURCHASES] AS [TOTAL_COMPRAS_LOJA]
      ,[AVG_STORE_PURCHASES] AS [MEDIA_COMPRAS_LOJA]
      ,[SUM_NUM_WEB_VISITS_MONTH] AS [TOTAL_VISITAS_SITE_ULT_MES]
      ,[AVG_NUM_WEB_VISITS_MONTH] AS [MEDIA_VISITAS_SITE_ULT_MES]
      ,[TOTAL_WINES] AS [TOTAL_VENDAS_CATEGORIA_VINHOS]
      ,[TOTAL_FRUITS] AS [TOTAL_VENDAS_CATEGORIA_FRUTAS]
      ,[TOTAL_MNT_MEAT_PRODUCTS] AS [TOTAL_VENDAS_CATEGORIA_CARNES]
      ,[TOTAL_MNT_FISH_PRODUCTS] AS [TOTAL_VENDAS_CATEGORIA_PEIXES]
      ,[TOTAL_MNT_SWEET_PRODUCTS] AS [TOTAL_VENDAS_CATEGORIA_DOCES]
      ,[TOTAL_MNT_GOLD_PRODUCTS] AS [TOTAL_VENDAS_CATEGORIA_GOLD]
      ,[TOTAL_WINES] + [TOTAL_FRUITS] + [TOTAL_MNT_MEAT_PRODUCTS] + [TOTAL_MNT_FISH_PRODUCTS] + [TOTAL_MNT_SWEET_PRODUCTS] + [TOTAL_MNT_GOLD_PRODUCTS] AS [TOTAL_PRODUTOS_VENDIDOS]

FROM [TBL_DATA]

GROUP BY
        [NUMBER_CLIENTS]
       ,[EDUCATION]
       ,[MARITAL_STATUS]
       ,ROUND(([NUMBER_CLIENTS] * 100)/(@NUMBER_CLIENTS),2)
       ,[AVG_YEARS_OLD]
       ,[AVG_MONTHLY_INCOME]
       ,[AVG_INCOME]
       ,[SUM_KIDHOME]
       ,[AVG_KIDHOME]
       ,[SUM_TEENHOME]
       ,[AVG_TEENHOME]
       ,[AVG_REG_CUSTOMER_TIME]
       ,[AVG_RECENCY]
       ,[SUM_NUM_DEALS_PURCHASES]
       ,[AVG_NUM_DEALS_PURCHASES]
       ,[SUM_WEB_PURCHASES]
       ,[AVG_WEB_PURCHASES]
       ,[SUM_CATALOG_PURCHASES]
       ,[AVG_CATALOG_PURCHASES]
       ,[SUM_STORE_PURCHASES]
       ,[AVG_STORE_PURCHASES]
       ,[SUM_NUM_WEB_VISITS_MONTH]
       ,[AVG_NUM_WEB_VISITS_MONTH]
       ,[TOTAL_WINES]
       ,[TOTAL_FRUITS]
       ,[TOTAL_MNT_MEAT_PRODUCTS]
       ,[TOTAL_MNT_FISH_PRODUCTS]
       ,[TOTAL_MNT_SWEET_PRODUCTS]
       ,[TOTAL_MNT_GOLD_PRODUCTS]
       ,[TOTAL_WINES] + [TOTAL_FRUITS] + [TOTAL_MNT_MEAT_PRODUCTS] + [TOTAL_MNT_FISH_PRODUCTS] + [TOTAL_MNT_SWEET_PRODUCTS] + [TOTAL_MNT_GOLD_PRODUCTS]

ORDER BY	   
        [TOTAL_WINES] + [TOTAL_FRUITS] + [TOTAL_MNT_MEAT_PRODUCTS] + [TOTAL_MNT_FISH_PRODUCTS] + [TOTAL_MNT_SWEET_PRODUCTS] + [TOTAL_MNT_GOLD_PRODUCTS] DESC
"""
)

# Lê o script (query) que gera a tabela de análise final no banco de dados.
df_result = pd.read_sql_query(query, conexao)

# Modifica a quantidade de linhas e colunas que irão aparecer no terminal como resultado. Para utilização dos comandos de controle de quantidade de linhas e colunas é só descomentar os comandos.
#pd.set_option("display.max_rows", 40) # Limite de linhas está em 40.
#pd.set_option("display.max_columns", 30) # Limite de colunas está em 30.

# Imprimir os resultados das 5 primeiros do script (query) executada no banco de dados.
print(df_result.head())

# Gera um arquivo em formato Excel do script (query) executado no banco de dados.
df_result.to_excel(r'', index=False) # Insira o caminho do local de destino e não esqueça de inserir um nome para o arquivo com sua extensão, por exemplo (\caderno_resultado_analise_campanha_marketing.xlsx).

# Imprmir a mensagem que o processo foi finalizado.
print('Processo finalizado.')
