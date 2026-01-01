# DSA Projeto 2 - Script 37 - RDD MapReduce

# Imports
import os
from pyspark.sql import SparkSession

# Ambiente
os.environ['TERM'] = 'xterm'
os.system('clear')

print('\nDSA Projeto 2 - Script 37 - RDD MapReduce:\n')

# Cria uma sessão Spark com um nome específico para a aplicação
spark = SparkSession.builder.appName('DSAProjeto2-Script37').getOrCreate()

dados_dsa = ["Formação Cientista de Dados",
             "Formação Engenheiro de Dados",
             "Formação Analista de Dados",
             "Formação Arquiteto de Dados",
             "Formação Engenheiro de IA"]

# Criação de RDD
rdd = spark.sparkContext.parallelize(dados_dsa)

# Passo de mapeamento: dividir cada frase em palavras
rdd_palavras = rdd.flatMap(lambda linha: linha.split())

# Passo de mapeamento: mapear cada palavra para uma tupla (palavra, 1)
rdd_contagem = rdd_palavras.map(lambda palavra: (palavra, 1))

# Passo de redução: somar todas as contagens para cada palavra
rdd_resultado = rdd_contagem.reduceByKey(lambda a, b: a + b)

# Coletando os resultados
resultados = rdd_resultado.collect()

# Exibir os resultados
for (palavra, contagem) in resultados:
    print(f'{palavra}: {contagem}')



    