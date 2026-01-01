# DSA Projeto 2 - Script 30 - RDD Actions
 
# Imports
import os
from pyspark.sql import SparkSession

# Ambiente
os.environ['TERM'] = 'xterm'
os.system('clear')

print('\nDSA Projeto 2 - Script 30 - RDD Actions:\n')

# Cria uma sessão Spark com um nome específico para a aplicação
spark = SparkSession.builder.appName('DSAProjeto2-Script30').getOrCreate()

# Define uma lista de tuplas para uso em um RDD
dados_dsa = [("A", 10),("B", 20),("C", 30),("D", 40),("E", 30),("F", 60)]

# Cria um RDD a partir da lista de tuplas
inputRDD = spark.sparkContext.parallelize(dados_dsa)

# Cria outro RDD a partir de uma lista de números, com duplicatas
listRdd = spark.sparkContext.parallelize([8,3,6,7,5,3,2,2,4,6,2,4,7,4,1])

# Conta o número de elementos no RDD
print("Count: " + str(listRdd.count()))
# Output: Count: 15

# Estima o número de elementos no RDD usando um timeout de 1200 milissegundos
print("countApprox: " + str(listRdd.countApprox(1200)))
# Output: countApprox: 15

# Estima o número de elementos distintos no listRdd
print("countApproxDistinct: " + str(listRdd.countApproxDistinct()))
# Output: countApproxDistinct: 8

# Estima o número de elementos distintos no inputRDD
print("countApproxDistinct: " + str(inputRDD.countApproxDistinct()))
# Output: countApproxDistinct: 6

# Conta o número de vezes que cada valor ocorre no RDD
print("countByValue:  " + str(listRdd.countByValue()))

# Retorna o primeiro elemento do RDD
print("Primeiro Elemento:  " + str(listRdd.first()))

# Retorna a primeira tupla do inputRDD
print("Primeira Tupla:  " + str(inputRDD.first()))

# Retorna os dois maiores elementos do listRdd
print("Dois Maiores Elementos: " + str(listRdd.top(2)))

# Retorna as duas maiores tuplas do inputRDD 
print("Duas Maiores Tuplas: " + str(inputRDD.top(2)))

# Retorna o menor elemento do listRdd
print("Menor Valor: " + str(listRdd.min()))

# Retorna a menor tupla do inputRDD 
print("Menor Valor:  " + str(inputRDD.min()))

# Retorna o maior elemento do listRdd
print("Maior Valor:  " + str(listRdd.max()))

# Retorna a maior tupla do inputRDD 
print("Maior Valor:  " + str(inputRDD.max()))

# Retorna os dois primeiros elementos do listRdd
print("Dois Primeiros Elementos: " + str(listRdd.take(2)))

# Retorna os dois primeiros elementos do listRdd quando ordenado
print("Dois Primeiros Elementos (Ordenaddo): " + str(listRdd.takeOrdered(2)))


# Actions são operações que instruem o Spark a executar cálculos e retornar o resultado final desses cálculos. 
# Elas são utilizadas para obter resultados concretos a partir de RDDs transformados ou não. 
# Ao contrário das transformações, que são operações "lazy" (preguiçosas) e apenas montam um plano de execução, 
# as actions forçam a execução desses planos e trazem os dados para o programa driver ou gravam em disco.



