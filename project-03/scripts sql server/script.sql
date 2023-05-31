--------------------------------------------------------------------------------------------------------------------------------------

-- Criação do database.

CREATE DATABASE MARKETING;
GO

--------------------------------------------------------------------------------------------------------------------------------------

-- Caso queira excluir o database criado.

USE master;
GO

DROP DATABASE MARKETING;
GO

--------------------------------------------------------------------------------------------------------------------------------------

-- Criação do schema.

USE MARKETING;
GO

CREATE SCHEMA MARKETING_ANALISE_CAMPANHA;
GO

-- Caso queira excluir o schema criado.

USE MARKETING;
GO

DROP SCHEMA MARKETING_ANALISE_CAMPANHA;
GO

--------------------------------------------------------------------------------------------------------------------------------------

-- Criação da tabela.

USE MARKETING;
GO

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
GO

USE MARKETING;
GO

-- Verificar informações da tabela, onde, a principal verificada neste caso, seria a (COLUMN_NAME) e (DATA_TYPE) para validar os tipos dos dados na criação da tabela.
SELECT * FROM INFORMATION_SCHEMA.COLUMNS WHERE TABLE_NAME = 'TBL_DADOS_CAMPANHA';
GO

-- Verificar se informações da tabela, onde, a principal verificada neste caso, seria se a tabela possuí uma chave primária, visando não duplicar registros.
SELECT * FROM INFORMATION_SCHEMA.TABLE_CONSTRAINTS WHERE TABLE_NAME = 'TBL_DADOS_CAMPANHA';
GO

-- Caso queria excluir a tabela criada.

DROP TABLE [MARKETING].[MARKETING_ANALISE_CAMPANHA].[TBL_DADOS_CAMPANHA];
GO

-- Caso queira deletar dados da tabela criada.
DELETE FROM [MARKETING].[MARKETING_ANALISE_CAMPANHA].[TBL_DADOS_CAMPANHA];
GO

- Caso queira truncar dados da tabela criada.
TRUNCA TABLE [MARKETING].[MARKETING_ANALISE_CAMPANHA].[TBL_DADOS_CAMPANHA];
GO

--------------------------------------------------------------------------------------------------------------------------------------

-- Criação da view.

USE [MARKETING];
GO

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
SELECT * FROM [TBL_DADOS_CAMPANHA];
GO

-- Caso queira excluir a view.

DROP VIEW [MARKETING_ANALISE_CAMPANHA].[TBL_DADOS_CAMPANHA_VW];
GO  

--------------------------------------------------------------------------------------------------------------------------------------

SELECT COUNT([ID]) AS [NUMBER_CLIENTS] FROM [MARKETING].[MARKETING_ANALISE_CAMPANHA].[TBL_DADOS_CAMPANHA_VW];

-- 2.240 clientes.

--------------------------------------------------------------------------------------------------------------------------------------

-- Idade média dos clientes.
SELECT ROUND(AVG([YEARS_OLD]),0) AS [AVG_AGE_CLIENTS] FROM [MARKETING].[MARKETING_ANALISE_CAMPANHA].[TBL_DADOS_CAMPANHA_VW];

-- 52 anos.
--------------------------------------------------------------------------------------------------------------------------------------

-- Quantidade de clientes pelo nível de educação.
DECLARE @NUMBER_CLIENTS FLOAT = (SELECT COUNT([ID]) FROM [MARKETING].[MARKETING_ANALISE_CAMPANHA].[TBL_DADOS_CAMPANHA_VW]);

WITH [TBL_DATA]
AS
(
SELECT 
      COUNT([ID]) AS [NUMBER_CLIENTS]
     ,[EDUCATION]

FROM [MARKETING].[MARKETING_ANALISE_CAMPANHA].[TBL_DADOS_CAMPANHA_VW]

GROUP BY
	[EDUCATION]
)
SELECT 
      [NUMBER_CLIENTS]
     ,[EDUCATION]
     ,ROUND(([NUMBER_CLIENTS] * 100)/(@NUMBER_CLIENTS),2) AS [PERCENT_CLIENTS_EDUCATION]

FROM [TBL_DATA]

GROUP BY
       [NUMBER_CLIENTS]
      ,[EDUCATION]

-- 1.127 clientes -> Graduation -> 50,3125% -> 50%
-- 486 clientes -> PhD -> 21,696428571428573% -> 22%
-- 370 clientes -> Master -> 16,517857142857142% -> 17%
-- 203 clientes -> 2n Cycle -> 9.0625% -> 9%
-- 54 clientes -> Basic -> 2,4107142857142856% -> 2%

--------------------------------------------------------------------------------------------------------------------------------------

-- Quantidade de clientes pelo estado civil.
DECLARE @NUMBER_CLIENTS FLOAT = (SELECT COUNT([ID]) FROM [MARKETING].[MARKETING_ANALISE_CAMPANHA].[TBL_DADOS_CAMPANHA_VW]);

WITH [TBL_DATA]
AS
(
SELECT 
      COUNT([ID]) AS [NUMBER_CLIENTS]
     ,[MARITAL_STATUS]

FROM [MARKETING].[MARKETING_ANALISE_CAMPANHA].[TBL_DADOS_CAMPANHA_VW]

GROUP BY
	[MARITAL_STATUS]
)
SELECT 
      [NUMBER_CLIENTS]
     ,[MARITAL_STATUS]
     ,ROUND(([NUMBER_CLIENTS] * 100)/(@NUMBER_CLIENTS),2) AS [PERCENT_CLIENTS_MARITAL_STATUS]

FROM [TBL_DATA]

GROUP BY
       [NUMBER_CLIENTS]
      ,[MARITAL_STATUS]

ORDER BY 
        [NUMBER_CLIENTS] DESC
       ,([NUMBER_CLIENTS] * 100)/(@NUMBER_CLIENTS) DESC

-- 2 clientes -> YOLO -> 0,0892857142857143% -> 1%
-- 3 clientes -> Alone -> 0,1339285714285714% -> 1%
-- 2 clientes -> Absurd -> 0,0892857142857143% -> 1%
-- 77 clientes -> Window -> 3.4375% -> 3%
-- 232 clientes -> Divorced -> 10,357142857142858% -> 10%
-- 480 clientes -> Single -> 21,428571428571427% -> 21%
-- 580 clientes -> Together -> 25,892857142857142% -> 26%
-- 864 clientes -> Married -> 38,57142857142857% -> 39%

--------------------------------------------------------------------------------------------------------------------------------------

-- Quantidade de clientes pelo nível de educação e estado civil.
DECLARE @NUMBER_CLIENTS FLOAT = (SELECT COUNT([ID]) FROM [MARKETING].[MARKETING_ANALISE_CAMPANHA].[TBL_DADOS_CAMPANHA_VW]);

WITH [TBL_DATA]
AS
(
SELECT 
      COUNT([ID]) AS [NUMBER_CLIENTS]
     ,[EDUCATION]
     ,[MARITAL_STATUS]

FROM [MARKETING].[MARKETING_ANALISE_CAMPANHA].[TBL_DADOS_CAMPANHA_VW]

GROUP BY
       [EDUCATION]
      ,[MARITAL_STATUS]
)
SELECT 
      [NUMBER_CLIENTS]
     ,[EDUCATION]
     ,[MARITAL_STATUS]
     ,ROUND(([NUMBER_CLIENTS] * 100)/(@NUMBER_CLIENTS),2) AS [PERCENT_EDUCATION_MARITAL_STATUS]

FROM [TBL_DATA]

GROUP BY
       [NUMBER_CLIENTS]
      ,[EDUCATION]
      ,[MARITAL_STATUS]

ORDER BY 
         [NUMBER_CLIENTS] DESC
       ,([NUMBER_CLIENTS] * 100)/(@NUMBER_CLIENTS) DESC

-- 1 cliente -> Basic -> Divorced -> 0,0446428571428571% -> 1%
-- 1 cliente -> Basic -> Widow -> 0,0446428571428571% -> 1%
-- 1 cliente -> Graduation -> Absurd -> 0,0446428571428571% -> 1%
-- 1 cliente -> Graduation -> Alone -> 0,0446428571428571% -> 1%
-- 1 cliente -> Master -> Absurd -> 0,0446428571428571% -> 1%
-- 1 cliente -> Master -> Alone -> 0,0446428571428571% -> 1%
-- 1 cliente -> PhD -> Alone -> 0,0446428571428571% -> 1%
-- 2 cliente -> PhD -> YOLO -> 0,0892857142857143% -> 1%
-- 5 cliente -> 2n Cycle -> Widow -> 0,2232142857142857% -> 1%
-- 12 cliente -> Master -> Widow -> 0,5357142857142857 -> 1%
-- 14 cliente -> Basic -> Together -> 0,625 -> 1%
-- 18 cliente -> Basic -> Single -> 0,8035714285714286 -> 1%
-- 20 cliente -> Basic -> Married -> 0,8928571428571429 -> 1%
-- 23 cliente -> 2n Cycle -> Divorced -> 0,1034126163391934% -> 1%
-- 24 cliente -> PhD -> Widow -> 1,0714285714285714% -> 1%
-- 35 cliente -> Graduation -> Widow-> 1,5625% -> 1%
-- 37 cliente -> 2n Cycle -> Single -> 1,6517857142857142% -> 1%
-- 37 cliente -> Master -> Divorced -> 1,6517857142857142% -> 1%
-- 52 cliente -> PhD -> Divorced -> 2,3214285714285716% -> 2%
-- 57 cliente -> 2n Cycle -> Together -> 2,544642857142857% -> 2%
-- 75 cliente -> Master -> Single -> 3,3482142857142856% -> 3%
-- 81 cliente -> 2n Cycle -> Married -> 3,6160714285714284% -> 3%
-- 98 cliente -> PhD -> Single -> 4,375% -> 4%
-- 106 cliente -> Master -> Together -> 4,732142857142857% -> 4%
-- 117 cliente -> PhD -> Together -> 5,223214285714286% -> 5%
-- 119 cliente -> Graduation -> Divorced -> 5,3125% -> 5%
-- 138 cliente -> Master -> Married -> 6,160714285714286% -> 6%
-- 192 cliente -> PhD -> Married -> 8,571428571428571% -> 8%
-- 252 cliente -> Graduation -> Single -> 11,25% -> 11%
-- 286 cliente -> Graduation -> Together -> 12,767857142857142% -> 12%
-- 433 cliente -> Graduation -> Married -> 19,330357142857142% -> 19%

--------------------------------------------------------------------------------------------------------------------------------------

-- Renda média mensal familiar dos clientes.
SELECT ROUND(AVG([MONTHLY_INCOME]),0) AS [AVERAGE_MONTHLY_INCOME] FROM [MARKETING].[MARKETING_ANALISE_CAMPANHA].[TBL_DADOS_CAMPANHA_VW];

-- 4.307.
--------------------------------------------------------------------------------------------------------------------------------------

--Renda média anual familiar dos clientes.
SELECT ROUND(AVG([INCOME]),0) AS [AVERAGE_INCOME] FROM [MARKETING].[MARKETING_ANALISE_CAMPANHA].[TBL_DADOS_CAMPANHA_VW];

-- 51.687.
--------------------------------------------------------------------------------------------------------------------------------------

-- Quantitade total de crianças, adoslecentes e a soma com total geral das duas categorias.
WITH [TBL_DATA] AS
(
SELECT
      SUM([KIDHOME]) AS [NUMBER_KIDHOME]
     ,SUM([TEENHOME]) AS [NUMBER_TEENHOME]

FROM [MARKETING].[MARKETING_ANALISE_CAMPANHA].[TBL_DADOS_CAMPANHA_VW]
)
SELECT
      [NUMBER_KIDHOME]
     ,[NUMBER_TEENHOME]
     ,[NUMBER_KIDHOME] + [NUMBER_TEENHOME] AS [TOTAL]

FROM [TBL_DATA]

-- 995 crianças.
-- 1.134 adoslecentes.
-- 2.129 na soma total de crianças e adolescentes.

--------------------------------------------------------------------------------------------------------------------------------------

-- Quantidade de clientes que não possuem crianças e adoslecentes.
-- Quantidade de clientes que possuem crianças e adoslecentes.
-- Quantidade de clientes que possuem crianças e não adoslecentes.
-- Quantidade de clientes que não possuem crianças e possuem adoslecentes.
DECLARE @NUMBER_CLIENTS FLOAT = (SELECT COUNT([ID]) FROM [MARKETING].[MARKETING_ANALISE_CAMPANHA].[TBL_DADOS_CAMPANHA_VW]);

