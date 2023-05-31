
# Documentação das análises realizadas para o case da campanha de Marketing.

---

| Documentação elaborada por     | Tipo | Segmentação           |
| -----------------------------  |:----:|:---------------------:|
| Luiz Phelipe Utiama Sempreboni | Case | Campanha de Marketing |


---

### Ferramentas utilizadas no método de análise:

- Input dos dados: Por meio de job do Python.

- Armazenamento dos dados: Microsoft SQL Server 2019.

- Linguagem utilizada para análise dos dados: Microsoft SQL Server 2019 - (DQL, DML, DDL, DTL), principalmente T-SQL.

- Linguagem utilizada para análise dos dados: Python (Google Colab), onde, neste caso, a análise final foi feita por SQL e essa mesma análise feita por Python, sem utilização do banco de dados, só o arquivo CSV.

- Apresentação dos dados: Power BI Desktop para algumas construções de tabelas internas e visualizações.

- Apresentação dos dados: Miro para auxiliar com as construções de visões e escritas.

- Apresentação dos dados: Power Point para apresentação da análise final.

---

### Observação sobre o método de análise:

O método utiliza o Microsoft SQL Server como banco de dados pelos motivos abaixo:

- Segurança dos dados: Por exemplo, rastreamento de usuários, tanto nominais, quanto de aplicação, onde é possível verificar qual database, schema ou tabela foi acessado.

- Capacidade de armazenamento dos dados: Por exemplo, uma tabela Excel, ou um arquivo CSV, dependendo da quantidade da dados, pode ocorrer um travamento e até perda dos dados, e já em um banco de dados, com capcidade maior de armazenamento, tem menos riscos de uma ocorrência deste tipo acontecer, e, se for bem gerenciado o banco de dados, teríamos um backup.

- Processamento dos dados: Por exemplo, se a infraestrutura for boa e adequada, o processamento dos dados será mais ágil.

- Backup dos dados: Por exemplo, se o banco for bem gerenciado pelo Administrador ou DBA, com um plano de execução de backups, haverá um backup para restauração dos dados.

Lembrando que, cada análise tem sua peculiaridade, criticidade e tempo de entrega, logo, terá que ser analisado como fazer esse processo de análise com os dados.

---
Resumo dos passos que foram realizados para essa análise de dados do case da campanha de martketing:

1º - Ter um usuário e login com privilégios para criação, inserção, drop e delete de databases, schema e tabelas.

2º - Conectar-se na ferramenta Microsoft SQL Server 2019.

3º - Criar um database que irá alocar o schema e a tabela. O comando abaixo irá criar um database de forma padrão, espelhado no database de sistema chamado (model), pois, não iremos destacar parâmetros neste caso.

4º - Criação do schema que alocará a tabela.

5º - Criação da tabela que alocará os dados para posteriormente realizar a análise. Nesta etapa, temos alguns passos adicionais conforme explicação abaixo. Esses passos entram como o tratamento de dados antes da realização da análise, para que seja a mais assertiva possível e os dados sejam de qualidade no momento da análise.

6º - Input dos dados na tabela criada no banco de dados Microsoft SQL Server com um job do Python.

7º - Criação de uma view com algumas adições de novas colunas conforme explicado abaixo.

8º - Job do Python que realiza desde a criação do database até a view que será utilizada para análise.

9º - Levantamento inicial dos KPI's.

10º - Primeira etapa das análises mais profundas e assertivas dos perfis dos clientes com base nos KPI's inciais levantados no 8º passo.

11º - Segunda etapa das análises mais profundas e assertivas dos perfis dos clientes, porém, iremos inserir as demais variáveis para verificação.

12º - Terceira etapa das análises mais profundas e assertivas dos perfis dos clientes, porém, iremos inserir as demais variáveis para verificação e realizaremos os agrupamentos unificados das variáveis (Educação e Estado Civil) e iremos inserir as variáveis (Crianças e Adolescentes) com somas e médias, logo, teremos todas variáveis unificadas das análises dos passos anteriores.

13º - Quarta etapa das análises mais profundas e assertivas dos perfis dos clientes, onde iremos analisar as campanhas que obtiveram respostas positivas dos clientes com o mesmo script do 12º passo, porém, por campanha.

14º - Comparação dos perfis dos clientes da análise realizada no 12º e 13º passo com as campanhas que obtiveram respostas positivas dos clientes.

15º - Resultado da análise final dos perfis dos clientes, chegando ao resultado da visualização abaixo com o perfil mais significativo da análise.

16º - Finalização das análises e da documentação.

---

### Descrição dos campos da tabela.

### Podemos dizer que são metadados, logo, dados sobre os dados.

| Campo               | Descrição us-es                                                      | Descrição pt-br                                                       |
| :------------------:|---------------------------------------------------------------------:|:---------------------------------------------------------------------:|
| AcceptedCmp1        | 1 if costumer accepted the offer in the 1º campaingn, 0 otherwise.   | 1 se o cliente aceitar a oferta na 1ª campanha, 0 caso contrário.     |
| AcceptedCmp2        | 1 if costumer accepted the offer in the 2º campaingn, 0 otherwise.   | 1 se o cliente aceitar a oferta na 2ª campanha, 0 caso contrário.     |
| AcceptedCmp3        | 1 if costumer accepted the offer in the 3º campaingn, 0 otherwise.   | 1 se o cliente aceitar a oferta na 3ª campanha, 0 caso contrário.     |
| AcceptedCmp4        | 1 if costumer accepted the offer in the 4º campaingn, 0 otherwise.   | 1 se o cliente aceitar a oferta na 4ª campanha, 0 caso contrário.     |
| AcceptedCmp5        | 1 if costumer accepted the offer in the 5º campaingn, 0 otherwise.   | 1 se o cliente aceitar a oferta na 5ª campanha, 0 caso contrário.     |
| Response (target)   | 1 if costumer accepted the offer in the last campaingn, 0 otherwise. | 1 se o cliente aceitar a oferta na última campanha, 0 caso contrário. |
| Complain            | 1 if costumer complained in the last 2 years.                        | 1 se o cliente reclamar nos últimos 2 anos.                           |
| DtCustomer          | date of costumer's enrollment with the company.                      | data de inscrição do cliente na empresa.                              |
| Education           | customer's level of education.                                       | nível de educação do cliente.                                         |
| Marital             | customer's marital status.                                           | estado civil do cliente.                                              |
| Kidhome             | number of small children in customer's household.                    | número de crianças pequenas na casa do cliente.                       |
| Teenhome            | number of teenagers in customer's household.                         | número de adolescentes na casa do cliente.                            |
| Income              | customer's yearly household income.                                  | renda familiar anual do cliente.                                      |
| MntFishProducts     | amount spent on fish products in the last 2 yeards.                  | montante gasto em produtos da pesca nos últimos 2 anos.               |
| MntMeatProducts     | amount spent on meat products in the last 2 yeards.                  | montante gasto em produtos cárneos nos últimos 2 anos.                |
| MntFruits           | amount spent on fruits products in the last 2 yeards.                | montante gasto em produtos de frutas nos últimos 2 anos.              |
| MntSweetProducts    | amount spent on sweet products in the last 2 yeards.                 | montante gasto com doces nos últimos 2 anos.                          |
| MntWines            | amount spent on wines products in the last 2 yeards.                 | montante gasto em produtos vitivinícolas nos últimos 2 anos.          |
| MntGoldProds        | amount spent on gold products in the last 2 yeards.                  | montante gasto em produtos de ouro nos últimos 2 anos.                |
| NumDealsPurchases   | number of purchases made with discount.                              | número de compras realizadas com desconto.                            |
| NumCatalogPurchases | number of purchases made using catalogue.                            | número de compras feitas por catálogo.                                |
| NumStorePurchases   | number of purchases made directly in stores.                         | número de compras feitas diretamente nas lojas.                       |
| NumWebPurchases     | number of purchases made through company's web site.                 | número de compras realizadas pelo site da empresa.                    |
| NumWebVisitsMonth   | number of visits to company's web site in the last month.            | número de visitas ao site da empresa no último mês.                   |
| Recency             | number of days since the last purchase.                              | número de dias desde a última compra.                                 |

---

### Passo a passo do método de análise:

---

NOTA IMPORTANTE:
- Os passos abaixo, do (1º ao 7º), são todos para o processo de importação dos dados do arquivo CSV para o Microsoft SQL Server.

- Temos um primeiro do job do Python que realiza a criação da tabela e importação dos dados.

- Temos um segundo job do Python, no 8º passo, que realiza todas as tarefas do (1º ao 7º), logo, fique á vontade para utiliza-lo caso não queira realizar os passos manuais no Microsoft SQL Server conforme abaixo.

---

1º - Ter um usuário e login com privilégios para criação, inserção, drop e delete de databases, schema e tabelas.

---

2º - Conectar-se na ferramenta Microsoft SQL Server 2019.

---

3º - Criar um database que irá alocar o schema e a tabela. O comando abaixo irá criar um database de forma padrão, espelhado no database de sistema chamado (model), pois, não iremos destacar parâmetros neste caso.

```
-- Criação do database.

CREATE DATABASE MARKETING;
GO

-- Caso queira excluir o database criado.

USE master;
GO

DROP DATABASE MARKETING;
GO

```

---

4º - Criação do schema que alocará a tabela.

```
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

```

---

5º - Criação da tabela que alocará os dados para posteriormente realizar a análise. Nesta etapa, temos alguns passos adicionais conforme explicação abaixo. Esses passos entram como o tratamento de dados antes da realização da análise, para que seja a mais assertiva possível e os dados sejam de qualidade no momento da análise.

- Passos adicionais:

- Essa etapa é realizada em conjunto com o 6º passo do job de importação de dados do Python, pois, como os dados estão sendo importados de diretamente de um arquivo CSV, é necessário verificar os tipos de dados das colunas que serão criadas, e, se o job consegue realizar a importação dos dados corretamente para o banco de dados Microsoft SQL Server, sem nenhum erro de tipo de dado incorreto, inválido ou que o mecanismo do banco de dados não consiga realizar a conversão, por exemplo, de (nvarchar) para (numerico), inclusive é um erro que ocorreu e foi corrigido neste passo.

- Foi inserido uma chave primária e indíce clusterizado nesta tabela, na coluna ID, pois, por lógica, um ID não se repete em uma tabela, logo, foi inserida chave primária para que o dado não se repita e seja o mais assertivo possível. A chave primária e o indíce clusterizado também deixam as pesquisas na tabela mais ágeis e efetivas, como na busca de um ID. Foi verificado se os 2.240 registros após a inserção da chave primária iriam se manter, e o resultado foi positivo, onde todos os registros foram mantidos.

