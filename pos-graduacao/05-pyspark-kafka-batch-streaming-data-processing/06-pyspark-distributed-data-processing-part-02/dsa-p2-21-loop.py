# DSA Projeto 2 - Script 21 - Loop

# Imports
import os
from pyspark.sql import SparkSession
from pyspark.sql.functions import concat_ws, col, lit

# Ambiente
os.environ['TERM'] = 'xterm'
os.system('clear')

print('\nDSA Projeto 2 - Script 21 - Loop:\n')

# Cria uma sessão Spark com um nome específico para a aplicação
spark = SparkSession.builder.appName('DSAProjeto2-Script21').getOrCreate()

# Cria uma lista de tuplas contendo dados de pessoas, incluindo primeiro nome, sobrenome, gênero e salário
dados_dsa = [('Alessandro','Gomes','M',30),
             ('Tereza','Oliveira','F',41),
             ('Fernando','Silva','M',62)]

# Define os nomes das colunas para o DataFrame
colunas = ["primeironome", "sobrenome", "genero", "salario"]

# Cria um DataFrame com os dados fornecidos e as colunas especificadas
df = spark.createDataFrame(data = dados_dsa, schema = colunas)

print('Dataframe Original:')
df.show()

# Seleciona e exibe o nome completo concatenado, o gênero e o dobro do salário
print('Dataframe com Concat:')
df.select(concat_ws(",", df.primeironome, df.sobrenome).alias("name"), df.genero, lit(df.salario * 2).alias("novo_salario")).show()

# Coleta os dados do DataFrame e imprime no console 
print('Dataframe com Collect:')
print(df.collect())

# Converte o DataFrame para um RDD e aplica uma transformação para concatenar nome e sobrenome, dobrar o salário
rdd = df.rdd.map(lambda x: (x[0] + "," + x[1], x[2], x[3] * 2))  

# Converte o RDD de volta para um DataFrame com colunas nomeadas
df2 = rdd.toDF(["name", "genero", "novo_salario"])

# Exibe o novo DataFrame
print("--------")
print('Dataframe Depois de Manipular os Dados com RDD:')
df2.show()

# Usa uma função lambda para imprimir dados do RDD
df.rdd.foreach(lambda x: print("Data ==>"+x["primeironome"]+","+x["sobrenome"]+","+x["genero"]+","+str(x["salario"] * 2)))

# Coleta dados do DataFrame e armazena em uma variável
dataCollect = df.collect()

# Itera sobre os dados coletados e imprime nome e sobrenome
print("--------")
print('Imprimindo Colunas do Dataframe via ROW:')
for row in dataCollect:
    print(row['primeironome'] + "," + row['sobrenome'])

# Converte o RDD para um iterador local e itera sobre ele, imprimindo nome e sobrenome
dataCollect = df.rdd.toLocalIterator()

# Importa a biblioteca pandas
import pandas as pd

# Converte o DataFrame do Spark para um DataFrame do Pandas
pandasDF = df.toPandas()

# Itera sobre o DataFrame do Pandas e imprime primeiro nome e gênero
print("--------")
print('Imprime Nome e Genero:')
for index, row in pandasDF.iterrows():
    print(row['primeironome'], row['genero'])
