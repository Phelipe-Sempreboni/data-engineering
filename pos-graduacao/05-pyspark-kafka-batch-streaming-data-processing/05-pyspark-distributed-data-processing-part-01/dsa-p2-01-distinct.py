# DSA Projeto 2 - Script 01 - Distinct

# Imports
import os
from pyspark.sql import SparkSession

# Ambiente
os.environ['TERM'] = 'xterm'
os.system('clear')

print('\nDSA Projeto 2 - Script 01 - Distinct:\n')

# Cria uma sessão Spark com um nome específico para a aplicação
spark = SparkSession.builder.appName('DSAProjeto2-Script01').getOrCreate()

# Define uma lista de tuplas, cada uma representando um registro com nome do funcionário, departamento e salário
dados_dsa = [("Roberto", "Vendas", 30000), \
             ("Michael", "Vendas", 46000), \
             ("Julio", "Vendas", 41000), \
             ("Maria", "Contabilidade", 30000), \
             ("Roberto", "Vendas", 30000), \
             ("Gustavo", "Contabilidade", 33000), \
             ("Jenifer", "Contabilidade", 39000), \
             ("Ana", "Marketing", 30000), \
             ("Ana", "Marketing", 30000), \
             ("Saulo", "Vendas", 41000)]

# Define os nomes das colunas para o DataFrame que será criado
columns = ["nome_funcionario", "departmento", "salario"]

# Cria um DataFrame a partir dos dados e esquema fornecidos
df = spark.createDataFrame(data = dados_dsa, schema = columns)

# Exibe o esquema do DataFrame, mostrando os tipos de dados de cada coluna
df.printSchema()

print("Count da Tabela Abaixo: " + str(df.count()) + "\n")

# Mostra o DataFrame, sem truncar os valores das células
df.show(truncate=False)

# Cria um novo DataFrame contendo apenas linhas distintas do DataFrame original
distinctDF = df.distinct()

# Imprime a contagem de linhas distintas
print("Distinct Count da Tabela Abaixo: " + str(distinctDF.count()) + "\n")

# Mostra o DataFrame de linhas distintas, sem truncar os valores das células
distinctDF.show(truncate=False)

# Cria outro DataFrame removendo duplicatas com base em todas as colunas
df2 = df.dropDuplicates()

# Imprime a contagem de linhas após remover duplicatas
print("Distinct Count da Tabela Abaixo Removendo Duplicatas: " + str(df2.count()) + "\n")

# Mostra o DataFrame após remover duplicatas, sem truncar os valores das células
df2.show(truncate=False)

# Cria um DataFrame removendo duplicatas com base apenas nas colunas 'departmento' e 'salario'
dropDisDF = df.dropDuplicates(["departmento", "salario"])

# Imprime a contagem de linhas distintas com base nas colunas 'departmento' e 'salario'
print("Distinct Count da Tabela Abaixo Removendo Duplicatas em Duas Colunas Apenas: " + str(dropDisDF.count()) + "\n")

# Mostra o DataFrame final, sem truncar os valores das células
dropDisDF.show(truncate=False)
