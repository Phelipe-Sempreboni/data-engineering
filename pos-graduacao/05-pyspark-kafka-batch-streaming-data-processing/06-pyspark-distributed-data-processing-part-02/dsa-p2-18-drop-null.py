# DSA Projeto 2 - Script 18 - Drop de NA

# Imports
import os
from pyspark.sql import SparkSession

# Ambiente
os.environ['TERM'] = 'xterm'
os.system('clear')

print('\nDSA Projeto 2 - Script 18 - Drop de NA:\n')

# Cria uma sessão Spark com um nome específico para a aplicação
spark = SparkSession.builder.appName('DSAProjeto2-Script18').getOrCreate()

# Cria uma lista de tuplas com dados, onde alguns valores estão ausentes (None)
dados_dsa = [("Jeremias", None, "M"), ("Ana", "Rio de Janeiro", "F"), ("Camila", None, None)]

# Define os nomes das colunas para o DataFrame
colunas = ["nome", "estado", "genero"]

# Cria um DataFrame com os dados e nomes de colunas especificados
df = spark.createDataFrame(dados_dsa, colunas)
df.printSchema()
df.show(truncate=False)

# Remove todas as linhas que contêm pelo menos um valor nulo e exibe os resultados sem truncar
df.na.drop().show(truncate=False)

# Remove todas as linhas que contêm pelo menos um valor nulo (equivalente ao exemplo anterior) 
# e exibe os resultados sem truncar
df.na.drop(how="any").show(truncate=False)

# Remove as linhas que contêm valores nulos nas colunas especificadas em 'subset' ('estado' e 'genero') 
# e exibe os resultados sem truncar
df.na.drop(subset=["estado", "genero"]).show(truncate=False)

# Remove todas as linhas que contêm pelo menos um valor nulo (método alternativo usando 'dropna') 
# e exibe os resultados sem truncar
df.dropna().show(truncate=False)




