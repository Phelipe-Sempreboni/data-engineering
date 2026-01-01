# DSA Projeto 2 - Script 33 - RDD FlatMap

# Imports
import os
from pyspark.sql import SparkSession

# Ambiente
os.environ['TERM'] = 'xterm'
os.system('clear')

print('\nDSA Projeto 2 - Script 33 - RDD FlatMap:\n')

# Cria uma sessão Spark com um nome específico para a aplicação
spark = SparkSession.builder.appName('DSAProjeto2-Script33').getOrCreate()

# Lista de strings
dados_dsa = ["Formação Cientista de Dados", 
             "Formação Engenheiro de Dados",
             "Formação Analista de Dados"]

# Criando um RDD a partir da lista de strings
rdd = spark.sparkContext.parallelize(dados_dsa)

print('\nRDD Original:\n')

# Coletando os elementos do RDD e imprimindo cada um
for element in rdd.collect():
    print(element)

# Aplicando um flatMap para dividir cada string em palavras e achatar o resultado em um único RDD
rdd2 = rdd.flatMap(lambda x: x.split(" "))

print('\nRDD Depois do flatMap:\n')

# Coletando e imprimindo cada palavra do RDD resultante
for element in rdd2.collect():
    print(element)


# No Spark, map e flatMap são duas operações de transformação que aplicam uma função a cada elemento de um RDD, 
# mas eles funcionam de maneiras ligeiramente diferentes:

# map: A operação map aplica uma função a cada elemento do RDD e retorna um novo RDD onde cada elemento 
# é o resultado da função aplicada. Cada entrada no RDD original resulta exatamente em uma saída no novo RDD. 
# Por exemplo, se você tem um RDD contendo números [1, 2, 3] e aplica uma função que multiplica cada 
# número por 2 usando map, você obterá um novo RDD [2, 4, 6].

# flatMap: A operação flatMap também aplica uma função a cada elemento do RDD, mas a função usada deve 
# retornar uma sequência para cada entrada e o flatMap achata todas as sequências em um único RDD. 
# Isso significa que cada entrada pode ser mapeada para zero ou mais saídas. Por exemplo, se você tem um 
# RDD com frases e aplica uma função que divide cada frase em palavras, flatMap resultará em um RDD com 
# todas as palavras de todas as frases, não listas separadas de palavras para cada frase.


