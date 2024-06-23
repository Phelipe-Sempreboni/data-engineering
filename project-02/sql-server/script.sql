-- Business Case ou Caso de Negócio real, criado com dados fictios, porém, o mesmo raciocinio e algumas melhorias neste projeto.
-- Hoje temos muitos cursos para aprender as aplicações, mas, creio que talvez um projeto deste, em passos e etapas ajude as pessoas em uma aplicação real.

-- Leia o arquivo README.md inicial deste repositório (Projeto SQL Server x Python para dados ETL entre databases no SQL Server) do GitHub para entendimento do projeto.

-- Ferramentas: SQL Server Management Studio 2017 e Python versão 3.8 (64-bit).

-- Desenvolvido por: Luiz Phelipe Utiama Sempreboni.

--------------x--------------x--------------x--------------x--------------x--------------x--------------x--------------x--------------x--------------x--------------x--------------x--------------x--------------x--------------x--------------x--------------x--------------x--------------x-----
-- 1º Passo:

-- Criação do database (PHP_CONSULTORIA).
-- Foi criado com comando básico do SQL SERVER (CREATE DATABASE), onde irá se espelhar nos databases do sistema (model).
-- Não se esqueça de executar o comando para setar (USE master) o master, para garantir a criação do banco.

-- Explicação sobre o comando (USE):
-- O comando (USE) serve para setar e/ou alterar para um database dentro do SQL Server. Normalmente, quando fazemos login no SQL Server, entramos automaticamente no database (master) do sistema, então, é aconselhável utilizar o (USE) para selecionar o database onde realizará os trabalhos.

-- Explicação sobre comando (GO):
-- O comando (GO) informa até onde deve ser processado como uma unica batch, ou, para o português, unico lote de instruções. O (GO) sinaliza o término de um lote de instruções Transact-SQL para os utilitários do SQL Server.
-- Um exemplo. Se nós colocassemos na frente do (GO) um 2, seria equivalente indicar que as 2 instruções acima do (GO), que seriam (USE master) e (CREATE DATABASE PHP_CONSULTORIA) seriam executados duas vezes e assim por diante.
-- Vou deixar um pequeno teste para você executar e verificar o que foi dito acima. Pode alterar para seu nome se quiser e executar e também pode mudar a quantidade de vezes que aparece na frente do (GO).

-- Explicação sobre os comandos (BEGIN e END):
-- Comando (BEGIN) -> Informa o inicio de um código.
-- Comando (END) -> Informa o final de um código.
-- Observação: Irei exeplicando os comandos de acordo como for aparecendo nos passos. Para não ser repetitivo, explicarei somente nos passos, certo ? Valeu :)

-- Explicação sobre comando (DROP):
-- O comando (DROP) pode ser combinado com (DROP TABLE), (DROP SCHEMA), (DROP DATABASE) e server para exluir objetos de acordo com seu objetivo.

-- Site Microsoft:
-- Link: https://docs.microsoft.com/pt-br/sql/t-sql/statements/create-database-transact-sql?view=sql-server-ver15
-- Link: https://docs.microsoft.com/pt-br/sql/t-sql/language-elements/use-transact-sql?view=sql-server-ver15
-- Link: https://docs.microsoft.com/pt-br/sql/t-sql/language-elements/sql-server-utilities-statements-go?view=sql-server-ver15
-- Link: https://docs.microsoft.com/pt-br/sql/t-sql/language-elements/begin-end-transact-sql?view=sql-server-ver15
-- Link: https://docs.microsoft.com/pt-br/sql/t-sql/statements/drop-database-transact-sql?view=sql-server-ver15

----------------------------------------------------
-- Execute os comandos juntos para criar o database.
USE master;
CREATE DATABASE PHP_CONSULTORIA;
GO
----------------------------------------------------

-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
-- Execute os comandos juntos para dropar o database.
-- Se não conseguir dropar o database por comandos, tente exluir pelo assistente do SQL Server Management Studio. Se for usar esse método, flag o campo (Close existing connections) para fechar a conexão.
USE master;
DROP DATABASE PHP_CONSULTORIA;
GO
-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

------------------------------------------------------------------------------
-- Execute esse bloco para teste do comando (GO) e dos comandos (BEGIN e END).
-- Execute os comandos juntos.
BEGIN

DECLARE @NOME VARCHAR (30)
SET @NOME = 'Phelipe'

SELECT @NOME AS 'Seu nome'

END
GO 2
------------------------------------------------------------------------------

----------x----------x----------x----------x----------x----------x----------x----------x----------x

-- 2º Passo:

-- Criação do schema (agrupamento) que ficará a tabela de registro de funcionários.
-- Não se esqueça de setar (USE PHP_CONSULTORIA) o database (PHP_CONSULTORIA) para criar o schema no database correto.

-- Explicação sobre (schema):
-- Os Schemas são uma coleção de objetos dentro de um determinado database (banco de dados), servem para agrupar objetos no nível de aplicação como também para simplesmente fazer divisões departamentais. Schemas são bastante utilizados em padrões de sistema de banco de dados. São muito importantes para a performance e segurança.
-- Explicação foi retirada do site da DEVMEDIA. É bom ler esse artigo -> https://www.devmedia.com.br/schemas-no-sql-server/24328

-- Site Microsoft:
-- Link: https://docs.microsoft.com/pt-br/sql/t-sql/statements/create-schema-transact-sql?view=sql-server-ver15

-- Execute os comandos juntos.
USE PHP_CONSULTORIA;
GO

CREATE SCHEMA [rh];
GO

-------------------------------------------------------------------------------------------------------
-- Execute os comandos juntos se quiser dropar (excluir) o schema criado no database (PHP_CONSULTORIA).
USE PHP_CONSULTORIA;
GO

DROP SCHEMA [rh];
GO
-------------------------------------------------------------------------------------------------------
----------x----------x----------x----------x----------x----------x----------x----------x----------x

-- 3º Passo:

-- Criação da tabela que receberá os dados sobre registro de funcionários com (CREATE TABLE).
-- Notar que essa tabela que será criada possui uma chave primária (PRIMARY KEY) com a coluna da (matricula) do funcionário, logo, não serão aceitas matriculas com numeração igual. Ocorrerá um erro caso aconteça.
-- Aqui não precisamos utilizar o (USE) para setar um database, pois, o caminho do (SELECT * FROM) já está com caminho completo, [nome_database].[schema].[tabela].
-- Explicação do (CREATE DEFAULT) que é referente ao campo ([data_etl_base] DATETIME DEFAULT GETDATE()):

-- Site Microsoft:
-- Cria um objeto chamado padrão. Quando associado a uma coluna ou a um tipo de dados de alias, um padrão especifica um valor a ser inserido na coluna à qual o objeto está associado (ou em todas as colunas, no caso de um tipo de dados de alias), quando nenhum valor é fornecido explicitamente durante uma inserção.
-- Importante: Esse recurso será removido em uma versão futura do Microsoft SQL Server. Evite usar esse recurso em desenvolvimentos novos e planeje modificar os aplicativos que atualmente o utilizam. Em vez dela, use definições padrão criadas usando a palavra-chave DEFAULT de ALTER TABLE ou CREATE TABLE.
-- Notar que iremos criar igual o recomendado pela Microsoft, que é dentro do (CREATE TABLE) com (DEFAULT).
-- Link: https://docs.microsoft.com/pt-br/sql/t-sql/statements/create-default-transact-sql?view=sql-server-ver15

-- Site w3schools.com:
-- A restrição DEFAULT é usada para fornecer um valor padrão para uma coluna. O valor padrão será adicionado a todos os novos registros SE nenhum outro valor for especificado.
-- Link: https://www.w3schools.com/sql/sql_default.asp

-- Resumo: Como criamos uma coluna ([data_etl_base]) com DEFAULT, o padrão de preenchimento deste campo sera a data e hora atual do sistema e que ocorreu a (ETL -> Extração, Transformação e Carregamento).

