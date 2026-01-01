# DSA Projeto 2 - Script 19 - Explode de Array e Map

# Imports
import os
import pyspark
from pyspark.sql import SparkSession

# Ambiente
os.environ['TERM'] = 'xterm'
os.system('clear')

print('\nDSA Projeto 2 - Script 19 - Explode de Array e Map:\n')

# Cria uma sessão Spark com um nome específico para a aplicação
spark = SparkSession.builder.appName('DSAProjeto2-Script19').getOrCreate()

# Define uma lista de tuplas contendo nomes, listas de linguagens de programação e dicionários com atributos
dados_dsa = [('Claudio', ['Java', 'Scala'], {'nivel': 'senior', 'cursos': 'DSA'}),
             ('Michel', ['Rust', 'Java', None], {'nivel': 'pleno', 'cursos': None}),
             ('Roberto', ['Python', ''], {'nivel': 'junior', 'cursos': ''}),
             ('Josias', None, None),
             ('Jefferson', ['Uva', 'Melancia'], {})]

# Cria um DataFrame a partir dos dados, especificando os nomes das colunas
df = spark.createDataFrame(data = dados_dsa, schema = ['nome', 'linguagens', 'atributos'])
df.printSchema()
df.show(truncate=False)

# Importa a função 'explode' para expandir os elementos das listas em linhas separadas
from pyspark.sql.functions import explode

# Seleciona o nome e expande a coluna 'linguagens' em linhas separadas
df2 = df.select(df.nome, explode(df.linguagens))
df2.printSchema()
df2.show(truncate=False)

# Importa novamente a função 'explode', desta vez para expandir os elementos dos dicionários em linhas separadas
from pyspark.sql.functions import explode

# Seleciona o nome e expande a coluna 'atributos' em linhas separadas
df3 = df.select(df.nome, explode(df.atributos))
df3.printSchema()
df3.show()

# Importa a função 'explode_outer' que funciona como 'explode', mas inclui linhas com valores nulos
from pyspark.sql.functions import explode_outer

# Expande a coluna 'linguagens' em linhas separadas, incluindo nomes com listas nulas
df.select(df.nome, explode_outer(df.linguagens)).show()

# Expande a coluna 'atributos' em linhas separadas, incluindo nomes com dicionários nulos ou vazios
df.select(df.nome, explode_outer(df.atributos)).show()

# Importa a função 'posexplode' que expande listas em linhas separadas e inclui o índice do elemento na lista
from pyspark.sql.functions import posexplode

# Expande a coluna 'linguagens', incluindo o índice de cada linguagem
df.select(df.nome, posexplode(df.linguagens)).show()

# Expande a coluna 'atributos', incluindo a chave como índice
df.select(df.nome, posexplode(df.atributos)).show()

# Importa a função 'posexplode_outer' que funciona como 'posexplode', mas inclui linhas com valores nulos
from pyspark.sql.functions import posexplode_outer

# Expande a coluna 'linguagens', incluindo o índice de cada linguagem, com tratamento para listas nulas
df.select(df.nome, posexplode_outer(df.linguagens)).show()

# Expande a coluna 'atributos', incluindo a chave como índice, com tratamento para dicionários nulos ou vazios
df.select(df.nome, posexplode_outer(df.atributos)).show()

