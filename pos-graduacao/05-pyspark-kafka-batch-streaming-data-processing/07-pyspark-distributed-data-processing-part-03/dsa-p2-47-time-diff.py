# DSA Projeto 2 - Script 47 - Time Diff

# Imports
import os
from pyspark.sql import SparkSession
from pyspark.sql.functions import *

# Ambiente
os.environ['TERM'] = 'xterm'
os.system('clear')

print('\nDSA Projeto 2 - Script 47 - Time Diff:\n')

# Cria uma sessão Spark com um nome específico para a aplicação
spark = SparkSession.builder.appName('DSAProjeto2-Script47').getOrCreate()

# Definindo uma lista de tuplas com identificadores e timestamps
dsa_datas = [("1","2025-07-01 12:01:19.111"),
             ("2","2025-06-24 12:01:19.222"),
             ("3","2025-11-16 16:44:55.406"),
             ("4","2025-11-16 16:50:59.406")]

# Criando um DataFrame a partir dos dados especificados com as colunas 'id' e 'from_timestamp'
df = spark.createDataFrame(data=dsa_datas, schema=["id","from_timestamp"])

# Adicionando colunas para converter 'from_timestamp' para timestamp, adicionar o timestamp atual e calcular a diferença em segundos
df2 = df.withColumn('from_timestamp', to_timestamp(col('from_timestamp')))\
        .withColumn('end_timestamp', current_timestamp())\
        .withColumn('DiffInSeconds', col("end_timestamp").cast("long") - col('from_timestamp').cast("long"))

# Exibindo os dados do DataFrame para verificar os resultados das conversões e cálculos
df2.show(truncate=False)

# Realizando as mesmas operações usando funções unix_timestamp para calcular a diferença em segundos
df.withColumn('from_timestamp', to_timestamp(col('from_timestamp')))\
  .withColumn('end_timestamp', current_timestamp())\
  .withColumn('DiffInSeconds', unix_timestamp("end_timestamp") - unix_timestamp('from_timestamp')) \
  .show(truncate=False)

# Calculando a diferença em minutos usando a diferença de segundos calculada anteriormente
df2.withColumn('DiffInMinutes', round(col('DiffInSeconds') / 60)).show(truncate=False)

# Calculando a diferença em horas usando a diferença de segundos calculada anteriormente
df2.withColumn('DiffInHours', round(col('DiffInSeconds') / 3600)).show(truncate=False)

# Definindo uma lista de tuplas com timestamps em formato de hora
dsa_horas = [("12:01:19.000", "13:01:19.000"),
             ("12:01:19.000", "12:02:19.000"),
             ("16:44:55.406", "17:44:55.406"),
             ("16:50:59.406", "16:44:59.406")]

# Criando um DataFrame a partir dos dados especificados com as colunas 'from_timestamp' e 'to_timestamp'
df3 = spark.createDataFrame(data = dsa_horas, schema = ["from_timestamp","to_timestamp"])

# Convertendo 'from_timestamp' e 'to_timestamp' para timestamp e calculando a diferença em segundos, minutos e horas
df3.withColumn("from_timestamp", to_timestamp(col("from_timestamp"), "HH:mm:ss.SSS")) \
   .withColumn("to_timestamp", to_timestamp(col("to_timestamp"), "HH:mm:ss.SSS")) \
   .withColumn("DiffInSeconds", col("from_timestamp").cast("long") - col("to_timestamp").cast("long")) \
   .withColumn("DiffInMinutes", round(col("DiffInSeconds") / 60)) \
   .withColumn("DiffInHours", round(col("DiffInSeconds") / 3600)) \
   .show(truncate=False)

# Criando um DataFrame com dados de timestamp para calcular diferenças com o timestamp atual
df3 = spark.createDataFrame(data = [("1","07-01-2019 12:01:19.406")], schema = ["id","input_timestamp"])

# Convertendo 'input_timestamp' para timestamp, adicionando o timestamp atual e calculando a diferença em segundos, minutos, horas e dias
df3.withColumn("input_timestamp", to_timestamp(col("input_timestamp"), "MM-dd-yyyy HH:mm:ss.SSS")) \
    .withColumn("current_timestamp", current_timestamp().alias("current_timestamp")) \
    .withColumn("DiffInSeconds", current_timestamp().cast("long") - col("input_timestamp").cast("long")) \
    .withColumn("DiffInMinutes", round(col("DiffInSeconds") / 60)) \
    .withColumn("DiffInHours", round(col("DiffInSeconds") / 3600)) \
    .withColumn("DiffInDays", round(col("DiffInSeconds") / (24*3600))) \
    .show(truncate=False)

# Executando consultas SQL para calcular a diferença em segundos, minutos e horas entre dois timestamps específicos
spark.sql("select unix_timestamp('2019-07-02 12:01:19') - unix_timestamp('2019-07-01 12:01:19') as DiffInSeconds").show()
spark.sql("select (unix_timestamp('2019-07-02 12:01:19') - unix_timestamp('2019-07-01 12:01:19')) / 60 as DiffInMinutes").show()
spark.sql("select (unix_timestamp('2019-07-02 12:01:19') - unix_timestamp('2019-07-01 12:01:19')) / 3600 as DiffInHours").show()