SELECT
      COUNT([ID]) AS [NUMBER_CLIENTS]
     ,ROUND((COUNT([ID]) * 100)/(@NUMBER_CLIENTS),2) AS [PERCENT_CLIENTES_KID_TEEN]
     ,
     CASE
     WHEN COUNT([ID]) NOT IN ('') THEN 'NOT KID AND TEEN'
     END AS [NOTE]

FROM [MARKETING].[MARKETING_ANALISE_CAMPANHA].[TBL_DADOS_CAMPANHA_VW]

WHERE [KIDHOME] IN (0) AND [TEENHOME] IN (0)

UNION ALL

SELECT
      COUNT([ID]) AS [NUMBER_CLIENTS]
     ,ROUND((COUNT([ID]) * 100)/(@NUMBER_CLIENTS),2) AS [PERCENT_CLIENTES_KID_TEEN]
     ,
     CASE
     WHEN COUNT([ID]) NOT IN ('') THEN 'YES KID AND TEEN'
     END AS [NOTE]

FROM [MARKETING].[MARKETING_ANALISE_CAMPANHA].[TBL_DADOS_CAMPANHA_VW]

WHERE [KIDHOME] > 0 AND [TEENHOME] > 0

UNION ALL

SELECT
      COUNT([ID]) AS [NUMBER_CLIENTS]
     ,ROUND((COUNT([ID]) * 100)/(@NUMBER_CLIENTS),2) AS [PERCENT_CLIENTES_KID_TEEN]
     ,
     CASE
     WHEN COUNT([ID]) NOT IN ('') THEN 'YES KID AND NOT TEEN'
     END AS [NOTE]

FROM [MARKETING].[MARKETING_ANALISE_CAMPANHA].[TBL_DADOS_CAMPANHA_VW]

WHERE [KIDHOME] > 0 AND [TEENHOME] = 0

UNION ALL

SELECT
      COUNT([ID]) AS [NUMBER_CLIENTS]
     ,ROUND((COUNT([ID]) * 100)/(@NUMBER_CLIENTS),2) AS [PERCENT_CLIENTES_KID_TEEN]
     ,
     CASE
     WHEN COUNT([ID]) NOT IN ('') THEN 'NOT KID AND YES TEEN'
     END AS [NOTE]

FROM [MARKETING].[MARKETING_ANALISE_CAMPANHA].[TBL_DADOS_CAMPANHA_VW]

WHERE [KIDHOME] = 0 AND [TEENHOME] > 0

ORDER BY 
        COUNT([ID]) DESC
       ,ROUND((COUNT([ID]) * 100)/(@NUMBER_CLIENTS),2) DESC

-- Não possuem crianças e adoslecentes -> 638 -> 28,482142857142858% -> 28%
-- Possuem crianças e adoslecentes -> 427 -> 19,0625% -> 19%
-- Possuem crianças e não possuem adoslecentes -> 520 -> 23,214285714285715% -> 23%
-- Não possuem crianças e possuem adoslecentes -> 655 -> 29,241071428571427% -> 29%

--------------------------------------------------------------------------------------------------------------------------------------

-- Quantidade de clientes pelo tempo de registro na empresa (em anos).
DECLARE @NUMBER_CLIENTS FLOAT = (SELECT COUNT([ID]) FROM [MARKETING].[MARKETING_ANALISE_CAMPANHA].[TBL_DADOS_CAMPANHA_VW]);

SELECT 
      COUNT([ID]) AS [NUMBER_CLIENTS]
     ,[REGISTERED_CUSTOMER_TIME]
     ,ROUND((COUNT([ID]) * 100)/(@NUMBER_CLIENTS),2) AS [PERCENT_CLIENTS_REGISTERED]

FROM [MARKETING].[MARKETING_ANALISE_CAMPANHA].[TBL_DADOS_CAMPANHA_VW]

GROUP BY
	[REGISTERED_CUSTOMER_TIME]

ORDER BY
	COUNT([ID]) DESC
	,ROUND((COUNT([ID]) * 100)/(@NUMBER_CLIENTS),2) DESC

-- 557 clientes -> 7 anos -> 24,866071428571427% -> 24%
-- 1.189 clientes -> 8 anos -> 53,080357142857146 -> 53%
-- 494 clientes -> 9 anos -> 22,053571428571427 -> 22%

--------------------------------------------------------------------------------------------------------------------------------------

-- Média do tempo (em dias) que um cliente passa sem comprar desde a última compra.
SELECT ROUND(AVG([RECENCY]),0) AS [AVG_RECENCY] FROM [MARKETING].[MARKETING_ANALISE_CAMPANHA].[TBL_DADOS_CAMPANHA_VW];

-- 49 dias.

--------------------------------------------------------------------------------------------------------------------------------------

-- Total de produtos vendidos agrupados.
WITH [TBL_DATA]
AS
(
SELECT 
      SUM([MNT_WINES]) AS [NUMBERS_PRODUCTS]

FROM [MARKETING].[MARKETING_ANALISE_CAMPANHA].[TBL_DADOS_CAMPANHA_VW]

UNION ALL

SELECT 
      SUM([MNT_FRUITS]) AS [NUMBERS_PRODUCTS]

FROM [MARKETING].[MARKETING_ANALISE_CAMPANHA].[TBL_DADOS_CAMPANHA_VW]

UNION ALL

SELECT 
      SUM([MNT_MEAT_PRODUCTS]) AS [NUMBERS_PRODUCTS]

FROM [MARKETING].[MARKETING_ANALISE_CAMPANHA].[TBL_DADOS_CAMPANHA_VW]

UNION ALL

SELECT 
      SUM([MNT_FISH_PRODUCTS]) AS [NUMBERS_PRODUCTS]

FROM [MARKETING].[MARKETING_ANALISE_CAMPANHA].[TBL_DADOS_CAMPANHA_VW]

UNION ALL

SELECT 
      SUM([MNT_SWEET_PRODUCTS]) AS [NUMBERS_PRODUCTS]

FROM [MARKETING].[MARKETING_ANALISE_CAMPANHA].[TBL_DADOS_CAMPANHA_VW]

UNION ALL

SELECT 
      SUM([MNT_GOLD_PRODS]) AS [NUMBERS_PRODUCTS]

FROM [MARKETING].[MARKETING_ANALISE_CAMPANHA].[TBL_DADOS_CAMPANHA_VW]
)
SELECT
      SUM([NUMBERS_PRODUCTS]) AS [TOTAL_SALES_PRODUCTS]

FROM [TBL_DATA]

-- 1.356.988 de produtos vendidos.

--------------------------------------------------------------------------------------------------------------------------------------

-- Produtos mais vendidos e menos vendidos.
DECLARE @SUM_GENERAL_PRODUCTS FLOAT = 1356988;

WITH [TBL_DATA]
AS
(
SELECT 
      SUM([MNT_WINES]) AS [NUMBERS_PRODUCTS]
      ,
      CASE
      WHEN SUM([MNT_WINES]) NOT IN ('') THEN 'MNT_WINES'
      END AS [TYPE_PRODUCT]

FROM [MARKETING].[MARKETING_ANALISE_CAMPANHA].[TBL_DADOS_CAMPANHA_VW]

UNION ALL

SELECT 
      SUM([MNT_FRUITS]) AS [NUMBERS_PRODUCTS]
     ,
     CASE
     WHEN SUM([MNT_FRUITS]) NOT IN ('') THEN 'MNT_FRUITS'
     END AS [TYPE_PRODUCT]

FROM [MARKETING].[MARKETING_ANALISE_CAMPANHA].[TBL_DADOS_CAMPANHA_VW]

UNION ALL

SELECT 
      SUM([MNT_MEAT_PRODUCTS]) AS [NUMBERS_PRODUCTS]
     ,
     CASE
     WHEN SUM([MNT_FRUITS]) NOT IN ('') THEN 'MNT_MEAT_PRODUCTS'
     END AS [TYPE_PRODUCT]

FROM [MARKETING].[MARKETING_ANALISE_CAMPANHA].[TBL_DADOS_CAMPANHA_VW]

UNION ALL

SELECT 
      SUM([MNT_FISH_PRODUCTS]) AS [NUMBERS_PRODUCTS]
     ,
     CASE
     WHEN SUM([MNT_FISH_PRODUCTS]) NOT IN ('') THEN 'MNT_FISH_PRODUCTS'
     END AS [TYPE_PRODUCT]

FROM [MARKETING].[MARKETING_ANALISE_CAMPANHA].[TBL_DADOS_CAMPANHA_VW]

UNION ALL

SELECT 
      SUM([MNT_SWEET_PRODUCTS]) AS [NUMBERS_PRODUCTS]
      ,
      CASE
      WHEN SUM([MNT_SWEET_PRODUCTS]) NOT IN ('') THEN 'MNT_SWEET_PRODUCTS'
      END AS [TYPE_PRODUCT]

FROM [MARKETING].[MARKETING_ANALISE_CAMPANHA].[TBL_DADOS_CAMPANHA_VW]

UNION ALL

SELECT 
      SUM([MNT_GOLD_PRODS]) AS [NUMBERS_PRODUCTS]
      ,
      CASE
      WHEN SUM([MNT_GOLD_PRODS]) NOT IN ('') THEN 'MNT_GOLD_PRODS'
      END AS [TYPE_PRODUCT]

FROM [MARKETING].[MARKETING_ANALISE_CAMPANHA].[TBL_DADOS_CAMPANHA_VW]
)
SELECT
      [NUMBERS_PRODUCTS]
      ,[TYPE_PRODUCT]
      ,ROUND(([NUMBERS_PRODUCTS] * 100)/(@SUM_GENERAL_PRODUCTS),2) AS [PERCENT_NUMBERS_PRODS_TYPE_PRODS]

FROM [TBL_DATA]

ORDER BY
        [NUMBERS_PRODUCTS] DESC
       ,([NUMBERS_PRODUCTS] * 100)/(@SUM_GENERAL_PRODUCTS) DESC

-- MNT_FRUITS -> 58.917 -> 4,341748047882517 -> 4%
-- MNT_SWEET_PRODUCTS -> 60.621 -> 4,467320271070931 -> 4%
-- MNT_FISH_PRODUCTS -> 84.057 -> 6,19438049562708 -> 6%
-- MNT_GOLD_PRODS -> 98.609 -> 7,26675549083706 -> 7%
-- MNT_MEAT_PRODUCTS -> 373.968 -> 27,558681432702425 -> 27%
-- MNT_WINES -> 680.816 -> 50,171114261879985 -> 50%

--------------------------------------------------------------------------------------------------------------------------------------

-- Quantidade de clientes que compraram com desconto.
-- Quantidade de clientes que não usaram ou tiveram desconto.
DECLARE @NUMBER_CLIENTS FLOAT = (SELECT COUNT([ID]) FROM [MARKETING].[MARKETING_ANALISE_CAMPANHA].[TBL_DADOS_CAMPANHA_VW]);

SELECT 
      COUNT([ID]) AS [NUMBER_CLIENTS]
     ,ROUND((COUNT([ID]) * 100)/(@NUMBER_CLIENTS),2) AS [PERCENT_CLIENTES_DISCOUNT]
     ,
     CASE
     WHEN COUNT([ID]) NOT IN ('') THEN 'bought at a discount'
     END AS [NOTE]

FROM [MARKETING].[MARKETING_ANALISE_CAMPANHA].[TBL_DADOS_CAMPANHA_VW]

WHERE [NUM_DEALS_PURCHASES] > 0

UNION ALL

SELECT 
      COUNT([ID]) AS [NUMBER_CLIENTS]
     ,ROUND((COUNT([ID]) * 100)/(@NUMBER_CLIENTS),2) AS [PERCENT_CLIENTES_DISCOUNT]
     ,
     CASE
     WHEN COUNT([ID]) NOT IN ('') THEN 'dont buy with a discount'
     END AS [NOTE]

FROM [MARKETING].[MARKETING_ANALISE_CAMPANHA].[TBL_DADOS_CAMPANHA_VW]

WHERE [NUM_DEALS_PURCHASES] = 0

ORDER BY
        [NUMBER_CLIENTS] DESC
       ,ROUND((COUNT([ID]) * 100)/(@NUMBER_CLIENTS),2) DESC

-- 2194 clientes -> 97,94642857142857% -> 97% -> Clientes que compraram com desconto.
-- 46 clientes -> 2,0535714285714284 -> 2% -> Clientes que não usaram ou tiveram desconto

--------------------------------------------------------------------------------------------------------------------------------------

-- Média de compras com desconto.
SELECT ROUND(AVG([NUM_DEALS_PURCHASES]),0) AS [AVG_NUM_DEALS_PURCHASES] FROM [MARKETING].[MARKETING_ANALISE_CAMPANHA].[TBL_DADOS_CAMPANHA_VW] WHERE [NUM_DEALS_PURCHASES] > 0;

-- 2.
-- Cada cliente, dos que compraram com desconto, teria uma média de 2 compras por desconto recebido/utilizado. 

