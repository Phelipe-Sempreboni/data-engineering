# DSA Projeto 2 - Script 11 - Aggregate e Stats

# Imports
import os
import pyspark
from pyspark.sql import SparkSession
from pyspark.sql.functions import approx_count_distinct, collect_list
from pyspark.sql.functions import collect_set, sum, avg, min, max, countDistinct, count, sum_distinct
from pyspark.sql.functions import first, last, kurtosis, mean, skewness 
from pyspark.sql.functions import stddev, stddev_samp, stddev_pop
from pyspark.sql.functions import variance, var_samp, var_pop

# Ambiente
os.environ['TERM'] = 'xterm'
os.system('clear')

print('\nDSA Projeto 2 - Script 11 - Aggregate e Stats:\n')

# Cria uma sessão Spark com um nome específico para a aplicação
spark = SparkSession.builder.appName('DSAProjeto2-Script11').getOrCreate()

# Define os dados e o esquema para o DataFrame
dados_dsa = [("Ana", "Vendas", 3000),
             ("Carlos", "Vendas", 4600),
             ("Maria", "Vendas", 4100),
             ("Gabriel", "Contabilidade", 3000),
             ("Eduardo", "Vendas", 3000),
             ("Mariano", "Contabilidade", 3300),
             ("Gustavo", "Contabilidade", 3900),
             ("Pedro", "Marketing", 3000),
             ("Leonardo", "Marketing", 2000),
             ("Wesley", "Vendas", 4100)]

# Define o esquema para o DataFrame
schema = ["nome", "departmento", "salario"]
  
# Cria um DataFrame com os dados e esquema fornecidos
df = spark.createDataFrame(data = dados_dsa, schema = schema)

# Exibe o esquema do DataFrame
df.printSchema()

# Mostra os dados do DataFrame sem truncar os valores
df.show(truncate=False)

# Calcula e imprime a contagem distinta dos salários
print("Contagem Distinta: " + str(df.select(approx_count_distinct("salario")).collect()[0][0]))
print()

# Calcula e imprime a média dos salários
print("Média: " + str(df.select(avg("salario")).collect()[0][0]))
print()

# Coleta e mostra a lista de todos os salários (com repetições)
df.select(collect_list("salario")).show(truncate=False)

# Coleta e mostra o conjunto de salários (sem repetições)
df.select(collect_set("salario")).show(truncate=False)

# Seleciona a contagem distinta dos departamentos e salários
df2 = df.select(countDistinct("departmento", "salario"))

# Mostra o resultado da contagem distinta
df2.show(truncate=False)

# Imprime a contagem distinta de departamentos e salários
print("Contagem Distinta de Departamento e Salario: "+str(df2.collect()[0][0]))
print()

# Calcula e imprime a contagem total dos salários
print("Contagem: "+str(df.select(count("salario")).collect()[0]))
print()

# Seleciona e mostra o primeiro salário da lista
df.select(first("salario")).show(truncate=False)

# Seleciona e mostra o último salário da lista
df.select(last("salario")).show(truncate=False)

# Calcula e mostra a curtose dos salários
df.select(kurtosis("salario")).show(truncate=False)

# Encontra e mostra o maior salário
df.select(max("salario")).show(truncate=False)

# Encontra e mostra o menor salário
df.select(min("salario")).show(truncate=False)

# Calcula e mostra a média dos salários
df.select(mean("salario")).show(truncate=False)

# Calcula e mostra a assimetria dos salários
df.select(skewness("salario")).show(truncate=False)

# Calcula e mostra o desvio padrão amostral e populacional dos salários
df.select(stddev("salario"), stddev_samp("salario"), stddev_pop("salario")).show(truncate=False)

# Calcula e mostra a soma dos salários
df.select(sum("salario")).show(truncate=False)

# Calcula e mostra a soma dos salários distintos
df.select(sum_distinct("salario")).show(truncate=False)

# Calcula e mostra a variância amostral e populacional dos salários
df.select(variance("salario"),var_samp("salario"),var_pop("salario")).show(truncate=False)
