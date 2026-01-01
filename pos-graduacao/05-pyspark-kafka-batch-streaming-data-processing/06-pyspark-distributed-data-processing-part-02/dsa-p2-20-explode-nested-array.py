# DSA Projeto 2 - Script 20 - Explode de Array Aninhados

# Imports
import os
import pyspark
from pyspark.sql import SparkSession
from pyspark.sql.functions import explode, flatten

# Ambiente
os.environ['TERM'] = 'xterm'
os.system('clear')

print('\nDSA Projeto 2 - Script 20 - Explode de Array Aninhados:\n')

# Cria uma sessão Spark com um nome específico para a aplicação
spark = SparkSession.builder.appName('DSAProjeto2-Script20').getOrCreate()

# Define uma lista de tuplas contendo nomes e listas de listas de linguagens de programação e tecnologias
dados_dsa = [
  ("Maria",[["Java","Scala","C++"],["Spark","Java"]]),
  ("Bob",[["Spark","Java","C++"],["Spark","Java"]]),
  ("Elias",[["Python","Rust"],["Spark","Python"]])]

# Cria um DataFrame a partir dos dados fornecidos com as colunas 'nome' e 'linguagens'
df = spark.createDataFrame(data = dados_dsa, schema = ['nome','linguagens'])

# Imprime o esquema do DataFrame para visualizar a estrutura das colunas
df.printSchema()

# Exibe o DataFrame completo sem truncar os dados para melhor visualização das listas de listas
df.show(truncate=False)

# Seleciona o nome e explode a coluna 'linguagens' para transformar cada lista interna em uma nova linha
df.select(df.nome, explode(df.linguagens)).show(truncate=False)

# Seleciona o nome e aplica a função flatten na coluna 'linguagens' para combinar as listas internas em uma única lista
df.select(df.nome, flatten(df.linguagens)).show(truncate=False)







