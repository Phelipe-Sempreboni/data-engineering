# -------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- #

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
Database='', # Insira o banco de dados. Neste job, insira o banco de dados que foi criado manualmente, o (customersuccess).
uid='', # Insira o usuário. É possível conectar por autentição do Windows.
pwd='', # Insira a senha. É possível conectar por autentição do Windows.
trusted_Connection='no', # Se o login no banco de dados é realizados com Autentição SQL Server, ou seja, com login e senha, deixe marcado como (no), caso contrário, retire o comando da linha de senha (pwd) e deixe este campo como (yes), informando que a conexão é por meio de Autentição Windows, ou seja, não necessita da senha.
autocommit=True  # Por padrão, o commit, que é a confirmação das transações no script SQL Server, principalmente para DDL, vem como (FALSE). Neste comando ele é alterado para (TRUE), visando fazer os scripts do SQL Server neste job do Python funcionarem e serem executados corretamente.
)
cursor = conexao.cursor() # Criação do cursor para executar comandos no banco de dados.

# Dropar/deletar a tabela se ela já existir e recria-lá com os critérios validados.
conexao.execute("""
drop table if exists [customersuccess].[marketing].[tb_customersuccess_sot_marketing_campaign];

create table [customersuccess].[marketing].[tb_customersuccess_sot_marketing_campaign] (
	 id int -- tipo do dado da coluna validado.
	,year_birth float -- tipo do dado da coluna validado.
	,education varchar (20) -- tipo do dado da coluna validado.
	,marital_status varchar (20) -- tipo do dado da coluna validado.
	,income float -- tipo do dado da coluna validado.
	,kidhome float -- tipo do dado da coluna validado.
	,teenhome float -- tipo do dado da coluna validado.
	,dt_customer date -- tipo do dado da coluna validado.
	,recency float -- tipo do dado da coluna validado.
	,mnt_wines float -- tipo do dado da coluna validado.
	,mnt_fruits float -- tipo do dado da coluna validado.
	,mnt_meat_products float -- tipo do dado da coluna validado.
	,mnt_fish_products float -- tipo do dado da coluna validado.
	,mnt_sweet_products float -- tipo do dado da coluna validado.
	,mnt_gold_prods float -- tipo do dado da coluna validado.
	,num_deals_purchases float -- tipo do dado da coluna validado.
	,num_web_purchases float -- tipo do dado da coluna validado.
	,num_catalog_purchases float -- tipo do dado da coluna validado.
	,num_store_purchases float -- tipo do dado da coluna validado.
	,num_web_visits_month float -- tipo do dado da coluna validado.
	,accepted_cmp3 float -- tipo do dado da coluna validado.
	,accepted_cmp4 float -- tipo do dado da coluna validado.
	,accepted_cmp5 float -- tipo do dado da coluna validado.
	,accepted_cmp1 float -- tipo do dado da coluna validado.
	,accepted_cmp2 float -- tipo do dado da coluna validado.
	,complain float -- tipo do dado da coluna validado.
	,z_cost_contact float -- tipo do dado da coluna validado.
	,z_revenue float -- tipo do dado da coluna validado.
	,response float -- tipo do dado da coluna validado.
	,constraint pk_id primary key clustered (id) -- chave primária criada para não duplicar dados e facilitar em buscas com índice clusterizado.
);
"""
)

# Manipulação do arquivo CSV.
df = pd.read_csv(r'C:\\Users\\data-marketing-campaign.csv') # Realiza a leitura. Insira o caminho de repositório do CSV.
df.to_csv(r'C:\\Users\\data-marketing-campaign.csv', header=False, index=False) # Retirado o cabeçalho e possíveis index criados na leitura da linha de comando acima. Insira o caminho de repositório do CSV.

print('Processo iniciado.')

# Inserção dos dados do arquivo CSV na tabela criada no banco de dados.
with open(r'C:\\Users\\data-marketing-campaign.csv', encoding="utf8") as csv_file: # Insira o caminho de repositório do CSV.
    csv_reader = csv.reader(csv_file, delimiter=",")
    for row in csv_reader:
        to_db = [(row[0]), (row[1]), (row[2]), (row[3]), (row[4]), (row[5]), (row[6]), (row[7]), (row[8]), (row[9]), (row[10]), (row[11]), (row[12]), (row[13]), (row[14]), (row[15]), (row[16]), (row[17]), (row[18]), (row[19]), (row[20]), (row[21]), (row[22]), (row[23]), (row[24]), (row[25]), (row[26]), (row[27]), (row[28])]
        conexao.execute(
        """
        insert into [customersuccess].[marketing].[tb_customersuccess_sot_marketing_campaign] (
        id
        ,year_birth
        ,education
        ,marital_status
        ,income
        ,kidhome
        ,teenhome
        ,dt_customer
        ,recency
        ,mnt_wines
        ,mnt_fruits
        ,mnt_meat_products
        ,mnt_fish_products
        ,mnt_sweet_products
        ,mnt_gold_prods
        ,num_deals_purchases
        ,num_web_purchases
        ,num_catalog_purchases
        ,num_store_purchases
        ,num_web_visits_month
        ,accepted_cmp3
        ,accepted_cmp4
        ,accepted_cmp5
        ,accepted_cmp1
        ,accepted_cmp2
        ,complain
        ,z_cost_contact
        ,z_revenue
        ,response
        ) 
        values 
        (
        ?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?
        );
        """
        ,to_db
        )

print('Processo finalizado.')

# -------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- #