- Foram confirmados por meios de querys e visando a qualidade dos dados, se os tipos de dados das colunas foram criados corretamente e se a chave primária também foi criada corretamente.

- Foram verificados os primeiros 25 registros entre arquivo CSV e a tabela criada no banco de dados Microsoft SQL Server, após a inserção dos dados pelo job do Python do 6º passo, para garantir por amostras, que os dados estão corretos e assim será para os demais inseridos.

- Nesta etapa também foram verificados os valores que estavam vazios no arquivo CSV e feito uma trativa, conforme descrito abaixo:
- Coluna (INCOME): Registros vazios foram preenchidos com (0) e o restante dos registros estavam preenchidos corretamente.

```
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
```
---

6º - Input dos dados na tabela criada no banco de dados Microsoft SQL Server com um job do Python.

- Atentar para as informações comentadas dentro do script abaixo.

```
# Se não houver instalado, instalar a biblioteca (pyodbc) para realizar a conexão com o banco de dados. Abra o prompt de comando e digite: pip install pyodbc.
# Se não houver instalado, instalar a biblioteca (pandas) para tratar o arquivo CSV. Abra o prompt de comando e digite: pip install pandas.
# Biblioteca (csv) é nativa do Python.

# Importações de bibliotecas.
import pyodbc
import pandas as pd
import csv

# Criação da conexão com o Microsoft SQL Server.
conexao = pyodbc.connect(
Driver='{SQL Server Native Client 11.0}',
Server='', # Insira o server.
Database='', # Insira o banco de dados. Neste job, insira o banco de dados que foi criado manualmente, o (MARKETING).
uid='', # Insira o usuário. É possível conectar por autentição do Windows.
pwd='', # Insira a senha. É possível conectar por autentição do Windows.
trusted_Connection='no', # Se o login no banco de dados é realizados com Autentição SQL Server, ou seja, com login e senha, deixe marcado como (no), caso contrário, retire o comando da linha de senha (pwd) e deixe este campo como (yes), informando que a conexão é por meio de Autentição Windows, ou seja, não necessita da senha.
autocommit=True  #Por padrão, o commit, que é a confirmação das transações no script SQL Server, principalmente para DDL, vem como (FALSE). Neste comando ele é alterado para (TRUE), visando fazer os scripts do SQL Server neste job do Python funcionarem e serem executados corretamente.
)
cursor = conexao.cursor() # Criação do cursor para executar comandos no banco de dados.

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

# Manipulação do arquivo CSV.
df = pd.read_csv(r'') # Realiza a leitura. Insira o caminho de repositório do CSV.
df.to_csv(r'', header=False, index=False) # Retirado o cabeçalho e possíveis index criados na leitura da linha de comando acima. Insira o caminho de repositório do CSV.

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
```
---

7º - Criação de uma view com algumas adições de novas colunas conforme explicado abaixo.

- A criação da view será feita como se fosse uma boa prática no banco de dados, na tabela origem e na análise de dados, onde temos alguns motivos abaixo.

- Motivo 1: Imaginemos que essa tabela criada tenha uma carga de atualização diária em um Datalake, sendo apagada e recriada todos os dias, logo, se a tabela estiver conectada em alguma ferramenta de visualização, ou uma outra ferramenta de banco de dados, como Microsoft Access, por exemplo, pode causar falhas de atualização da tabela devido as conexões abertas/pendentes nessas ferramentas. Criando uma view não teremos esse problema, pois, não temos conexão diretamente na tabela, além de conseguir realizar tratativas diretamente no script da view, e a vantagem de encapsulamento do script.

- Motivo 2: Caso essa tabela seja, por exemplo, uma tabela de um Datalake, onde normalmente os dados são extraídos de suas origens e inseridos na base de dados sem tratamentos, podemos criar uma view com nossos próprios tratamentos e não necessitar diretamente da tabela, que não possuí tratamentos e é carregada diretament no Datalake.

- Motivo 3: Facilidade de alteração da view, ou seja, no script, onde caso a tabela não tenha seu caminho e nomes de colunas alteradas, a view sempre será fiel a base origem, já com seus tratamentos realizados.

- Motivo 4: É possível utilizar a view com uma tabela de auxiliar de dados, por exemplo, um de/para, ou de uma transformação de dados muito complexa, que irá se relacionar e completar outras tabelas e/ou views.

- Motivo 5: Conseguir realizar a transformação de dados sem necessidade de alteração da tabela principal.

#### Colunas adicionadas e suas descrições:

| Campo                    | Descrição us-es                                                      | Descrição pt-br                                                       |
| :-----------------------:|---------------------------------------------------------------------:|:---------------------------------------------------------------------:|
| YEARS OLD                | customer age.                                                        | idade do cliente.                                                     |
| MONTHLY INCOME           | monthly income of the client's family.                               | renda mensal familia do cliente.                                      |
| REGISTERED CUSTOMER TIME | time the customer is registered with the company.                    | tempo que o cliente é registrado na empresa.                          |

```
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
```
---

8º - Job do Python que realiza desde a criação do database até a view que será utilizada para análise.

- Caso queira realizar todos os passos, desde a criação do database (MARKETING) até a criação da view que será utilizada para análise, por um job do Python, criei o job abaixo que realiza essas tarefas, conforme os passos (2, 3, 4, 5, 6 e 7).

- É necessário ler os comentários e inserir as informações solicitadas, tanto para conexão no banco de dados, quanto para acessar o arquivo CSV com os dados.
```
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
```
---

9º - Levantamento inicial dos KPI's. 
- Nesta etapa, será feito um levantamento inicial dos KPI's que os dados podem nos fornecer, e, á partir destes KPI's teremos insigths para as análises mais profundas e assertivas.

---
- Quantidade total de clientes.
```
SELECT COUNT([ID]) AS [NUMBER_CLIENTS] FROM [MARKETING].[MARKETING_ANALISE_CAMPANHA].[TBL_DADOS_CAMPANHA_VW];

-- 2.240 clientes.

```
---
- Idade média dos clientes.
```
SELECT ROUND(AVG([YEARS_OLD]),0) AS [AVG_AGE_CLIENTS] FROM [MARKETING].[MARKETING_ANALISE_CAMPANHA].[TBL_DADOS_CAMPANHA_VW];

-- 52 anos.
```
---
- Quantidade de clientes pelo nível de educação.
```
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
```
---
- Quantidade de clientes pelo estado civil.
```
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
```
---
- Quantidade de clientes pelo nível de educação e estado civil.
```
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
```
---
- Renda média mensal familiar dos clientes.
```
SELECT ROUND(AVG([MONTHLY_INCOME]),0) AS [AVERAGE_MONTHLY_INCOME] FROM [MARKETING].[MARKETING_ANALISE_CAMPANHA].[TBL_DADOS_CAMPANHA_VW];

-- 4.307.
```
---
- Renda média anual familiar dos clientes. 
```
SELECT ROUND(AVG([INCOME]),0) AS [AVERAGE_INCOME] FROM [MARKETING].[MARKETING_ANALISE_CAMPANHA].[TBL_DADOS_CAMPANHA_VW];

-- 51.687.
```
---
- Quantitade total de crianças, adoslecentes e a soma com total geral das duas categorias.
```
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
```
---
- Quantidade de clientes que não possuem crianças e adoslecentes.
- Quantidade de clientes que possuem crianças e adoslecentes.
- Quantidade de clientes que possuem crianças e não adoslecentes.
- Quantidade de clientes que não possuem crianças e possuem adoslecentes.
```
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
```
---
- Quantidade de clientes pelo tempo de registro na empresa (em anos).
```
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
```
---
- Média do tempo (em dias) que um cliente passa sem comprar desde a última compra.
```
SELECT ROUND(AVG([RECENCY]),0) AS [AVG_RECENCY] FROM [MARKETING].[MARKETING_ANALISE_CAMPANHA].[TBL_DADOS_CAMPANHA_VW];

-- 49 dias.
```
- Total de produtos vendidos agrupados.
```
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
```
---
- Produtos mais vendidos e menos vendidos.
```
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
```
---
- Quantidade de clientes que compraram com desconto.
- Quantidade de clientes que não usaram ou tiveram desconto.
```
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
```
---
- Média de compras com desconto.
```
SELECT ROUND(AVG([NUM_DEALS_PURCHASES]),0) AS [AVG_NUM_DEALS_PURCHASES] FROM [MARKETING].[MARKETING_ANALISE_CAMPANHA].[TBL_DADOS_CAMPANHA_VW] WHERE [NUM_DEALS_PURCHASES] > 0;

-- 2.
-- Cada cliente, dos que compraram com desconto, teria uma média de 2 compras por desconto recebido/utilizado. 
```
---
- Quantidade de clientes pelo número de vezes que ele comprou com desconto.
```
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
```
---
- Quantidade total de descontos utilizados pelos clientes.
```
SELECT SUM([NUM_DEALS_PURCHASES]) AS [NUM_GENERAL_DEALS_PURCHASES] FROM [MARKETING].[MARKETING_ANALISE_CAMPANHA].[TBL_DADOS_CAMPANHA_VW];

-- 5.208 descontos.
```
---
- Quantidade de clientes que compraram pelo site.
- Quantidade de clientes que não compraram pelo site.
```
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
```
---
- Quantidade de clientes pelo número de vezes que ele comprou pelo site.
```
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
```
---
- Quantidade total de compras pelo site.
```
SELECT SUM([NUM_WEB_PURCHASES]) AS [SUM_NUM_WEB_PURCHASES] FROM [MARKETING].[MARKETING_ANALISE_CAMPANHA].[TBL_DADOS_CAMPANHA_VW];

-- 9.150 de compras pelo site.
```
---
- Quantidade de clientes que compraram pelo catálogo.
- Quantidade de clientes que não compraram pelo catálogo.
```
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
```
---
- Quantidade de clientes pelo número de vezes que ele comprou pelo catálogo.
```
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
```
---
- Quantidade total de compras pelo catálogo.
```
SELECT SUM([NUM_CATALOG_PURCHASES]) AS [SUM_NUM_CATALOG_PURCHASES] FROM [MARKETING].[MARKETING_ANALISE_CAMPANHA].[TBL_DADOS_CAMPANHA_VW];

-- 5.963 compras pelo catálogo.
```
---
- Quantidade de clientes que compraram na loja.
- Quantidade de clientes que não compraram na loja.
```
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
```
---
- Quantidade de clientes pelo número de vezes que ele comprou na loja.
```
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
```
---
- Quantidade total de compras na loja.
```
SELECT SUM([NUM_STORE_PURCHASES]) AS [NUM_GENERAL_STORE_PURCHASES] FROM [MARKETING].[MARKETING_ANALISE_CAMPANHA].[TBL_DADOS_CAMPANHA_VW];

-- 12.970 de compras pela loja.
```
--
- Quantidade de clientes que visitaram o site no último mês.
- Quantidade de clientes que não visitaram o site no último mês.
```
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
```
---
- Quantidade de clientes pelo número de vezes visitaram o site no último mês.
```
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
```
---
- Quantidade total de visitas no site no último mês.
```
SELECT SUM([NUM_WEB_VISITS_MONTH]) AS [SUM_NUM_WEB_VISITS_MONTH] FROM [MARKETING].[MARKETING_ANALISE_CAMPANHA].[TBL_DADOS_CAMPANHA_VW];

-- 11.909 de visitas no site no último mês.
```
---
- Quantidade de clientes que aceitaram e não aceitaram a oferta na 1º campanha.
- Quantidade de clientes que aceitaram e não aceitaram a oferta na 2º campanha.
- Quantidade de clientes que aceitaram e não aceitaram a oferta na 3º campanha.
- Quantidade de clientes que aceitaram e não aceitaram a oferta na 4º campanha.
- Quantidade de clientes que aceitaram e não aceitaram a oferta na 5º campanha.
- Quantidade de clientes que aceitaram e não aceitaram a oferta na 6º campanha.
```
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
```
---
- Média de sucesso da campanha.
```
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

-- Média de sucesso da campanha.
-- Analisando da primeira a última campanha, temos uma média de sucesso de 7%.
```
---
#### Resumo do levantamento inicial de KPI's para as próximas análises mais profundas e assertivas.

