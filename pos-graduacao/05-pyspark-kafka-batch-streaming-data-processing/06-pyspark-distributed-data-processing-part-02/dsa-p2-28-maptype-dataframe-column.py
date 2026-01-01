# DSA Projeto 2 - Script 28 - Maptype

# Veja o ebook complementar no Capítulo 6 do curso.

# Imports
import os
from pyspark.sql import SparkSession
from pyspark.sql.types import StructField, StructType, StringType, MapType

# Ambiente
os.environ['TERM'] = 'xterm'
os.system('clear')

print('\nDSA Projeto 2 - Script 28 - Maptype:\n')

# Cria uma sessão Spark com um nome específico para a aplicação
spark = SparkSession.builder.appName('DSAProjeto2-Script28').getOrCreate()

# Define uma lista de tuplas contendo nomes e um dicionário de atributos (nivel e especialidade)
dsa_dados = [('Marcela',{'nivel':'senior','especialidade':'Engenharia de Dados'}),
             ('Lucas',{'nivel':'pleno','especialidade':None}),
             ('Gabriel',{'nivel':'junior','especialidade':'Machine Learning'}),
             ('Rafael',{'nivel':'junior','especialidade':'Data Science'}),
             ('Isabela',{'nivel':'pleno','especialidade':''})]

# Define o schema do DataFrame com um campo de string para o nome e um mapa para os atributos
schema = StructType([
    StructField('nome', StringType(), True),
    StructField('atributos', MapType(StringType(),StringType()),True)
])

# Cria um DataFrame a partir da lista de dados com o schema especificado
df = spark.createDataFrame(data = dsa_dados, schema = schema)

# Imprime o esquema do DataFrame para visualizar sua estrutura
df.printSchema()

# Mostra o DataFrame completo sem truncar os dados para melhor visualização
df.show(truncate=False)

# Transforma o DataFrame em um RDD para manipulação dos dados e converte novamente para DataFrame com uma estrutura específica
df3 = df.rdd.map(lambda x: (x.nome,x.atributos["nivel"],x.atributos["especialidade"])).toDF(["nome", "nivel", "especialidade"])

# Imprime o esquema do novo DataFrame para visualizar a estrutura após a transformação
df3.printSchema()

# Mostra o novo DataFrame
df3.show(truncate=False)

# Adiciona novas colunas 'nivel' e 'especialidade' ao DataFrame original extraídas do mapa 'atributos', depois remove a coluna 'atributos'
df.withColumn("nivel", df.atributos.getItem("nivel")) \
  .withColumn("especialidade", df.atributos.getItem("especialidade")) \
  .drop("atributos") \
  .show(truncate=False)

# Repete o processo anterior, mas usando uma sintaxe alternativa para acessar os valores no mapa
df.withColumn("nivel", df.atributos["nivel"]) \
  .withColumn("especialidade", df.atributos["especialidade"]) \
  .drop("atributos") \
  .show(truncate=False)

# Seleciona o nome e explode o mapa de atributos em duas colunas separadas: chave e valor
from pyspark.sql.functions import explode
df.select(df.nome, explode(df.atributos)).show(truncate=False)

# Seleciona o nome e extrai as chaves do mapa de atributos
from pyspark.sql.functions import map_keys
df.select(df.nome, map_keys(df.atributos)).show(truncate=False)

# Seleciona o nome e extrai os valores do mapa de atributos
from pyspark.sql.functions import map_values
df.select(df.nome, map_values(df.atributos)).show(truncate=False)

