# DSA Projeto 2 - Script 17 - Drop de Colunas

# Imports
import os
import pyspark
from pyspark.sql import SparkSession
from pyspark.sql.functions import col

# Ambiente
os.environ['TERM'] = 'xterm'
os.system('clear')

print('\nDSA Projeto 2 - Script 17 - Drop de Colunas:\n')

# Cria uma sessão Spark com um nome específico para a aplicação
spark = SparkSession.builder.appName('DSAProjeto2-Script17').getOrCreate()

# Define uma tupla de tuplas contendo dados de exemplo
dados_dsa = (("Carlos", "", "Smith", "16636", "Rio de Janeiro", 13100), \
             ("Leonardo", "Rose", "", "20288", "Belo Horizonte", 14300), \
             ("Marcos", "", "Williams", "12114", "Natal", 11400), \
             ("Maria", "Anne", "Jones", "19192", "Natal", 15500), \
             ("Alex", "Mary", "Brown", "24561", "Rio de Janeiro", 13000) \
            )

# Define os nomes das colunas para o DataFrame
colunas = ["primeironome", "nomedomeio", "sobrenome", "id", "cidade", "salario"]

# Cria um DataFrame a partir dos dados fornecidos e com o esquema especificado pelas colunas
df = spark.createDataFrame(data = dados_dsa, schema = colunas)

# Exibe o esquema do DataFrame, mostrando os tipos de dados e a estrutura
df.printSchema()

# Exibe os dados do DataFrame sem truncar os valores para visualização completa
df.show(truncate=False)

# Remove a coluna 'primeironome' do DataFrame e exibe o novo esquema
df.drop("primeironome").printSchema()
  
# Remove a coluna 'primeironome' do DataFrame usando a função 'col' e exibe o novo esquema
df.drop(col("primeironome")).printSchema()  
  
# Remove a coluna 'primeironome' diretamente acessando-a como atributo do DataFrame e exibe o novo esquema
df.drop(df.primeironome).printSchema()

# Remove as colunas 'primeironome', 'nomedomeio' e 'sobrenome' do DataFrame e exibe o novo esquema
df.drop("primeironome", "nomedomeio", "sobrenome").printSchema()

# Define uma tupla com os nomes das colunas a serem removidas
cols = ("primeironome", "nomedomeio", "sobrenome", "cidade")

# Remove as colunas especificadas na tupla 'cols' do DataFrame e exibe o novo esquema
df.drop(*cols).printSchema()