CREATE TABLE [PHP_CONSULTORIA].[rh].[registro_funcionarios]
(
	[matricula] VARCHAR (10) NOT NULL,
	[nome do funcionario] VARCHAR (50) NOT NULL,
	[data de nascimento] DATE NOT NULL,
	[idade] INT NOT NULL,
    [data contratacao] DATE NOT NULL,
    [tipo da contratacao] VARCHAR (10) NOT NULL,
    [situacao] VARCHAR (10) NOT NULL,
	[cargo] VARCHAR (80) NOT NULL,
	[diretoria] VARCHAR (50) NOT NULL,
	[setor] VARCHAR (50) NOT NULL,
    [salario] FLOAT NOT NULL,
    [data ultima atualizado dos registros] DATE,
	[data_etl_base] DATETIME DEFAULT GETDATE()
    CONSTRAINT [PK_matricula] PRIMARY KEY CLUSTERED ([matricula])
);
GO

-------------------------------------------------------------------------------------------------------
-- Execute os comandos juntos se quiser dropar (excluir) a tabela criada no database (PHP_CONSULTORIA).

DROP TABLE [PHP_CONSULTORIA].[rh].[registro_funcionarios];
GO
-------------------------------------------------------------------------------------------------------
----------x----------x----------x----------x----------x----------x----------x----------x----------x

-- 4º Passo:

-- Comando (SELECT) para verificar rapidamente a estrutura da tabela que foi criada no (3º Passo).
-- Aqui não precisamos utilizar o (USE) para setar um database, pois, o caminho do (SELECT) já está com caminho completo, [nome_database].[schema].[tabela].

-- Explicação sobre comando (SELECT):
-- Site Microsoft:
-- Recupera linhas do banco de dados e permite a seleção de uma ou várias linhas ou colunas de uma ou várias tabelas no SQL Server. A sintaxe completa da instrução SELECT é complexa, mas as cláusulas principais podem ser assim resumidas: Verificar no site.
-- Link: https://docs.microsoft.com/pt-br/sql/t-sql/queries/select-transact-sql?view=sql-server-ver15

-- Resumo: Aqui usaremos a sintaxe simples do comando (SELECT), onde utilizaremos para verificar a estrutura da tabela, com suas colunas, campos (se houve dados) e conferencias gerais. Neste caso, selecionaremos todas colunas, com o (*).

SELECT * FROM [PHP_CONSULTORIA].[rh].[registro_funcionarios];
GO

----------x----------x----------x----------x----------x----------x----------x----------x----------x

-- 5º Passo:

-- Comandos necessários para executar o (6º Passo), pois, sem essa configuração não será possível ler o arquivo em Excel do registro de funcionários que irá compor a tabela criada (3º Passo). Notar adendos abaixo sobre esses comandos.
-- 1- Selecione todo script do lote deste (5º Passo) para habilitar os recursos e siga os passos abaixo para desabilitar. Também haverá no (9º Passo) um lote de script para desabilitar essas configurações.
-- 2- Para realizar a leitura e/ou importação por script do arquivo Excel com os registros de funcionários, temos que alterar a configuração do item II para (1) e dos itens (III e IIII) para (1) também, onde o 1 seria a habilitação e o 0 desabilitação.
-- 3- Aconselho que ao executar essa configuração para realizar o (6º Passo), seja alterado novamente para desabilitado por questões de segurança.
-- 4- Se o uso for recorrente, por exemplo, para exportação de dados, aconselho criar uma (STORED PROCEDURE - será visto mais a frente) que habilite e ao término do script desabilite as configurações, mas, haverá exemplo de uma STORED PROCEDURE assim.
-- 5- Não altere o item (I) para 0, pois, não funcionará.
-- 6- Caso trabalhe em uma empresa, consulte o DBA (Administrador do banco de dados)para saber se pode ser habilitada está configuração ou se tem algum procedimento para tal, pois, em servidores distribuídos temos a questão da segurança.
-- 7- Veja o video do link abaixo e configure a parte de (Server Objects) que é mencionado no video.
-- 8: É muito importante que seja visto o link do vídeo do Youtube para prosseguir, pois, tem uma pequena configuração que fica melhor sendo realizada observando o vídeo.
-- 9: Todos comandos deste lote podem ser executados em conjunto.
-- 10: Caso não consiga executar esse comandos e ocorrer erros, verifique o seu nível de usuário que foi concedido no SQL Server, pois, normalmente é necessário ter o (sysadmin). Converse com o DBA se necessário.

-- Abaixo materiais de apoio para melhor entendimento sobre esses assuntos:
-- Link da Bóson Treinamentos explicando sobre (Ad Hoc Distribute Queries) -> http://www.bosontreinamentos.com.br/bancos-de-dados/o-que-e-uma-consulta-ad-hoc-em-bancos-de-dados/
-- Link da Microsoft explicando sobre opções de configuração de (Ad Hoc Distribute Queries) -> https://docs.microsoft.com/pt-br/sql/database-engine/configure-windows/ad-hoc-distributed-queries-server-configuration-option?view=sql-server-ver15
-- Link de um breve video sobre leitura e/ou importação de arquivos Excel via comandos no SQL Server -> https://www.youtube.com/watch?v=KWEc-MzQUmg

---- Execute os comandos juntos.
USE master;
GO

-- I:
EXEC sp_configure 'Show Advanced Options', 1; -- Não altere;
RECONFIGURE
GO

-- II:
EXEC sp_configure 'Ad Hoc Distributed Queries', 1; -- Para desabilitar altere para 0;
RECONFIGURE
GO

-- III:
EXEC sp_MSSet_oledb_prop N'Microsoft.ACE.OLEDB.16.0', N'AllowInProcess', 1; -- Para desabilitar altere para 0;
GO

-- IIII:
EXEC sp_MSSet_oledb_prop N'Microsoft.ACE.OLEDB.16.0', N'DynamicParameters', 1; -- Para desabilitar altere para 0;
GO

----------x----------x----------x----------x----------x----------x----------x----------x----------x

-- 6º Passo:

-- Comando para realizar a leitura do arquivo Excel de registro de funcionários, que no (7º Passo) será importado para tabela registro de funcionários do database (PHP_CONSULTORIA). 
-- Iremos realizar a leitura primeiramente e posteriormente a inserção dos dados por comandos.
-- O arquivo Excel de registro de funcionários está na pasta deste projeto do GitHub para Dowload.
-- Salve o arquivo onde for melhor para você e não esqueça de alterar o caminho do arquivo conforme comentado abaixo.

-- Explicação sobre o comando (OPENROWSET): Neste caso, aconselho leitura direta no site da Microsoft pelo link abaixo, pois, a explicação é grande. Mas resumidamente, esse comando (OPENROWSET) nos ajudar na leitura e/ou importação de dados de uma fonte de dados externa, neste caso, o arquivo em Excel.
-- Site Microsoft:
-- É importante notar as questões de permissões e segurança para execução deste comando. Descrevi um pouco no (5º Passo).
-- Link: https://docs.microsoft.com/pt-br/sql/t-sql/functions/openrowset-transact-sql?view=sql-server-ver15

SELECT * FROM OPENROWSET
(
    'Microsoft.ACE.OLEDB.16.0',
    'Excel 12.0; Database=C:\Temp\Tabelas\Tabelas databases\PHP_CONSULTORIA\xlsx\registro_funcionarios.xlsx', -- Altere somente do (C:\...) para frente do caminho que você salvará/salvou o arquivo da tabela de funcinários do Excel.
    'SELECT * FROM [registro_funcionarios$]' -- Consulta realizada no arquivo Excel. O que está em colchetes é o nome que esta a planilha, normalmente como (Plan1), mas não neste caso. Não retire o ($) do comando, pois, ocorrerá erro.
);
GO

----------x----------x----------x----------x----------x----------x----------x----------x----------x

-- 7º Passo:

-- Comando para inserção dos dados do Excel para o database (PHP_CONSULTORIA) na tabela criada anteriormente (3º Passo) de registro de funcionarios.
-- Notar que o comando é praticamente o comando do (6º Passo), porém, com o (INSERT INTO) para adicionar os dados na tabela criada no (3º Passo).
-- Lembre-se que só é possível seguir com o comando do deste passo (7º Passo), caso tenha exito no (5º Passo).
-- O arquivo Excel de registro de funcionários está na pasta deste projeto do GitHub para Dowload.
-- Salve o arquivo onde for melhor para você e não esqueça de alterar o caminho do arquivo conforme comentado abaixo.

