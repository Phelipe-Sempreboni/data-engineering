# DSA Projeto 2 - Script 09 - Sampling

# Imports
import os
from pyspark.sql import SparkSession

# Ambiente
os.environ['TERM'] = 'xterm'
os.system('clear')

print('\nDSA Projeto 2 - Script 09 - Sampling:\n')

# Cria uma sessão Spark com um nome específico para a aplicação
spark = SparkSession.builder.appName('DSAProjeto2-Script09').getOrCreate()

# Cria um DataFrame com 100 números, de 0 a 99
df = spark.range(100)

print("Exemplos com sample()")
print()

# Imprime uma amostra de aproximadamente 6% dos dados
print(df.sample(0.06).collect())
print()

# Imprime uma amostra de aproximadamente 10% dos dados, com uma semente específica para reprodução
print(df.sample(0.1,123).collect())
print()

# Repete a amostragem anterior para demonstrar a consistência com a mesma semente
print(df.sample(0.1,123).collect())
print()

# Imprime outra amostra de 10%, mas com uma semente diferente, resultando em uma amostra diferente
print(df.sample(0.1,456).collect())
print()

print("Exemplos com Substituição")
print()

# Amostra com substituição, aproximadamente 30% dos dados, com semente especificada
print(df.sample(True,0.3,123).collect())
print()

# Amostra sem substituição, aproximadamente 30% dos dados, com semente especificada
print(df.sample(0.3,123).collect())
print()

print("Exemplos com sampleBy")
print()

# Cria um novo DataFrame adicionando uma coluna 'key', calculada como o resto da divisão do id por 3
df2 = df.select((df.id % 3).alias("key"))

# Realiza uma amostragem estratificada com diferentes frações para cada valor da chave, sem semente especificada
print(df2.sampleBy("key", {0: 0.1, 1: 0.2},0).collect())
print()

print("Exemplos com RDD")
print()

# Cria um RDD de números de 0 a 99
rdd = spark.sparkContext.range(0,100)

# Imprime uma amostra sem substituição de aproximadamente 10% dos dados do RDD, com semente especificada
print(rdd.sample(False,0.1,0).collect())
print()

# Imprime uma amostra com substituição de aproximadamente 30% dos dados do RDD, com semente especificada
print(rdd.sample(True,0.3,123).collect())
print()

# Realiza uma amostragem sem substituição, selecionando 10 elementos aleatórios do RDD, com semente especificada
print(rdd.takeSample(False,10,0))
print()

# Realiza uma amostragem com substituição, selecionando 30 elementos aleatórios do RDD, com semente especificada
print(rdd.takeSample(True,30,123))
print()

# A semente (seed) em operações de amostragem, como as realizadas em processos de seleção aleatória de dados, 
# serve para garantir a reprodutibilidade dos resultados. Quando você especifica uma semente para um algoritmo 
# de amostragem ou qualquer outro tipo de operação que envolve aleatoriedade, você está essencialmente fixando 
# o ponto de partida do gerador de números aleatórios. Isso significa que cada vez que você executar o mesmo código, 
# com a mesma semente, nos mesmos dados, você obterá exatamente o mesmo conjunto de resultados.



