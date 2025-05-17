# Projeto de ETL com SQL Server e Python (Extração, Transformação e Carregamento) entre databases e tabela dentro do no SQL Server

#### Este projeto foi criado com base em um (business case) ou (caso de negócio) real, onde, foram utilizas as ferramentas SQL Server e Python para criação de uma ETL entre databases dentro do SQL Server. 

#### Ferramentas utilizadas neste projeto: SQL Server Management Studio 2017 e Python versão 3.8 (64-bit)

---

Explicação do projeto (Business Case ou Caso de Negócio):

Imagine que temos um database dentro do SQL Server Management Studio que seria o principal, onde este recebe as informações dos sistemas origem/legados da empresa e todos dados ficam alocados nele, por meio de schemas para realizar seus agrupamentos, onde temos ETLs (Extração, Transformação e Carregamentos) de dados por peridiocidade de acordo com a politica da empresa, setor, gerencia, diretoria e demanda dos usuários.

Imagine também que temos setores dentro dessa empresa, como Recursos Humanos (RH), Engenharia (ENG), Meio Ambiente (MA), etc, e cada um desses setores usa algum dado/tabela dessa database principal, onde seria necessário duplicar as informações do database principal para os databases de ramificações, pois, conforme politica da empresa, somente a área de TI e Cyber Security tem acesso e permissão a este database principal. Iremos utilziar como exemplo neste projeto o setor do Recursos Humanos (RH), que está localizado no schema (rh) e será o nosso business case ou caso de negócio para este projeto.

Notar que faremos uma ETL entre databases dentro do SQL Server, porém, este projeto contará desde a criação do database, criação de tabelas, inserção dados até chegar no arquivo Python para auxiliar nessa ETL.

Espero que este projeto ajude de alguma maneira seu processo, seu estudo, trabalho de faculdade ou curso, qualquer coisa só deixar um (ISSUE) no GitHub.

---

#### Comandos que você e/ou aprenderá neste projeto do SQL Server:

* USE.
* BEGIN E END.
* GO.
* CREATE DATABASE com e sem parametros.
* CREATE SCHEMA.
* CREATE TABLE.
* CREATE PROCEDURE convencional e criptografada.
* DROP DATABASE.
* DROP SCHEMA.
* DROP TABLE.
* INSERT INTO.
* TRUNCATE TABLE.
* SELECT.
* COUNT.
* EXEC / EXECUTE.
* OPENROWSET.
* SET NOCOUNT ON / OFF
* IF.
* WAITFOR DELAY.
* sp_configure.
* sp_MSSet_oledb_prop.
* sp_help
* sp_helptext

---

#### Comandos que você e/ou aprenderá neste projeto do Python:

Os comandos relacionados ao Python serão verificados de maneira mais fácil até para entedimento diretamente no arquivo do Python.

---

[Acesse meu GitHub :cat:](https://github.com/Phelipe-Sempreboni)

[Acesse meu LinkedIn :computer:](https://www.linkedin.com/in/luiz-phelipe-utiama-sempreboni-319902169/)

---

_Espero que este projeto ajude no trabalho, estudos ou ideias_ :smiley:
