# DSA Projeto 2 - Script 36 - RDD MapReduce

# Imports
import os
from pyspark.sql import SparkSession

# Ambiente
os.environ['TERM'] = 'xterm'
os.system('clear')

print('\nDSA Projeto 2 - Script 36 - RDD MapReduce:\n')

# Cria uma sessão Spark com um nome específico para a aplicação
spark = SparkSession.builder.appName('DSAProjeto2-Script36').getOrCreate()

# Carrega um arquivo de texto para um RDD
rdd = spark.sparkContext.textFile("/opt/spark/data/dataset1.txt")

print('\n----------')

# Coleta e imprime todos os elementos do RDD
for element in rdd.collect():
    print(element)

# Utiliza flatMap para dividir cada linha do RDD em palavras e achatá-las em um único RDD de palavras
rdd2 = rdd.flatMap(lambda x: x.split(" "))

print('\n----------')

# Coleta e imprime todas as palavras do RDD resultante
for element in rdd2.collect():
    print(element)

# Mapeia cada palavra para uma tupla (palavra, 1), preparando para contagem
rdd3 = rdd2.map(lambda x: (x,1))

print('\n----------')

# Coleta e imprime todas as tuplas do RDD
for element in rdd3.collect():
    print(element)

# Aplica reduceByKey para somar os valores de cada chave (palavra), realizando a contagem de palavras
rdd4 = rdd3.reduceByKey(lambda a,b: a+b)

print('\n----------')

# Coleta e imprime o resultado da contagem de palavras
for element in rdd4.collect():
    print(element)

# Mapeia cada tupla para inverter ordem, colocando a contagem antes da palavra, e depois ordena pelo número de ocorrências
rdd5 = rdd4.map(lambda x: (x[1],x[0])).sortByKey()

print('\n----------')

# Coleta e imprime as tuplas após a ordenação
for element in rdd5.collect():
    print(element)

# Filtra as tuplas, mantendo apenas aquelas cuja palavra contém a letra 'a'
rdd6 = rdd5.filter(lambda x : 'a' in x[1])

print('\n----------')

# Coleta e imprime as tuplas filtradas
for element in rdd6.collect():
    print(element)