-- Observações importantes para o (INSERT INTO) e para executar no comando abaixo:
-- 1: Para inserir dados de uma tabela para outra entre databases do SQL SERVER como os comandos (INSERT INTO) e (SELECT * FROM) é necessário que os campos sejam iguais e o numeros de colunas iguais. Caso haja menos ou mais colunas, ocorrerá um erro.
-- 2: No nosso caso, no (3º Passo) criamos uma tabela identica para o database do RH, porém, criamos a coluna ([data_etl_base]) que foi deixada como (DEFAULT - padrão) para auto preehcimento com a data e hora atual, que garantirá para nós gravar o horário da (ETL).
-- 3: Para resolver esse caso e conseguir inserir os dados, iremos informar no (INSERT INTO) somente as colunas que são comuns entre a tabela (registro_funcionarios) dos databases (PHP_CONSULTORIA e PHP_CONSLTORIA_RH), logo, a coluna ([data_etl_base]) não entrará e será preenchida automaticamente.

-- Explicação sobre o comando (INSERT INTO):
-- Site Microsoft:
-- Adiciona uma ou mais linhas a uma tabela ou exibição no SQL Server.
-- Link: https://docs.microsoft.com/pt-br/sql/t-sql/statements/insert-transact-sql?view=sql-server-ver15

-- Explicação sobre o comando (TRUNCATE TABLE) e observações em comparação ao comando (DELETE):
-- Site Microsoft:
-- Explicação e Observação: Cuidado com o comando (TRUNCATE TABLE), pois, ele não contém clausula (WHERE), igual um comando (DELETE FROM WHERE), e o comando (TRUNCATE TABLE) tem um (COMMIT) explicito, então, uma vez excluídos os dados, não será possível recuperação, pois, diferente do comando (DELETE), o (TRUNCATE) não possuí arquivos de logs de transação para possível recuperação dos dados.
-- Link: https://docs.microsoft.com/pt-br/sql/t-sql/statements/truncate-table-transact-sql?view=sql-server-ver15
-- Link: https://docs.microsoft.com/pt-br/sql/t-sql/statements/delete-transact-sql?view=sql-server-ver15

-- I:
INSERT INTO [PHP_CONSULTORIA].[rh].[registro_funcionarios] ([matricula], [nome do funcionario], [data de nascimento], [idade], [data contratacao], [tipo da contratacao], [situacao], [cargo], [diretoria], [setor], [salario], [data ultima atualizado dos registros])
SELECT * FROM OPENROWSET
(
    'Microsoft.ACE.OLEDB.16.0',
    'Excel 12.0; Database=C:\Temp\Tabelas\Tabelas databases\PHP_CONSULTORIA\xlsx\registro_funcionarios.xlsx', -- Altere somente do (C:\...) para frente do caminho que você salvará/salvou o arquivo da tabela de funcinários do Excel.
    'SELECT * FROM [registro_funcionarios$]' -- Consulta realizada no arquivo Excel. O que está em colchetes é o nome que esta a planilha, normalmente como (Plan1), mas não neste caso. Não retire o ($) do comando, pois, ocorrerá erro.
);
GO

----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

-- Comando (TRUNCATE TABLE) para caso você queira excluir todos dados da tabela, conforme execução do comando mencionado acima (I) deste passo acima, que fez a inserção dos dados na tabela ([PHP_CONSULTORIA].[rh].[registro_funcionarios]).
-- Leia a explicação e observação sobre este comando (TRUNCATE TABLE),

TRUNCATE TABLE [PHP_CONSULTORIA].[rh].[registro_funcionarios];
GO

----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

----------x----------x----------x----------x----------x----------x----------x----------x----------x

-- 8º Passo:

-- Comando (SELECT) para verificar rapidamente se os dados foram inseridos corretamente conforme o (7º Passo).

SELECT * FROM [PHP_CONSULTORIA].[rh].[registro_funcionarios];
GO

----------x----------x----------x----------x----------x----------x----------x----------x----------x

-- 9º Passo:

-- Conforme descrito no (5º Passo), iremos desabilitar as configurações que foram habilitadas para leitura e inserção dos dados do arquivo Excel.
-- Tente executar os (6º Passo e 7º Passo) após execução deste script. Ocorrerá um erro.
-- Todos comandos deste lote podem ser executados em conjunto.
-- Caso não consiga executar esse comandos e ocorrer erros, verifique o seu nível de usuário que foi concedido no SQL Server, pois, normalmente é necessário ter o (sysadmin). Converse com o DBA se necessário.

-- Execute os comandos juntos.
USE [master];
GO

-- I:
EXEC sp_configure 'Show Advanced Options', 1; -- Não altere;
RECONFIGURE
GO

-- II:
EXEC sp_configure 'Ad Hoc Distributed Queries', 0; -- Para desabilitar altere para 0;
RECONFIGURE
GO

-- III:
EXEC sp_MSSet_oledb_prop N'Microsoft.ACE.OLEDB.16.0', N'AllowInProcess', 0; -- Para desabilitar altere para 0;
GO

-- IIII:
EXEC sp_MSSet_oledb_prop N'Microsoft.ACE.OLEDB.16.0', N'DynamicParameters', 0; -- Para desabilitar altere para 0;
GO

----------x----------x----------x----------x----------x----------x----------x----------x----------x

-- 10º Passo:

-- Criação do database (PHP_CONSULTORIA_RH).
-- Esse database será criado com um comando mais elaborado do SQL SERVER (CREATE DATABASE) com parametros conforme abaixo, definindo caminhos e tamanhos para os dados e logs de transação.
-- Não se esqueça de executar o comando para setar o master, para garantir a criação do banco.
-- Lembre-se de alterar o caminho das linhas 195 e 203 para o onde está seu banco de dados SQL Server Management Studio.
-- Não se esqueça de setar (USE master) para uma execução correta.
-- Todos comandos desse lote podem ser executado em conjunto.
-- Após criação, dê uma olhada na pasta que foi destinada a criação, e verá algumas diferenças da criação mais simples sem parametros do (CREATE DATABASE).

-- Execute os comandos juntos.
USE master;
CREATE DATABASE PHP_CONSULTORIA_RH
ON
( 
    NAME = PHP_CONSULTORIA_RH_DADOS,
    FILENAME = 'C:\DataBase\DataBaseFiles\PHP_CONSULTORIA_RH_DADOS.mdf', -- Altere para o caminho que foi especificado para o SQL Server, que seria o mais recomendado.
    SIZE = 10, -- Tamanho inicial
    MAXSIZE = 80, -- Tamanho máximo
    FILEGROWTH = 10 -- Taxa de crescimento do arquivo do database
)
LOG ON
( 
    NAME = PHP_CONSULTORIA_RH_LOG,
    FILENAME = 'C:\DataBase\LogFiles\PHP_CONSULTORIA_RH_LOG.ldf', -- Altere para o caminho que foi especificado para o SQL Server, que seria o mais recomendado.
    SIZE = 10MB, -- Tamanho inicial
    MAXSIZE = 80MB, -- Tamanho máximo
    FILEGROWTH = 10MB -- Taxa de crescimento do arquivo de log
);
GO

-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
-- Execute os comandos juntos para dropar o database.
-- Se não conseguir dropar o database por comandos, tente exluir pelo assistente do SQL Server Management Studio. Se for usar esse método, flag o campo (Close existing connections) para fechar a conexão.
USE master;
DROP DATABASE PHP_CONSULTORIA_RH;
GO
-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

----------x----------x----------x----------x----------x----------x----------x----------x----------x

-- 11º Passo:

-- Criação do schema (agrupamento) que ficará a tabela de registro de funcionários no database criado no (10º Passo) chamado (PHP_CONSULTORIA_RH).
-- Não se esqueça de setar (USE PHP_CONSULTORIA_RH) o database (PHP_CONSULTORIA_RH) para criar o schema no database correto.
-- Primeiro execute o comando (USE PHP_CONSULTORIA_RH) e depois o comando (CREATE SCHEMA [funcionarios]) para não ocorrer erro no comando, pois, o comando (CREATE SCHEMA) dever ser a primeira instrução em um lote de consulta.

USE PHP_CONSULTORIA_RH;
GO

CREATE SCHEMA [funcionarios];
GO

-------------------------------------------------------------------------------------------------------
-- Execute os comandos juntos se quiser dropar (excluir) o schema criado no database (PHP_CONSULTORIA_PHP).
USE PHP_CONSULTORIA_RH;
GO

DROP SCHEMA [funcionarios];
GO
-------------------------------------------------------------------------------------------------------

----------x----------x----------x----------x----------x----------x----------x----------x----------x

-- 12º Passo:

-- Iremos criar uma tabela quase identica ao do database (PHP_CONSULTORIA) de registro de funcionarios, como se estivessemos duplicando a estrutura da tabela para o pessoal do RH e somente RH consultar/modificar a tabela, porém, adicionando a coluna ([data_duplicacao_tabela]) que nos informará quando duplicamos a tabela.
-- Iremos imaginar que as tabelas origens dos sistemas da empresa como (SAP, TOTVS, etc) são todas armazenadas no database principal (PHP_CONSULTORIA) e á partir deste database serão distribuídas (ETL) nos demais databases de acordo com os setores.
-- Aqui não precisamos utilizar o (USE) para setar um database, pois, o caminho do (SELECT * FROM) já está com caminho completo, [nome_database].[schema].[tabela].
-- Notar que essa tabela que será criada possui uma chave primária (PRIMARY KEY) com a coluna da (matricula) do funcionário, logo, não serão aceitas matriculas com numeração igual. Ocorrerá um erro caso aconteça. 
-- Notar que adicionaremos a coluna ([data_duplicacao_tabela]) com (DEFAULT - Padrão) o (GETDATE()) para adicionar a data e hora atual do sistema, para informar quando duplicamos a tabela.
-- Executamos o mesmo procedimento no (3º Passo).

CREATE TABLE [PHP_CONSULTORIA_RH].[funcionarios].[registro_funcionarios]
(
	[matricula] VARCHAR (10) NOT NULL,
	[nome do funcionario] VARCHAR (50) NOT NULL,
	[data de nascimento] DATE NOT NULL,
	[idade] INT NOT NULL,
    [data contratacao] DATE NOT NULL,
    [tipo da contratacao] VARCHAR (10) NOT NULL,
    [situacao] VARCHAR (10) NOT NULL,
	[cargo] VARCHAR (80) NOT NULL,
	[diretoria] VARCHAR (50) NOT NULL,
	[setor] VARCHAR (50) NOT NULL,
    [salario] FLOAT NOT NULL,
    [data ultima atualizado dos registros] DATE,
	[data_etl_base] DATETIME,
	[data_duplicacao_tabela] DATETIME DEFAULT GETDATE(),
    CONSTRAINT [PK_matricula] PRIMARY KEY CLUSTERED ([matricula])
);
GO

-------------------------------------------------------------------------------------------------------
-- Execute os comandos juntos se quiser dropar (excluir) a tabela criada no database (PHP_CONSULTORIA_RH).

DROP TABLE [PHP_CONSULTORIA_RH].[funcionarios].[registro_funcionarios];
GO
-------------------------------------------------------------------------------------------------------
----------x----------x----------x----------x----------x----------x----------x----------x----------

-- 13º Passo:

-- Comando (SELECT) para verificar rapidamente a estrutura da tabela criada pelo (12º Passo).
SELECT * FROM [PHP_CONSULTORIA_RH].[funcionarios].[registro_funcionarios];
GO

----------x----------x----------x----------x----------x----------x----------x----------x----------

-- 14º Passo:

-- Iremos inserir os dados da tabela (registro_funcionarios) do database (PHP_CONSULTORIA - Principal) na tabela (registro_funcionarios) no database (PHP_CONSULTORIA_RH) do RH.
-- Iremos executar o comando (INSERT INTO) com o comando (SELECT * FROM) para realizar essa inserção e lembrando que os dados já estão/foram inseridos na tabela originára do database (PHP_CONSULTORIA).

-- I:
INSERT INTO [PHP_CONSULTORIA_RH].[funcionarios].[registro_funcionarios] ([matricula], [nome do funcionario], [data de nascimento], [idade], [data contratacao], [tipo da contratacao], [situacao], [cargo], [diretoria], [setor], [salario], [data ultima atualizado dos registros], [data_etl_base])
SELECT * FROM [PHP_CONSULTORIA].[rh].[registro_funcionarios];
GO

-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
-- Comando (TRUNCATE TABLE) para caso você queira excluir todos dados da tabela, conforme execução do comando mencionado acima (I) deste passo acima, que fez a inserção dos dados na tabela ([PHP_CONSULTORIA_RH].[funcionarios].[registro_funcionarios]).
-- Leia a explicação e observação sobre este comando (TRUNCATE TABLE),

TRUNCATE TABLE [PHP_CONSULTORIA_RH].[funcionarios].[registro_funcionarios];
GO
-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

----------x----------x----------x----------x----------x----------x----------x----------x----------x

-- 15º Passo:

-- Comando (SELECT) para verificar rapidamente se os dados foram inseridos corretamente conforme (14º Passo).
SELECT * FROM [PHP_CONSULTORIA_RH].[funcionarios].[registro_funcionarios];
GO

----------x----------x----------x----------x----------x----------x----------x----------x----------

-- Leia a nota abaixo:

----------x----------x----------x----------x----------x----------x----------x----------x----------x----------x----------x----------x----------x----------x----------x----------x----------x----------x----------x----------x----------x----------x----------x
-- Nota á partir daqui:

-- Imaagine que esse processo todo tenha que ser feito todos os dias ou algumas vezes na semana (periodicidade), tanto na tabela de registro de funcionários como com outras tabelas dos databases. 
-- Realizar esses procedimentos/passos manualmente seria improdutivo dependendo da quantidade de tabelas que tenham que ser trabalhadas, sem contar nas modificãções que talvez necessitem ser realizadas.
-- Iremos criar uma (STORED PROCEDURE - Procedimento Armazenado), que seria uma espécie de programação no SQL Server, onde "unificaremos" esses comandos e executaremos por uma unica linha (procedimento armazenado).
-- Iremos também utilizar o Python para finalizar o processo e tentar deixa-lo o mais automatizado possível. Esse Pyhon poderá ser convertido em um arquivo executável e inserido no Gerenciador de Tarefas do Windows como uma tarefa programada do sistema.
-- Podemos dizer que este processo que será realizado é como se fosse uma ETL (Extração, Transformação e Carregamento) de dados, entre databases e tabelas.

-- Explicação sobre (STORED PROCEDURE) ou (Procedimento Armazenado):
-- Iremos criar uma (STORED PROCEDURE - Procedimento Armazenado), que seria uma espécie de programação no SQL Server, onde "unificaremos" esses comandos e executaremos por uma unica linha (procedimento armazenado).
-- Recomendo ler no site da Microsoft sobre (STORED PROCEDURE).

-- Site Microsoft:
-- Link: https://docs.microsoft.com/pt-br/sql/t-sql/statements/create-procedure-transact-sql?view=sql-server-ver15
-- Link: https://docs.microsoft.com/pt-br/sql/relational-databases/stored-procedures/create-a-stored-procedure?view=sql-server-ver15
----------x----------x----------x----------x----------x----------x----------x----------x----------x----------x----------x----------x----------x----------x----------x----------x----------x----------x----------x----------x----------x----------x----------x

-- 16º Passo: Será dividido em 2 etapas.