- Quantidade de clientes.
- Idade média dos clientes.
- Quantidade de clientes pelo nível de educação.
- Quantidade de clientes pelo estado civil.
- Quantidade de clientes pelo nível de educação e estado civil.
- Renda média mensal familiar dos clientes.
- Renda média anual familiar dos clientes.
- Quantitade total de crianças e adoslecentes.
- Quantidade de clientes que não possuem crianças e adoslecentes.
- Quantidade de clientes que possuem crianças e adoslecentes.
- Quantidade de clientes que possuem crianças e não adoslecentes.
- Quantidade de clientes que não possuem crianças e possuem adoslecentes.
- Quantidade de clientes pelo tempo de registro na empresa (em anos).
- Média do tempo (em dias) que um cliente passa sem comprar desde a última compra.
- Total de produtos vendidos agrupados.
- Produtos mais vendidos e menos vendidos.
- Quantidade de clientes que compraram com desconto.
- Quantidade de clientes que não usaram ou tiveram desconto.
- Média de compras com desconto.
- Quantidade de clientes pelo número de vezes que ele comprou com desconto.
- Quantidade total de descontos utilizados pelos clientes.
- Quantidade de clientes que compraram pelo site.
- Quantidade de clientes que não compraram pelo site.
- Quantidade de clientes pelo número de vezes que ele comprou pelo site.
- Quantidade total de compras pelo site.
- Quantidade de clientes que compraram pelo catálogo.
- Quantidade de clientes que não compraram pelo catálogo.
- Quantidade de clientes pelo número de vezes que ele comprou pelo catálogo.
- Quantidade total de compras pelo catálogo.
- Quantidade de clientes que compraram na loja.
- Quantidade de clientes que não compraram na loja.
- Quantidade de clientes pelo número de vezes que ele comprou na loja.
- Quantidade total de compras na loja.
- Quantidade de clientes que visitaram o site no último mês.
- Quantidade de clientes que não visitaram o site no último mês.
- Quantidade de clientes pelo número de vezes visitaram o site no último mês.
- Quantidade total de visitas no site no último mês.
- Quantidade de clientes que aceitaram e não aceitaram a oferta na 1º campanha.
- Quantidade de clientes que aceitaram e não aceitaram a oferta na 2º campanha.
- Quantidade de clientes que aceitaram e não aceitaram a oferta na 3º campanha.
- Quantidade de clientes que aceitaram e não aceitaram a oferta na 4º campanha.
- Quantidade de clientes que aceitaram e não aceitaram a oferta na 5º campanha.
- Quantidade de clientes que aceitaram e não aceitaram a oferta na 6º campanha.
- Média de sucesso da campanha.
---
10º - Primeira etapa das análises mais profundas e assertivas dos perfis dos clientes com base nos KPI's inciais levantados no 8º passo.

---

- Neste caso iremos analisar 4 variáveis principais agrupadas, que seriam:
- Educação, Estado Civil, Crianças e Adolescentes.

---

- Com o agrupamento realizado, iremos utilizar, contagens,  somas e porcentagens, que seriam:
- Contagem do número de clientes.
- Soma de todos os tipos de produtos por categoria.
- Soma geral de todos os produtos com suas categorias.
- Porcentagem do total de clientes pelo tipo de agrupamento (Educação, Estado Civil, Crianças e Adolescentes).

---

- Quantidade de clientes pelo nível de educação por quantidade de compras por produtos e total geral dos produtos somados.
```
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
```
---
- Quantidade de clientes pelo estado civil por quantidade de compras por produtos e total geral dos produtos somados.
```
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
```
---
- Quantidade de clientes pela quantidade de crianças por quantidade de compras por produtos e total geral dos produtos somados.
```
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
```
---
- Quantidade de clientes pela quantidade de adolescentes por quantidade de compras por produtos e total geral dos produtos somados.
```
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
```
---
- Resultado das análises:
- Neste caso utilizei o Miro como forma de agrupamento das informações para apresentação.
- Esta é uma apresentação parcial, pois, ainda teremos uma apresentação no Power Point que será fornecida pelo Power BI.

