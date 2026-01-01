# DSA Projeto 2 - Script 44 - Dataframe Partition

# Imports
import os
from pyspark.sql import SparkSession

# Ambiente
os.environ['TERM'] = 'xterm'
os.system('clear')

print('\nDSA Projeto 2 - Script 44 - Dataframe Partition:\n')

# Cria uma sessão Spark com um nome específico para a aplicação
spark = SparkSession.builder.appName('DSAProjeto2-Script44').getOrCreate()

df1 = spark.range(0,20)

print("Número de Partições do df1: " + str(df1.rdd.getNumPartitions()))

df1.write.mode("overwrite").csv("/opt/spark/data/partition-df1")

df2 = df1.repartition(6)

df2.write.mode("overwrite").csv("/opt/spark/data/partition-df2")

print("Número de Partições do df2: " + str(df2.rdd.getNumPartitions()))

df3 = df1.coalesce(5)

df3.write.mode("overwrite").csv("/opt/spark/data/partition-df3")

print("Número de Partições do df3: " + str(df3.rdd.getNumPartitions()))

df4 = df1.groupBy("id").count()

df4.write.mode("overwrite").csv("/opt/spark/data/partition-df4")

print("Número de Partições do df4: " + str(df4.rdd.getNumPartitions()))


# A função coalesce no Spark é usada principalmente para reduzir o número de partições em um DataFrame. 
# No entanto, ao contrário da função repartition, coalesce não pode aumentar o número de partições para 
# mais do que já existem. Se você tentar aumentar o número de partições usando coalesce, ele simplesmente 
# retornará o DataFrame original sem fazer nenhuma alteração.

# Aqui está a diferença entre coalesce e repartition:

# coalesce(numPartitions): Reduz o número de partições para numPartitions. 
# Essa função é otimizada para reduzir o número de partições e evita a movimentação excessiva de dados 
# entre as partições existentes. Não pode aumentar o número de partições.

# repartition(numPartitions): Reorganiza o DataFrame em numPartitions, movendo dados entre as partições 
# conforme necessário. Pode tanto aumentar quanto diminuir o número de partições.