-- Iremos criar, analisar, executar e unificar os comandos necessários e na ordem cronológica correta que necessitam ser executados para criação da (STORED PROCEDURE). 
-- Ainda não criaremos a (STORED PROCEDURE), pois, primeiramente vamos analisar os comandos, testa-los e posterioremente se todos forem executados corretamente, podemos seguir com a criação definitiva da (STORED PROCEDURE).
-- Imagine que a tabela (registro_funcionarios) já foi carregada para o database (PHP_CONSULTORIA) e a periodicidade de carregamento é de (1 em 1 semana). 
-- Então de 1 em 1 semana, nós teríamos que fazer esse processo com a tabela (registro_funcionários) para o database (PHP_CONSULTORIA_RH).
-- Vamos raciocinar. Para inserir dados de uma tabela para outra no SQL com o comando (INSERT INTO) e (SELECT * FROM), é necessário que ambas tabelas (origem e cópia) sejam iguais, mesma quantidade de campos... logo, se houver um campo a mais ou a menos ocorrerá um erro. 
-- Se notarmos, as tabelas de (registro_funcionarios) dos databases (PHP_CONSULTORIA) e (PHP_CONSULTORIA_RH) cada um tem uma coluna a mais que é a ([data_etl_base]) e (data_duplicacao_tabela) respectivamente, que foram adicionadsa para sabermos quando houve a (ETL) e (duplicação da tabela de registro de funcionários) para os databases (PHP_CONSULTORIA) e (PHP_CONSULTORIA_RH), logo, haveria erro ao tentar usar os comandos para inserção de dados, porém, vamos utilziar o mesmo comando (INSERT INTO) com (SELECT * FROM) do (7º Passo).

-- 1º: Para que o processo se repita automaticamente e seguindo uma lógica, devemos verificar e excluir os dados da tabela ([PHP_CONSULTORIA_RH].[funcionarios].[registro_funcionarios]). Iremos utilziar o comando (TRUNCATE TABLE).
-- 2º: Devemos, pela lógica, inserir os dados novamente na ([PHP_CONSULTORIA_RH].[funcionarios].[registro_funcionarios]) de uma maneira que não ocorra erros e automatizando o processo.

-- Vamos continuar!

----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
-- Vamos deixar um (SELEC) da tabela registro de funcionarios do database (PHP_CONSULTORIA) para conferencia ao decorrer da execução dos comandos, pois, essa será a tabela que será realizado todo processo.
SELECT * FROM [PHP_CONSULTORIA_RH].[funcionarios].[registro_funcionarios];
GO
----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

-- 1º:

-- I etapa:
-- Esse script verifica se a tabela de (registro_funcionarios) do database (PH_CONSULTORIA_RH) contém dados em sua estrutura, e, caso contenha dados serão truncados(execluídos), e, caso contrário, seguirá o fluxo dos demais comandos.
-- Observação: Cuidado com o comando (TRUNCATE TABLE), pois, ele não contém clausula (WHERE), igual um comando (DELETE FROM WHERE), e o comando (TRUNCATE TABLE) tem um (COMMIT) explicito, então, uma vez excluídos os dados, não será possível recuperação, pois, diferente do comando (DELETE), o (TRUNCATE) não possuí arquivos de logs de transação para possível recuperação dos dados.

-- Informações sobre os comandos (SET NOCOUNT ON) e (SET NOCOUNT OFF):
-- SET NOCOUNT ON -> Desabilita as mensagens de inserção de linhas (1 row affected), pois, as mensagens "pesam" na execução dependendo do que será feito e o tamanho do trabalho.
-- SET NOCOUNT OFF -> Sempre depois de utilizar O (SET NOCOUNT ON), é recomendável reabilita-lo por (SET NOCOUNT OFF).
-- Impede que a mensagem que mostra a contagem do número de linhas afetadas por uma instrução Transact-SQL ou por um procedimento armazenado seja retornada como parte do conjunto de resultados.

-- Site Microsoft:
-- Link: https://docs.microsoft.com/pt-br/sql/t-sql/statements/set-nocount-transact-sql?view=sql-server-ver15

BEGIN
SET NOCOUNT ON
END;

BEGIN
	IF OBJECT_ID ('PHP_CONSULTORIA_RH.funcionarios.registro_funcionarios') IS NOT NULL
	TRUNCATE TABLE [PHP_CONSULTORIA_RH].[funcionarios].[registro_funcionarios];
END;

-- 2º:

-- II etapa:
-- Aqui iremos inserir os dados novamente na tabela (registro_funcionarios) do database (PHP_CONSULTORIA_RH), que foram excluídos pela (II etapa).
-- O comando (WAITFOR DELAY) é como se fosse um cronometro para aguardar a execução de um determinado comando para o outro, como se estivesse em fila de espera. 
-- Irei deixar o comando (WAITFOR DELAY) juntamente com este. Você pode testa-lo selecionado e executando somente ele.
-- Deixaremos um tempo de 2 segundos conforme abaixo.
-- Este comando de (INSERT INTO) com (SELECT) é o mesmo do (14º Passo).

BEGIN
    WAITFOR DELAY '00:00:02'
    INSERT INTO [PHP_CONSULTORIA_RH].[funcionarios].[registro_funcionarios] ([matricula], [nome do funcionario], [data de nascimento], [idade], [data contratacao], [tipo da contratacao], [situacao], [cargo], [diretoria], [setor], [salario], [data ultima atualizado dos registros],[data_etl_base])
	SELECT [matricula], [nome do funcionario], [data de nascimento], [idade], [data contratacao], [tipo da contratacao], [situacao], [cargo], [diretoria], [setor], [salario], [data ultima atualizado dos registros], [data_etl_base] FROM [PHP_CONSULTORIA].[rh].[registro_funcionarios]
END;

BEGIN
SET NOCOUNT OFF
END;
GO

-- Aqui terminamos de unificar em etapas os scripts que irão compo nossa (STORED PROCEDUREs), que nos ajudará a deixar esse processo mais automatizado.

------------------------------------------------------------------------------------------------
-- Vamos deixar um (SELECT) da tabela para conferencias enquanto executamos os processos.
SELECT * FROM [PHP_CONSULTORIA_RH].[funcionarios].[registro_funcionarios];
GO
------------------------------------------------------------------------------------------------

-- 17º Passo:

-- Aqui faremos um último teste antes de criar a (STORED PROCEDURE), para garantir a execução correta.
-- Execute todo o batch (lote) abaixo, menos o (SELECT * FROM) para tetar os comandos e verificar se serão executados com sucesso.

BEGIN
SET NOCOUNT ON
END;

BEGIN
	IF OBJECT_ID ('PHP_CONSULTORIA_RH.funcionarios.registro_funcionarios') IS NOT NULL
	TRUNCATE TABLE [PHP_CONSULTORIA_RH].[funcionarios].[registro_funcionarios];
END;

BEGIN
    WAITFOR DELAY '00:00:02'
    INSERT INTO [PHP_CONSULTORIA_RH].[funcionarios].[registro_funcionarios] ([matricula], [nome do funcionario], [data de nascimento], [idade], [data contratacao], [tipo da contratacao], [situacao], [cargo], [diretoria], [setor], [salario], [data ultima atualizado dos registros],[data_etl_base])
	SELECT [matricula], [nome do funcionario], [data de nascimento], [idade], [data contratacao], [tipo da contratacao], [situacao], [cargo], [diretoria], [setor], [salario], [data ultima atualizado dos registros], [data_etl_base] FROM [PHP_CONSULTORIA].[rh].[registro_funcionarios]
END;

BEGIN
SET NOCOUNT OFF
END;
GO

------------------------------------------------------------------------------------------------
-- Vamos deixar um (SELECT) da tabela para conferencias enquanto executamos os processos.
SELECT * FROM [PHP_CONSULTORIA_RH].[funcionarios].[registro_funcionarios];
GO

----------x----------x----------x----------x----------x----------x----------x----------x----------

-- 18º Passo:

