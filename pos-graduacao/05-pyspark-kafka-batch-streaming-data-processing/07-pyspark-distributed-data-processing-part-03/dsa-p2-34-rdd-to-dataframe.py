# DSA Projeto 2 - Script 34 - RDD e Dataframe

# Imports
import os
from pyspark.sql import SparkSession
from pyspark.sql.types import StructType,StructField, StringType

# Ambiente
os.environ['TERM'] = 'xterm'
os.system('clear')

print('\nDSA Projeto 2 - Script 34 - RDD e Dataframe:\n')

# Cria uma sessão Spark com um nome específico para a aplicação
spark = SparkSession.builder.appName('DSAProjeto2-Script34').getOrCreate()

# Lista de tuplas contendo nomes de departamentos e seus respectivos IDs
dept = [("Vendas",10), 
        ("Marketing",20), 
        ("RH",30), 
        ("Engenharia de Dados",40)]

# Criando um RDD a partir da lista de departamentos
rdd = spark.sparkContext.parallelize(dept)

# Convertendo o RDD para um DataFrame sem especificar nomes de colunas
df = rdd.toDF()

# Imprimindo o esquema inferido do DataFrame
df.printSchema()

# Exibindo o DataFrame sem truncar os dados
df.show(truncate=False)

# Definindo os nomes das colunas para o DataFrame
deptColumns = ["dept_name", "dept_id"]

# Criando um novo DataFrame com os nomes de colunas especificados
df2 = rdd.toDF(deptColumns)

# Imprimindo o esquema do novo DataFrame
df2.printSchema()

# Exibindo o novo DataFrame sem truncar os dados
df2.show(truncate=False)

# Criando um DataFrame diretamente com dados e um esquema de colunas especificado
deptDF = spark.createDataFrame(data = dept, schema = deptColumns)

# Imprimindo o esquema do DataFrame criado
deptDF.printSchema()

# Exibindo o DataFrame criado sem truncar os dados
deptDF.show(truncate=False)

# Definindo um esquema para o DataFrame com tipos de dados e opção de nulabilidade
deptSchema = StructType([       
    StructField('dept_name', StringType(), True),
    StructField('dept_id', StringType(), True)
])

# Criando um DataFrame com o esquema detalhado e dados fornecidos
deptDF1 = spark.createDataFrame(data = dept, schema = deptSchema)

# Imprimindo o esquema do DataFrame definido
deptDF1.printSchema()

# Exibindo o DataFrame definido sem truncar os dados
deptDF1.show(truncate=False)
