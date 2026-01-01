# DSA Projeto 2 - Script 08 - Top N

# Imports
import os
from pyspark.sql import SparkSession

# Ambiente
os.environ['TERM'] = 'xterm'
os.system('clear')

print('\nDSA Projeto 2 - Script 08 - Top N:\n')

# Cria uma sessão Spark com um nome específico para a aplicação
spark = SparkSession.builder.appName('DSAProjeto2-Script08').getOrCreate()

# Define os dados para criar o DataFrame, incluindo nomes e idades
dados_dsa = [("Bob",24),("Ana",44),
             ("Greg",43),("Laura",43),
             ("John",27),("Carolina",47)]

# Define os nomes das colunas para o DataFrame
columns = ["nome","idade",]

# Cria um DataFrame com os dados fornecidos e esquema definido pelas colunas
df = spark.createDataFrame(data = dados_dsa, schema = columns)

# Mostra o conteúdo do DataFrame
df.show()

# Imprime os dois primeiros registros do DataFrame
print(df.take(2))
print()

# Imprime os dois últimos registros do DataFrame
print(df.tail(2))
print()

# Imprime os dois primeiros registros do DataFrame, semelhante a take(2)
print(df.head(2))
print()

# Imprime o primeiro registro do DataFrame
print(df.first())
print()

# Coleta e imprime todos os registros do DataFrame como uma lista de linhas
print(df.collect())
print()

# Converte os primeiros três registros do DataFrame para um DataFrame do Pandas e imprime
pandasDF = df.limit(3).toPandas()
print(pandasDF)
print()


