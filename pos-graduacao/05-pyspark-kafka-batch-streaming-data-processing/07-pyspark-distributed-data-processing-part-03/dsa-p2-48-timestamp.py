# DSA Projeto 2 - Script 48 - Timestamp

# Imports
import os
from pyspark.sql import SparkSession
from pyspark.sql.functions import *

# Ambiente
os.environ['TERM'] = 'xterm'
os.system('clear')

print('\nDSA Projeto 2 - Script 48 - Timestamp:\n')

# Cria uma sessão Spark com um nome específico para a aplicação
spark = SparkSession.builder.appName('DSAProjeto2-Script48').getOrCreate()

# Definindo uma lista de tuplas com datas em diferentes formatos de string
dados_dsa = [("2024-07-01 12:01:19",
              "07-01-2024 12:01:19",
              "07-01-2024")]

# Definindo as colunas do DataFrame, cada uma representando um tipo diferente de timestamp
colunas = ["timestamp_1", "timestamp_2", "timestamp_3"]

# Criando um DataFrame a partir dos dados especificados com as colunas definidas
df = spark.createDataFrame(data = dados_dsa, schema = colunas)

# Imprimindo o esquema do DataFrame para verificar os tipos de dados e estrutura de colunas
df.printSchema()

# Exibindo os dados do DataFrame sem truncar as informações para verificar os dados carregados
df.show(truncate=False)

# Selecionando colunas do DataFrame e convertendo-as para formato Unix timestamp
df2 = df.select(
    unix_timestamp(col("timestamp_1")).alias("timestamp_1"),
    unix_timestamp(col("timestamp_2"), "MM-dd-yyyy HH:mm:ss").alias("timestamp_2"),
    unix_timestamp(col("timestamp_3"), "MM-dd-yyyy").alias("timestamp_3"),
    unix_timestamp().alias("timestamp_4"))

# Imprimindo o esquema do novo DataFrame para verificar os tipos de dados após a conversão para Unix timestamp
df2.printSchema()

# Exibindo os dados do novo DataFrame para verificar os timestamps Unix
df2.show(truncate=False)

# Convertendo os valores de Unix timestamp de volta para formato de data legível, usando diferentes formatos
df3 = df2.select(
    from_unixtime(col("timestamp_1")).alias("timestamp_1"),
    from_unixtime(col("timestamp_2"), "MM-dd-yyyy HH:mm:ss").alias("timestamp_2"),
    from_unixtime(col("timestamp_3"), "MM-dd-yyyy").alias("timestamp_3"),
    from_unixtime(col("timestamp_4")).alias("timestamp_4"))

# Imprimindo o esquema do DataFrame final para verificar os tipos de dados depois de converter de Unix timestamp para string de data
df3.printSchema()

# Exibindo os dados do DataFrame final para visualizar as datas em formatos legíveis
df3.show(truncate=False)


