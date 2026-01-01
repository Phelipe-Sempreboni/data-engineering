# DSA Projeto 2 - Script 25 - Operadores

# Veja o ebook complementar no Capítulo 6 do curso.

# Imports
import os
from pyspark.sql import SparkSession
from pyspark.sql.functions import expr

# Ambiente
os.environ['TERM'] = 'xterm'
os.system('clear')

print('\nDSA Projeto 2 - Script 25 - Operadores:\n')

# Cria uma sessão Spark com um nome específico para a aplicação
spark = SparkSession.builder.appName('DSAProjeto2-Script25').getOrCreate()

# Cria uma lista
dados_dsa = [("Eric", "Clapton", "100", None),
             ("Eddie", "Van Halen", "200", 'M'),
             ("Carlos", "Santana", "None", ''),
             ("Jimi Hendrix", None, "400", 'M'),
             ("Mark", "Knopfler", 500, 'M')] 

# Nome das colunas
colunas = ["primeironome", "sobrenome", "id", "genero"]

# Cria o dataframe
df = spark.createDataFrame(dados_dsa, colunas)

# Alias
print('\nOperador alias():')
df.select(df.primeironome.alias("first_name"), \
          df.sobrenome.alias("last_name"), \
          expr("primeironome ||','|| sobrenome").alias("fulsobrenome")).show()

# asc, desc
print('\nOperadores asc() e desc():')
df.sort(df.primeironome.asc()).show()
df.sort(df.primeironome.desc()).show()

# cast
print('\nCast Para Valor int:')
df.select(df.primeironome, df.id.cast("int")).printSchema()

# between
print('\nOperador between():')
df.filter(df.id.between(100,300)).show()

# contains
print('\nOperador contains():')
df.filter(df.primeironome.contains("Mark")).show()

# startswith e endswith
print('\nOperadores startswith() e endswith():')
df.filter(df.primeironome.startswith("E")).show()
df.filter(df.primeironome.endswith("k")).show()

# isNull e isNotNull
print('\nOperadores isNull() e isNotNull():')
df.filter(df.sobrenome.isNull()).show()
df.filter(df.sobrenome.isNotNull()).show()

# substr
print('\nOperador substr():')
df.select(df.primeironome.substr(1,2).alias("substr")).show()