--------------------------------------------------------------------------------------------------------------------------------------

-- Quantidade de clientes pelo número de vezes que ele comprou com desconto.
DECLARE @NUMBER_CLIENTS FLOAT = (SELECT COUNT([ID]) FROM [MARKETING].[MARKETING_ANALISE_CAMPANHA].[TBL_DADOS_CAMPANHA_VW] WHERE [NUM_DEALS_PURCHASES] > 0);

SELECT 
      COUNT([ID]) AS [NUMBER_CLIENTS]
     ,[NUM_DEALS_PURCHASES]
     ,ROUND((COUNT([ID]) * 100)/(@NUMBER_CLIENTS),2) AS [PERCENT_CLIENTS_NUM_DEALS_PURCHASES]

FROM [MARKETING].[MARKETING_ANALISE_CAMPANHA].[TBL_DADOS_CAMPANHA_VW]

WHERE [NUM_DEALS_PURCHASES] > 0

GROUP BY
       [NUM_DEALS_PURCHASES]

ORDER BY
       COUNT([ID]) DESC
      ,(COUNT([ID]) * 100)/(@NUMBER_CLIENTS) DESC

--  3 clientes -> 13 compras com desconto - Equivalente a (dos 2194 clientes que já compraram com desconto): 0,1367365542388332% -> 1%
--  4 clientes -> 12 compras com desconto - Equivalente a (dos 2194 clientes que já compraram com desconto): 0,1823154056517776% -> 1%
--  5 clientes -> 10 compras com desconto - Equivalente a (dos 2194 clientes que já compraram com desconto): 0,227894257064722%  -> 1%
--  5 clientes -> 11 compras com desconto - Equivalente a (dos 2194 clientes que já compraram com desconto): 0,227894257064722%  -> 1%
--  7 clientes -> 15 compras com desconto - Equivalente a (dos 2194 clientes que já compraram com desconto): 0,3190519598906107% -> 1%
--  8 clientes ->  9 compras com desconto - Equivalente a (dos 2194 clientes que já compraram com desconto): 0,3646308113035551% -> 1%
--  14 clientes -> 8 compras com desconto - Equivalente a (dos 2194 clientes que já compraram com desconto): 0,6381039197812215% -> 1%
--  40 clientes -> 7 compras com desconto - Equivalente a (dos 2194 clientes que já compraram com desconto): 1,8231540565177757% -> 1%
--  61 clientes -> 6 compras com desconto - Equivalente a (dos 2194 clientes que já compraram com desconto): 2,780309936189608% -> 2%
--  94 clientes -> 5 compras com desconto - Equivalente a (dos 2194 clientes que já compraram com desconto): 4,284412032816773% -> 4%
--  189 clientes -> 4 compras com desconto - Equivalente a (dos 2194 clientes que já compraram com desconto): 8,61440291704649% -> 8%
--  297 clientes -> 3 compras com desconto - Equivalente a (dos 2194 clientes que já compraram com desconto): 13,536918869644484% -> 13%
--  497 clientes -> 2 compras com desconto - Equivalente a (dos 2194 clientes que já compraram com desconto): 22,652689152233364% -> 22%
--  970 clientes -> 1 compra com desconto - Equivalente a (dos 2194 clientes que já compraram com desconto): 44,21148587055606% -> 44%

--------------------------------------------------------------------------------------------------------------------------------------

-- Quantidade total de descontos utilizados pelos clientes.
SELECT SUM([NUM_DEALS_PURCHASES]) AS [NUM_GENERAL_DEALS_PURCHASES] FROM [MARKETING].[MARKETING_ANALISE_CAMPANHA].[TBL_DADOS_CAMPANHA_VW];

-- 5.208 descontos.

--------------------------------------------------------------------------------------------------------------------------------------

-- Quantidade de clientes que compraram pelo site.
-- Quantidade de clientes que não compraram pelo site.
DECLARE @NUMBER_CLIENTS FLOAT = (SELECT COUNT([ID]) FROM [MARKETING].[MARKETING_ANALISE_CAMPANHA].[TBL_DADOS_CAMPANHA_VW]);

SELECT 
      COUNT([ID]) AS [NUMBER_CLIENTS]
      ,ROUND((COUNT([ID]) * 100)/(@NUMBER_CLIENTS),2) AS [PERCENT_CLIENTS_NUM_WEB_PURCHASES]
      ,
      CASE
      WHEN COUNT([ID]) NOT IN ('') THEN 'bought on the site'
      END AS [NOTE]

FROM [MARKETING].[MARKETING_ANALISE_CAMPANHA].[TBL_DADOS_CAMPANHA_VW]

WHERE [NUM_WEB_PURCHASES] > 0

UNION ALL

SELECT 
      COUNT([ID]) AS [NUMBER_CLIENTS]
     ,ROUND((COUNT([ID]) * 100)/(@NUMBER_CLIENTS),2) AS [PERCENT_CLIENTS_NUM_WEB_PURCHASES]
     ,
     CASE
     WHEN COUNT([ID]) NOT IN ('') THEN 'dont buy on the site'
     END AS [NOTE]

FROM [MARKETING].[MARKETING_ANALISE_CAMPANHA].[TBL_DADOS_CAMPANHA_VW]

WHERE [NUM_WEB_PURCHASES] = 0

ORDER BY
        [NUMBER_CLIENTS] DESC
       ,ROUND((COUNT([ID]) * 100)/(@NUMBER_CLIENTS),2) DESC

-- 2191 clientes -> 97,8125% -> 97% -> Clientes que compraram pelo site.
-- 49 clientes -> 2,0081967213114753% -> 2% -> Clientes que não compraram pelo site.

--------------------------------------------------------------------------------------------------------------------------------------

-- Quantidade de clientes pelo número de vezes que ele comprou pelo site.
DECLARE @NUMBER_CLIENTS FLOAT = (SELECT COUNT([ID]) FROM [MARKETING].[MARKETING_ANALISE_CAMPANHA].[TBL_DADOS_CAMPANHA_VW] WHERE [NUM_WEB_PURCHASES] > 0);

SELECT 
      COUNT([ID]) AS [NUMBER_CLIENTS]
     ,[NUM_WEB_PURCHASES]
     ,ROUND((COUNT([ID]) * 100)/(@NUMBER_CLIENTS),2) AS [PERCENT_CLIENTS_NUM_WEB_PURCHASES]

FROM [MARKETING].[MARKETING_ANALISE_CAMPANHA].[TBL_DADOS_CAMPANHA_VW]

WHERE [NUM_WEB_PURCHASES] > 0

GROUP BY
	[NUM_WEB_PURCHASES]

ORDER BY
	COUNT([ID]) DESC
       ,ROUND((COUNT([ID]) * 100)/(@NUMBER_CLIENTS),2) DESC

--  1 clientes -> 23 compras pelo site - Equivalente a (dos 2191 clientes que já compraram pelo site): 0,0456412596987677% -> 1%
--  1 clientes -> 25 compras pelo site - Equivalente a (dos 2191 clientes que já compraram pelo site): 0,0456412596987677% -> 1%
--  2 clientes -> 23 compras pelo site - Equivalente a (dos 2191 clientes que já compraram pelo site): 0,0912825193975354% -> 1%
--  43 clientes -> 23 compras pelo site - Equivalente a (dos 2191 clientes que já compraram pelo site): 1,9625741670470105% -> 1%
--  44 clientes -> 23 compras pelo site - Equivalente a (dos 2191 clientes que já compraram pelo site): 2,008215426745778% -> 2%
--  75 clientes -> 23 compras pelo site - Equivalente a (dos 2191 clientes que já compraram pelo site): 3,4230944774075764% -> 3%
--  102 clientes -> 23 compras pelo site - Equivalente a (dos 2191 clientes que já compraram pelo site): 4,655408489274304% -> 4%
--  155 clientes -> 23 compras pelo site - Equivalente a (dos 2191 clientes que já compraram pelo site): 7,0743952533089915% -> 7%
--  205 clientes -> 23 compras pelo site - Equivalente a (dos 2191 clientes que já compraram pelo site): 9,356458238247376% -> 9%
--  220 clientes -> 23 compras pelo site - Equivalente a (dos 2191 clientes que já compraram pelo site): 10,04107713372889% -> 10%
--  280 clientes -> 23 compras pelo site - Equivalente a (dos 2191 clientes que já compraram pelo site): 12,779552715654953% -> 12%
--  336 clientes -> 23 compras pelo site - Equivalente a (dos 2191 clientes que já compraram pelo site): 15,335463258785943% -> 15%
--  354 clientes -> 23 compras pelo site - Equivalente a (dos 2191 clientes que já compraram pelo site): 16,15700593336376% -> 16%
--  373 clientes -> 23 compras pelo site - Equivalente a (dos 2191 clientes que já compraram pelo site): 17,024189867640345% -> 17%

--------------------------------------------------------------------------------------------------------------------------------------

-- Quantidade total de compras pelo site.
SELECT SUM([NUM_WEB_PURCHASES]) AS [SUM_NUM_WEB_PURCHASES] FROM [MARKETING].[MARKETING_ANALISE_CAMPANHA].[TBL_DADOS_CAMPANHA_VW];

-- 9.150 de compras pelo site.

--------------------------------------------------------------------------------------------------------------------------------------

-- Quantidade de clientes que compraram pelo catálogo.
-- Quantidade de clientes que não compraram pelo catálogo.
DECLARE @NUMBER_CLIENTS FLOAT = (SELECT COUNT([ID]) FROM [MARKETING].[MARKETING_ANALISE_CAMPANHA].[TBL_DADOS_CAMPANHA_VW]);

SELECT 
      COUNT([ID]) AS [NUMBER_CLIENTS]
     ,ROUND((COUNT([ID]) * 100)/(@NUMBER_CLIENTS),2) AS [PERCENT_CLIENTS_NUM_CATALOG_PURCHASES]
     ,
     CASE
     WHEN COUNT([ID]) NOT IN ('') THEN 'bought from the catalog.'
     END AS [NOTE]

FROM [MARKETING].[MARKETING_ANALISE_CAMPANHA].[TBL_DADOS_CAMPANHA_VW]

WHERE [NUM_CATALOG_PURCHASES] > 0

UNION ALL

SELECT 
      COUNT([ID]) AS [NUMBER_CLIENTS]
     ,ROUND((COUNT([ID]) * 100)/(@NUMBER_CLIENTS),2) AS [PERCENT_CLIENTS_NUM_CATALOG_PURCHASES]
     ,
     CASE
     WHEN COUNT([ID]) NOT IN ('') THEN 'they dont buy from the catalog.'
     END AS [NOTE]

FROM [MARKETING].[MARKETING_ANALISE_CAMPANHA].[TBL_DADOS_CAMPANHA_VW]

WHERE [NUM_CATALOG_PURCHASES] = 0

ORDER BY
        COUNT([ID]) DESC
       ,ROUND((COUNT([ID]) * 100)/(@NUMBER_CLIENTS),2) DESC

-- 1654 clientes -> 73,83928571428571% -> 73% -> Clientes que compraram pelo catálogo.
-- 586 clientes -> 26,160714285714285% -> 26% -> Clientes que não compraram pelo catálogo.

--------------------------------------------------------------------------------------------------------------------------------------

-- Quantidade de clientes pelo número de vezes que ele comprou pelo catálogo.
DECLARE @NUMBER_CLIENTS FLOAT = (SELECT COUNT([ID]) FROM [MARKETING].[MARKETING_ANALISE_CAMPANHA].[TBL_DADOS_CAMPANHA_VW] WHERE [NUM_CATALOG_PURCHASES] > 0);

SELECT 
      COUNT([ID]) AS [NUMBER_CLIENTS]
     ,[NUM_CATALOG_PURCHASES]
     ,ROUND((COUNT([ID]) * 100)/(@NUMBER_CLIENTS),2) AS [PERCENT_CLIENTS_NUM_CATALOGO_PURCHASES]

FROM [MARKETING].[MARKETING_ANALISE_CAMPANHA].[TBL_DADOS_CAMPANHA_VW]

WHERE [NUM_CATALOG_PURCHASES] > 0

GROUP BY
	[NUM_CATALOG_PURCHASES]

ORDER BY
	COUNT([ID]) DESC
       ,ROUND((COUNT([ID]) * 100)/(@NUMBER_CLIENTS),2) DESC

