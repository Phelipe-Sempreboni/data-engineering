# DSA Projeto 2 - Script 42 - Range Partition

# Imports
import os
from pyspark.sql import SparkSession

# Ambiente
os.environ['TERM'] = 'xterm'
os.system('clear')

print('\nDSA Projeto 2 - Script 42 - Range Repartition:\n')

# Cria uma sessão Spark com um nome específico para a aplicação
spark = SparkSession.builder.appName('DSAProjeto2-Script42').getOrCreate()
          
# Lista de tuplas representando pares de IDs e valores associados
dados_dsa = [(1,10),(2,20),(3,10),(4,20),(5,10),
             (6,30),(7,50),(8,50),(9,50),(10,30),
             (11,10),(12,10),(13,40),(14,40),(15,40),
             (16,40),(17,50),(18,10),(19,40),(20,40)]

# Criação de um DataFrame no Spark a partir dos dados, com colunas 'id' e 'valor'
df = spark.createDataFrame(dados_dsa, ["id", "valor"])

# Reparticionamento do DataFrame baseado em 3 partições e na coluna 'valor', 
# gravação do resultado em formato CSV com cabeçalho, sobrescrevendo dados existentes
df.repartition(3, "valor") \
  .write.option("header", True) \
  .mode("overwrite") \
  .csv("/opt/spark/data/re-partition")

# Repartição do DataFrame em 3 partições por faixa de valores na coluna 'valor', escrita do resultado 
# em formato CSV com cabeçalho, sobrescrevendo os dados existentes
df.repartitionByRange(3, "valor") \
  .write.option("header", True) \
  .mode("overwrite") \
  .csv("/opt/spark/data/range-partition")

# Explicação do plano físico para repartição do DataFrame em 3 partições por faixa de valores na coluna 'valor'
df.repartitionByRange(3, "valor").explain(True)


# Range Partition no Apache Spark é uma técnica de particionamento de dados baseada no valor das colunas. 
# Isso permite que os dados sejam distribuídos entre as partições de acordo com intervalos de valores de uma coluna específica. 
# Este tipo de particionamento é útil quando se trabalha com grandes conjuntos de dados onde o balanceamento das cargas 
# de trabalho entre os nós de processamento é importante.


