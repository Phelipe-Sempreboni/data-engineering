# DSA Projeto 2 - Script 00 - Testando o Nível de Log

# Imports
import os
from pyspark.sql import SparkSession

# Ambiente
os.environ['TERM'] = 'xterm'
os.system('clear')

print('\nDSA Projeto 2 - Script 00 - Testando o Nível de Log:\n')

# Sessão
spark = SparkSession.builder.appName('DSAProjeto2-Script00').getOrCreate()

# Cria os dados
dados = [("FCD", "Data Science", 6), ("FED", "Engenharia de Dados", 5), ("FADA", "Analytics", 4)]

# Colunas
colunas = ["nome", "categoria", "num_cursos"]

# Cria o dataframe
df = spark.createDataFrame(data = dados, schema = colunas)

# Mostra a tabela
df.show(truncate=False)