--  1 clientes -> 22 compras pelo catálogo - Equivalente a (dos 1654 clientes que já compraram pelo catálogo): 0,060459492140266% -> 1%
--  3 clientes -> 28 compras pelo catálogo - Equivalente a (dos 1654 clientes que já compraram pelo catálogo): 0,1813784764207981% -> 1%
--  19 clientes -> 11 compras pelo catálogo - Equivalente a (dos 1654 clientes que já compraram pelo catálogo): 1,1487303506650544% -> 1%
--  42 clientes -> 9 compras pelo catálogo - Equivalente a (dos 1654 clientes que já compraram pelo catálogo): 2,539298669891173% -> 2%
--  48 clientes -> 10 compras pelo catálogo - Equivalente a (dos 1654 clientes que já compraram pelo catálogo): 2,902055622732769% -> 2%
--  55 clientes -> 8 compras pelo catálogo - Equivalente a (dos 1654 clientes que já compraram pelo catálogo): 3,3252720677146312% -> 3%
--  79 clientes -> 7 compras pelo catálogo - Equivalente a (dos 1654 clientes que já compraram pelo catálogo): 4,776299879081016% -> 4%
--  128 clientes -> 6 compras pelo catálogo - Equivalente a (dos 1654 clientes que já compraram pelo catálogo): 7,738814993954051% -> 7%
--  140 clientes -> 5 compras pelo catálogo - Equivalente a (dos 1654 clientes que já compraram pelo catálogo): 8,464328899637243% -> 8%
--  182 clientes -> 4 compras pelo catálogo - Equivalente a (dos 1654 clientes que já compraram pelo catálogo): 11,003627569528415% -> 11%
--  184 clientes -> 3 compras pelo catálogo - Equivalente a (dos 1654 clientes que já compraram pelo catálogo): 11,124546553808948% -> 11%
--  276 clientes -> 2 compras pelo catálogo - Equivalente a (dos 1654 clientes que já compraram pelo catálogo): 16,68681983071342% -> 16%
--  497 clientes -> 1 compras pelo catálogo - Equivalente a (dos 1654 clientes que já compraram pelo catálogo): 30,048367593712214% -> 30%

--------------------------------------------------------------------------------------------------------------------------------------

-- Quantidade total de compras pelo catálogo.
SELECT SUM([NUM_CATALOG_PURCHASES]) AS [SUM_NUM_CATALOG_PURCHASES] FROM [MARKETING].[MARKETING_ANALISE_CAMPANHA].[TBL_DADOS_CAMPANHA_VW];

-- 5.963 compras pelo catálogo.
Quantidade de clientes que compraram na loja.
Quantidade de clientes que não compraram na loja.
DECLARE @NUMBER_CLIENTS FLOAT = (SELECT COUNT([ID]) FROM [MARKETING].[MARKETING_ANALISE_CAMPANHA].[TBL_DADOS_CAMPANHA_VW]);

SELECT 
      COUNT([ID]) AS [NUMBER_CLIENTS]
     ,ROUND((COUNT([ID]) * 100)/(@NUMBER_CLIENTS),2) AS [PERCENT_CLIENTS_NUM_STORE_PURCHASES]
     ,
     CASE
     WHEN COUNT([ID]) NOT IN ('') THEN 'bought by the store.'
     END AS [NOTE]

FROM [MARKETING].[MARKETING_ANALISE_CAMPANHA].[TBL_DADOS_CAMPANHA_VW]

WHERE [NUM_STORE_PURCHASES] > 0

UNION ALL

SELECT 
      COUNT([ID]) AS [NUMBER_CLIENTS]
     ,ROUND((COUNT([ID]) * 100)/(@NUMBER_CLIENTS),2) AS [PERCENT_CLIENTS_NUM_STORE_PURCHASES]
     ,
     CASE
     WHEN COUNT([ID]) NOT IN ('') THEN 'not bought by the store.'
     END AS [NOTE]

FROM [MARKETING].[MARKETING_ANALISE_CAMPANHA].[TBL_DADOS_CAMPANHA_VW]

WHERE [NUM_STORE_PURCHASES] = 0

ORDER BY
        COUNT([ID]) DESC
       ,ROUND((COUNT([ID]) * 100)/(@NUMBER_CLIENTS),2) DESC

-- 2225 clientes -> 99,33035714285714% -> 99% -> Clientes que compraram na loja.
-- 15 clientes -> 0,6696428571428571% -> 1% -> Clientes que não compraram na loja.

--------------------------------------------------------------------------------------------------------------------------------------

-- Quantidade de clientes pelo número de vezes que ele comprou na loja.
DECLARE @NUMBER_CLIENTS FLOAT = (SELECT COUNT([ID]) FROM [MARKETING].[MARKETING_ANALISE_CAMPANHA].[TBL_DADOS_CAMPANHA_VW] WHERE [NUM_STORE_PURCHASES] > 0);

SELECT 
      COUNT([ID]) AS [NUMBER_CLIENTS]
     ,[NUM_STORE_PURCHASES]
     ,ROUND((COUNT([ID]) * 100)/(@NUMBER_CLIENTS),2) AS [PERCENT_CLIENTS_NUM_STORE_PURCHASES]

FROM [MARKETING].[MARKETING_ANALISE_CAMPANHA].[TBL_DADOS_CAMPANHA_VW]

WHERE [NUM_STORE_PURCHASES] > 0

GROUP BY
	[NUM_STORE_PURCHASES]

ORDER BY
        COUNT([ID]) DESC
       ,ROUND((COUNT([ID]) * 100)/(@NUMBER_CLIENTS),2) DESC

--  7 clientes -> 1 compras pela loja - Equivalente a (dos 2225 clientes que já compraram pela loja): 0,3146067415730337% -> 1%
--  81 clientes -> 11 compras pela loja - Equivalente a (dos 2225 clientes que já compraram pela loja): 3,640449438202247% -> 3%
--  83 clientes -> 13 compras pela loja - Equivalente a (dos 2225 clientes que já compraram pela loja): 3,730337078651685% -> 3%
--  105 clientes -> 12 compras pela loja - Equivalente a (dos 2225 clientes que já compraram pela loja): 4,719101123595506% -> 4%
--  106 clientes -> 9 compras pela loja - Equivalente a (dos 2225 clientes que já compraram pela loja): 4,764044943820225% -> 4%
--  125 clientes -> 10 compras pela loja - Equivalente a (dos 2225 clientes que já compraram pela loja): 5,617977528089888% -> 5%
--  143 clientes -> 7 compras pela loja - Equivalente a (dos 2225 clientes que já compraram pela loja): 6,426966292134831% -> 6%
--  149 clientes -> 8 compras pela loja - Equivalente a (dos 2225 clientes que já compraram pela loja): 6,696629213483146% -> 6%
--  178 clientes -> 6 compras pela loja - Equivalente a (dos 2225 clientes que já compraram pela loja): 8% -> 8%
--  212 clientes -> 5 compras pela loja - Equivalente a (dos 2225 clientes que já compraram pela loja): 9,52808988764045% -> 9%
--  223 clientes -> 2 compras pela loja - Equivalente a (dos 2225 clientes que já compraram pela loja): 10,02247191011236% -> 10%
--  323 clientes -> 4 compras pela loja - Equivalente a (dos 2225 clientes que já compraram pela loja): 14,51685393258427% -> 14%
--  490 clientes -> 3 compras pela loja - Equivalente a (dos 2225 clientes que já compraram pela loja): 22,02247191011236% -> 22%

--------------------------------------------------------------------------------------------------------------------------------------

-- Quantidade total de compras na loja.
SELECT SUM([NUM_STORE_PURCHASES]) AS [NUM_GENERAL_STORE_PURCHASES] FROM [MARKETING].[MARKETING_ANALISE_CAMPANHA].[TBL_DADOS_CAMPANHA_VW];

-- 12.970 de compras pela loja.

--------------------------------------------------------------------------------------------------------------------------------------

-- Quantidade de clientes que visitaram o site no último mês.
-- Quantidade de clientes que não visitaram o site no último mês.
DECLARE @NUMBER_CLIENTS FLOAT = (SELECT COUNT([ID]) FROM [MARKETING].[MARKETING_ANALISE_CAMPANHA].[TBL_DADOS_CAMPANHA_VW]);

SELECT 
      COUNT([ID]) AS [NUMBER_CLIENTS]
     ,ROUND((COUNT([ID]) * 100)/(@NUMBER_CLIENTS),2) AS [PERCENT_CLIENTS_NUM_WEB_VISITS]
     ,
     CASE
     WHEN COUNT([ID]) NOT IN ('') THEN 'visited the site in the last month.'
     END AS [NOTE]

FROM [MARKETING].[MARKETING_ANALISE_CAMPANHA].[TBL_DADOS_CAMPANHA_VW]

WHERE [NUM_WEB_VISITS_MONTH] > 0

UNION ALL

SELECT 
      COUNT([ID]) AS [NUMBER_CLIENTS]
     ,ROUND((COUNT([ID]) * 100)/(@NUMBER_CLIENTS),2) AS [PERCENT_CLIENTS_NUM_WEB_VISITS]
     ,
     CASE
     WHEN COUNT([ID]) NOT IN ('') THEN 'dont visited the site in the last month.'
     END AS [NOTE]

FROM [MARKETING].[MARKETING_ANALISE_CAMPANHA].[TBL_DADOS_CAMPANHA_VW]

WHERE [NUM_WEB_VISITS_MONTH] = 0

ORDER BY
        COUNT([ID]) DESC
	   ,ROUND((COUNT([ID]) * 100)/(@NUMBER_CLIENTS),2) DESC

-- 2229 clientes -> 99,50892857142857% -> 99% -> Clientes que visitaram o site da loja no último mês.
-- 11 clientes -> 0,4910714285714285% -> 1% -> Clientes que não visitaram o site da loja no último mês

--------------------------------------------------------------------------------------------------------------------------------------

-- Quantidade de clientes pelo número de vezes visitaram o site no último mês.
DECLARE @NUMBER_CLIENTS FLOAT = (SELECT COUNT([ID]) FROM [MARKETING].[MARKETING_ANALISE_CAMPANHA].[TBL_DADOS_CAMPANHA_VW] WHERE [NUM_WEB_VISITS_MONTH] > 0);

SELECT 
      COUNT([ID]) AS [NUMBER_CLIENTS]
     ,[NUM_WEB_VISITS_MONTH]
     ,ROUND((COUNT([ID]) * 100)/(@NUMBER_CLIENTS),2) AS [PERCENT_CLIENTS_NUM_WEB_VISITS_MONTH]

FROM [MARKETING].[MARKETING_ANALISE_CAMPANHA].[TBL_DADOS_CAMPANHA_VW]

WHERE [NUM_WEB_VISITS_MONTH] > 0

GROUP BY
	[NUM_WEB_VISITS_MONTH]

ORDER BY
	COUNT([ID]) DESC
       ,ROUND((COUNT([ID]) * 100)/(@NUMBER_CLIENTS),2) DESC

--  1 clientes -> 13 visitas no site no último mês - Equivalente a (dos 2229 clientes que visitaram o site no último mês): 0,0448631673396142% -> 1%
--  1 clientes -> 17 visitas no site no último mês - Equivalente a (dos 2229 clientes que visitaram o site no último mês): 0,0448631673396142% -> 1%
--  2 clientes -> 14 visitas no site no último mês - Equivalente a (dos 2229 clientes que visitaram o site no último mês): 0,0897263346792284% -> 1%
--  2 clientes -> 19 visitas no site no último mês - Equivalente a (dos 2229 clientes que visitaram o site no último mês): 0,0897263346792284% -> 1%
--  3 clientes -> 10 visitas no site no último mês - Equivalente a (dos 2229 clientes que visitaram o site no último mês): 0,1345895020188425% -> 1%
--  3 clientes -> 20 visitas no site no último mês - Equivalente a (dos 2229 clientes que visitaram o site no último mês): 0,1345895020188425% -> 1%
--  83 clientes -> 9 visitas no site no último mês - Equivalente a (dos 2229 clientes que visitaram o site no último mês): 3,7236428891879765% -> 3%
--  153 clientes -> 1 visitas no site no último mês - Equivalente a (dos 2229 clientes que visitaram o site no último mês): 6,864064602960969% -> 6%
--  202 clientes -> 2 visitas no site no último mês - Equivalente a (dos 2229 clientes que visitaram o site no último mês): 9,062359802602064% -> 9%
--  205 clientes -> 3 visitas no site no último mês - Equivalente a (dos 2229 clientes que visitaram o site no último mês): 9,196949304620906% -> 9%
--  218 clientes -> 4 visitas no site no último mês - Equivalente a (dos 2229 clientes que visitaram o site no último mês): 9,78017048003589% -> 9%
--  281 clientes -> 5 visitas no site no último mês - Equivalente a (dos 2229 clientes que visitaram o site no último mês): 12,606550022431584% -> 12%
--  340 clientes -> 6 visitas no site no último mês - Equivalente a (dos 2229 clientes que visitaram o site no último mês): 15,25347689546882% -> 15%
--  342 clientes -> 8 visitas no site no último mês - Equivalente a (dos 2229 clientes que visitaram o site no último mês): 15,343203230148049% -> 15%
--  393 clientes -> 7 visitas no site no último mês - Equivalente a (dos 2229 clientes que visitaram o site no último mês): 17,63122476446837% -> 17%