-- Aqui faremos a criação da (STORED PROCEDURE) para automatização dos passos manuais e conforme teste do (17º Passo).
-- Iremos utilziar o comando básico (CREATE PROCEDURE).
-- As (STORED PROCEDURES) devem ficar armazenadas em algum database, e, no nosso caso temos dois (PHP_CONSULTORIA e PHP_CONSULTORIA_RH). Iremos deixar a (STORED PROCEDURE) no database principal, que seria o que recebe a informação dos sistemas origem conforme dito anteriormente. Também definimos no nosso (BUSINESS CASE) ou (CASO DE NEGÓCIO). Esse assunto está no arquivo (README.md) deste projeto. É legal ler para entender esse projeto.
-- Lembre-se de setar o database com (USE nome_database) para que a (STORED PROCEDURE) seja criada no local que definimos, que será o database principal (PHP_CONSULTORIA).
-- No comando (CREATE PROCEDURE) não informe o caminho do database, ele será feito pelo setar (USE nome_database). Informe somente o schema (agrupamento) e em seguida o nome da procedure de sua escolha. Deixaremos a nossa (STORED PROCEDURE) no database (PHP_CONSULTORIA), no schema (rh) com nome de (spt_export_atualizacao_tabela_registro_funcionarios). O nome é livre, então fique a vontade, porém, por boas práticas de programação, crire (STORED PROCEDURE) com abreviação (spt), pois, o banco de dados já utiliza o (sp) para procedimento so próprio sistema, logo, o consumo de memória para localizar a sua (STORED PROCEDURE) é um pouco mais elevado e demorado se fosse (sp).

-- Explicação sobre (STORED PROCEDURE) ou (Procedimento Armazenado):
-- Iremos criar uma (STORED PROCEDURE - Procedimento Armazenado), que seria uma espécie de programação no SQL Server, onde "unificaremos" esses comandos e executaremos por uma unica linha (procedimento armazenado).
-- Recomendo ler no site da Microsoft sobre (STORED PROCEDURE).

-- Site Microsoft:
-- Link: https://docs.microsoft.com/pt-br/sql/t-sql/statements/create-procedure-transact-sql?view=sql-server-ver15
-- Link: https://docs.microsoft.com/pt-br/sql/relational-databases/stored-procedures/create-a-stored-procedure?view=sql-server-ver15

-- Execute todo os comandos juntos desse batch (lote).
USE PHP_CONSULTORIA;
GO

CREATE PROCEDURE [rh].[spt_export_atualizacao_tabela_registro_funcionarios]

AS

BEGIN
SET NOCOUNT ON
END;

BEGIN
	IF OBJECT_ID ('PHP_CONSULTORIA_RH.funcionarios.registro_funcionarios') IS NOT NULL
	TRUNCATE TABLE [PHP_CONSULTORIA_RH].[funcionarios].[registro_funcionarios];
END;

BEGIN
    WAITFOR DELAY '00:00:02'
    INSERT INTO [PHP_CONSULTORIA_RH].[funcionarios].[registro_funcionarios] ([matricula], [nome do funcionario], [data de nascimento], [idade], [data contratacao], [tipo da contratacao], [situacao], [cargo], [diretoria], [setor], [salario], [data ultima atualizado dos registros],[data_etl_base])
	SELECT [matricula], [nome do funcionario], [data de nascimento], [idade], [data contratacao], [tipo da contratacao], [situacao], [cargo], [diretoria], [setor], [salario], [data ultima atualizado dos registros], [data_etl_base] FROM [PHP_CONSULTORIA].[rh].[registro_funcionarios]
END;

BEGIN
SET NOCOUNT OFF
END;
GO

----------x----------x----------x----------x----------x----------x----------x----------x----------

-- 19º Passo:

-- Informações sobre o comando (EXECUTE):
-- ... A instrução EXECUTE pode ser usada para enviar comandos de passagem aos servidores vinculados. Além disso, o contexto no qual uma cadeia de caracteres ou comando é executado pode ser definido explicitamente.
-- Importante: Antes de chamar EXECUTE com uma cadeia de caracteres, valide a cadeia de caracteres. Nunca execute um comando construído por uma entrada de usuário que não foi validada.
-- Aconselho leitura no link abaixo do site da Microsoft.

-- Site Microsoft:
-- Link: https://docs.microsoft.com/pt-br/sql/t-sql/language-elements/execute-transact-sql?view=sql-server-ver15

-- Para testar o funcionamento da (STORED PROCEDURE) criada, vamos utilizar o comando (TRUNCATE TABLE) para excluir dos dados, utilizar o comando (SELECT) para verificar se os dados foram excluídos e em seguida executar a (STORED PROCEDURE) para verificar se os dados foram duplicados para tabela e atentar ao horário das ultimas duas colunas.
TRUNCATE TABLE [PHP_CONSULTORIA_RH].[funcionarios].[registro_funcionarios];
GO

-- Vamos executar a (STORED PROCEDURE) criada. Para executar uma (STORED PROCEDURE) utilize o comando (EXECUTE).
EXECUTE [PHP_CONSULTORIA].[rh].[spt_export_atualizacao_tabela_registro_funcionarios]

-- Vamos utilizar o (SELECT) para conferir se a execução da (STORED PROCEURE) funcionou.
-- Para verificar se funcionou, vamos nos orientar pelo horário. Execute o (SELECT) abaixo, verifique a coluna (data_duplicacao_tabela) e a data e hora, espere 1 minuto, execute a (STORED PROCEDURE) do (19º Passo) e caso o horário tenha sido alterado, a (STORED PROCEDURE) está funcionando.
-- Abaixo vou deixar um comando (SELECT) normal e um comando (SELECT) executado com o comando (EXECUTE).

SELECT * FROM [PHP_CONSULTORIA_RH].[funcionarios].[registro_funcionarios];

EXECUTE ('SELECT * FROM [PHP_CONSULTORIA_RH].[funcionarios].[registro_funcionarios]');

----------x----------x----------x----------x----------x----------x----------x----------x----------

-- 20º Passo: Bônus e Dicas!

-- Iremos criar uma (STORED PROCEDURE) sobre os assuntos do (5º Passo e 9º Passo), sobre (Ad Hoc Distributed Queries).
-- Releita todas informações do (5º Passo e 9º Passo), leia o site se possível para entender, pois, este assunto, é muito importante e requer atenção para ser executado, principalmente se você for executar na empresa em que trabalhe e servidores distribuídos.
-- Faça testes, entenda e posteriormente execute.
-- Se for na empresa em que trabalha, e você não for o DBA, consulte o DBA (Admistrador do banco de dados) para saber o procedimento e se é possível utilziar estes comandos.
-- Aconselhável criar uma (STORED PROCEDURE) e limitar os acessos a essa (STORED PROCEDURE) para quando for utilziar este tipo de comando, beleza ?
-- Observação: É possível limitar os acessos a uma (STORED PROCEDURE).

-- OBSERVAÇÃO: Irei dexiar os assuntos do (5º Passo e 9º Passo) para não precisarmos sempre ficar subindo, beleza ?

--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

-- 5º Passo:

-- Comandos necessários para executar o (6º Passo), pois, sem essa configuração não será possível ler o arquivo em Excel do registro de funcionários que irá compor a tabela criada (3º Passo). Notar adendos abaixo sobre esses comandos.
-- 1- Selecione todo script do lote deste (5º Passo) para habilitar os recursos e siga os passos abaixo para desabilitar. Também haverá no (9º Passo) um lote de script para desabilitar essas configurações.
-- 2- Para realizar a leitura e/ou importação por script do arquivo Excel com os registros de funcionários, temos que alterar a configuração do item II para (1) e dos itens (III e IIII) para (1) também, onde o 1 seria a habilitação e o 0 desabilitação.
-- 3- Aconselho que ao executar essa configuração para realizar o (6º Passo), seja alterado novamente para desabilitado por questões de segurança.
-- 4- Se o uso for recorrente, por exemplo, para exportação de dados, aconselho criar uma (STORED PROCEDURE - será visto mais a frente) que habilite e ao término do script desabilite as configurações, mas, haverá exemplo de uma STORED PROCEDURE assim.
-- 5- Não altere o item (I) para 0, pois, não funcionará.
-- 6- Caso trabalhe em uma empresa, consulte o DBA (Administrador do banco de dados)para saber se pode ser habilitada está configuração ou se tem algum procedimento para tal, pois, em servidores distribuídos temos a questão da segurança.
-- 7- Veja o video do link abaixo e configure a parte de (Server Objects) que é mencionado no video.
-- 8: É muito importante que seja visto o link do vídeo do Youtube para prosseguir, pois, tem uma pequena configuração que fica melhor sendo realizada observando o vídeo.
-- 9: Todos comandos deste lote podem ser executados em conjunto.
-- 10: Caso não consiga executar esse comandos e ocorrer erros, verifique o seu nível de usuário que foi concedido no SQL Server, pois, normalmente é necessário ter o (sysadmin). Converse com o DBA se necessário.

