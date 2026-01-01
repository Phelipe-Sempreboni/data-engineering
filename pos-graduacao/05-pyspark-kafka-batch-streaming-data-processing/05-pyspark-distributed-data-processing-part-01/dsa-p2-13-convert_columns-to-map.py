# DSA Projeto 2 - Script 13 - Converte Coluna Para Map

# Imports
import os
from pyspark.sql import SparkSession
from pyspark.sql.types import StructType, StructField, StringType, IntegerType
from pyspark.sql.functions import col, lit, create_map

# Ambiente
os.environ['TERM'] = 'xterm'
os.system('clear')

print('\nDSA Projeto 2 - Script 13 - Converte Coluna em Map:\n')

# Cria uma sessão Spark com um nome específico para a aplicação
spark = SparkSession.builder.appName('DSAProjeto2-Script13').getOrCreate()

# Define os dados a serem usados no DataFrame
dados_dsa = [("98712","Vendas",3000,"Portugal"), 
             ("57014","Vendas",5000,"Espanha"), 
             ("32986","RH",3900,"Portugal"), 
             ("10958","Marketing",2500,"Chile"), 
             ("67023","RH",6500,"Inglaterra") ]

# Define o esquema para o DataFrame com tipos específicos para cada coluna
schema = StructType([
     StructField('id', StringType(), True),
     StructField('dept', StringType(), True),
     StructField('salario', IntegerType(), True),
     StructField('pais', StringType(), True)
     ])

# Cria o DataFrame com os dados e esquema definidos
df = spark.createDataFrame(data = dados_dsa, schema = schema)

# Exibe o esquema do DataFrame para confirmar a estrutura
df.printSchema()

# Mostra o conteúdo do DataFrame sem truncar os valores
df.show(truncate=False)

# Modifica o DataFrame para adicionar uma coluna do tipo mapa (propertiesMap) 
# que contém o salário e o país, em seguida, remove as colunas originais 'salario' e 'pais'
df = df.withColumn("propertiesMap",create_map(
        lit("salario"),col("salario"),  # Adiciona o salário ao map
        lit("pais"),col("pais")         # Adiciona o país ao map
        )).drop("salario","pais")       # Remove as colunas originais 'salario' e 'pais' originais

# Exibe o esquema do DataFrame modificado para confirmar as mudanças
df.printSchema()

# Mostra o conteúdo do DataFrame modificado sem truncar os valores
df.show(truncate=False)

