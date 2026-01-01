# DSA Projeto 2 - Script 23 - Split

# Imports
import os
import pyspark
from pyspark.sql import SparkSession
from pyspark.sql.functions import split, col

# Ambiente
os.environ['TERM'] = 'xterm'
os.system('clear')

print('\nDSA Projeto 2 - Script 23 - Split:\n')

# Cria uma sessão Spark com um nome específico para a aplicação
spark = SparkSession.builder.appName('DSAProjeto2-Script23').getOrCreate()

# Cria uma lista de tuplas contendo dados de pessoas, incluindo nome, nome do meio, sobrenome e data de nascimento
dados_dsa = [('Marcela','','Figueiredo','1981-04-01'),
             ('Eduardo','Barros','','2001-05-19'),
             ('Rafael','','Almeida','1979-09-05'),
             ('Isabela','Cristina','Souza','1997-12-01'),
             ('Lucas','Antonio','Nascimento','1990-02-17')]

# Define os nomes das colunas para o DataFrame
colunas = ["nome", "nomedomeio", "sobrenome", "data_nascimento"]

# Cria um DataFrame a partir dos dados com as colunas especificadas
df = spark.createDataFrame(dados_dsa, colunas)

# Imprime o esquema do DataFrame para visualizar a estrutura das colunas
df.printSchema()

# Exibe o DataFrame completo sem truncar os dados
df.show(truncate=False)

# Adiciona colunas separadas para ano, mês e dia a partir da coluna 'data_nascimento' usando a função split()
df1 = df.withColumn('year', split(df['data_nascimento'], '-').getItem(0)) \
        .withColumn('month', split(df['data_nascimento'], '-').getItem(1)) \
        .withColumn('day', split(df['data_nascimento'], '-').getItem(2))

# Imprime o esquema do novo DataFrame para mostrar as colunas adicionadas
df1.printSchema()

# Exibe o DataFrame com as novas colunas de data
df1.show(truncate=False)

# Alternativa à função split()
split_col = pyspark.sql.functions.split(df['data_nascimento'], '-')

# Utiliza a variável split_col para adicionar as colunas de ano, mês e dia
df2 = df.withColumn('year', split_col.getItem(0)) \
        .withColumn('month', split_col.getItem(1)) \
        .withColumn('day', split_col.getItem(2))

# Exibe o DataFrame df2 com as novas colunas
df2.show(truncate=False)

# Utiliza a função split() diretamente na seleção de colunas para adicionar ano, mês e dia com aliases
split_col = pyspark.sql.functions.split(df['data_nascimento'], '-')

# Usa o select
df3 = df.select("nome", "nomedomeio", "sobrenome", "data_nascimento", split_col.getItem(0).alias('year'), split_col.getItem(1).alias('month'), split_col.getItem(2).alias('day'))

# Exibe o DataFrame df3 com as novas colunas
df3.show(truncate=False)

# Cria um DataFrame com uma string que será dividida usando expressões regulares
df4 = spark.createDataFrame([('certezaqueAvemantesdeBnoalfabeto',)], ['str',])

# Seleciona a coluna e a divide em substrings onde 'A' ou 'B' ocorrem, sem limitar o número de resultados
df4.select(split(df4.str, '[AB]').alias('str')).show(truncate=False)

# Divide a string em substrings onde 'A' ou 'B' ocorrem, com um limite máximo de 2 substrings
df4.select(split(df4.str, '[AB]', 2).alias('str')).show(truncate=False)







