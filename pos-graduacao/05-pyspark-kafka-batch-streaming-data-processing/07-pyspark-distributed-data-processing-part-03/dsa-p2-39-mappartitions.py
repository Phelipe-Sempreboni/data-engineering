# DSA Projeto 2 - Script 39 - MapPartitions

# Imports
import os
from pyspark.sql import SparkSession

# Ambiente
os.environ['TERM'] = 'xterm'
os.system('clear')

print('\nDSA Projeto 2 - Script 39 - MapPartitions:\n')

# Cria uma sessão Spark com um nome específico para a aplicação
spark = SparkSession.builder.appName('DSAProjeto2-Script39').getOrCreate()

# Define os dados em uma lista de tuplas, cada uma representando informações de um empregado
dados_dsa = [('Juliano','Souza','M',3000),
             ('Maria','Rosa','F',4100),
             ('Tadeu','Teixeira','M',6200)]

# Define os nomes das colunas que serão usadas no DataFrame
colunas = ["primeironome", "sobrenome", "genero", "salario"]

# Cria um DataFrame a partir dos dados e do esquema especificado
df = spark.createDataFrame(data = dados_dsa, schema = colunas)

# Exibe o DataFrame criado
df.show()

# Reparticiona o DataFrame em 2 partições
df = df.repartition(2)

# Define uma função para reformatar dados, calculando 10% do salário como bônus
def reformat(partitionData):
    for row in partitionData:
        # Gera uma lista com nome completo e 10% do salário
        yield [row.primeironome + " " + row.sobrenome, row.salario * 10/100]

# Aplica a função de reformatação ao RDD do DataFrame e converte o resultado de volta para DataFrame
df.rdd.mapPartitions(reformat).toDF().show()

# Define outra função para reformatar dados, armazenando resultados intermediários
def reformat2(partitionData):
    updatedData = []
    for row in partitionData:
        # Combina nome e sobrenome, calcula 10% do salário e adiciona à lista
        name = row.primeironome + " " + row.sobrenome
        bonus = row.salario * 10/100
        updatedData.append([name,bonus])
    # Retorna um iterador sobre os dados atualizados
    return iter(updatedData)

# Aplica a segunda função de reformatação ao RDD do DataFrame original, 
# especificando nomes de colunas para o novo DataFrame
df2 = df.rdd.mapPartitions(reformat2).toDF(["name","bonus"])

# Exibe o novo DataFrame com os dados reformatados
df2.show()


# No Apache Spark, mapPartitions é uma função de transformação que processa os dados em 
# RDDs (Resilient Distributed Datasets). É uma alternativa ao uso da função map, mas opera em uma escala diferente. 
# Enquanto map aplica uma função a cada elemento individualmente no RDD, mapPartitions aplica uma função a 
# cada partição do RDD como um todo. 


