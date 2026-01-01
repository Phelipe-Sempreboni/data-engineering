# DSA Projeto 2 - Script 22 - Pivot

# Imports
import os
import pyspark
from pyspark.sql import SparkSession
from pyspark.sql.functions import expr

# Ambiente
os.environ['TERM'] = 'xterm'
os.system('clear')

print('\nDSA Projeto 2 - Script 22 - Pivot:\n')

# Cria uma sessão Spark com um nome específico para a aplicação
spark = SparkSession.builder.appName('DSAProjeto2-Script22').getOrCreate()

# Define uma lista de tuplas contendo informações sobre produtos, quantidades e países de origem
dados_dsa = [("Banana",1000,"Equador"), ("Cenoura",1500,"Equador"), ("Arroz",1600,"Equador"),
             ("Laranja",2000,"Equador"), ("Laranja",2000,"Equador"), ("Banana",400,"Portugal"),
             ("Cenoura",1200,"Portugal"), ("Arroz",1500,"Portugal"), ("Laranja",4000,"Portugal"),
             ("Banana",2000,"Argentina"), ("Cenoura",2000,"Argentina"), ("Arroz",2000,"Mexico")]

# Define os nomes das colunas para o DataFrame
colunas = ["Produto", "Quantidade", "Pais"]

# Cria um DataFrame com os dados fornecidos e os nomes das colunas especificados
df = spark.createDataFrame(data = dados_dsa, schema = colunas)

# Imprime o esquema do DataFrame para mostrar a estrutura das colunas
df.printSchema()

# Exibe o DataFrame completo sem truncar os dados para melhor visualização
df.show(truncate=False)

# Agrupa os dados por produto e pivota com base no país, somando as quantidades de cada produto por país
pivotDF = df.groupBy("Produto").pivot("Pais").sum("Quantidade")

# Imprime o esquema do DataFrame pivoteado para mostrar a nova estrutura das colunas
pivotDF.printSchema()

# Exibe o DataFrame pivoteado
pivotDF.show(truncate=False)

# Agrupa os dados por produto e país, soma as quantidades, agrupa novamente por produto e pivota com base no país
# Esta abordagem garante que a soma seja feita antes do pivot para evitar possíveis problemas com múltiplas entradas
pivotDF = df.groupBy("Produto","Pais") \
      .sum("Quantidade") \
      .groupBy("Produto") \
      .pivot("Pais") \
      .sum("sum(Quantidade)")

# Imprime o esquema do DataFrame resultante para verificar a estrutura das colunas após o pivot
pivotDF.printSchema()

# Exibe o DataFrame resultante
pivotDF.show(truncate=False)

# Define uma expressão para desfazer o pivot (unpivot), transformando colunas em linhas
unpivotExpr = "stack(3, 'Argentina', Argentina, 'Portugal', Portugal, 'Mexico', Mexico) as (Pais,Total)"

# Seleciona a coluna de produto e aplica a expressão de unpivot, excluindo linhas onde o total é nulo
unPivotDF = pivotDF.select("Produto", expr(unpivotExpr)).where("Total is not null")

# Exibe o DataFrame após a operação de unpivot
unPivotDF.show(truncate=False)