-- Abaixo materiais de apoio para melhor entendimento sobre esses assuntos:
-- Link da Bóson Treinamentos explicando sobre (Ad Hoc Distribute Queries) -> http://www.bosontreinamentos.com.br/bancos-de-dados/o-que-e-uma-consulta-ad-hoc-em-bancos-de-dados/
-- Link da Microsoft explicando sobre opções de configuração de (Ad Hoc Distribute Queries) -> https://docs.microsoft.com/pt-br/sql/database-engine/configure-windows/ad-hoc-distributed-queries-server-configuration-option?view=sql-server-ver15
-- Link de um breve video sobre leitura e/ou importação de arquivos Excel via comandos no SQL Server -> https://www.youtube.com/watch?v=KWEc-MzQUmg

---- Execute os comandos juntos.
USE master;
GO

-- I:
EXEC sp_configure 'Show Advanced Options', 1; -- Não altere;
RECONFIGURE
GO

-- II:
EXEC sp_configure 'Ad Hoc Distributed Queries', 1; -- Para desabilitar altere para 0;
RECONFIGURE
GO

-- III:
EXEC sp_MSSet_oledb_prop N'Microsoft.ACE.OLEDB.16.0', N'AllowInProcess', 1; -- Para desabilitar altere para 0;
GO

-- IIII:
EXEC sp_MSSet_oledb_prop N'Microsoft.ACE.OLEDB.16.0', N'DynamicParameters', 1; -- Para desabilitar altere para 0;
GO


-- 9º Passo:

-- Conforme descrito no (5º Passo), iremos desabilitar as configurações que foram habilitadas para leitura e inserção dos dados do arquivo Excel.
-- Tente executar os (6º Passo e 7º Passo) após execução deste script. Ocorrerá um erro.
-- Todos comandos deste lote podem ser executados em conjunto.
-- Caso não consiga executar esse comandos e ocorrer erros, verifique o seu nível de usuário que foi concedido no SQL Server, pois, normalmente é necessário ter o (sysadmin). Converse com o DBA se necessário.

-- Execute os comandos juntos.
USE [master];
GO

-- I:
EXEC sp_configure 'Show Advanced Options', 1; -- Não altere;
RECONFIGURE
GO

-- II:
EXEC sp_configure 'Ad Hoc Distributed Queries', 0; -- Para desabilitar altere para 0;
RECONFIGURE
GO

-- III:
EXEC sp_MSSet_oledb_prop N'Microsoft.ACE.OLEDB.16.0', N'AllowInProcess', 0; -- Para desabilitar altere para 0;
GO

-- IIII:
EXEC sp_MSSet_oledb_prop N'Microsoft.ACE.OLEDB.16.0', N'DynamicParameters', 0; -- Para desabilitar altere para 0;
GO
--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
-- Bônus e Dicas:

-- I:
-- Dicas sobre dados com execução da (STORED PROCEDURE) do sistema chamada: sp_help
-- Este comando consegue informar as informações de estrutura da nossa tabela do database (PHP_CONSULTORIA) da tabela (registro_funcionarios).
-- É um comando muito útil para quando haver dúvidas sobre estrutura de uma tabela que não foi você que criou.
-- Sempre use o setar database (USE) e no (sp_help) insira o nome do database, o schema e o nome da tabela ou esteja no database fonte da informação. Aconselho deixar os dois para não ocorrer erro.

USE PHP_CONSULTORIA_RH;
EXECUTE sp_help 'PHP_CONSULTORIA_RH.funcionarios.registro_funcionarios'
GO

-- II:
-- Dica sobre (STORED PROCEDURE) com execução da própria (STORED PROCEDURE) do sistema chamada: sp_helptext
-- Este comando consegue ler/informar o conteúdo de uma (STORED PROCEDURE).
-- Execute o comando abaixo e faça o teste.
-- Observação: É possível criptografar uma (STORED PROCEDURE) e dessa maneira não será possível visualiza-la com o comando (sp_helptext). Iremos fazer um teste deste caso também com nossa (STORED PROCEDURE) do database (PHP_CONSULTORIA).
-- Essa nossa (STORED PROCEDURE) abaixo criada no (18º Passo) não possui criptografia, logo, conseguimos visualizar o seu conteúdo sem problemas.

USE PHP_CONSULTORIA;
EXECUTE sp_helptext '[PHP_CONSULTORIA].[rh].[spt_export_atualizacao_tabela_registro_funcionarios]'
GO

-- Tente executar novamente o comando abaixo, porém, da (STORED PROCEDURE) que foi criptografada no item (III).
USE PHP_CONSULTORIA;
EXECUTE sp_helptext '[PHP_CONSULTORIA].[rh].[spt_export_atualizacao_tabela_registro_funcionarios_criptogragado]'
GO

