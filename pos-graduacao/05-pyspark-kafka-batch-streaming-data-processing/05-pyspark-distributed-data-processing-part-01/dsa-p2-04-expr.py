# DSA Projeto 2 - Script 04 - Expr

# Imports
import os
from pyspark.sql import SparkSession
from pyspark.sql.functions import expr

# Ambiente
os.environ['TERM'] = 'xterm'
os.system('clear')

print('\nDSA Projeto 2 - Script 04 - Expr:\n')

# Cria uma sessão Spark com um nome específico para a aplicação
spark = SparkSession.builder.appName('DSAProjeto2-Script04').getOrCreate()

# Cria os dados
dados_dsa = [("Laura","Martins"), ("Rodrigo","Silva")] 

# Cria o dataframe
df = spark.createDataFrame(dados_dsa).toDF("Nome","Sobrenome") 

# Cria nova coluna em tempo de execução
df.withColumn("NomeCompleto", expr("Nome || ' ' || Sobrenome")).show()

# Novos dados
dados_dsa = [("Laura","F"), ("Rodrigo","M"), ("Mateus","")]

# Colunas
columns = ["nome", "genero"]

# Cria o dataframe
df = spark.createDataFrame(data = dados_dsa, schema = columns)

# Imprime o novo dataframe
df.show()

# Cria nova coluna e salva em um novo dataframe
df2 = df.withColumn("genero", expr("CASE WHEN genero = 'M' THEN 'Masculino' " +
           "WHEN genero = 'F' THEN 'Feminino' ELSE 'Desconhecido' END"))

# Imprime o novo dataframe
df2.show()

# Novos dados
dados_dsa = [("2025-01-15",1), ("2025-06-22",2), ("2025-09-27",3)] 

# Cria o dataframe com nomes para as colunas
df = spark.createDataFrame(dados_dsa).toDF("data","incremento") 

# Adiciona meses com o incremento e cria o alias
df.select(df.data, df.incremento,
     expr("add_months(data,incremento)")
  .alias("inc_data1")).show()

# Adiciona meses com o incremento com alias dentro da expressão
df.select(df.data, df.incremento,
     expr("""add_months(data,incremento) as inc_data2""")
  ).show()

# Adiciona meses com o incremento modificado com alias dentro da expressão
df.select(df.data, df.incremento + 5,
     expr("""add_months(data,incremento + 5) as inc_data3""")
  ).show()



