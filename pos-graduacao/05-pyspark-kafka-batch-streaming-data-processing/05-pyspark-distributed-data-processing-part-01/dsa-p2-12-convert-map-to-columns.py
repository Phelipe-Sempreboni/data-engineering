# DSA Projeto 2 - Script 12 - Converte Map Para Coluna

# Imports
import os
from pyspark.sql import SparkSession
from pyspark.sql.functions import col
from pyspark.sql.types import StructType, StructField, StringType, MapType

# Ambiente
os.environ['TERM'] = 'xterm'
os.system('clear')

print('\nDSA Projeto 2 - Script 12 - Converte Map Para Coluna:\n')

# Cria uma sessão Spark com um nome específico para a aplicação
spark = SparkSession.builder.appName('DSAProjeto2-Script12').getOrCreate()

# Define o esquema do DataFrame, incluindo uma coluna do tipo Map
schema = StructType([
    StructField("nome", StringType(), True),
    StructField("atributos", MapType(StringType(), StringType()), True)
])

# Cria dados para o DataFrame
dados_dsa = [("Bruno", {"idade": "30", "cidade": "Natal"}),
             ("Tatiana", {"idade": "25", "cidade": "Manaus"})]

# Cria um DataFrame com os dados definidos
df = spark.createDataFrame(data = dados_dsa, schema = schema)

# Mostra o DataFrame original
df.show(truncate=False)

# Converte o map para colunas
# Usando getItem para acessar os valores das chaves específicas do map
df = df.withColumn("idade", col("atributos").getItem("idade")) \
       .withColumn("cidade", col("atributos").getItem("cidade")) \
       .drop("atributos")

# Mostra o DataFrame após a conversão do map para colunas
df.show(truncate=False)