-- III: 
-- Criptografando uma (STORED PROCEDURE) para que não seja possível visualizar sua estrutura com a (STORED PROCEDURE) do sistema (sp_helptext).
-- Copie o comando do lote do (18º Passo), e abaixo do comando (CREATE PROCEDURE) adicione o comando (WITH ENCRYPTION) que seria (COM CRIPTOGRAFIA).
-- Para não ocorrer erros na criação dessa (STORED PROCEDURE CRIPTOGRAFA) altere o nome na frente do (CREATE PROCEDURE). Vamos inserir no final um (_criptografado) para diferencia da existente.
-- Vamos criar no mesmo database da (STORED PROCEDURE) que já temos definida como ([PHP_CONSULTORIA].[rh].[spt_export_atualizacao_tabela_registro_funcionarios).
-- Execute o lote de comandos deste item (III) e posteriormente tente executar o comando do item (II).
-- Iremos ter um código informando que a (STORED PROCEDURE) é criptografada e nem pelo assistente do SQL Server Management Studio é possível modificar ou visualizar o seu conteúdo.

-- Observações para criar a (STORED PROCEDURE):
-- Execute o (5º Passo) - Reabilitar configurações.
-- Execute o lote de instrução abaixo deste item (III) para criar a (STORED PROCEDURE).
-- Execute o (9º Passo) - Desabilitar configuranções que foram habilitadas pelo (5º Passo).


USE PHP_CONSULTORIA;
GO

CREATE PROCEDURE [rh].[spt_export_atualizacao_tabela_registro_funcionarios_criptogragado]

WITH ENCRYPTION

AS

BEGIN
SET NOCOUNT ON
END;

BEGIN
	IF OBJECT_ID ('PHP_CONSULTORIA_RH.funcionarios.registro_funcionarios') IS NOT NULL
	TRUNCATE TABLE [PHP_CONSULTORIA_RH].[funcionarios].[registro_funcionarios];
END;

BEGIN
    WAITFOR DELAY '00:00:02'
    INSERT INTO [PHP_CONSULTORIA_RH].[funcionarios].[registro_funcionarios] ([matricula], [nome do funcionario], [data de nascimento], [idade], [data contratacao], [tipo da contratacao], [situacao], [cargo], [diretoria], [setor], [salario], [data ultima atualizado dos registros],[data_etl_base])
	SELECT [matricula], [nome do funcionario], [data de nascimento], [idade], [data contratacao], [tipo da contratacao], [situacao], [cargo], [diretoria], [setor], [salario], [data ultima atualizado dos registros], [data_etl_base] FROM [PHP_CONSULTORIA].[rh].[registro_funcionarios]
END;

BEGIN
SET NOCOUNT OFF
END;
GO
--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

-- Bônus e Dicas:
-- Criando uma (STORED PROCEDURE) para habilitar e desabilitar configurações de (Ad Hoc Distributed Queries) e (OLE DB) utilizando os (5º Passo e 9º Passo).
-- Importante ler as intruções de texto dos (5º Passo e 9º Passo) e ter assistido o video que foi deixado o link no (5º Passo), pois, lá explica rapidamente sobre (N'Microsoft.ACE.OLEDB.16.0', N'AllowInProcess') e você precisará verificar qual o drive/versão do seu SQL Server Management Studio.
-- AConselho reler novamente o (5º Passo e 9º Passo).

-- I:
-- Criando uma (STORED PROCEDURE) de habilitação de (Ad Hoc Distributed Queries).
-- Por motivos de segurança, essa será um Query criptograda igual a vista acima do bonus, no item (III).
-- Como combinado anteriormente, nossas (STORED PROCEDURES) ficariam alocadas no database (PHP_CONSULTORIA) por ser o database principal. Já temos o schema (agrupamento), chamado (rh) criado. Iremos criar um schema chamado (config), que será o quê fará o agrupamento para esse tipo de processo, usando processos de configuração e reconfiguração.

------------------------------------------------------------
-- Criação do schema (config) no database (PHP_CONSULTORIA).
USE PHP_CONSULTORIA;
GO

CREATE SCHEMA config;
GO
------------------------------------------------------------

---------------------------------------------------------------------------------
-- Criação da (STORED PROCEDURE) criptografada de habilitação das configurações.

USE PHP_CONSULTORIA;
GO

CREATE PROCEDURE [config].[habitar_ad_hoc_distributed_queries_ole_db]

WITH ENCRYPTION

AS

BEGIN

EXEC sp_configure 'Show Advanced Options', 1;
RECONFIGURE

EXEC sp_configure 'Ad Hoc Distributed Queries', 1;
RECONFIGURE

EXEC sp_MSSet_oledb_prop N'Microsoft.ACE.OLEDB.16.0', N'AllowInProcess', 1;

EXEC sp_MSSet_oledb_prop N'Microsoft.ACE.OLEDB.16.0', N'DynamicParameters', 1;

END
GO
---------------------------------------------------------------------------------

---------------------------------------------------------------------------------

-- Criação da (STORED PROCEDURE) criptografada de desabilitação das configurações.

USE PHP_CONSULTORIA;
GO

CREATE PROCEDURE [config].[desabilitar_ad_hoc_distributed_queries_ole_db]

WITH ENCRYPTION

AS

BEGIN

EXEC sp_configure 'Show Advanced Options', 1;
RECONFIGURE

EXEC sp_configure 'Ad Hoc Distributed Queries', 0;
RECONFIGURE

EXEC sp_MSSet_oledb_prop N'Microsoft.ACE.OLEDB.16.0', N'AllowInProcess', 0;

EXEC sp_MSSet_oledb_prop N'Microsoft.ACE.OLEDB.16.0', N'DynamicParameters', 0;

END
GO

---------------------------------------------------------------------------------

-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

-- Execute a (STORED PROCEDURE) abaixo que foi criada para habilitação das configurações e faça o teste.
-- Execute a (STORED PROCEDURE) abaixo que foi criada para desabilitação das configurações e faça o teste.
-- Para fazer o teste, vamos executar o comando do (6º Passo), que faz a leitura do arquivo Excel que contém os dados da tabela de registro de funcionários, que só conseguimos ler caso as configurações estejam habilitadas.
-- O teste está abaixo como (TESTE de habilitação e desabilitação).

-- Primeiro: Faça o teste de habilitação: Execute a (STORED PROCEDURE) de habilitação, execute o (TESTE de habilitação e desabilitação).
-- Segundo: Faça o teste da desabilitação: Execute a (STORED PROCEDURE) de desabilitação, execute o (TESTE de habilitação e desabilitação), ocorreá um erro sobre a leitura do arquivo.

-- IMPORTANTE: Se não for utilizar esse recurso, aconselho mante-lo desabilitado.

-- Habilitação:
EXECUTE [PHP_CONSULTORIA].[config].[habitar_ad_hoc_distributed_queries_ole_db];
GO

-- Desabilitação:
EXECUTE [PHP_CONSULTORIA].[config].[desabilitar_ad_hoc_distributed_queries_ole_db];
GO

-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

-- TESTE de habilitação e desabilitação:

SELECT * FROM OPENROWSET
(
    'Microsoft.ACE.OLEDB.16.0',
    'Excel 12.0; Database=C:\Temp\Tabelas\Tabelas databases\PHP_CONSULTORIA\xlsx\registro_funcionarios.xlsx', -- Altere somente do (C:\...) para frente do caminho que você salvará/salvou o arquivo da tabela de funcinários do Excel.
    'SELECT * FROM [registro_funcionarios$]' -- Consulta realizada no arquivo Excel. O que está em colchetes é o nome que esta a planilha, normalmente como (Plan1), mas não neste caso. Não retire o ($) do comando, pois, ocorrerá erro.
);
GO

-- Comando (SELECT) para conferencias:

SELECT * FROM [PHP_CONSULTORIA_RH].[funcionarios].[registro_funcionarios];
GO

---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

-- (STORED PROCEDURES) que temos criadas no database (PHP_CONSULTORIA), que é o local que combinamos de alocar. Se você quiser alocar também em outro database, não tem problema.

EXECUTE [PHP_CONSULTORIA].[rh].[spt_export_atualizacao_tabela_registro_funcionarios];
GO

EXECUTE [PHP_CONSULTORIA].[rh].[spt_export_atualizacao_tabela_registro_funcionarios_criptogragado];
GO

EXECUTE [PHP_CONSULTORIA].[config].[habitar_ad_hoc_distributed_queries_ole_db];
GO

EXECUTE [PHP_CONSULTORIA].[config].[desabilitar_ad_hoc_distributed_queries_ole_db];
GO

---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

-- 21º Passo: Agora iremos para parte do Python!

-- Agora iremos utilizar o Python para nos auxiliar e talvez despertar seu interesse pela ferramenta caso não utilize.
-- Python é uma linguagem de programação (Open Source) ou em português (Código Aberto), que é uma linguagem muito utilizada por Cientista de Dados, Analista de Dados e quem trabalhar e analisa dados.
-- É uma ferramenta interessante de aprender para ajudar na sua trajetória.

-- 1º Passo: Caso você não possua o Python, será necessário instalar. Te indico depois de instalar o Python, instalar e utilizar a IDLE chamada PyCharm para manipulação dos códigos da ferramenta. Também é possível instalar o VSCODE e baixar a extensão do Python, que é até mais leve que utilizar o PyCharm.
-- 2º Passo: Vá ao GitHub onde está este projeto em extensão (.sql) e haverá uma em extensão (.py).
-- 3º Passo: Abra esse arquivo (.py), leia as instruções que estão comentadas neste arquivo.
-- 4º Passo: Após leitura e entedimento, copie esse código e insira na IDLE que você utilizar em seu computador.
-- 5º Passo: Se já tiver feito toda alteração para que funcione no seu computador, execute o código no Python e confira no SQL Server Management Studio o horário da última coluna da tabela de (registro_funcionarios) do database (PHP_CONSULTORIA_RH).
-- 6º Passo: Caso o horário seja o mesmo que você fez a execução do código, observando o horário do seu computador, o comando está funcionando e também aparecerá no Python as mensagens caso haja sucesso ou haja erro.

-- Deixarei um (SELECT) para conferência se o código Python para SQL Server Management Studio funcioniou:
SELECT * FROM [PHP_CONSULTORIA_RH].[funcionarios].[registro_funcionarios];
GO

-- Este comando abaixo esta dentro do arquivo Python, na função (def query_qtde_carregada():) para contabilizar e confirmar por mensagem a quantidade de linhas inseridas na tabelas.
SELECT COUNT(*) FROM [PHP_CONSULTORIA_RH].[funcionarios].[registro_funcionarios]
GO

---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

-- Espero que este projeto ajude no trabalho, estudos ou nas ideias!

-- Valeu!