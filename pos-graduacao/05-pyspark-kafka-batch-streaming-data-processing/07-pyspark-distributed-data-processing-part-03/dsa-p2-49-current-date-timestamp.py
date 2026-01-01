# DSA Projeto 2 - Script 49 - Current Date Timestamp

# Imports
import os
from pyspark.sql import SparkSession
from pyspark.sql.functions import *

# Ambiente
os.environ['TERM'] = 'xterm'
os.system('clear')

print('\nDSA Projeto 2 - Script 49 - Date Timestamp:\n')

# Cria uma sessão Spark com um nome específico para a aplicação
spark = SparkSession.builder.appName('DSAProjeto2-Script49').getOrCreate()

# Definindo uma lista simples de dados com um único elemento
dados = [["1"]]

# Criando um DataFrame a partir da lista de dados com a coluna 'id'
df = spark.createDataFrame(dados, ["id"])

# Adicionando colunas com a data e a hora atual ao DataFrame e exibindo o resultado
df.withColumn("current_date", current_date()) \
  .withColumn("current_timestamp", current_timestamp()) \
  .show(truncate=False)

# Executando uma query SQL diretamente para obter a data e a hora atual e exibindo o resultado
spark.sql("select current_date(), current_timestamp()").show(truncate=False)

# Adicionando colunas formatadas para data e conversão de timestamp e exibindo o resultado
df.withColumn("date_format", date_format(current_date(), "MM-dd-yyyy")) \
  .withColumn("to_timestamp", to_timestamp(current_timestamp(), "MM-dd-yyyy HH mm ss SSS")) \
  .show(truncate=False)

# Executando uma query SQL para obter a data formatada e a conversão de timestamp e exibindo o resultado
spark.sql("select date_format(current_date(),'MM-dd-yyyy') as date_format ," + \
          "to_timestamp(current_timestamp(),'MM-dd-yyyy HH mm ss SSS') as to_timestamp") \
     .show(truncate=False)
