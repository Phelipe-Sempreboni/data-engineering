# DSA Projeto 2 - Script 50 - Window Functions

# Imports
import os
from pyspark.sql import SparkSession
from pyspark.sql.window import Window
from pyspark.sql.functions import row_number
from pyspark.sql.functions import rank
from pyspark.sql.functions import dense_rank
from pyspark.sql.functions import percent_rank
from pyspark.sql.functions import ntile
from pyspark.sql.functions import cume_dist    
from pyspark.sql.functions import lag    
from pyspark.sql.functions import lead    
from pyspark.sql.functions import col, avg, sum, min, max, row_number 

# Ambiente
os.environ['TERM'] = 'xterm'
os.system('clear')

print('\nDSA Projeto 2 - Script 50 - Window Functions:\n')

# Cria uma sessão Spark com um nome específico para a aplicação
spark = SparkSession.builder.appName('DSAProjeto2-Script50').getOrCreate()

# Definindo os dados
dados_dsa = (("Tatiana", "Comercial", 3000),
             ("Fernando", "Comercial", 4600),
             ("Pedro", "Comercial", 4100),
             ("Gabriel", "RH", 3000),
             ("Danilo", "Comercial", 3000),
             ("Josias", "RH", 3300),
             ("Tadeu", "RH", 3900),
             ("Ana", "Marketing", 3000),
             ("Carlos", "Marketing", 2000),
             ("Silvio", "Comercial", 4100))

# Definindo as colunas do DataFrame
colunas = ["nome", "departamento", "salario"]

# Criando um DataFrame com os dados fornecidos e a estrutura de colunas especificada
df = spark.createDataFrame(data = dados_dsa, schema = colunas)

# Imprimindo o esquema do DataFrame para verificar tipos de dados e estrutura de colunas
df.printSchema()

# Exibindo os dados do DataFrame sem truncar as informações
df.show(truncate=False)

# Definindo um particionamento para operações de janela
windowSpec = Window.partitionBy("departamento").orderBy("salario")

# Adicionando uma coluna 'row_number' que mostra o número da linha dentro da partição especificada
df.withColumn("row_number", row_number().over(windowSpec)).show(truncate=False)

# Adicionando uma coluna 'rank' que mostra o rank do salário dentro da partição especificada
df.withColumn("rank", rank().over(windowSpec)).show()

# Adicionando uma coluna 'dense_rank' que mostra o dense rank do salário dentro da partição especificada
df.withColumn("dense_rank", dense_rank().over(windowSpec)).show()

# Adicionando uma coluna 'percent_rank' que mostra o percentual de rank do salário dentro da partição especificada
df.withColumn("percent_rank", percent_rank().over(windowSpec)).show()

# Adicionando uma coluna 'ntile' que divide os dados em 2 grupos dentro da partição especificada
df.withColumn("ntile", ntile(2).over(windowSpec)).show()

# Adicionando uma coluna 'cume_dist' que mostra a distribuição cumulativa do salário dentro da partição especificada
df.withColumn("cume_dist", cume_dist().over(windowSpec)).show()

# Adicionando uma coluna 'lag' que retorna o salário com um deslocamento de 2 posições atrás na partição especificada
df.withColumn("lag", lag("salario", 2).over(windowSpec)).show()

# Adicionando uma coluna 'lead' que retorna o salário com um deslocamento de 2 posições à frente na partição especificada
df.withColumn("lead", lead("salario", 2).over(windowSpec)).show()

# Definindo uma especificação de janela para agregação sem ordenação
windowSpecAgg = Window.partitionBy("departamento")

# Adicionando múltiplas colunas de agregação e exibindo somente a primeira linha de cada departamento
df.withColumn("row", row_number().over(windowSpec)) \
  .withColumn("avg", avg(col("salario")).over(windowSpecAgg)) \
  .withColumn("sum", sum(col("salario")).over(windowSpecAgg)) \
  .withColumn("min", min(col("salario")).over(windowSpecAgg)) \
  .withColumn("max", max(col("salario")).over(windowSpecAgg)) \
  .where(col("row") == 1).select("departamento", "avg", "sum", "min", "max") \
  .show()


