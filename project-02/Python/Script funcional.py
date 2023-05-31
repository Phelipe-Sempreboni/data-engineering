#Essa conexão que iremos fazer com o database do SQL Server, está por autenticação do SQL Server, logo necessita de senha.
#Se quiser fazer por autenticação Windows, altere o comando da função (def conectar():), chamado (Trusted_Connection='no') para (yes) e retire o comando (pwd) que seria a inserção de senha.

#Nota: Os comandos abaixo são do projeto SQL Server que está neste pasta chamada (Projeto SQL Server x Python p/ dados - ETL entre databases no SQL Server) , então, é o que realizará a nossa (ETL) entre databases dentro do SQL Server. 
#Nota2: Esse projeto foi baseado em (Business Case) ou (Caso de Negócio) real.
#Nota3: Você pode utilizar de modelo se quiser para testes em outras demandas e estudar se quiser.
#Nota4: Por favor, para não ocorrer erros, vá lendo os comentários das linhas com atenção. 
#Nota5: Para verificar o (DRIVER) do SQL Server, conforme temos em todos comandos, você pode seguir o caminho: Tecla do Windows ou no pesquisa, digitar (ODBC), irá abrir uma janela com algumas abas, procure por (DRIVERS) e procure os referente a (SQL Server). Lá estarão as informações de (DRIVERS).

import pyodbc #importar biblioteca para conexão com banco de dados.
import time #importar bibliotaca para informação de data e hora.

def conectar():
    try:
        conexao = pyodbc.connect(
            Driver='{SQL Server Native Client 11.0}', #Altere de acordo com seu driver. A (#Nota5) fala desse assunto.
            Server='SERVIDOR', #Insira seu servidor.
            Database='PHP_CONSULTORIA', #Insira o nome do banco de dados (database) que você quer conectar. Neste caso, iremos manter o (PHP_CONSULTORIA) que é o database que utilziamos para este projeto entre SQL Server x Python.
            uid='USUARIO', #Insira seu usuário.
            pwd='SENHA', #Insira sua senha.
            Trusted_Connection='no' #Este campo em (no) refere-se ao tipo de autentição, neste caso, autenticação SQL Server. Se quiser fazer com autenticação Windows, retire o campo (pwd) que seria a senha, e mude este campo para (yes).
        )
        return conexao.cursor()
    except:
        return 1

def query_execute_stored_procedure():
    try:
        cursor = conectar()
        query_exec_stored_procedure = "EXECUTE [PHP_CONSULTORIA].[rh].[spt_export_atualizacao_tabela_registro_funcionarios]" #Insira a (STORED PROCEDURE) que deseja executar. Neste caso, vamos manter essa (STORED PROCEDURE), pois, é a do nosso projeto.
        cursor.execute(query_exec_stored_procedure)
        cursor.commit()
        return()
    except:
        print('Não foi possivel retornar os dados da consulta.') #Mensagem pode ser alterada se quiser.
    finally:
        print('Stored Procedure executada com sucesso.') #Mensagem pode ser alterada se quiser.

def query_qtde_carregada():
    try:
        cursor = conectar()
        data_hora_minuto_segundo_atual = time.strftime('%d-%m-%Y ás %H:%M:%S', time.localtime()) #Aqui você pode fazer alteração do formato de data se tiver conhecimento, do que está dentro do parenteses.
        query_exec_contador_linhas = "SELECT COUNT(*) FROM [PHP_CONSULTORIA_RH].[funcionarios].[registro_funcionarios]" #Insira a query que desaja executar. Neste caso, vamos manter a nossa query que contará a quantidade de linhas da tabelas do database.
        cursor.execute(query_exec_contador_linhas)
        query_resultado = cursor.fetchone()
        return()
    finally:
        print('Quantidade de linhas inseridas na tabela é de',query_resultado, 'em', data_hora_minuto_segundo_atual,'.') #Mensagem pode ser alterada se quiser, mas os campos em branco, que são funções, não devem ser alteradas.

def encerrar_cursor_conexao():
    try:    
        cursor = conectar()
        cursor.close()
        conexao = conectar()
        conexao.close()
        return()
    except:
        print("Não foi possível encerrar o cursor e a conexão.") #Mensagem pode ser alterada se quiser.
    finally:
        print("Cursor e conexão com banco de dados foram encerradas.") #Mensagem pode ser alterada se quiser.

def execucoes():
    try:
        query_execute_stored_procedure()
        query_qtde_carregada()
        encerrar_cursor_conexao()
    except:
        print('Caso haja erro na conexão com banco de dados ou falha na execução da consulta, por favor, verifique ou solicite ao responsável da programação verificar os scripts.') #Mensagem pode ser alterada se quiser.
execucoes()