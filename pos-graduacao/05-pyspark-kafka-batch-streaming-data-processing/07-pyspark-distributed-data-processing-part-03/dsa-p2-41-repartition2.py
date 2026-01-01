# DSA Projeto 2 - Script 41 - Repartition

# Imports
import os
from pyspark.sql import SparkSession

# Ambiente
os.environ['TERM'] = 'xterm'
os.system('clear')

print('\nDSA Projeto 2 - Script 41 - Repartition:\n')

# Cria uma sessão Spark com um nome específico para a aplicação
spark = SparkSession.builder.appName('DSAProjeto2-Script41').getOrCreate()

df = spark.read.option("header",True).csv("/opt/spark/data/dataset2.csv")

df1 = df.repartition(3)

print("Número de Partições do df1: " + str(df1.rdd.getNumPartitions()))

df1.write.option("header",True).mode("overwrite").csv("/opt/spark/data/zipcodes-estado")

df2 = df.repartition(3,"estado")

print("Número de Partições do df2: " + str(df2.rdd.getNumPartitions()))

df2.write.option("header",True).mode("overwrite").csv("/opt/spark/data/zipcodes-estado-3estados")

df3 = df.repartition("estado")

print("Número de Partições do df3: " + str(df3.rdd.getNumPartitions()))

df3.write.option("header",True).mode("overwrite").csv("/opt/spark/data/zipcodes-estado-todosestados")




