'''

Caderno de resultados da análise da campanha de marketing.

Google Colab com Python.

Instruções para utilização desse script.

1º - É necessário importar o arquivo que contém as informações do GitHub para um arquivo csv, pois, utilizamos o pandas com padrão csv para essa análise.
2º - Se possível nomeie o arquivo como (data.csv), e, caso escolha outro nome, altere o campo que contém o seguinte script (df = pd.read_csv(r'data.csv')) com o nome escolhido.
3º - Após importar para um arquivo csv, é necessário importar esse arquivo para o Google Colab.
4º - Abra o Google Colab na web -> (research.google.com/colaboratory).
5º - Utilize este script, que esta no formato (.py), copie e cole este scritp no Google Colab.
6º - Visando garantir a execução correta do script, uma linha antes, utilize o script (!pip install pandas) para instalar a biblioteca pandas no Google Colab.
7º - Para importar para o Google Colab, vá na aba esquerda, clique nas três linhas da parte superior, clique na pasta (arquivos) e clique na figura de um arquivo com uma seta pra cima, chamado (Fazer upload para armazenamento da sessão).
8º - Execute o script.
9º - Resultado será exibido em formato de tabela.

'''

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
