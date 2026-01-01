# DSA Projeto 2 - Script 35 - ReduceByKey

# Imports
import os
from pyspark.sql import SparkSession

# Ambiente
os.environ['TERM'] = 'xterm'
os.system('clear')

print('\nDSA Projeto 2 - Script 35 - ReduceByKey:\n')

# Cria uma sessão Spark com um nome específico para a aplicação
spark = SparkSession.builder.appName('DSAProjeto2-Script35').getOrCreate()

# Lista de tuplas com profissões e um contador inicializado como 1
dsa_dados = [('Cientista', 1),
             ('Arquiteto', 1),
             ('Arquiteto', 1),
             ('Analista', 1),
             ('Gerente', 1),
             ('Engenheiro', 1),
             ('Cientista', 1),
             ('Engenheiro', 1),
             ('Analista', 1),
             ('Cientista', 1),
             ('Engenheiro', 1),
             ('Cientista', 1),
             ('Engenheiro', 1)]

# Criando um RDD a partir da lista de profissões e contadores
rdd = spark.sparkContext.parallelize(dsa_dados)

# Aplicando a operação reduceByKey para somar os contadores de cada profissão
rdd2 = rdd.reduceByKey(lambda a,b: a+b)

# Coletando e imprimindo os resultados do RDD após a redução
for element in rdd2.collect():
    print(element)
