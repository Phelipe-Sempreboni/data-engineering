# DSA Projeto 2 - Script 46 - Parallelize

# Imports
import os
import pyspark
from pyspark.sql import SparkSession

# Ambiente
os.environ['TERM'] = 'xterm'
os.system('clear')

print('\nDSA Projeto 2 - Script 46 - Parallelize:\n')

# Cria uma sessão Spark com um nome específico para a aplicação
spark = SparkSession.builder.appName('DSAProjeto2-Script46').getOrCreate()

# Criando um RDD (Resilient Distributed Dataset) no Spark a partir de uma lista de números
rdd = spark.sparkContext.parallelize([1,2,3,4,5])

# Imprimindo o número de partições do RDD
print("Número de Partições: " + str(rdd.getNumPartitions()))

# Imprimindo o primeiro elemento do RDD, uma ação que retorna o primeiro elemento
print("Primeiro Elemento do RDD: " + str(rdd.first()))

# Coletando os dados do RDD para a memória do driver (cuidado com o uso em RDDs grandes!)
rddCollect = rdd.collect()

# Imprimindo todos os elementos coletados do RDD
print("Todos os Elementos do RDD: ") 
print(rddCollect)

# Criando um RDD vazio usando o contexto do Spark
emptyRDD = spark.sparkContext.emptyRDD()

# Criando outro RDD vazio, reatribuindo 'rdd' a um novo RDD vazio
emptyRDD2 = rdd = spark.sparkContext.parallelize([])

# Imprimindo se o segundo RDD vazio realmente não tem elementos
print("O RDD Criado está vazio? " + str(emptyRDD2.isEmpty()))