--------------------------------------------------------------------------------------------------------------------------------------

-- Quantidade total de visitas no site no último mês.
SELECT SUM([NUM_WEB_VISITS_MONTH]) AS [SUM_NUM_WEB_VISITS_MONTH] FROM [MARKETING].[MARKETING_ANALISE_CAMPANHA].[TBL_DADOS_CAMPANHA_VW];

-- 11.909 de visitas no site no último mês.

--------------------------------------------------------------------------------------------------------------------------------------

-- Quantidade de clientes que aceitaram e não aceitaram a oferta na 1º campanha.
-- Quantidade de clientes que aceitaram e não aceitaram a oferta na 2º campanha.
-- Quantidade de clientes que aceitaram e não aceitaram a oferta na 3º campanha.
-- Quantidade de clientes que aceitaram e não aceitaram a oferta na 4º campanha.
-- Quantidade de clientes que aceitaram e não aceitaram a oferta na 5º campanha.
-- Quantidade de clientes que aceitaram e não aceitaram a oferta na 6º campanha.
DECLARE @NUMBER_CLIENTS FLOAT = (SELECT COUNT([ID]) FROM [MARKETING].[MARKETING_ANALISE_CAMPANHA].[TBL_DADOS_CAMPANHA_VW]);

SELECT 
      COUNT([ID]) AS [NUMBER_CLIENTS]
     ,ROUND((COUNT([ID]) * 100)/(@NUMBER_CLIENTS),2) AS [PERCENT_CLIENTS_CAMPAIGNS]
     ,
     CASE
     WHEN COUNT([ID]) NOT IN ('') THEN '1º - CLIENTS NOT ACCEPTED CMP1'
     END AS [NOTE]
	  
FROM [MARKETING].[MARKETING_ANALISE_CAMPANHA].[TBL_DADOS_CAMPANHA_VW]

WHERE [ACCEPTED_CMP1] = 0

UNION ALL 

SELECT 
      COUNT([ID]) AS [NUMBER_CLIENTS]
     ,ROUND((COUNT([ID]) * 100)/(@NUMBER_CLIENTS),2) AS [PERCENT_CLIENTS_CAMPAIGNS]
     ,
     CASE
     WHEN COUNT([ID]) NOT IN ('') THEN '1º - CLIENTS ACCEPTED CMP1'
     END AS [NOTE]
	  
FROM [MARKETING].[MARKETING_ANALISE_CAMPANHA].[TBL_DADOS_CAMPANHA_VW]

WHERE [ACCEPTED_CMP1] > 0

UNION ALL

SELECT 
      COUNT([ID]) AS [NUMBER_CLIENTS]
     ,ROUND((COUNT([ID]) * 100)/(@NUMBER_CLIENTS),2) AS [PERCENT_CLIENTS_CAMPAIGNS]
     ,
     CASE
     WHEN COUNT([ID]) NOT IN ('') THEN '2º - CLIENTS NOT ACCEPTED CMP2'
     END AS [NOTE]
	  
FROM [MARKETING].[MARKETING_ANALISE_CAMPANHA].[TBL_DADOS_CAMPANHA_VW]

WHERE [ACCEPTED_CMP2] = 0

UNION ALL

SELECT 
      COUNT([ID]) AS [NUMBER_CLIENTS]
    ,ROUND((COUNT([ID]) * 100)/(@NUMBER_CLIENTS),2) AS [PERCENT_CLIENTS_CAMPAIGNS]
    ,
     CASE
     WHEN COUNT([ID]) NOT IN ('') THEN '2º - CLIENTS ACCEPTED CMP2'
     END AS [NOTE]
	  
FROM [MARKETING].[MARKETING_ANALISE_CAMPANHA].[TBL_DADOS_CAMPANHA_VW]

WHERE [ACCEPTED_CMP2] > 0

UNION ALL

SELECT 
      COUNT([ID]) AS [NUMBER_CLIENTS]
     ,ROUND((COUNT([ID]) * 100)/(@NUMBER_CLIENTS),2) AS [PERCENT_CLIENTS_CAMPAIGNS]
     ,
     CASE
     WHEN COUNT([ID]) NOT IN ('') THEN '3º - CLIENTS NOT ACCEPTED CMP3'
     END AS [NOTE]
	  
FROM [MARKETING].[MARKETING_ANALISE_CAMPANHA].[TBL_DADOS_CAMPANHA_VW]

WHERE [ACCEPTED_CMP3] = 0

UNION ALL

SELECT 
      COUNT([ID]) AS [NUMBER_CLIENTS]
     ,ROUND((COUNT([ID]) * 100)/(@NUMBER_CLIENTS),2) AS [PERCENT_CLIENTS_CAMPAIGNS]
     ,
     CASE
     WHEN COUNT([ID]) NOT IN ('') THEN '3º - CLIENTS ACCEPTED CMP3'
     END AS [NOTE]
	  
FROM [MARKETING].[MARKETING_ANALISE_CAMPANHA].[TBL_DADOS_CAMPANHA_VW]

WHERE [ACCEPTED_CMP3] > 0

UNION ALL

SELECT 
      COUNT([ID]) AS [NUMBER_CLIENTS]
     ,ROUND((COUNT([ID]) * 100)/(@NUMBER_CLIENTS),2) AS [PERCENT_CLIENTS_CAMPAIGNS]
     ,
     CASE
     WHEN COUNT([ID]) NOT IN ('') THEN '4º - CLIENTS NOT ACCEPTED CMP4'
     END AS [NOTE]
	  
FROM [MARKETING].[MARKETING_ANALISE_CAMPANHA].[TBL_DADOS_CAMPANHA_VW]

WHERE [ACCEPTED_CMP4] = 0

UNION ALL

SELECT 
      COUNT([ID]) AS [NUMBER_CLIENTS]
     ,ROUND((COUNT([ID]) * 100)/(@NUMBER_CLIENTS),2) AS [PERCENT_CLIENTS_CAMPAIGNS]
     ,
     CASE
     WHEN COUNT([ID]) NOT IN ('') THEN '4º - CLIENTS ACCEPTED CMP4'
     END AS [NOTE]
	  
FROM [MARKETING].[MARKETING_ANALISE_CAMPANHA].[TBL_DADOS_CAMPANHA_VW]

WHERE [ACCEPTED_CMP4] > 0

UNION ALL

SELECT 
      COUNT([ID]) AS [NUMBER_CLIENTS]
     ,ROUND((COUNT([ID]) * 100)/(@NUMBER_CLIENTS),2) AS [PERCENT_CLIENTS_CAMPAIGNS]
     ,
     CASE
     WHEN COUNT([ID]) NOT IN ('') THEN '5º - CLIENTS NOT ACCEPTED CMP5'
     END AS [NOTE]
	  
FROM [MARKETING].[MARKETING_ANALISE_CAMPANHA].[TBL_DADOS_CAMPANHA_VW]

WHERE [ACCEPTED_CMP5] = 0

UNION ALL

SELECT 
      COUNT([ID]) AS [NUMBER_CLIENTS]
     ,ROUND((COUNT([ID]) * 100)/(@NUMBER_CLIENTS),2) AS [PERCENT_CLIENTS_CAMPAIGNS]
     ,
     CASE
     WHEN COUNT([ID]) NOT IN ('') THEN '5º - CLIENTS ACCEPTED CMP5'
     END AS [NOTE]
	  
FROM [MARKETING].[MARKETING_ANALISE_CAMPANHA].[TBL_DADOS_CAMPANHA_VW]

WHERE [ACCEPTED_CMP5] > 0

UNION ALL

SELECT 
      COUNT([ID]) AS [NUMBER_CLIENTS]
     ,ROUND((COUNT([ID]) * 100)/(@NUMBER_CLIENTS),2) AS [PERCENT_CLIENTS_CAMPAIGNS]
     ,
     CASE
     WHEN COUNT([ID]) NOT IN ('') THEN '6º - CLIENTS NOT ACCEPTED (RESPONSE - TARGET)'
     END AS [NOTE]
	  
FROM [MARKETING].[MARKETING_ANALISE_CAMPANHA].[TBL_DADOS_CAMPANHA_VW]

WHERE [RESPONSE] = 0

UNION ALL

SELECT 
      COUNT([ID]) AS [NUMBER_CLIENTS]
     ,ROUND((COUNT([ID]) * 100)/(@NUMBER_CLIENTS),2) AS [PERCENT_CLIENTS_CAMPAIGNS]
     ,
     CASE
     WHEN COUNT([ID]) NOT IN ('') THEN '6º - CLIENTS ACCEPTED (RESPONSE - TARGET)'
     END AS [NOTE]
	  
FROM [MARKETING].[MARKETING_ANALISE_CAMPANHA].[TBL_DADOS_CAMPANHA_VW]

WHERE [RESPONSE] > 0

-- 1º Campanha:
-- 2096 -> 93,57142857142857% -> 93% -> Clientes que não aceitaram a oferta na 1º campanha.
-- 144 -> 6,428571428571429% -> 6% -> Clientes que aceitaram a oferta na 1º campanha.

-- 2º Campanha:
-- 2096 -> 98,66071428571429% -> 98% -> Clientes que não aceitaram a oferta na 2º campanha.
-- 30 -> 1,3392857142857142% -> 1% -> Clientes que aceitaram a oferta na 2º campanha.

-- 3º Campanha:
-- 2077 -> 92,72321428571429% -> 92% -> Clientes que não aceitaram a oferta na 3º campanha.
-- 163 -> 7,276785714285714% -> 7% -> Clientes que aceitaram a oferta na 3º campanha.

-- 4º Campanha:
-- 2073 -> 92,54464285714286% -> 92% -> Clientes que não aceitaram a oferta na 4º campanha.
-- 167 -> 7,455357142857143% -> 7% -> Clientes que aceitaram a oferta na 4º campanha.

-- 5º Campanha:
-- 2077 -> 92,72321428571429% -> 92% -> Clientes que não aceitaram a oferta na 5º campanha.
-- 163 -> 7,276785714285714% -> 7% -> Clientes que aceitaram a oferta na 5º campanha.

-- 6º Campanha (Última):
-- 1906 -> 85,08928571428571% -> 85% -> Clientes que não aceitaram a oferta na 6º Campanha (última).
-- 334 -> 14,910714285714286% -> 14% -> Clientes que aceitaram a oferta na 6º Campanha (última).

--------------------------------------------------------------------------------------------------------------------------------------

-- Média de sucesso da campanha.
DECLARE @NUMBER_CLIENTS FLOAT = (SELECT COUNT([ID]) FROM [MARKETING].[MARKETING_ANALISE_CAMPANHA].[TBL_DADOS_CAMPANHA_VW]);