![image](https://user-images.githubusercontent.com/57469401/125725132-6894605c-a1d3-46b6-9c20-72c38e239da6.png)

---
11º - Segunda etapa das análises mais profundas e assertivas dos perfis dos clientes, porém, iremos inserir as demais variáveis para verificação.

---

- Neste caso iremos analisar 4 variáveis principais agrupadas, que seriam:
- Educação, Estado Civil, Crianças e Adolescentes.

---

- Com o agrupamento realizado, iremos utilizar, contagens,  somas e porcentagens, que seriam:
- Contagem do número de clientes.
- Soma de todos os tipos de produtos por categoria.
- Soma geral de todos os produtos com suas categorias.
- Porcentagem do total de clientes pelo tipo de agrupamento (Educação, Estado Civil, Crianças e Adolescentes).
- Demais variáveis que não foram utilizadas, todas utilizando as média e somas.

---
- Quantidade de clientes pelo nível de educação pelas demais variáveis.
```
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
```
- Quantidade de clientes pelo estado civil pelas demais variáveis.
```
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
```
- Quantidade de clientes por crinças pelas demais variáveis.
```
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
```
- Quantidade de clientes por adolescentes pelas demais variáveis.
```
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
```
---
12º - Terceira etapa das análises mais profundas e assertivas dos perfis dos clientes, porém, iremos inserir as demais variáveis para verificação e realizaremos os agrupamentos unificados das variáveis (Educação e Estado Civil) e iremos inserir as variáveis (Crianças e Adolescentes) com somas e médias, logo, teremos todas variáveis unificadas das análises dos passos anteriores.

---

- NOTA: Uma nota sobre essa terceira etapa que agrupou e unificou todas variáveis dos passos anteriores, é que que servirá de comparação e validação com os métodos isolados anteriores, que agrupamos as variáveis principais escolhidas (Educação, Estado Civil, Crianças e Adolescentes). 

---

- NOTA2: Essa etapa também servirá para comparação com a próxima etapa (13º), que iremos comparar esse perfil de cliente localizado com os perfis dos clientes que aceitaram as campanhas anteriores.

---

```
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
```
---
```
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
```
---
- Representação da tabela da análise final construída para verificação dos perfis dos clientes
![image](https://user-images.githubusercontent.com/57469401/125708129-6515254e-3bb0-49e5-b3ea-c58862dd59aa.png)
---

13º - Quarta etapa das análises mais profundas e assertivas dos perfis dos clientes, onde iremos analisar as campanhas que obtiveram respostas positivas dos clientes com o mesmo script do 12º passo, porém, por campanha.

---

- Clientes que aceitaram a campanha 1, com base no script do 12º passo.
```
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
```
---
- Clientes que aceitaram a campanha 2, com base no script do 12º passo.
```
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
```
---
- Clientes que aceitaram a campanha 3, com base no script do 12º passo.
```
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
```
---
- Clientes que aceitaram a campanha 4, com base no script do 12º passo.
```
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
```
---
- Clientes que aceitaram a campanha 5, com base no script do 12º passo.
```
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
```
---
- Clientes que aceitaram a última campanha, com taxa de 15º de sucesso, com base no script do 12º passo.
```
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
```
---

14º - Comparação dos perfis dos clientes da análise realizada no 12º e 13º passo com as campanhas que obtiveram respostas positivas dos clientes.

- Com perfis de clientes encontrados pelas análises realizadas, iremos verificar os perfis de clientes que aceitaram as últimas campanhas conforme as bases de dados e analisar se são os mesmos perfis localizados pela análise.

- Pergunta: Porquê realizar essa análise ?

- Resposta: Realizando essa análise ficará mais claro, objetivo e assertivo sobre o perfil de cliente localizado na análise de dados, pois, pela lógica, clientes que aceitaram as ofertas tendem a ter o perfil encontrado na análise.

- Resultado: 

---
- Comparações da análise final realizada pelos resultados das campanhas anteriores.
![image](https://user-images.githubusercontent.com/57469401/125724899-8b48eef4-a59c-474b-86d2-567252db116f.png)
---

15º - Resultado da análise final dos perfis dos clientes, chegando ao resultado da visualização abaixo com o perfil mais significativo da análise.
![image](https://user-images.githubusercontent.com/57469401/126021113-c7b37bbb-c4d5-48ee-bd43-683644772231.png)

---

16º - Finalização das análises e da documentação.

- Aqui finalizamos as análises e a documentação deste case. 

- Para formar a tabela da análise final, construí um job do Python, que parte desde a criação do database, até a query da análise final, gera e exporta um arquivo em formato Excel, assim formando o (Caderno de resultados da análise final), que foi o nome dado para este arquivo e caso queira trocar na query, fique á vontade.

- Notar que para rodar o job do Python, serão necessárias algumas configurações no arquivo do job, além das ferramentas SQL Server (neste caso utilizamos o 2019) e o Python.

- As configurações estarão descritas no job do Python abaixo.

- No repositório deste projeto, chamado (Job do Python), temos o arquivo chamado (Script funcional 3), que é o equivalente deste job abaixo, logo, também pode ser utilizado aquele job.

- Objetivo do job: Gerar o (Caderno de resultados da análise final).

---
1º: Job do Python que realiza desde a criação do database até a geração e exportação do caderno de resultados.

- Foi utilizado SQL Server e Python neste caso.

```
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
df_result.to_excel(r'', index=False) # Insira o caminho do local de destino e não esqueça de inserir um nome para o arquivo com sua extensão, por exemplo (\resultado_analise_campanha.xlsx).

# Imprmir a mensagem que o processo foi finalizado.
print('Processo finalizado.')
```
---

2º: Python pelo Google Colab, onde utilizei o Python na web para realizar a mesma análise do job do Python do 1º item, porém, utilizando diretamente o arquivo CSV, sem utilização do SQL Server como base de armazenamento e consulta dos dados.
```
# ---- # ---- # ---- # ---- # ---- # ---- # ---- # ---- # ---- # ---- # ---- # ---- # ---- # ---- # ---- # ---- # ---- # ---- # ---- # ---- # ---- # ---- # ---- # ---- # ---- # ---- # ---- # ---- # ---- # ---- #

# Caderno de resultados da análise da campanha de marketing.

# Google Colab com Python.

# ---- # ---- # ---- # ---- # ---- # ---- # ---- # ---- # ---- # ---- # ---- # ---- # ---- # ---- # ---- # ---- # ---- # ---- # ---- # ---- # ---- # ---- # ---- # ---- # ---- # ---- # ---- # ---- # ---- # ---- #

# Instruções para utilização desse script.

# 1º - É necessário importar o arquivo que contém as informações do GitHub para um arquivo csv, pois, utilizamos o pandas com padrão csv para essa análise.
# 2º - Se possível nomeie o arquivo como (data.csv), e, caso escolha outro nome, altere o campo que contém o seguinte script (df = pd.read_csv(r'data.csv')) com o nome escolhido.
# 3º - Após importar para um arquivo csv, é necessário importar esse arquivo para o Google Colab.
# 4º - Abra o Google Colab na web -> (research.google.com/colaboratory).
# 5º - Utilize este script, que esta no formato (.py), copie e cole este scritp no Google Colab.
# 6º - Visando garantir a execução correta do script, uma linha antes, utilize o script (!pip install pandas) para instalar a biblioteca pandas no Google Colab.
# 7º - Para importar para o Google Colab, vá na aba esquerda, clique nas três linhas da parte superior, clique na pasta (arquivos) e clique na figura de um arquivo com uma seta pra cima, chamado (Fazer upload para armazenamento da sessão).
# 8º - Execute o script.
# 9º - Resultado será exibido em formato de tabela.

# ---- # ---- # ---- # ---- # ---- # ---- # ---- # ---- # ---- # ---- # ---- # ---- # ---- # ---- # ---- # ---- # ---- # ---- # ---- # ---- # ---- # ---- # ---- # ---- # ---- # ---- # ---- # ---- # ---- # ---- #

# Copie ele e cole este script uma linha antes ou junto com o script geral.
# Este script é para instalar a biblioteca pandas no Google Colab caso ela não exista.

!pip install pandas

# ---- # ---- # ---- # ---- # ---- # ---- # ---- # ---- # ---- # ---- # ---- # ---- # ---- # ---- # ---- # ---- # ---- # ---- # ---- # ---- # ---- # ---- # ---- # ---- # ---- # ---- # ---- # ---- # ---- # ---- #

# Importa a biblioca do pandas.
import pandas as pd
from datetime import datetime

# ---- # ---- # ---- # ---- # ---- # ---- # ---- # ---- # ---- # ---- # ---- # ---- # ---- # ---- # ---- # ---- # ---- # ---- # ---- # ---- # ---- # ---- # ---- # ---- # ---- # ---- # ---- # ---- # ---- # ---- #

# Lê o arquivo que foi carregado para o Google Colab.
# Notar que é necessário carregar ao lado em "Arquivos" o arquivo CSV com os dados e manter o nome (data.csv). Caso altere o nome, altere também no comando abaixo.
df = pd.read_csv(r'data.csv')

# ---- # ---- # ---- # ---- # ---- # ---- # ---- # ---- # ---- # ---- # ---- # ---- # ---- # ---- # ---- # ---- # ---- # ---- # ---- # ---- # ---- # ---- # ---- # ---- # ---- # ---- # ---- # ---- # ---- # ---- #

# Variáveis:
df_count = float(df['ID'].count()) # Contar a quantidade de registros pelo campo ID.
df_monthlys = int(12)

# ---- # ---- # ---- # ---- # ---- # ---- # ---- # ---- # ---- # ---- # ---- # ---- # ---- # ---- # ---- # ---- # ---- # ---- # ---- # ---- # ---- # ---- # ---- # ---- # ---- # ---- # ---- # ---- # ---- # ---- #

# Tratatar os valores (NaN) da coluna (Income), visando não inteferir em cálculos futuros.
df_replace = df['Income'] = df['Income'].fillna(0)

# ---- # ---- # ---- # ---- # ---- # ---- # ---- # ---- # ---- # ---- # ---- # ---- # ---- # ---- # ---- # ---- # ---- # ---- # ---- # ---- # ---- # ---- # ---- # ---- # ---- # ---- # ---- # ---- # ---- # ---- #

# Alterar a configuração do número de linhas para exibição.
pd.set_option("display.max_rows", 2250)

# Alterar a configuração do número de colunas para exibição.
pd.set_option("display.max_columns", 40)

# ---- # ---- # ---- # ---- # ---- # ---- # ---- # ---- # ---- # ---- # ---- # ---- # ---- # ---- # ---- # ---- # ---- # ---- # ---- # ---- # ---- # ---- # ---- # ---- # ---- # ---- # ---- # ---- # ---- # ---- #

# Alterar os valores (NaN) da coluna (Income) visando não prejudicas análises futuras. 
df_replace = df['Income'].replace(['NaN'], '0')

# ---- # ---- # ---- # ---- # ---- # ---- # ---- # ---- # ---- # ---- # ---- # ---- # ---- # ---- # ---- # ---- # ---- # ---- # ---- # ---- # ---- # ---- # ---- # ---- # ---- # ---- # ---- # ---- # ---- # ---- #

# Excluir colunas do df.
#df = df.drop('YEARS_OLD', 1)
#df = df.drop('MONTHLY_INCOME', 1)
#df = df.drop('REGISTERED_CUSTOMER_TIME', 1)
#df = df.drop('KIDHOME2', 1)
#df = df.drop('TEENHOME2', 1)
#df = df.drop('NUMDEALSPURCHASES2', 1)
#df = df.drop('NUMWEBPURCHASES2', 1)
#df = df.drop('NUMCATALOGPURCHASES2', 1)
#df = df.drop('MNUMSTOREPURCHASES2', 1)
#df = df.drop('NUMWEBVISITSMONTH2', 1)

# Conferindo e inserindo novas colunas.
if set(['YEARS_OLD', 'MONTHLY_INCOME', 'REGISTERED_CUSTOMER_TIME', 'KIDHOME2', 'TEENHOME2', 'NUMDEALSPURCHASES2', 'NUMWEBPURCHASES2', 'NUMCATALOGPURCHASES2', 'MNUMSTOREPURCHASES2', 'NUMWEBVISITSMONTH2']).issubset(df.columns):
  print('colunas já existem')
else:
  df.insert(loc=1, column='YEARS_OLD', value=float(datetime.now().strftime('%Y')) - df['Year_Birth']) # Coluna que calcula a idade.
  df.insert(loc=2, column='MONTHLY_INCOME', value=df['Income'] / df_monthlys) # Coluna que calcula o salário mensal
  df.insert(loc=3, column='REGISTERED_CUSTOMER_TIME', value= float(datetime.now().strftime('%Y')) - df['Dt_Customer'].str.slice(0,4).apply(lambda x: float(x))) # Coluna que calcula tempo que o cliente é registrado na empresa em anos.
  df.insert(loc=4, column='KIDHOME2', value=df['Kidhome']) # Coluna extra para o campo (Kidhome) visando realização de cálculos no futuro da análise.
  df.insert(loc=6, column='TEENHOME2', value=df['Teenhome']) # Coluna extra para o campo (Teenhome) visando realização de cálculos no futuro da análise.
  df.insert(loc=7, column='NUMDEALSPURCHASES2', value=df['NumDealsPurchases']) # Coluna extra para o campo (NumDealsPurchases) visando realização de cálculos no futuro da análise.
  df.insert(loc=8, column='NUMWEBPURCHASES2', value=df['NumWebPurchases']) # Coluna extra para o campo (NumWebPurchases) visando realização de cálculos no futuro da análise.
  df.insert(loc=9, column='NUMCATALOGPURCHASES2', value=df['NumCatalogPurchases']) # Coluna extra para o campo (NumCatalogPurchases) visando realização de cálculos no futuro da análise.
  df.insert(loc=10, column='MNUMSTOREPURCHASES2', value=df['NumStorePurchases']) # Coluna extra para o campo (NumStorePurchases) visando realização de cálculos no futuro da análise.
  df.insert(loc=11, column='NUMWEBVISITSMONTH2', value=df['NumWebVisitsMonth']) # Coluna extra para o campo (NumWebVisitsMonth) visando realização de cálculos no futuro da análise.

# ---- # ---- # ---- # ---- # ---- # ---- # ---- # ---- # ---- # ---- # ---- # ---- # ---- # ---- # ---- # ---- # ---- # ---- # ---- # ---- # ---- # ---- # ---- # ---- # ---- # ---- # ---- # ---- # ---- # ---- #

# Alterando o nome das colunas.
df_alter_names_columns = df.rename(columns={'ID': 'QTDE_CLIENTES', 'Year_Birth': 'ANO_NASCIMENTO', 'YEARS_OLD': 'IDADE', 'MONTHLY_INCOME': 'RENDA_FAMILIAR_MENSAL', 'Education': 'NIVEL_EDUCACAO', 'Marital_Status': 'ESTADO_CIVIL', 'Income': 'RENDA_FAMILIAR_ANUAL', 'Kidhome': 'CRIANCAS', 'KIDHOME2': 'CRIANCAS2','Teenhome': 'ADOLESCENTES', 'TEENHOME2': 'ADOLESCENTES2', 'Dt_Customer': 'DATA_REGISTRO_CLIENTE_EMPRESA', 'REGISTERED_CUSTOMER_TIME': 'TEMPO_REGISTRO_CLIENTE_EMPRESA', 'Recency': 'QTDE_DIAS_DESDE_ULT_COMPRA', 'MntWines': 'PRODUTOS_VINHOS', 'MntFruits': 'PRODUTOS_FRUTAS', 'MntMeatProducts': 'PRODUTOS_CARNES'  , 'MntFishProducts': 'PRODUTOS_PEIXES', 'MntSweetProducts': 'PRODUTOS_DOCES', 'MntGoldProds': 'PRODUTOS_GOLD', 'NumDealsPurchases': 'NUMERO_COMPRAS_COM_DESCONTOS', 'NUMDEALSPURCHASES2': 'NUMERO_COMPRAS_COM_DESCONTOS2', 'NumWebPurchases': 'NUMERO_COMPRAS_SITE', 'NUMWEBPURCHASES2': 'NUMERO_COMPRAS_SITE2', 'NumCatalogPurchases': 'NUMERO_COMPRAS_CATALOGO', 'NUMCATALOGPURCHASES2': 'NUMERO_COMPRAS_CATALOGO2', 'NumStorePurchases': 'NUMERO_COMPRAS_LOJA', 'MNUMSTOREPURCHASES2': 'NUMERO_COMPRAS_LOJA2','NumWebVisitsMonth': 'NUMERO_VISITAS_SITE_ULT_MES', 'NUMWEBVISITSMONTH2': 'NUMERO_VISITAS_SITE_ULT_MES2', 'AcceptedCmp3': 'ACEITOS_CAMPANHA_3', 'AcceptedCmp4': 'ACEITOS_CAMPANHA_4', 'AcceptedCmp5': 'ACEITOS_CAMPANHA_5', 'AcceptedCmp1': 'ACEITOS_CAMPANHA_1', 'AcceptedCmp2': 'ACEITOS_CAMPANHA_2', 'Complain': 'COMPLAIN', 'Z_CostContact': 'Z_COSTCONTACT', 'Z_Revenue': 'Z_REVENUE', 'Response': 'ACEITOS_ULT_CAMPANHA'})

# Selecionando as colunas.
df_converts_result = pd.DataFrame(data=df_alter_names_columns, columns=['QTDE_CLIENTES', 'ANO_NASCIMENTO', 'IDADE', 'NIVEL_EDUCACAO', 'ESTADO_CIVIL', 'RENDA_FAMILIAR_MENSAL', 'RENDA_FAMILIAR_ANUAL', 'CRIANCAS', 'CRIANCAS2', 'ADOLESCENTES', 'ADOLESCENTES2', 'DATA_REGISTRO_CLIENTE_EMPRESA', 'TEMPO_REGISTRO_CLIENTE_EMPRESA', 'QTDE_DIAS_DESDE_ULT_COMPRA', 'PRODUTOS_VINHOS', 'PRODUTOS_FRUTAS', 'PRODUTOS_CARNES', 'PRODUTOS_PEIXES', 'PRODUTOS_DOCES', 'PRODUTOS_GOLD', 'NUMERO_COMPRAS_COM_DESCONTOS', 'NUMERO_COMPRAS_COM_DESCONTOS2', 'NUMERO_COMPRAS_SITE', 'NUMERO_COMPRAS_SITE2','NUMERO_COMPRAS_CATALOGO', 'NUMERO_COMPRAS_CATALOGO2', 'NUMERO_COMPRAS_LOJA', 'NUMERO_COMPRAS_LOJA2', 'NUMERO_VISITAS_SITE_ULT_MES', 'NUMERO_VISITAS_SITE_ULT_MES2','ACEITOS_CAMPANHA_3', 'ACEITOS_CAMPANHA_4', 'ACEITOS_CAMPANHA_5', 'ACEITOS_CAMPANHA_1', 'ACEITOS_CAMPANHA_2', 'COMPLAIN', 'Z_COSTCONTACT', 'Z_REVENUE', 'ACEITOS_ULT_CAMPANHA'])

# ---- # ---- # ---- # ---- # ---- # ---- # ---- # ---- # ---- # ---- # ---- # ---- # ---- # ---- # ---- # ---- # ---- # ---- # ---- # ---- # ---- # ---- # ---- # ---- # ---- # ---- # ---- # ---- # ---- # ---- #

# Agrupando campos e valores.
df_group_one = df_converts_result.groupby(['NIVEL_EDUCACAO', 'ESTADO_CIVIL']).agg({'QTDE_CLIENTES': 'count', 'IDADE': 'mean', 'RENDA_FAMILIAR_MENSAL': 'mean', 'RENDA_FAMILIAR_ANUAL': 'mean', 'CRIANCAS': 'sum', 'CRIANCAS2': 'mean', 'ADOLESCENTES': 'sum', 'ADOLESCENTES2': 'mean', 'TEMPO_REGISTRO_CLIENTE_EMPRESA': 'mean', 'QTDE_DIAS_DESDE_ULT_COMPRA': 'mean', 'NUMERO_COMPRAS_COM_DESCONTOS': 'sum', 'NUMERO_COMPRAS_COM_DESCONTOS2': 'mean', 'NUMERO_COMPRAS_SITE': 'sum', 'NUMERO_COMPRAS_SITE2': 'mean', 'NUMERO_COMPRAS_CATALOGO': 'sum', 'NUMERO_COMPRAS_CATALOGO2': 'mean', 'NUMERO_COMPRAS_LOJA': 'sum', 'NUMERO_COMPRAS_LOJA2': 'mean', 'NUMERO_VISITAS_SITE_ULT_MES': 'sum', 'NUMERO_VISITAS_SITE_ULT_MES2': 'mean', 'PRODUTOS_VINHOS': 'sum', 'PRODUTOS_FRUTAS': 'sum', 'PRODUTOS_CARNES': 'sum', 'PRODUTOS_PEIXES': 'sum', 'PRODUTOS_DOCES': 'sum', 'PRODUTOS_GOLD': 'sum'}).reset_index().round(2)

# Alterando o nome das colunas.
df_alter_names_columns_group_one = df_group_one.rename(columns={'QTDE_CLIENTES': 'QTDE_CLIENTES', 'IDADE': 'IDADE_MEDIA', 'RENDA_FAMILIAR_MENSAL': 'RENDA_MEDIA_MENSAL_FAMILIAR', 'RENDA_FAMILIAR_ANUAL': 'RENDA_MEDIA_FAMILIAR_ANUAL', 'CRIANCAS': 'TOTAL_CRIANCAS', 'CRIANCAS2': 'MEDIA_CRIANCAS','ADOLESCENTES': 'TOTAL_ADOLESCENTES', 'ADOLESCENTES2': 'MEDIA_ADOLESCENTES', 'TEMPO_REGISTRO_CLIENTE_EMPRESA': 'MEDIA_TEMPO_CLIENTE_REGISTRADO_EMPRESA', 'QTDE_DIAS_DESDE_ULT_COMPRA': 'MEDIA_DIAS_DESDE_ULT_COMPRA', 'NUMERO_COMPRAS_COM_DESCONTOS': 'TOTAL_COMPRAS_COM_DESCONTO', 'NUMERO_COMPRAS_COM_DESCONTOS2': 'MEDIA_COMPRAS_COM_DESCONTO', 'NUMERO_COMPRAS_SITE': 'TOTAL_COMPRAS_SITE', 'NUMERO_COMPRAS_SITE2': 'MEDIA_COMPRAS_SITE', 'NUMERO_COMPRAS_CATALOGO': 'TOTAL_COMPRAS_CATALOGO', 'NUMERO_COMPRAS_CATALOGO2': 'MEDIA_COMPRAS_CATALOGO', 'NUMERO_COMPRAS_LOJA': 'TOTAL_COMPRAS_LOJA', 'NUMERO_COMPRAS_LOJA2': 'MEDIA_COMPRAS_LOJA', 'NUMERO_VISITAS_SITE_ULT_MES': 'TOTAL_VISITAS_SITE_ULT_MES', 'NUMERO_VISITAS_SITE_ULT_MES2': 'MEDIA_VISITAS_SITE_ULT_MES', 'PRODUTOS_VINHOS': 'TOTAL_VENDAS_CATEGORIA_VINHOS', 'PRODUTOS_FRUTAS': 'TOTAL_VENDAS_CATEGORIA_FRUTAS', 'PRODUTOS_CARNES': 'TOTAL_VENDAS_CATEGORIA_CARNES', 'PRODUTOS_PEIXES': 'TOTAL_VENDAS_CATEGORIA_PEIXES', 'PRODUTOS_DOCES': 'TOTAL_VENDAS_CATEGORIA_DOCES', 'PRODUTOS_GOLD': 'TOTAL_VENDAS_CATEGORIA_GOLD'})

# ---- # ---- # ---- # ---- # ---- # ---- # ---- # ---- # ---- # ---- # ---- # ---- # ---- # ---- # ---- # ---- # ---- # ---- # ---- # ---- # ---- # ---- # ---- # ---- # ---- # ---- # ---- # ---- # ---- # ---- #

df_converts_result_group_one = pd.DataFrame(data=df_alter_names_columns_group_one, columns=['QTDE_CLIENTES', 'NIVEL_EDUCACAO', 'ESTADO_CIVIL', 'IDADE_MEDIA', 'RENDA_MEDIA_MENSAL_FAMILIAR', 'RENDA_MEDIA_FAMILIAR_ANUAL','TOTAL_CRIANCAS', 'MEDIA_CRIANCAS', 'TOTAL_ADOLESCENTES', 'MEDIA_ADOLESCENTES','MEDIA_TEMPO_CLIENTE_REGISTRADO_EMPRESA', 'MEDIA_DIAS_DESDE_ULT_COMPRA', 'TOTAL_COMPRAS_COM_DESCONTO', 'MEDIA_COMPRAS_COM_DESCONTO', 'TOTAL_COMPRAS_SITE', 'MEDIA_COMPRAS_SITE', 'TOTAL_COMPRAS_CATALOGO', 'MEDIA_COMPRAS_CATALOGO', 'TOTAL_COMPRAS_LOJA', 'MEDIA_COMPRAS_LOJA', 'TOTAL_VISITAS_SITE_ULT_MES', 'MEDIA_VISITAS_SITE_ULT_MES', 'TOTAL_VENDAS_CATEGORIA_VINHOS', 'TOTAL_VENDAS_CATEGORIA_FRUTAS', 'TOTAL_VENDAS_CATEGORIA_CARNES', 'TOTAL_VENDAS_CATEGORIA_PEIXES', 'TOTAL_VENDAS_CATEGORIA_DOCES', 'TOTAL_VENDAS_CATEGORIA_GOLD'])

# ---- # ---- # ---- # ---- # ---- # ---- # ---- # ---- # ---- # ---- # ---- # ---- # ---- # ---- # ---- # ---- # ---- # ---- # ---- # ---- # ---- # ---- # ---- # ---- # ---- # ---- # ---- # ---- # ---- # ---- #

# Excluir colunas do df.
#df = df_converts_result_group_one.drop('PORCENTAGEM_CLIENTES', 1)

# Conferindo e inserindo novas colunas.
if set(['PORCENTAGEM_CLIENTES']).issubset(df.columns):
  print('colunas já existem')
else:
  df_converts_result_group_one.insert(loc=12, column='PORCENTAGEM_CLIENTES', value=(df_converts_result_group_one['QTDE_CLIENTES'] * 100 / df_count).round(2)) # Coluna que calcula a porcentagem de clientes.

# ---- # ---- # ---- # ---- # ---- # ---- # ---- # ---- # ---- # ---- # ---- # ---- # ---- # ---- # ---- # ---- # ---- # ---- # ---- # ---- # ---- # ---- # ---- # ---- # ---- # ---- # ---- # ---- # ---- # ---- #

# Excluir colunas do df.
#df = df_converts_result_group_one.drop('PORCENTAGEM_CLIENTES', 1)

# Conferindo e inserindo novas colunas.
if set(['TOTAL_PRODUTOS_VENDIDOS']).issubset(df.columns):
  print('colunas já existem')
else:
  df_converts_result_group_one.insert(loc=13, column='TOTAL_PRODUTOS_VENDIDOS', value=df_converts_result_group_one['TOTAL_VENDAS_CATEGORIA_VINHOS'] + df_converts_result_group_one['TOTAL_VENDAS_CATEGORIA_FRUTAS'] + df_converts_result_group_one['TOTAL_VENDAS_CATEGORIA_CARNES'] + df_converts_result_group_one['TOTAL_VENDAS_CATEGORIA_PEIXES'] + df_converts_result_group_one['TOTAL_VENDAS_CATEGORIA_DOCES'] + df_converts_result_group_one['TOTAL_VENDAS_CATEGORIA_GOLD']) # Coluna que calcula o total de produtos vendidos de todas as categorias.

# ---- # ---- # ---- # ---- # ---- # ---- # ---- # ---- # ---- # ---- # ---- # ---- # ---- # ---- # ---- # ---- # ---- # ---- # ---- # ---- # ---- # ---- # ---- # ---- # ---- # ---- # ---- # ---- # ---- # ---- #

# Selecionando as colunas.
df_final_result = pd.DataFrame(data=df_converts_result_group_one, columns=['QTDE_CLIENTES', 'NIVEL_EDUCACAO', 'ESTADO_CIVIL', 'PORCENTAGEM_CLIENTES', 'IDADE_MEDIA', 'RENDA_MEDIA_MENSAL_FAMILIAR', 'RENDA_MEDIA_FAMILIAR_ANUAL','TOTAL_CRIANCAS', 'MEDIA_CRIANCAS', 'TOTAL_ADOLESCENTES', 'MEDIA_ADOLESCENTES','MEDIA_TEMPO_CLIENTE_REGISTRADO_EMPRESA', 'MEDIA_DIAS_DESDE_ULT_COMPRA', 'TOTAL_COMPRAS_COM_DESCONTO', 'MEDIA_COMPRAS_COM_DESCONTO', 'TOTAL_COMPRAS_SITE', 'MEDIA_COMPRAS_SITE', 'TOTAL_COMPRAS_CATALOGO', 'MEDIA_COMPRAS_CATALOGO', 'TOTAL_COMPRAS_LOJA', 'MEDIA_COMPRAS_LOJA', 'TOTAL_VISITAS_SITE_ULT_MES', 'MEDIA_VISITAS_SITE_ULT_MES', 'TOTAL_VENDAS_CATEGORIA_VINHOS', 'TOTAL_VENDAS_CATEGORIA_FRUTAS', 'TOTAL_VENDAS_CATEGORIA_CARNES', 'TOTAL_VENDAS_CATEGORIA_PEIXES', 'TOTAL_VENDAS_CATEGORIA_DOCES', 'TOTAL_VENDAS_CATEGORIA_GOLD', 'TOTAL_PRODUTOS_VENDIDOS'])
                          
# ---- # ---- # ---- # ---- # ---- # ---- # ---- # ---- # ---- # ---- # ---- # ---- # ---- # ---- # ---- # ---- # ---- # ---- # ---- # ---- # ---- # ---- # ---- # ---- # ---- # ---- # ---- # ---- # ---- # ---- #

df_final_result.sort_values(by=['TOTAL_PRODUTOS_VENDIDOS'], ascending=False)

# ---- # ---- # ---- # ---- # ---- # ---- # ---- # ---- # ---- # ---- # ---- # ---- # ---- # ---- # ---- # ---- # ---- # ---- # ---- # ---- # ---- # ---- # ---- # ---- # ---- # ---- # ---- # ---- # ---- # ---- #
```
---
3º: Python pelo Visual Studio Code, onde utilizei o Python na IDLE Visual Studio Code, porém, pode ser utilizado em outra,  para realizar a mesma análise do job do Python do 1º item, porém, utilizando diretamente o arquivo CSV, sem utilização do SQL Server como base de armazenamento e consulta dos dados.

- Neste caso, é possível realizar a exportação do resultado para um arquivo em formato Excel.
```
# ---- # ---- # ---- # ---- # ---- # ---- # ---- # ---- # ---- # ---- # ---- # ---- # ---- # ---- # ---- # ---- # ---- # ---- # ---- # ---- # ---- # ---- # ---- # ---- # ---- # ---- # ---- # ---- # ---- # ---- #

# Caderno de resultados da análise da campanha de marketing.

# Python.

# Este script importa para algum local desejado o resultado.

# ---- # ---- # ---- # ---- # ---- # ---- # ---- # ---- # ---- # ---- # ---- # ---- # ---- # ---- # ---- # ---- # ---- # ---- # ---- # ---- # ---- # ---- # ---- # ---- # ---- # ---- # ---- # ---- # ---- # ---- #

# Instruções para utilização desse script.

# 1º - É necessário importar o arquivo que contém as informações do GitHub para um arquivo csv, pois, utilizamos o pandas com padrão csv para essa análise.
# 2º - Se possível nomeie o arquivo como (data.csv), e, caso escolha outro nome, altere o campo que contém o seguinte script (df = pd.read_csv(r'data.csv')) com o nome escolhido.
# 3º - Após importar para um arquivo csv, é necessário salvar em algum local em sua máquina.
# 4º - Altere o caminho origem do arquivo que foi salvo na sua máquina na linha 31.
# 5º - Altere o caminho destino do arquivo que será exportado em formato Exel na linha 141.
# 8º - Execute o script.
# 9º - Resultado será exibido em formato de tabela no terminal e será exportado para um arquivo em formato Excel.

# ---- # ---- # ---- # ---- # ---- # ---- # ---- # ---- # ---- # ---- # ---- # ---- # ---- # ---- # ---- # ---- # ---- # ---- # ---- # ---- # ---- # ---- # ---- # ---- # ---- # ---- # ---- # ---- # ---- # ---- #

# Importa a biblioca do pandas.
import pandas as pd
from datetime import datetime

# ---- # ---- # ---- # ---- # ---- # ---- # ---- # ---- # ---- # ---- # ---- # ---- # ---- # ---- # ---- # ---- # ---- # ---- # ---- # ---- # ---- # ---- # ---- # ---- # ---- # ---- # ---- # ---- # ---- # ---- #

# Lê o arquivo em formato csv.
# Altere o caminho abaixo para o local origem que foi salvo o arquivo csv
df = pd.read_csv(r'') 

# ---- # ---- # ---- # ---- # ---- # ---- # ---- # ---- # ---- # ---- # ---- # ---- # ---- # ---- # ---- # ---- # ---- # ---- # ---- # ---- # ---- # ---- # ---- # ---- # ---- # ---- # ---- # ---- # ---- # ---- #

# Variáveis:
df_count = float(df['ID'].count()) # Contar a quantidade de registros pelo campo ID.
df_monthlys = int(12)

# ---- # ---- # ---- # ---- # ---- # ---- # ---- # ---- # ---- # ---- # ---- # ---- # ---- # ---- # ---- # ---- # ---- # ---- # ---- # ---- # ---- # ---- # ---- # ---- # ---- # ---- # ---- # ---- # ---- # ---- #

# Tratatar os valores (NaN) da coluna (Income), visando não inteferir em cálculos futuros.
df_replace = df['Income'] = df['Income'].fillna(0)

# ---- # ---- # ---- # ---- # ---- # ---- # ---- # ---- # ---- # ---- # ---- # ---- # ---- # ---- # ---- # ---- # ---- # ---- # ---- # ---- # ---- # ---- # ---- # ---- # ---- # ---- # ---- # ---- # ---- # ---- #

# Alterar a configuração do número de linhas para exibição.
pd.set_option("display.max_rows", 2250)

# Alterar a configuração do número de colunas para exibição.
pd.set_option("display.max_columns", 40)

# ---- # ---- # ---- # ---- # ---- # ---- # ---- # ---- # ---- # ---- # ---- # ---- # ---- # ---- # ---- # ---- # ---- # ---- # ---- # ---- # ---- # ---- # ---- # ---- # ---- # ---- # ---- # ---- # ---- # ---- #

# Alterar os valores (NaN) da coluna (Income) visando não prejudicas análises futuras. 
df_replace = df['Income'].replace(['NaN'], '0')

# ---- # ---- # ---- # ---- # ---- # ---- # ---- # ---- # ---- # ---- # ---- # ---- # ---- # ---- # ---- # ---- # ---- # ---- # ---- # ---- # ---- # ---- # ---- # ---- # ---- # ---- # ---- # ---- # ---- # ---- #

# Excluir colunas do df.
#df = df.drop('YEARS_OLD', 1)
#df = df.drop('MONTHLY_INCOME', 1)
#df = df.drop('REGISTERED_CUSTOMER_TIME', 1)
#df = df.drop('KIDHOME2', 1)
#df = df.drop('TEENHOME2', 1)
#df = df.drop('NUMDEALSPURCHASES2', 1)
#df = df.drop('NUMWEBPURCHASES2', 1)
#df = df.drop('NUMCATALOGPURCHASES2', 1)
#df = df.drop('MNUMSTOREPURCHASES2', 1)
#df = df.drop('NUMWEBVISITSMONTH2', 1)

# Conferindo e inserindo novas colunas.
if set(['YEARS_OLD', 'MONTHLY_INCOME', 'REGISTERED_CUSTOMER_TIME', 'KIDHOME2', 'TEENHOME2', 'NUMDEALSPURCHASES2', 'NUMWEBPURCHASES2', 'NUMCATALOGPURCHASES2', 'MNUMSTOREPURCHASES2', 'NUMWEBVISITSMONTH2']).issubset(df.columns):
  print('colunas já existem')
else:
  df.insert(loc=1, column='YEARS_OLD', value=float(datetime.now().strftime('%Y')) - df['Year_Birth']) # Coluna que calcula a idade.
  df.insert(loc=2, column='MONTHLY_INCOME', value=df['Income'] / df_monthlys) # Coluna que calcula o salário mensal
  df.insert(loc=3, column='REGISTERED_CUSTOMER_TIME', value= float(datetime.now().strftime('%Y')) - df['Dt_Customer'].str.slice(0,4).apply(lambda x: float(x))) # Coluna que calcula tempo que o cliente é registrado na empresa em anos.
  df.insert(loc=4, column='KIDHOME2', value=df['Kidhome']) # Coluna extra para o campo (Kidhome) visando realização de cálculos no futuro da análise.
  df.insert(loc=6, column='TEENHOME2', value=df['Teenhome']) # Coluna extra para o campo (Teenhome) visando realização de cálculos no futuro da análise.
  df.insert(loc=7, column='NUMDEALSPURCHASES2', value=df['NumDealsPurchases']) # Coluna extra para o campo (NumDealsPurchases) visando realização de cálculos no futuro da análise.
  df.insert(loc=8, column='NUMWEBPURCHASES2', value=df['NumWebPurchases']) # Coluna extra para o campo (NumWebPurchases) visando realização de cálculos no futuro da análise.
  df.insert(loc=9, column='NUMCATALOGPURCHASES2', value=df['NumCatalogPurchases']) # Coluna extra para o campo (NumCatalogPurchases) visando realização de cálculos no futuro da análise.
  df.insert(loc=10, column='MNUMSTOREPURCHASES2', value=df['NumStorePurchases']) # Coluna extra para o campo (NumStorePurchases) visando realização de cálculos no futuro da análise.
  df.insert(loc=11, column='NUMWEBVISITSMONTH2', value=df['NumWebVisitsMonth']) # Coluna extra para o campo (NumWebVisitsMonth) visando realização de cálculos no futuro da análise.

# ---- # ---- # ---- # ---- # ---- # ---- # ---- # ---- # ---- # ---- # ---- # ---- # ---- # ---- # ---- # ---- # ---- # ---- # ---- # ---- # ---- # ---- # ---- # ---- # ---- # ---- # ---- # ---- # ---- # ---- #

# Alterando o nome das colunas.
df_alter_names_columns = df.rename(columns={'ID': 'QTDE_CLIENTES', 'Year_Birth': 'ANO_NASCIMENTO', 'YEARS_OLD': 'IDADE', 'MONTHLY_INCOME': 'RENDA_FAMILIAR_MENSAL', 'Education': 'NIVEL_EDUCACAO', 'Marital_Status': 'ESTADO_CIVIL', 'Income': 'RENDA_FAMILIAR_ANUAL', 'Kidhome': 'CRIANCAS', 'KIDHOME2': 'CRIANCAS2','Teenhome': 'ADOLESCENTES', 'TEENHOME2': 'ADOLESCENTES2', 'Dt_Customer': 'DATA_REGISTRO_CLIENTE_EMPRESA', 'REGISTERED_CUSTOMER_TIME': 'TEMPO_REGISTRO_CLIENTE_EMPRESA', 'Recency': 'QTDE_DIAS_DESDE_ULT_COMPRA', 'MntWines': 'PRODUTOS_VINHOS', 'MntFruits': 'PRODUTOS_FRUTAS', 'MntMeatProducts': 'PRODUTOS_CARNES'  , 'MntFishProducts': 'PRODUTOS_PEIXES', 'MntSweetProducts': 'PRODUTOS_DOCES', 'MntGoldProds': 'PRODUTOS_GOLD', 'NumDealsPurchases': 'NUMERO_COMPRAS_COM_DESCONTOS', 'NUMDEALSPURCHASES2': 'NUMERO_COMPRAS_COM_DESCONTOS2', 'NumWebPurchases': 'NUMERO_COMPRAS_SITE', 'NUMWEBPURCHASES2': 'NUMERO_COMPRAS_SITE2', 'NumCatalogPurchases': 'NUMERO_COMPRAS_CATALOGO', 'NUMCATALOGPURCHASES2': 'NUMERO_COMPRAS_CATALOGO2', 'NumStorePurchases': 'NUMERO_COMPRAS_LOJA', 'MNUMSTOREPURCHASES2': 'NUMERO_COMPRAS_LOJA2','NumWebVisitsMonth': 'NUMERO_VISITAS_SITE_ULT_MES', 'NUMWEBVISITSMONTH2': 'NUMERO_VISITAS_SITE_ULT_MES2', 'AcceptedCmp3': 'ACEITOS_CAMPANHA_3', 'AcceptedCmp4': 'ACEITOS_CAMPANHA_4', 'AcceptedCmp5': 'ACEITOS_CAMPANHA_5', 'AcceptedCmp1': 'ACEITOS_CAMPANHA_1', 'AcceptedCmp2': 'ACEITOS_CAMPANHA_2', 'Complain': 'COMPLAIN', 'Z_CostContact': 'Z_COSTCONTACT', 'Z_Revenue': 'Z_REVENUE', 'Response': 'ACEITOS_ULT_CAMPANHA'})

# Selecionando as colunas.
df_converts_result = pd.DataFrame(data=df_alter_names_columns, columns=['QTDE_CLIENTES', 'ANO_NASCIMENTO', 'IDADE', 'NIVEL_EDUCACAO', 'ESTADO_CIVIL', 'RENDA_FAMILIAR_MENSAL', 'RENDA_FAMILIAR_ANUAL', 'CRIANCAS', 'CRIANCAS2', 'ADOLESCENTES', 'ADOLESCENTES2', 'DATA_REGISTRO_CLIENTE_EMPRESA', 'TEMPO_REGISTRO_CLIENTE_EMPRESA', 'QTDE_DIAS_DESDE_ULT_COMPRA', 'PRODUTOS_VINHOS', 'PRODUTOS_FRUTAS', 'PRODUTOS_CARNES', 'PRODUTOS_PEIXES', 'PRODUTOS_DOCES', 'PRODUTOS_GOLD', 'NUMERO_COMPRAS_COM_DESCONTOS', 'NUMERO_COMPRAS_COM_DESCONTOS2', 'NUMERO_COMPRAS_SITE', 'NUMERO_COMPRAS_SITE2','NUMERO_COMPRAS_CATALOGO', 'NUMERO_COMPRAS_CATALOGO2', 'NUMERO_COMPRAS_LOJA', 'NUMERO_COMPRAS_LOJA2', 'NUMERO_VISITAS_SITE_ULT_MES', 'NUMERO_VISITAS_SITE_ULT_MES2','ACEITOS_CAMPANHA_3', 'ACEITOS_CAMPANHA_4', 'ACEITOS_CAMPANHA_5', 'ACEITOS_CAMPANHA_1', 'ACEITOS_CAMPANHA_2', 'COMPLAIN', 'Z_COSTCONTACT', 'Z_REVENUE', 'ACEITOS_ULT_CAMPANHA'])

# ---- # ---- # ---- # ---- # ---- # ---- # ---- # ---- # ---- # ---- # ---- # ---- # ---- # ---- # ---- # ---- # ---- # ---- # ---- # ---- # ---- # ---- # ---- # ---- # ---- # ---- # ---- # ---- # ---- # ---- #

# Agrupando campos e valores.
df_group_one = df_converts_result.groupby(['NIVEL_EDUCACAO', 'ESTADO_CIVIL']).agg({'QTDE_CLIENTES': 'count', 'IDADE': 'mean', 'RENDA_FAMILIAR_MENSAL': 'mean', 'RENDA_FAMILIAR_ANUAL': 'mean', 'CRIANCAS': 'sum', 'CRIANCAS2': 'mean', 'ADOLESCENTES': 'sum', 'ADOLESCENTES2': 'mean', 'TEMPO_REGISTRO_CLIENTE_EMPRESA': 'mean', 'QTDE_DIAS_DESDE_ULT_COMPRA': 'mean', 'NUMERO_COMPRAS_COM_DESCONTOS': 'sum', 'NUMERO_COMPRAS_COM_DESCONTOS2': 'mean', 'NUMERO_COMPRAS_SITE': 'sum', 'NUMERO_COMPRAS_SITE2': 'mean', 'NUMERO_COMPRAS_CATALOGO': 'sum', 'NUMERO_COMPRAS_CATALOGO2': 'mean', 'NUMERO_COMPRAS_LOJA': 'sum', 'NUMERO_COMPRAS_LOJA2': 'mean', 'NUMERO_VISITAS_SITE_ULT_MES': 'sum', 'NUMERO_VISITAS_SITE_ULT_MES2': 'mean', 'PRODUTOS_VINHOS': 'sum', 'PRODUTOS_FRUTAS': 'sum', 'PRODUTOS_CARNES': 'sum', 'PRODUTOS_PEIXES': 'sum', 'PRODUTOS_DOCES': 'sum', 'PRODUTOS_GOLD': 'sum'}).reset_index().round(2)

# Alterando o nome das colunas.
df_alter_names_columns_group_one = df_group_one.rename(columns={'QTDE_CLIENTES': 'QTDE_CLIENTES', 'IDADE': 'IDADE_MEDIA', 'RENDA_FAMILIAR_MENSAL': 'RENDA_MEDIA_MENSAL_FAMILIAR', 'RENDA_FAMILIAR_ANUAL': 'RENDA_MEDIA_FAMILIAR_ANUAL', 'CRIANCAS': 'TOTAL_CRIANCAS', 'CRIANCAS2': 'MEDIA_CRIANCAS','ADOLESCENTES': 'TOTAL_ADOLESCENTES', 'ADOLESCENTES2': 'MEDIA_ADOLESCENTES', 'TEMPO_REGISTRO_CLIENTE_EMPRESA': 'MEDIA_TEMPO_CLIENTE_REGISTRADO_EMPRESA', 'QTDE_DIAS_DESDE_ULT_COMPRA': 'MEDIA_DIAS_DESDE_ULT_COMPRA', 'NUMERO_COMPRAS_COM_DESCONTOS': 'TOTAL_COMPRAS_COM_DESCONTO', 'NUMERO_COMPRAS_COM_DESCONTOS2': 'MEDIA_COMPRAS_COM_DESCONTO', 'NUMERO_COMPRAS_SITE': 'TOTAL_COMPRAS_SITE', 'NUMERO_COMPRAS_SITE2': 'MEDIA_COMPRAS_SITE', 'NUMERO_COMPRAS_CATALOGO': 'TOTAL_COMPRAS_CATALOGO', 'NUMERO_COMPRAS_CATALOGO2': 'MEDIA_COMPRAS_CATALOGO', 'NUMERO_COMPRAS_LOJA': 'TOTAL_COMPRAS_LOJA', 'NUMERO_COMPRAS_LOJA2': 'MEDIA_COMPRAS_LOJA', 'NUMERO_VISITAS_SITE_ULT_MES': 'TOTAL_VISITAS_SITE_ULT_MES', 'NUMERO_VISITAS_SITE_ULT_MES2': 'MEDIA_VISITAS_SITE_ULT_MES', 'PRODUTOS_VINHOS': 'TOTAL_VENDAS_CATEGORIA_VINHOS', 'PRODUTOS_FRUTAS': 'TOTAL_VENDAS_CATEGORIA_FRUTAS', 'PRODUTOS_CARNES': 'TOTAL_VENDAS_CATEGORIA_CARNES', 'PRODUTOS_PEIXES': 'TOTAL_VENDAS_CATEGORIA_PEIXES', 'PRODUTOS_DOCES': 'TOTAL_VENDAS_CATEGORIA_DOCES', 'PRODUTOS_GOLD': 'TOTAL_VENDAS_CATEGORIA_GOLD'})

# ---- # ---- # ---- # ---- # ---- # ---- # ---- # ---- # ---- # ---- # ---- # ---- # ---- # ---- # ---- # ---- # ---- # ---- # ---- # ---- # ---- # ---- # ---- # ---- # ---- # ---- # ---- # ---- # ---- # ---- #

df_converts_result_group_one = pd.DataFrame(data=df_alter_names_columns_group_one, columns=['QTDE_CLIENTES', 'NIVEL_EDUCACAO', 'ESTADO_CIVIL', 'IDADE_MEDIA', 'RENDA_MEDIA_MENSAL_FAMILIAR', 'RENDA_MEDIA_FAMILIAR_ANUAL','TOTAL_CRIANCAS', 'MEDIA_CRIANCAS', 'TOTAL_ADOLESCENTES', 'MEDIA_ADOLESCENTES','MEDIA_TEMPO_CLIENTE_REGISTRADO_EMPRESA', 'MEDIA_DIAS_DESDE_ULT_COMPRA', 'TOTAL_COMPRAS_COM_DESCONTO', 'MEDIA_COMPRAS_COM_DESCONTO', 'TOTAL_COMPRAS_SITE', 'MEDIA_COMPRAS_SITE', 'TOTAL_COMPRAS_CATALOGO', 'MEDIA_COMPRAS_CATALOGO', 'TOTAL_COMPRAS_LOJA', 'MEDIA_COMPRAS_LOJA', 'TOTAL_VISITAS_SITE_ULT_MES', 'MEDIA_VISITAS_SITE_ULT_MES', 'TOTAL_VENDAS_CATEGORIA_VINHOS', 'TOTAL_VENDAS_CATEGORIA_FRUTAS', 'TOTAL_VENDAS_CATEGORIA_CARNES', 'TOTAL_VENDAS_CATEGORIA_PEIXES', 'TOTAL_VENDAS_CATEGORIA_DOCES', 'TOTAL_VENDAS_CATEGORIA_GOLD'])

# ---- # ---- # ---- # ---- # ---- # ---- # ---- # ---- # ---- # ---- # ---- # ---- # ---- # ---- # ---- # ---- # ---- # ---- # ---- # ---- # ---- # ---- # ---- # ---- # ---- # ---- # ---- # ---- # ---- # ---- #

# Excluir colunas do df.
#df = df_converts_result_group_one.drop('PORCENTAGEM_CLIENTES', 1)

# Conferindo e inserindo novas colunas.
if set(['PORCENTAGEM_CLIENTES']).issubset(df.columns):
  print('colunas já existem')
else:
  df_converts_result_group_one.insert(loc=12, column='PORCENTAGEM_CLIENTES', value=(df_converts_result_group_one['QTDE_CLIENTES'] * 100 / df_count).round(2)) # Coluna que calcula a porcentagem de clientes.

# ---- # ---- # ---- # ---- # ---- # ---- # ---- # ---- # ---- # ---- # ---- # ---- # ---- # ---- # ---- # ---- # ---- # ---- # ---- # ---- # ---- # ---- # ---- # ---- # ---- # ---- # ---- # ---- # ---- # ---- #

# Excluir colunas do df.
#df = df_converts_result_group_one.drop('PORCENTAGEM_CLIENTES', 1)

# Conferindo e inserindo novas colunas.
if set(['TOTAL_PRODUTOS_VENDIDOS']).issubset(df.columns):
  print('colunas já existem')
else:
  df_converts_result_group_one.insert(loc=13, column='TOTAL_PRODUTOS_VENDIDOS', value=df_converts_result_group_one['TOTAL_VENDAS_CATEGORIA_VINHOS'] + df_converts_result_group_one['TOTAL_VENDAS_CATEGORIA_FRUTAS'] + df_converts_result_group_one['TOTAL_VENDAS_CATEGORIA_CARNES'] + df_converts_result_group_one['TOTAL_VENDAS_CATEGORIA_PEIXES'] + df_converts_result_group_one['TOTAL_VENDAS_CATEGORIA_DOCES'] + df_converts_result_group_one['TOTAL_VENDAS_CATEGORIA_GOLD']) # Coluna que calcula o total de produtos vendidos de todas as categorias.

# ---- # ---- # ---- # ---- # ---- # ---- # ---- # ---- # ---- # ---- # ---- # ---- # ---- # ---- # ---- # ---- # ---- # ---- # ---- # ---- # ---- # ---- # ---- # ---- # ---- # ---- # ---- # ---- # ---- # ---- #

# Selecionando as colunas.
df_final_result = pd.DataFrame(data=df_converts_result_group_one, columns=['QTDE_CLIENTES', 'NIVEL_EDUCACAO', 'ESTADO_CIVIL', 'PORCENTAGEM_CLIENTES', 'IDADE_MEDIA', 'RENDA_MEDIA_MENSAL_FAMILIAR', 'RENDA_MEDIA_FAMILIAR_ANUAL','TOTAL_CRIANCAS', 'MEDIA_CRIANCAS', 'TOTAL_ADOLESCENTES', 'MEDIA_ADOLESCENTES','MEDIA_TEMPO_CLIENTE_REGISTRADO_EMPRESA', 'MEDIA_DIAS_DESDE_ULT_COMPRA', 'TOTAL_COMPRAS_COM_DESCONTO', 'MEDIA_COMPRAS_COM_DESCONTO', 'TOTAL_COMPRAS_SITE', 'MEDIA_COMPRAS_SITE', 'TOTAL_COMPRAS_CATALOGO', 'MEDIA_COMPRAS_CATALOGO', 'TOTAL_COMPRAS_LOJA', 'MEDIA_COMPRAS_LOJA', 'TOTAL_VISITAS_SITE_ULT_MES', 'MEDIA_VISITAS_SITE_ULT_MES', 'TOTAL_VENDAS_CATEGORIA_VINHOS', 'TOTAL_VENDAS_CATEGORIA_FRUTAS', 'TOTAL_VENDAS_CATEGORIA_CARNES', 'TOTAL_VENDAS_CATEGORIA_PEIXES', 'TOTAL_VENDAS_CATEGORIA_DOCES', 'TOTAL_VENDAS_CATEGORIA_GOLD', 'TOTAL_PRODUTOS_VENDIDOS'])
                          
# ---- # ---- # ---- # ---- # ---- # ---- # ---- # ---- # ---- # ---- # ---- # ---- # ---- # ---- # ---- # ---- # ---- # ---- # ---- # ---- # ---- # ---- # ---- # ---- # ---- # ---- # ---- # ---- # ---- # ---- #

# Resutaldo impresso no terminal.
print(df_final_result.sort_values(by=['TOTAL_PRODUTOS_VENDIDOS'], ascending=False))

# ---- # ---- # ---- # ---- # ---- # ---- # ---- # ---- # ---- # ---- # ---- # ---- # ---- # ---- # ---- # ---- # ---- # ---- # ---- # ---- # ---- # ---- # ---- # ---- # ---- # ---- # ---- # ---- # ---- # ---- #

# Gera um arquivo em formato Excel do script (query) executado no banco de dados.
df_final_result.to_excel(r'', index=False) # Insira o caminho do local de destino e não esqueça de inserir um nome para o arquivo com sua extensão, por exemplo (\caderno_resultado_analise_campanha_marketing.xlsx).

# ---- # ---- # ---- # ---- # ---- # ---- # ---- # ---- # ---- # ---- # ---- # ---- # ---- # ---- # ---- # ---- # ---- # ---- # ---- # ---- # ---- # ---- # ---- # ---- # ---- # ---- # ---- # ---- # ---- # ---- #
```
---
Fique á vontade para utilização dessa documentação e scripts, tanto SQL quanto Python! 
---
- Muito obrigado pela atenção e espero que gostem deste projeto!

---

[Acesse meu GitHub :cat:](https://github.com/Phelipe-Sempreboni)

[Acesse meu LinkedIn :computer:](https://www.linkedin.com/in/luiz-phelipe-utiama-sempreboni-319902169/)

---
