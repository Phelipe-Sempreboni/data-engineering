# DSA Projeto 2 - Script 38 - Partition

# Imports
import os
from pyspark.sql import SparkSession

# Ambiente
os.environ['TERM'] = 'xterm'
os.system('clear')

print('\nDSA Projeto 2 - Script 38 - Partition:\n')

# Cria uma sessão Spark com um nome específico para a aplicação
spark = SparkSession.builder.appName('DSAProjeto2-Script38').getOrCreate()

# Lê um arquivo CSV com cabeçalho e o armazena em um DataFrame
df_dsa = spark.read.option("header",True).csv("/opt/spark/data/dataset2.csv")

# Exibe o conteúdo do DataFrame
df_dsa.show()

# Imprime o número de partições do RDD subjacente ao DataFrame
# Veja os detalhes ao final do script
print('\nNúmero Original de Partições:')
print(df_dsa.rdd.getNumPartitions())

# Grava o DataFrame em arquivos CSV, particionado por estado, com cabeçalho 
# e sobrescrevendo arquivos existentes
df_dsa.write.option("header",True) \
        .partitionBy("estado") \
        .mode("overwrite") \
        .csv("/opt/spark/data/partition1")
        
# Grava o DataFrame em arquivos CSV, particionado por estado e cidade, com cabeçalho 
# e sobrescrevendo arquivos existentes
df_dsa.write.option("header",True) \
        .partitionBy("estado","cidade") \
        .mode("overwrite") \
        .csv("/opt/spark/data/partition2")

# Reparticiona o DataFrame em 2 partições
df_dsa = df_dsa.repartition(2)

# Imprime o número de partições após a repartição
print('\nNúmero de Partições Após o Reparticionamento:')
print(df_dsa.rdd.getNumPartitions())

# Grava novamente o DataFrame em arquivos CSV, particionado por estado, com cabeçalho 
# e sobrescrevendo arquivos existentes, após repartição
df_dsa.write.option("header",True) \
        .partitionBy("estado") \
        .mode("overwrite") \
        .csv("/opt/spark/data/partition3")
        
# Lê o DataFrame dos arquivos CSV particionados por estado, com cabeçalho
df_dsaPartition = spark.read.option("header",True).csv("/opt/spark/data/partition1")

# Imprime o esquema do DataFrame lido
df_dsaPartition.printSchema()

# Lê um único arquivo CSV específico, de uma partição específica de estado e cidade, com cabeçalho
df_dsaSinglePart = spark.read.option("header",True).csv("/opt/spark/data/partition2/estado=SC/cidade=BLUMENAU")

# Imprime o esquema do DataFrame específico lido
df_dsaSinglePart.printSchema()

# Exibe os dados do DataFrame específico
df_dsaSinglePart.show()

# Lê os dados do DataFrame
parqdf_dsa = spark.read.option("header",True).csv("/opt/spark/data/partition1")

# Cria uma vista temporária do DataFrame para usar com SQL
parqdf_dsa.createOrReplaceTempView("DSATABLE")

# Executa uma consulta SQL na vista temporária, filtrando por estado e cidade específicos, e exibe os resultados
spark.sql("select * from DSATABLE where Estado='SC' and Cidade = 'BLUMENAU'").show()

# Grava o DataFrame em arquivos CSV, limitando o número máximo de registros por arquivo, 
# particionado por estado, com cabeçalho e sobrescrevendo arquivos existentes
df_dsa.write.option("header",True) \
        .option("maxRecordsPerFile", 2) \
        .partitionBy("estado") \
        .mode("overwrite") \
        .csv("/opt/spark/data/partition4")


# O método getNumPartitions() é utilizado para obter o número de partições de um RDD no Apache Spark. 
# Quando aplicado como df_dsa.rdd.getNumPartitions(), ele retorna o número de partições do RDD subjacente 
# ao DataFrame df_dsa. Aqui está uma explicação mais detalhada:

# DataFrame para RDD: O atributo .rdd converte um DataFrame para o seu RDD subjacente. 
# DataFrames no Spark são construídos sobre o conceito de RDDs (Resilient Distributed Datasets), 
# que são coleções distribuídas de objetos que podem ser processados em paralelo. Cada DataFrame tem um RDD 
# por trás que gerencia a distribuição e o processamento dos dados.

# Partições: As partições são subdivisões do dataset original, e cada partição pode ser processada em paralelo 
#em diferentes nós de um cluster. A granularidade das partições influencia diretamente o desempenho do 
# processamento paralelo. Menos partições podem levar a menos paralelismo e mais partições podem aumentar o 
# overhead de gerenciamento, então há um ponto de equilíbrio que geralmente depende do tamanho do dataset 
# e da configuração do cluster.

# getNumPartitions(): Este método retorna o número de partições que o RDD está utilizando. 
# Esse número pode fornecer insights sobre como os dados estão distribuídos e como as tarefas de processamento 
# serão paralelizadas. Um número adequado de partições ajuda a otimizar o desempenho do processamento distribuído.

# Portanto, quando você chama df_dsa.rdd.getNumPartitions(), você está investigando quantas partições o RDD 
# por trás do seu DataFrame está usando, o que pode ser útil para entender e otimizar o desempenho de operações 
# que envolvem shuffling de dados, como agrupamentos e ordenações, ou para ajustar a configuração de paralelismo 
# do seu job Spark.



