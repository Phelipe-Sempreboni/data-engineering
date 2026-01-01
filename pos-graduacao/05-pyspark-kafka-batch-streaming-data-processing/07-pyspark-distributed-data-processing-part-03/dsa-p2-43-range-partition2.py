# DSA Projeto 2 - Script 43 - Range Partition

# Imports
import os
from pyspark.sql import SparkSession
from pyspark.sql.functions import col
from pyspark.sql.functions import spark_partition_id

# Ambiente
os.environ['TERM'] = 'xterm'
os.system('clear')

print('\nDSA Projeto 2 - Script 43 - Range Partition:\n')

# Cria uma sessão Spark com um nome específico para a aplicação
spark = SparkSession.builder.appName('DSAProjeto2-Script43').getOrCreate()

# Dados
dados_dsa = [(1,10),(2,20),(3,10),(4,20),(5,10),
             (6,30),(7,50),(8,50),(9,50),(10,30),
             (11,10),(12,10),(13,40),(14,40),(15,40),
             (16,40),(17,50),(18,10),(19,40),(20,40)]

# Criação do DataFrame
df = spark.createDataFrame(dados_dsa,["id","valor"])

# Definição do número de partições
num_particoes = 4

# Criação do DataFrame particionado por intervalo
df_particionado = df.repartitionByRange(num_particoes, col("valor"))

# Função para exibir as partições
def exibir_particoes(df):
    df_dsa_com_partition_id = df.withColumn("partitionId", spark_partition_id())
    df_dsa_com_partition_id.show(truncate=False)
    
# Exibindo o DataFrame particionado com os IDs das partições
exibir_particoes(df_particionado)