WITH [TBL_DATA] AS
(
SELECT 
      COUNT([ID]) AS [NUMBER_CLIENTS]
     ,ROUND((COUNT([ID]) * 100)/(@NUMBER_CLIENTS),2) AS [PERCENT_CLIENTS_CAMPAIGNS]
     ,
     CASE
     WHEN COUNT([ID]) NOT IN ('') THEN '1º - CLIENTS NOT ACCEPTED CMP1'
     END AS [NOTE]
	  
FROM [MARKETING].[MARKETING_ANALISE_CAMPANHA].[TBL_DADOS_CAMPANHA_VW]

WHERE [ACCEPTED_CMP1] = 0

UNION ALL 

SELECT 
      COUNT([ID]) AS [NUMBER_CLIENTS]
     ,ROUND((COUNT([ID]) * 100)/(@NUMBER_CLIENTS),2) AS [PERCENT_CLIENTS_CAMPAIGNS]
     ,
     CASE
     WHEN COUNT([ID]) NOT IN ('') THEN '1º - CLIENTS ACCEPTED CMP1'
     END AS [NOTE]
	  
FROM [MARKETING].[MARKETING_ANALISE_CAMPANHA].[TBL_DADOS_CAMPANHA_VW]

WHERE [ACCEPTED_CMP1] > 0

UNION ALL

SELECT 
      COUNT([ID]) AS [NUMBER_CLIENTS]
     ,ROUND((COUNT([ID]) * 100)/(@NUMBER_CLIENTS),2) AS [PERCENT_CLIENTS_CAMPAIGNS]
     ,
     CASE
     WHEN COUNT([ID]) NOT IN ('') THEN '2º - CLIENTS NOT ACCEPTED CMP2'
     END AS [NOTE]
	  
FROM [MARKETING].[MARKETING_ANALISE_CAMPANHA].[TBL_DADOS_CAMPANHA_VW]

WHERE [ACCEPTED_CMP2] = 0

UNION ALL

SELECT 
      COUNT([ID]) AS [NUMBER_CLIENTS]
     ,ROUND((COUNT([ID]) * 100)/(@NUMBER_CLIENTS),2) AS [PERCENT_CLIENTS_CAMPAIGNS]
     ,
     CASE
     WHEN COUNT([ID]) NOT IN ('') THEN '2º - CLIENTS ACCEPTED CMP2'
     END AS [NOTE]
	  
FROM [MARKETING].[MARKETING_ANALISE_CAMPANHA].[TBL_DADOS_CAMPANHA_VW]

WHERE [ACCEPTED_CMP2] > 0

UNION ALL

SELECT 
      COUNT([ID]) AS [NUMBER_CLIENTS]
     ,ROUND((COUNT([ID]) * 100)/(@NUMBER_CLIENTS),2) AS [PERCENT_CLIENTS_CAMPAIGNS]
     ,
     CASE
     WHEN COUNT([ID]) NOT IN ('') THEN '3º - CLIENTS NOT ACCEPTED CMP3'
     END AS [NOTE]
	  
FROM [MARKETING].[MARKETING_ANALISE_CAMPANHA].[TBL_DADOS_CAMPANHA_VW]

WHERE [ACCEPTED_CMP3] = 0

UNION ALL

SELECT 
      COUNT([ID]) AS [NUMBER_CLIENTS]
     ,ROUND((COUNT([ID]) * 100)/(@NUMBER_CLIENTS),2) AS [PERCENT_CLIENTS_CAMPAIGNS]
     ,
     CASE
     WHEN COUNT([ID]) NOT IN ('') THEN '3º - CLIENTS ACCEPTED CMP3'
     END AS [NOTE]
	  
FROM [MARKETING].[MARKETING_ANALISE_CAMPANHA].[TBL_DADOS_CAMPANHA_VW]

WHERE [ACCEPTED_CMP3] > 0

UNION ALL

SELECT 
      COUNT([ID]) AS [NUMBER_CLIENTS]
     ,ROUND((COUNT([ID]) * 100)/(@NUMBER_CLIENTS),2) AS [PERCENT_CLIENTS_CAMPAIGNS]
     ,
     CASE
     WHEN COUNT([ID]) NOT IN ('') THEN '4º - CLIENTS NOT ACCEPTED CMP4'
     END AS [NOTE]
	  
FROM [MARKETING].[MARKETING_ANALISE_CAMPANHA].[TBL_DADOS_CAMPANHA_VW]

WHERE [ACCEPTED_CMP4] = 0

UNION ALL

SELECT 
      COUNT([ID]) AS [NUMBER_CLIENTS]
     ,ROUND((COUNT([ID]) * 100)/(@NUMBER_CLIENTS),2) AS [PERCENT_CLIENTS_CAMPAIGNS]
     ,
     CASE
     WHEN COUNT([ID]) NOT IN ('') THEN '4º - CLIENTS ACCEPTED CMP4'
     END AS [NOTE]
	  
FROM [MARKETING].[MARKETING_ANALISE_CAMPANHA].[TBL_DADOS_CAMPANHA_VW]

WHERE [ACCEPTED_CMP4] > 0

UNION ALL

SELECT 
      COUNT([ID]) AS [NUMBER_CLIENTS]
     ,ROUND((COUNT([ID]) * 100)/(@NUMBER_CLIENTS),2) AS [PERCENT_CLIENTS_CAMPAIGNS]
     ,
     CASE
     WHEN COUNT([ID]) NOT IN ('') THEN '5º - CLIENTS NOT ACCEPTED CMP5'
     END AS [NOTE]
	  
FROM [MARKETING].[MARKETING_ANALISE_CAMPANHA].[TBL_DADOS_CAMPANHA_VW]

WHERE [ACCEPTED_CMP5] = 0

UNION ALL

SELECT 
      COUNT([ID]) AS [NUMBER_CLIENTS]
     ,ROUND((COUNT([ID]) * 100)/(@NUMBER_CLIENTS),2) AS [PERCENT_CLIENTS_CAMPAIGNS]
     ,
     CASE
     WHEN COUNT([ID]) NOT IN ('') THEN '5º - CLIENTS ACCEPTED CMP5'
     END AS [NOTE]
	  
FROM [MARKETING].[MARKETING_ANALISE_CAMPANHA].[TBL_DADOS_CAMPANHA_VW]

WHERE [ACCEPTED_CMP5] > 0

UNION ALL

SELECT 
      COUNT([ID]) AS [NUMBER_CLIENTS]
     ,ROUND((COUNT([ID]) * 100)/(@NUMBER_CLIENTS),2) AS [PERCENT_CLIENTS_CAMPAIGNS]
     ,
     CASE
     WHEN COUNT([ID]) NOT IN ('') THEN '6º - CLIENTS NOT ACCEPTED (RESPONSE - TARGET)'
     END AS [NOTE]
	  
FROM [MARKETING].[MARKETING_ANALISE_CAMPANHA].[TBL_DADOS_CAMPANHA_VW]

WHERE [RESPONSE] = 0

UNION ALL

SELECT 
      COUNT([ID]) AS [NUMBER_CLIENTS]
     ,ROUND((COUNT([ID]) * 100)/(@NUMBER_CLIENTS),2) AS [PERCENT_CLIENTS_CAMPAIGNS]
     ,
     CASE
     WHEN COUNT([ID]) NOT IN ('') THEN '6º - CLIENTS ACCEPTED (RESPONSE - TARGET)'
     END AS [NOTE]
	  
FROM [MARKETING].[MARKETING_ANALISE_CAMPANHA].[TBL_DADOS_CAMPANHA_VW]

WHERE [RESPONSE] > 0
)
SELECT 
      AVG([PERCENT_CLIENTS_CAMPAIGNS]) AS [AVG_PERCENT_SUCCESS_CAMPAIGN]

FROM [TBL_DATA]

WHERE [NOTE] LIKE '%CLIENTS ACCEPTED%'

--------------------------------------------------------------------------------------------------------------------------------------

-- Quantidade de clientes pelo nível de educação por quantidade de compras por produtos e total geral dos produtos somados.
DECLARE @NUMBER_CLIENTS FLOAT = (SELECT COUNT([ID]) FROM [MARKETING].[MARKETING_ANALISE_CAMPANHA].[TBL_DADOS_CAMPANHA_VW]);

WITH [TBL_DATA]
AS
(
SELECT 
      COUNT([ID]) AS [NUMBER_CLIENTS]
     ,[EDUCATION]
     ,SUM([MNT_WINES]) AS [TOTAL_WINES]
     ,SUM([MNT_FRUITS]) AS [TOTAL_FRUITS]
     ,SUM([MNT_MEAT_PRODUCTS]) AS [TOTAL_MNT_MEAT_PRODUCTS]
     ,SUM([MNT_FISH_PRODUCTS]) AS [TOTAL_MNT_FISH_PRODUCTS]
     ,SUM([MNT_SWEET_PRODUCTS]) AS [TOTAL_MNT_SWEET_PRODUCTS]
     ,SUM([MNT_GOLD_PRODS]) AS [TOTAL_MNT_GOLD_PRODUCTS]

FROM [MARKETING].[MARKETING_ANALISE_CAMPANHA].[TBL_DADOS_CAMPANHA_VW]

GROUP BY
	[EDUCATION]
)
SELECT 
      [NUMBER_CLIENTS]
     ,[EDUCATION]
     ,ROUND(([NUMBER_CLIENTS] * 100)/(@NUMBER_CLIENTS),2) AS [PERCENT_CLIENTS_EDUCATION]
     ,[TOTAL_WINES]
     ,[TOTAL_FRUITS]
     ,[TOTAL_MNT_MEAT_PRODUCTS]
     ,[TOTAL_MNT_FISH_PRODUCTS]
     ,[TOTAL_MNT_SWEET_PRODUCTS]
     ,[TOTAL_MNT_GOLD_PRODUCTS]
     ,[TOTAL_WINES] + [TOTAL_FRUITS] + [TOTAL_MNT_MEAT_PRODUCTS] + [TOTAL_MNT_FISH_PRODUCTS] + [TOTAL_MNT_SWEET_PRODUCTS] + [TOTAL_MNT_GOLD_PRODUCTS] AS [TOTAL_PRODUCTS]


FROM [TBL_DATA]

GROUP BY
        [NUMBER_CLIENTS]
       ,[EDUCATION]
       ,[TOTAL_WINES]
       ,[TOTAL_FRUITS]
       ,[TOTAL_MNT_MEAT_PRODUCTS]
       ,[TOTAL_MNT_FISH_PRODUCTS]
       ,[TOTAL_MNT_SWEET_PRODUCTS]
       ,[TOTAL_MNT_GOLD_PRODUCTS]

ORDER BY
        [TOTAL_WINES] DESC
	,[TOTAL_FRUITS] DESC
	,[TOTAL_MNT_MEAT_PRODUCTS] DESC
	,[TOTAL_MNT_FISH_PRODUCTS] DESC
	,[TOTAL_MNT_SWEET_PRODUCTS] DESC
	,[TOTAL_MNT_GOLD_PRODUCTS] DESC
	,[TOTAL_WINES] + [TOTAL_FRUITS] + [TOTAL_MNT_MEAT_PRODUCTS] + [TOTAL_MNT_FISH_PRODUCTS] + [TOTAL_MNT_SWEET_PRODUCTS] + [TOTAL_MNT_GOLD_PRODUCTS] DESC

-- 1.127 clientes -> Graduation -> 50% -> Wines: 320.371 -> Fruits: 34.683 -> Meat: 202.284 -> Fish: 48.630 -> Sweet: 35.351 -> Gold: 57.307.
-- 486 clientes -> PhD -> 21% -> Wines: 196.585 -> Fruits: 97.44 -> Meat: 81.941 -> Fish: 12.990 -> Sweet: 9.828 -> Gold: 15.703.
-- 370 clientes -> Master -> 16% -> Wines: 123.238 -> Fruits: 8.012 -> Meat: 60.450 -> Fish: 11.877 -> Sweet: 7.835 -> Gold: 14.947.
-- 203 clientes -> 2n Cycle -> 9% -> Wines: 40.231 -> Fruits: 5.878 -> Meat: 28.675 -> Fish: 9.639 -> Sweet: 6.953 -> Gold: 9.419
-- 54 clientes -> Basic -> 2% -> Wines: 391 -> Fruits: 600 -> Meat: 618 -> Fish: 921 -> Sweet: 654 -> Gold: 1.233

--------------------------------------------------------------------------------------------------------------------------------------

-- Quantidade de clientes pelo estado civil por quantidade de compras por produtos e total geral dos produtos somados.
DECLARE @NUMBER_CLIENTS FLOAT = (SELECT COUNT([ID]) FROM [MARKETING].[MARKETING_ANALISE_CAMPANHA].[TBL_DADOS_CAMPANHA_VW]);

WITH [TBL_DATA]
AS
(
SELECT 
      COUNT([ID]) AS [NUMBER_CLIENTS]
     ,[MARITAL_STATUS]
     ,SUM([MNT_WINES]) AS [TOTAL_WINES]
     ,SUM([MNT_FRUITS]) AS [TOTAL_FRUITS]
     ,SUM([MNT_MEAT_PRODUCTS]) AS [TOTAL_MNT_MEAT_PRODUCTS]
     ,SUM([MNT_FISH_PRODUCTS]) AS [TOTAL_MNT_FISH_PRODUCTS]
     ,SUM([MNT_SWEET_PRODUCTS]) AS [TOTAL_MNT_SWEET_PRODUCTS]
     ,SUM([MNT_GOLD_PRODS]) AS [TOTAL_MNT_GOLD_PRODUCTS]

FROM [MARKETING].[MARKETING_ANALISE_CAMPANHA].[TBL_DADOS_CAMPANHA_VW]

GROUP BY
		[MARITAL_STATUS]
)
SELECT 
      [NUMBER_CLIENTS]
     ,[MARITAL_STATUS]
     ,ROUND(([NUMBER_CLIENTS] * 100)/(@NUMBER_CLIENTS),2) AS [PERCENT_CLIENTS_MARITAL_STATUS]
     ,[TOTAL_WINES]
     ,[TOTAL_FRUITS]
     ,[TOTAL_MNT_MEAT_PRODUCTS]
     ,[TOTAL_MNT_FISH_PRODUCTS]
     ,[TOTAL_MNT_SWEET_PRODUCTS]
     ,[TOTAL_MNT_GOLD_PRODUCTS]
     ,[TOTAL_WINES] + [TOTAL_FRUITS] + [TOTAL_MNT_MEAT_PRODUCTS] + [TOTAL_MNT_FISH_PRODUCTS] + [TOTAL_MNT_SWEET_PRODUCTS] + [TOTAL_MNT_GOLD_PRODUCTS] AS [TOTAL_PRODUCTS]


