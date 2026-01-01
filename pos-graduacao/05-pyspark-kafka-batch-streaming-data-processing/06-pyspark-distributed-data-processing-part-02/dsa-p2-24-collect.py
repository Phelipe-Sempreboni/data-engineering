# DSA Projeto 2 - Script 24 - Collect

# Veja o ebook complementar no Capítulo 6 do curso.

# Imports
import os
import pyspark
from pyspark.sql import SparkSession

# Ambiente
os.environ['TERM'] = 'xterm'
os.system('clear')

print('\nDSA Projeto 2 - Script 24 - Collect:\n')

# Cria uma sessão Spark com um nome específico para a aplicação
spark = SparkSession.builder.appName('DSAProjeto2-Script24').getOrCreate()

# Define uma lista de tuplas contendo nomes de departamentos e seus respectivos IDs
dados_dsa = [("Data Science", 10), ("Tecnologia", 20), ("Marketing", 30), ("Vendas", 40)]

# Define os nomes das colunas para o DataFrame
deptColumns = ["dept_name", "dept_id"]

# Cria um DataFrame no Spark a partir dos dados fornecidos com as colunas especificadas
deptDF = spark.createDataFrame(data=dados_dsa, schema=deptColumns)

# Imprime o esquema do DataFrame para mostrar a estrutura das colunas
deptDF.printSchema()

# Exibe o DataFrame completo sem truncar os dados para melhor visualização das colunas e seus valores
deptDF.show(truncate=False)

# Coleta todos os dados do DataFrame em uma lista de objetos Row, movendo os dados para a memória local
dataCollect = deptDF.collect()

# Imprime a lista de Rows coletada do DataFrame
print(dataCollect)

# Seleciona e coleta os dados da coluna 'dept_name' do DataFrame, resultando em uma lista de objetos Row
dataCollect2 = deptDF.select("dept_name").collect()

# Imprime a lista de Rows contendo apenas o nome dos departamentos
print(dataCollect2)

# Itera sobre cada Row na lista coletada e imprime o nome do departamento e o ID, formatados como uma string
for row in dataCollect:
    print(row['dept_name'] + "," + str(row['dept_id']))


