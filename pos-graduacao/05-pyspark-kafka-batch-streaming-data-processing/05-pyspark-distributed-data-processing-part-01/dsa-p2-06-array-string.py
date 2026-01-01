# DSA Projeto 2 - Script 06 - Array String

# Imports
import os
from pyspark.sql import SparkSession
from pyspark.sql.functions import col, concat_ws

# Ambiente
os.environ['TERM'] = 'xterm'
os.system('clear')

print('\nDSA Projeto 2 - Script 06 - Array String:\n')

# Cria uma sessão Spark com um nome específico para a aplicação
spark = SparkSession.builder.appName('DSAProjeto2-Script06').getOrCreate()

# Define os dados para o DataFrame
dados_dsa = [("Ana,Silva",["Rust","Javascript","C++"],"RJ"), \
             ("Mario,Teixeira,",["Javascript","Rust","C++"],"SP"), \
             ("Tatiana,Freitas",["Scala","Python"],"ES")]

# Define os nomes das colunas para o DataFrame
columns = ["nome","linguagemMaisUsada","estado"]

# Cria um DataFrame com os dados fornecidos e o esquema especificado pelas colunas
df = spark.createDataFrame(data = dados_dsa, schema = columns)

# Exibe o esquema do DataFrame para verificar os tipos de dados das colunas
df.printSchema()

# Mostra o DataFrame sem truncar os valores (para visualização completa)
df.show(truncate=False)

# Cria um novo DataFrame, convertendo a coluna 'linguagemMaisUsada' de um array para uma string, separada por vírgulas
df2 = df.withColumn("linguagemMaisUsada", concat_ws(",",col("linguagemMaisUsada")))

# Exibe o esquema do novo DataFrame para verificar a alteração na coluna 'linguagemMaisUsada'
df2.printSchema()

# Mostra o novo DataFrame sem truncar os valores, permitindo a visualização da coluna 'linguagemMaisUsada' como uma string
df2.show(truncate=False)

# Cria uma view temporária do DataFrame original para executar queries SQL diretamente 
df.createOrReplaceTempView("ARRAY_STRING")

# Executa uma query SQL para selecionar e mostrar os nomes, as linguagens mais usadas (como uma string separada por vírgulas) 
# e o estado, sem truncar os valores
spark.sql("select nome, concat_ws(',',linguagemMaisUsada) as linguagemMaisUsada, estado from ARRAY_STRING").show(truncate=False)