FROM [TBL_DATA]

GROUP BY
        [NUMBER_CLIENTS]
       ,[MARITAL_STATUS]
       ,[TOTAL_WINES]
       ,[TOTAL_FRUITS]
       ,[TOTAL_MNT_MEAT_PRODUCTS]
       ,[TOTAL_MNT_FISH_PRODUCTS]
       ,[TOTAL_MNT_SWEET_PRODUCTS]
       ,[TOTAL_MNT_GOLD_PRODUCTS]

ORDER BY
        [TOTAL_WINES] DESC
	,[TOTAL_FRUITS] DESC
	,[TOTAL_MNT_MEAT_PRODUCTS] DESC
	,[TOTAL_MNT_FISH_PRODUCTS] DESC
	,[TOTAL_MNT_SWEET_PRODUCTS] DESC
	,[TOTAL_MNT_GOLD_PRODUCTS] DESC
	,[TOTAL_WINES] + [TOTAL_FRUITS] + [TOTAL_MNT_MEAT_PRODUCTS] + [TOTAL_MNT_FISH_PRODUCTS] + [TOTAL_MNT_SWEET_PRODUCTS] + [TOTAL_MNT_GOLD_PRODUCTS] DESC

-- 864 clientes -> Married -> 38% -> Wines: 258.751 -> Fruits: 22.235 -> Meat: 138.829 -> Fish: 30.569 -> Sweet: 23070 -> Gold: 36999.
-- 580 clientes -> Together -> 25% -> Wines: 177.959 -> Fruits: 14.703 -> Meat: 97.500 -> Fish: 22.615 -> Sweet: 15151 -> Gold: 24937.
-- 480 clientes -> Single -> 21% -> Wines: 138.399 -> Fruits: 12.881 -> Meat: 87.412 -> Fish: 18.344 -> Sweet: 13086 -> Gold: 20990.
-- 232 clientes -> Divorced -> 10% -> Wines: 75.364 -> Fruits: 6.363 -> Meat: 34.848 -> Fish: 8.130 -> Sweet: 6222 -> Gold: 10739.
-- 77 clientes -> Widow -> 3% -> Wines: 28.434 -> Fruits: 2.548 -> Meat: 14.575 -> Fish: 3.957 -> Sweet: 3004 -> Gold: 4371.
-- 2 clientes -> Absurd -> 1% -> Wines: 711 -> Fruits: 169 -> Meat: 625 -> Fish: 411 -> Sweet: 61 -> Gold: 408.
-- 2 clientes -> YOLO -> 1% -> Wines: 644 -> Fruits: 6 -> Meat: 100 -> Fish: 8 -> Sweet: 6 -> Gold: 84.
-- 3 clientes -> Alone -> 1% -> Wines: 554 -> Fruits: 554 -> Meat: 79 -> Fish: 23 -> Sweet: 21 -> Gold: 81.

--------------------------------------------------------------------------------------------------------------------------------------

-- Quantidade de clientes pela quantidade de crianças por quantidade de compras por produtos e total geral dos produtos somados.
DECLARE @NUMBER_CLIENTS FLOAT = (SELECT COUNT([ID]) FROM [MARKETING].[MARKETING_ANALISE_CAMPANHA].[TBL_DADOS_CAMPANHA_VW]);

WITH [TBL_DATA]
AS
(
SELECT 
      COUNT([ID]) AS [NUMBER_CLIENTS]
     ,[KIDHOME]
     ,SUM([MNT_WINES]) AS [TOTAL_WINES]
     ,SUM([MNT_FRUITS]) AS [TOTAL_FRUITS]
     ,SUM([MNT_MEAT_PRODUCTS]) AS [TOTAL_MNT_MEAT_PRODUCTS]
     ,SUM([MNT_FISH_PRODUCTS]) AS [TOTAL_MNT_FISH_PRODUCTS]
     ,SUM([MNT_SWEET_PRODUCTS]) AS [TOTAL_MNT_SWEET_PRODUCTS]
     ,SUM([MNT_GOLD_PRODS]) AS [TOTAL_MNT_GOLD_PRODUCTS]

FROM [MARKETING].[MARKETING_ANALISE_CAMPANHA].[TBL_DADOS_CAMPANHA_VW]

GROUP BY
       [KIDHOME]
)
SELECT 
      [NUMBER_CLIENTS]
     ,[KIDHOME]
     ,ROUND(([NUMBER_CLIENTS] * 100)/(@NUMBER_CLIENTS),2) AS [PERCENT_CLIENTS_KIDHOME]
     ,[TOTAL_WINES]
     ,[TOTAL_FRUITS]
     ,[TOTAL_MNT_MEAT_PRODUCTS]
     ,[TOTAL_MNT_FISH_PRODUCTS]
     ,[TOTAL_MNT_SWEET_PRODUCTS]
     ,[TOTAL_MNT_GOLD_PRODUCTS]
     ,[TOTAL_WINES] + [TOTAL_FRUITS] + [TOTAL_MNT_MEAT_PRODUCTS] + [TOTAL_MNT_FISH_PRODUCTS] + [TOTAL_MNT_SWEET_PRODUCTS] + [TOTAL_MNT_GOLD_PRODUCTS] AS [TOTAL_PRODUCTS]

FROM [TBL_DATA]

GROUP BY
        [NUMBER_CLIENTS]
       ,[KIDHOME]
       ,[TOTAL_WINES]
       ,[TOTAL_FRUITS]
       ,[TOTAL_MNT_MEAT_PRODUCTS]
       ,[TOTAL_MNT_FISH_PRODUCTS]
       ,[TOTAL_MNT_SWEET_PRODUCTS]
       ,[TOTAL_MNT_GOLD_PRODUCTS]

ORDER BY
	[TOTAL_WINES] DESC
	,[TOTAL_FRUITS] DESC
	,[TOTAL_MNT_MEAT_PRODUCTS] DESC
	,[TOTAL_MNT_FISH_PRODUCTS] DESC
	,[TOTAL_MNT_SWEET_PRODUCTS] DESC
	,[TOTAL_MNT_GOLD_PRODUCTS] DESC
	,[TOTAL_WINES] + [TOTAL_FRUITS] + [TOTAL_MNT_MEAT_PRODUCTS] + [TOTAL_MNT_FISH_PRODUCTS] + [TOTAL_MNT_SWEET_PRODUCTS] + [TOTAL_MNT_GOLD_PRODUCTS] DESC

-- 1293 clientes -> Kidhome: 0 -> 57% -> Wines: 583.367 -> Fruits: 50.935 -> Meat: 328.417 -> Fish: 72.618 -> Sweet: 52.365 -> Gold: 77.628.
-- 899 clientes -> Kidhome: 1 -> 40% -> Wines: 93.859 -> Fruits: 7.657 -> Meat: 43.927 -> Fish: 11.068 -> Sweet: 8.030 -> Gold: 20.145.
-- 48 clientes -> Kidhome: 2 -> 2% -> Wines: 3.590 -> Fruits: 325 -> Meat: 1.624 -> Fish: 371 -> Sweet: 226 -> Gold: 836.

--------------------------------------------------------------------------------------------------------------------------------------

-- Quantidade de clientes pela quantidade de adolescentes por quantidade de compras por produtos e total geral dos produtos somados.
DECLARE @NUMBER_CLIENTS FLOAT = (SELECT COUNT([ID]) FROM [MARKETING].[MARKETING_ANALISE_CAMPANHA].[TBL_DADOS_CAMPANHA_VW]);

WITH [TBL_DATA]
AS
(
SELECT 
      COUNT([ID]) AS [NUMBER_CLIENTS]
     ,[TEENHOME]
     ,SUM([MNT_WINES]) AS [TOTAL_WINES]
     ,SUM([MNT_FRUITS]) AS [TOTAL_FRUITS]
     ,SUM([MNT_MEAT_PRODUCTS]) AS [TOTAL_MNT_MEAT_PRODUCTS]
     ,SUM([MNT_FISH_PRODUCTS]) AS [TOTAL_MNT_FISH_PRODUCTS]
     ,SUM([MNT_SWEET_PRODUCTS]) AS [TOTAL_MNT_SWEET_PRODUCTS]
     ,SUM([MNT_GOLD_PRODS]) AS [TOTAL_MNT_GOLD_PRODUCTS]

FROM [MARKETING].[MARKETING_ANALISE_CAMPANHA].[TBL_DADOS_CAMPANHA_VW]

GROUP BY
       [TEENHOME]
)
SELECT 
      [NUMBER_CLIENTS]
     ,[TEENHOME]
     ,ROUND(([NUMBER_CLIENTS] * 100)/(@NUMBER_CLIENTS),2) AS [PERCENT_CLIENTS_TEENHOME]
     ,[TOTAL_WINES]
     ,[TOTAL_FRUITS]
     ,[TOTAL_MNT_MEAT_PRODUCTS]
     ,[TOTAL_MNT_FISH_PRODUCTS]
     ,[TOTAL_MNT_SWEET_PRODUCTS]
     ,[TOTAL_MNT_GOLD_PRODUCTS]
     ,[TOTAL_WINES] + [TOTAL_FRUITS] + [TOTAL_MNT_MEAT_PRODUCTS] + [TOTAL_MNT_FISH_PRODUCTS] + [TOTAL_MNT_SWEET_PRODUCTS] + [TOTAL_MNT_GOLD_PRODUCTS] AS [TOTAL_PRODUCTS]

FROM [TBL_DATA]

GROUP BY
        [NUMBER_CLIENTS]
       ,[TEENHOME]
       ,[TOTAL_WINES]
       ,[TOTAL_FRUITS]
       ,[TOTAL_MNT_MEAT_PRODUCTS]
       ,[TOTAL_MNT_FISH_PRODUCTS]
       ,[TOTAL_MNT_SWEET_PRODUCTS]
       ,[TOTAL_MNT_GOLD_PRODUCTS]

ORDER BY
	[TOTAL_WINES] DESC
	,[TOTAL_FRUITS] DESC
	,[TOTAL_MNT_MEAT_PRODUCTS] DESC
	,[TOTAL_MNT_FISH_PRODUCTS] DESC
	,[TOTAL_MNT_SWEET_PRODUCTS] DESC
	,[TOTAL_MNT_GOLD_PRODUCTS] DESC
	,[TOTAL_WINES] + [TOTAL_FRUITS] + [TOTAL_MNT_MEAT_PRODUCTS] + [TOTAL_MNT_FISH_PRODUCTS] + [TOTAL_MNT_SWEET_PRODUCTS] + [TOTAL_MNT_GOLD_PRODUCTS] DESC

-- 1158 clientes -> Teenhome: 0 -> 51% -> Wines: 352.985 -> Fruits: 38.573 -> Meat: 263.005 -> Fish: 56.346 -> Sweet: 38.945 -> Gold: 52.407.
-- 1030 clientes -> Teenhome: 1 -> 45% -> Wines: 309.010 -> Fruits: 19.433 -> Meat: 104.475 -> Fish: 26.468 -> Sweet: 20.840 -> Gold: 43.865.
-- 52 clientes -> Teenhome: 2 -> 2% -> Wines: 18.821 -> Fruits: 911 -> Meat: 6.488 -> Fish: 1.243 -> Sweet: 836 -> Gold: 2.337.

--------------------------------------------------------------------------------------------------------------------------------------

-- Quantidade de clientes pelo nível de educação pelas demais variáveis.
DECLARE @NUMBER_CLIENTS FLOAT = (SELECT COUNT([ID]) FROM [MARKETING].[MARKETING_ANALISE_CAMPANHA].[TBL_DADOS_CAMPANHA_VW]);

WITH [TBL_DATA]
AS
(
SELECT 
      COUNT([ID]) AS [NUMBER_CLIENTS]
     ,[EDUCATION]
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
)
SELECT 
      [NUMBER_CLIENTS]
     ,[EDUCATION]
     ,ROUND(([NUMBER_CLIENTS] * 100)/(@NUMBER_CLIENTS),2) AS [PERCENT_CLIENTS_EDUCATION]
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
     ,[TOTAL_WINES] + [TOTAL_FRUITS] + [TOTAL_MNT_MEAT_PRODUCTS] + [TOTAL_MNT_FISH_PRODUCTS] + [TOTAL_MNT_SWEET_PRODUCTS] + [TOTAL_MNT_GOLD_PRODUCTS] AS [TOTAL_PRODUCTS]

FROM [TBL_DATA]

GROUP BY
        [NUMBER_CLIENTS]
       ,[EDUCATION]
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

--------------------------------------------------------------------------------------------------------------------------------------

