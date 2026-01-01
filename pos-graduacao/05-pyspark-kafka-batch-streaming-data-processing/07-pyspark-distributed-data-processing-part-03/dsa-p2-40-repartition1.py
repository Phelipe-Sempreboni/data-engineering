# DSA Projeto 2 - Script 40 - Repartition

# Imports
import os
from pyspark.sql import SparkSession

# Ambiente
os.environ['TERM'] = 'xterm'
os.system('clear')

print('\nDSA Projeto 2 - Script 40 - Repartition:\n')

# Cria uma sessão Spark com um nome específico para a aplicação
spark = SparkSession.builder.appName('DSAProjeto2-Script40').getOrCreate()

# Cria um DataFrame com uma coluna contendo números de 0 a 19
df = spark.range(0,20)

# Imprime o número de partições do RDD subjacente ao DataFrame
print("Número Padrão de Partições Definindo Pelo Spark: " + str(df.rdd.getNumPartitions()))

# Define a configuração de shuffle do Spark para usar até 500 partições
spark.conf.set("spark.sql.shuffle.partitions", "500")

# Cria um RDD com um único elemento, uma tupla (0, 20)
rdd = spark.sparkContext.parallelize((0,20))

# Imprime o número de partições do RDD, criado com a configuração padrão para o contexto Spark
print("Número de Partições Após Modificar o Parâmetro do Spark: " + str(rdd.getNumPartitions()))

# Cria um RDD com um único elemento, uma tupla (0, 25), especificando 6 partições
rdd1 = spark.sparkContext.parallelize((0,25), 6)

# Imprime o número de partições do RDD
print("Número de Partições no Parallelize: " + str(rdd1.getNumPartitions()))

# Salva o RDD em um arquivo de texto no diretório especificado
rdd1.saveAsTextFile("/opt/spark/data/dsa_partition1")

# Reparticiona o RDD1 para 4 partições usando o método repartition
rdd2 = rdd1.repartition(4)

# Imprime o novo número de partições do RDD2
print("Número de Partições Após o Reparticionamento: " + str(rdd2.getNumPartitions()))

# Salva o RDD2 reparticionado
rdd2.saveAsTextFile("/opt/spark/data/re-partition")

# Coalesce o RDD1 em 4 partições, que potencialmente reduz o número de partições sem causar shuffle completo
rdd3 = rdd1.coalesce(4)

# Imprime o número de partições após o coalesce
print("Número de Partições Após o Reparticionamento com Coalesce: "  + str(rdd3.getNumPartitions()))

# Salva o RDD3 coalescido em um arquivo de texto
rdd3.saveAsTextFile("/opt/spark/data/coalesce2")

# Reparticionamento no Apache Spark é uma técnica usada para modificar a distribuição de dados entre diferentes 
# nós em um cluster. Esta técnica é importante para otimizar a performance de operações que envolvem shuffling de dados, 
# como agrupamentos (groupBy), junções (joins) e ordenações (sortBy). Reparticionar um RDD ou um DataFrame pode ajudar 
# a melhorar a eficiência do processamento paralelo e a gestão da carga de trabalho entre os nós.