-- Quantidade de clientes pelo estado civil pelas demais variáveis.
DECLARE @NUMBER_CLIENTS FLOAT = (SELECT COUNT([ID]) FROM [MARKETING].[MARKETING_ANALISE_CAMPANHA].[TBL_DADOS_CAMPANHA_VW]);

WITH [TBL_DATA]
AS
(
SELECT 
      COUNT([ID]) AS [NUMBER_CLIENTS]
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
       [MARITAL_STATUS]
)
SELECT 
      [NUMBER_CLIENTS]
     ,[MARITAL_STATUS]
     ,ROUND(([NUMBER_CLIENTS] * 100)/(@NUMBER_CLIENTS),2) AS [PERCENT_CLIENTS_MARITAL_STATUS]
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
     ,[TOTAL_WINES] + [TOTAL_FRUITS] + [TOTAL_MNT_MEAT_PRODUCTS] + [TOTAL_MNT_FISH_PRODUCTS] + [TOTAL_MNT_SWEET_PRODUCTS] + [TOTAL_MNT_GOLD_PRODUCTS] AS [TOTAL_PRODUCTS]

FROM [TBL_DATA]

GROUP BY
        [NUMBER_CLIENTS]
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

--------------------------------------------------------------------------------------------------------------------------------------

-- Quantidade de clientes por crinças pelas demais variáveis.
DECLARE @NUMBER_CLIENTS FLOAT = (SELECT COUNT([ID]) FROM [MARKETING].[MARKETING_ANALISE_CAMPANHA].[TBL_DADOS_CAMPANHA_VW]);

WITH [TBL_DATA]
AS
(
SELECT 
      COUNT([ID]) AS [NUMBER_CLIENTS]
     ,[KIDHOME]
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
       [KIDHOME]
)
SELECT 
      [NUMBER_CLIENTS]
     ,[KIDHOME]
     ,ROUND(([NUMBER_CLIENTS] * 100)/(@NUMBER_CLIENTS),2) AS [PERCENT_CLIENTS_KIDHOME]
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
     ,[TOTAL_WINES] + [TOTAL_FRUITS] + [TOTAL_MNT_MEAT_PRODUCTS] + [TOTAL_MNT_FISH_PRODUCTS] + [TOTAL_MNT_SWEET_PRODUCTS] + [TOTAL_MNT_GOLD_PRODUCTS] AS [TOTAL_PRODUCTS]

FROM [TBL_DATA]

GROUP BY
        [NUMBER_CLIENTS]
       ,[KIDHOME]
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

--------------------------------------------------------------------------------------------------------------------------------------

-- Quantidade de clientes por adolescentes pelas demais variáveis.
DECLARE @NUMBER_CLIENTS FLOAT = (SELECT COUNT([ID]) FROM [MARKETING].[MARKETING_ANALISE_CAMPANHA].[TBL_DADOS_CAMPANHA_VW]);

WITH [TBL_DATA]
AS
(
SELECT 
      COUNT([ID]) AS [NUMBER_CLIENTS]
     ,[TEENHOME]
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
       [TEENHOME]
)
SELECT 
      [NUMBER_CLIENTS]
     ,[TEENHOME]
     ,ROUND(([NUMBER_CLIENTS] * 100)/(@NUMBER_CLIENTS),2) AS [PERCENT_CLIENTS_TEENHOME]
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
     ,[TOTAL_WINES] + [TOTAL_FRUITS] + [TOTAL_MNT_MEAT_PRODUCTS] + [TOTAL_MNT_FISH_PRODUCTS] + [TOTAL_MNT_SWEET_PRODUCTS] + [TOTAL_MNT_GOLD_PRODUCTS] AS [TOTAL_PRODUCTS]

FROM [TBL_DATA]

GROUP BY
        [NUMBER_CLIENTS]
       ,[TEENHOME]
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
		
--------------------------------------------------------------------------------------------------------------------------------------
-- Tabela padrão.

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
       CONCAT(RANK() OVER (ORDER BY [TOTAL_WINES] + [TOTAL_FRUITS] + [TOTAL_MNT_MEAT_PRODUCTS] + [TOTAL_MNT_FISH_PRODUCTS] + [TOTAL_MNT_SWEET_PRODUCTS] + [TOTAL_MNT_GOLD_PRODUCTS] DESC), ' ', 'º') AS [RANK_CLIENT_PROFILE]
      ,[NUMBER_CLIENTS]
      ,[EDUCATION]
      ,[MARITAL_STATUS]
      ,ROUND(([NUMBER_CLIENTS] * 100)/(@NUMBER_CLIENTS),2) AS [PERCENT_CLIENTS]
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
      ,[TOTAL_WINES] + [TOTAL_FRUITS] + [TOTAL_MNT_MEAT_PRODUCTS] + [TOTAL_MNT_FISH_PRODUCTS] + [TOTAL_MNT_SWEET_PRODUCTS] + [TOTAL_MNT_GOLD_PRODUCTS] AS [TOTAL_PRODUCTS]

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

--------------------------------------------------------------------------------------------------------------------------------------

-- Tabela com colunas traduzidas.

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
       CONCAT(RANK() OVER (ORDER BY [TOTAL_WINES] + [TOTAL_FRUITS] + [TOTAL_MNT_MEAT_PRODUCTS] + [TOTAL_MNT_FISH_PRODUCTS] + [TOTAL_MNT_SWEET_PRODUCTS] + [TOTAL_MNT_GOLD_PRODUCTS] DESC), ' ', 'º') AS [RANKIN_PERFIL_CLIENTE]
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

--------------------------------------------------------------------------------------------------------------------------------------

-- Clientes que aceitaram a campanha 1, com base no script do 12º passo.
DECLARE @NUMBER_CLIENTS FLOAT = (SELECT COUNT([ID]) FROM [MARKETING].[MARKETING_ANALISE_CAMPANHA].[TBL_DADOS_CAMPANHA_VW] WHERE [ACCEPTED_CMP1] = 1);

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

WHERE [ACCEPTED_CMP1] = 1

GROUP BY
       [EDUCATION]
      ,[MARITAL_STATUS]
)
SELECT 
       [NUMBER_CLIENTS]
      ,[EDUCATION]
      ,[MARITAL_STATUS]
      ,ROUND(([NUMBER_CLIENTS] * 100)/(@NUMBER_CLIENTS),2) AS [PERCENT_CLIENTS]
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
      ,[TOTAL_WINES] + [TOTAL_FRUITS] + [TOTAL_MNT_MEAT_PRODUCTS] + [TOTAL_MNT_FISH_PRODUCTS] + [TOTAL_MNT_SWEET_PRODUCTS] + [TOTAL_MNT_GOLD_PRODUCTS] AS [TOTAL_PRODUCTS]

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

--------------------------------------------------------------------------------------------------------------------------------------

-- Clientes que aceitaram a campanha 2, com base no script do 12º passo.
DECLARE @NUMBER_CLIENTS FLOAT = (SELECT COUNT([ID]) FROM [MARKETING].[MARKETING_ANALISE_CAMPANHA].[TBL_DADOS_CAMPANHA_VW] WHERE [ACCEPTED_CMP2] = 1);

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

WHERE [ACCEPTED_CMP2] = 1

GROUP BY
       [EDUCATION]
      ,[MARITAL_STATUS]
)
SELECT 
       [NUMBER_CLIENTS]
      ,[EDUCATION]
      ,[MARITAL_STATUS]
      ,ROUND(([NUMBER_CLIENTS] * 100)/(@NUMBER_CLIENTS),2) AS [PERCENT_CLIENTS]
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
      ,[TOTAL_WINES] + [TOTAL_FRUITS] + [TOTAL_MNT_MEAT_PRODUCTS] + [TOTAL_MNT_FISH_PRODUCTS] + [TOTAL_MNT_SWEET_PRODUCTS] + [TOTAL_MNT_GOLD_PRODUCTS] AS [TOTAL_PRODUCTS]

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

--------------------------------------------------------------------------------------------------------------------------------------

-- Clientes que aceitaram a campanha 3, com base no script do 12º passo.
DECLARE @NUMBER_CLIENTS FLOAT = (SELECT COUNT([ID]) FROM [MARKETING].[MARKETING_ANALISE_CAMPANHA].[TBL_DADOS_CAMPANHA_VW] WHERE [ACCEPTED_CMP3] = 1);

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

WHERE [ACCEPTED_CMP3] = 1

GROUP BY
       [EDUCATION]
      ,[MARITAL_STATUS]
)
SELECT 
       [NUMBER_CLIENTS]
      ,[EDUCATION]
      ,[MARITAL_STATUS]
      ,ROUND(([NUMBER_CLIENTS] * 100)/(@NUMBER_CLIENTS),2) AS [PERCENT_CLIENTS]
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
      ,[TOTAL_WINES] + [TOTAL_FRUITS] + [TOTAL_MNT_MEAT_PRODUCTS] + [TOTAL_MNT_FISH_PRODUCTS] + [TOTAL_MNT_SWEET_PRODUCTS] + [TOTAL_MNT_GOLD_PRODUCTS] AS [TOTAL_PRODUCTS]

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

--------------------------------------------------------------------------------------------------------------------------------------

-- Clientes que aceitaram a campanha 4, com base no script do 12º passo.
DECLARE @NUMBER_CLIENTS FLOAT = (SELECT COUNT([ID]) FROM [MARKETING].[MARKETING_ANALISE_CAMPANHA].[TBL_DADOS_CAMPANHA_VW] WHERE [ACCEPTED_CMP4] = 1);

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

WHERE [ACCEPTED_CMP4] = 1

GROUP BY
       [EDUCATION]
      ,[MARITAL_STATUS]
)
SELECT 
       [NUMBER_CLIENTS]
      ,[EDUCATION]
      ,[MARITAL_STATUS]
      ,ROUND(([NUMBER_CLIENTS] * 100)/(@NUMBER_CLIENTS),2) AS [PERCENT_CLIENTS]
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
      ,[TOTAL_WINES] + [TOTAL_FRUITS] + [TOTAL_MNT_MEAT_PRODUCTS] + [TOTAL_MNT_FISH_PRODUCTS] + [TOTAL_MNT_SWEET_PRODUCTS] + [TOTAL_MNT_GOLD_PRODUCTS] AS [TOTAL_PRODUCTS]

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

--------------------------------------------------------------------------------------------------------------------------------------

-- Clientes que aceitaram a campanha 5, com base no script do 12º passo.
DECLARE @NUMBER_CLIENTS FLOAT = (SELECT COUNT([ID]) FROM [MARKETING].[MARKETING_ANALISE_CAMPANHA].[TBL_DADOS_CAMPANHA_VW] WHERE [ACCEPTED_CMP5] = 1);

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

WHERE [ACCEPTED_CMP5] = 1

GROUP BY
       [EDUCATION]
      ,[MARITAL_STATUS]
)
SELECT 
       [NUMBER_CLIENTS]
      ,[EDUCATION]
      ,[MARITAL_STATUS]
      ,ROUND(([NUMBER_CLIENTS] * 100)/(@NUMBER_CLIENTS),2) AS [PERCENT_CLIENTS]
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
      ,[TOTAL_WINES] + [TOTAL_FRUITS] + [TOTAL_MNT_MEAT_PRODUCTS] + [TOTAL_MNT_FISH_PRODUCTS] + [TOTAL_MNT_SWEET_PRODUCTS] + [TOTAL_MNT_GOLD_PRODUCTS] AS [TOTAL_PRODUCTS]

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

--------------------------------------------------------------------------------------------------------------------------------------

-- Clientes que aceitaram a última campanha, com taxa de 15º de sucesso, com base no script do 12º passo.
DECLARE @NUMBER_CLIENTS FLOAT = (SELECT COUNT([ID]) FROM [MARKETING].[MARKETING_ANALISE_CAMPANHA].[TBL_DADOS_CAMPANHA_VW] WHERE [RESPONSE] = 1);

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

WHERE [RESPONSE] = 1

GROUP BY
       [EDUCATION]
      ,[MARITAL_STATUS]
)
SELECT 
       [NUMBER_CLIENTS]
      ,[EDUCATION]
      ,[MARITAL_STATUS]
      ,ROUND(([NUMBER_CLIENTS] * 100)/(@NUMBER_CLIENTS),2) AS [PERCENT_CLIENTS]
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
      ,[TOTAL_WINES] + [TOTAL_FRUITS] + [TOTAL_MNT_MEAT_PRODUCTS] + [TOTAL_MNT_FISH_PRODUCTS] + [TOTAL_MNT_SWEET_PRODUCTS] + [TOTAL_MNT_GOLD_PRODUCTS] AS [TOTAL_PRODUCTS]

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

--------------------------------------------------------------------------------------------------------------------------------------

