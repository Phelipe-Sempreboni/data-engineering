# DSA Projeto 2 - Script 02 - Adicionar Nova Coluna

# Imports
import os
from pyspark.sql import SparkSession
from pyspark.sql.functions import lit
from pyspark.sql.functions import concat_ws
from pyspark.sql.functions import when
from pyspark.sql.functions import current_date

# Ambiente
os.environ['TERM'] = 'xterm'
os.system('clear')

print('\nDSA Projeto 2 - Script 02 - Adicionar Nova Coluna:\n')

# Cria uma sessão Spark com um nome específico para a aplicação
spark = SparkSession.builder.appName('DSAProjeto2-Script02').getOrCreate()

# Define dados de exemplo
dados_dsa = [('Ana', 'Silva', 'F', 3000),
             ('Carlos', 'Souza', 'M', 4100),
             ('Fernanda', 'Lima', 'F', 6200)]

# Define os nomes das colunas
columns = ["nome", "sobrenome", "genero", "salario"]

# Cria um DataFrame com os dados e esquema especificados
df = spark.createDataFrame(data = dados_dsa, schema = columns)

# Mostra o DataFrame
df.show()

# Verifica se a coluna 'percentual_bonus' não está presente no DataFrame
if 'percentual_bonus' not in df.columns:

    print("A coluna percentual_bonus não existe na tabela. Adicionando...\n")

    # Adiciona a coluna com o percentual de bônus 
    df.withColumn("percentual_bonus", lit(0.3)).show()
    
# Adiciona uma coluna com o valor do bônus calculado com base no salário
df.withColumn("valor_bonus", df.salario * 0.3).show()

# Adiciona uma coluna concatenando nome e sobrenome
df.withColumn("name", concat_ws(",","nome",'sobrenome')).show()

# Adiciona uma coluna com a data atual
df.withColumn("current_date", current_date()).show()

# Adiciona uma coluna com a classificação com base no salário
df.withColumn("nivel", \
   when((df.salario < 4000), lit("A")) \
     .when((df.salario >= 4000) & (df.salario <= 5000), lit("B")) \
     .otherwise(lit("C")) \
  ).show()
    
# Seleciona duas colunas e adiciona uma coluna com o bônus
df.select("nome", "salario", lit(0.3).alias("bonus")).show()

# Seleciona duas colunas e adiciona uma coluna calculada com o valor do bônus
df.select("nome", "salario", lit(df.salario * 0.3).alias("valor_bonus")).show()

# Seleciona algumas colunas e adiciona uma coluna com a data atual
df.select("nome", "salario", current_date().alias("today_date")).show()

# Mostra o DataFrame
df.show()

# Cria ou substitui uma visualização temporária com o nome 'DSATEMP'
df.createOrReplaceTempView("DSATEMP")

# Executa uma consulta SQL para selecionar algumas colunas e adicionar uma coluna com o bônus
spark.sql("select nome, salario, '0.3' as bonus from DSATEMP").show()

# Executa uma consulta SQL para selecionar algumas colunas e adicionar uma coluna calculada com o valor do bônus
spark.sql("select nome, salario, salario * 0.3 as valor_bonus from DSATEMP").show()

# Executa uma consulta SQL para selecionar algumas colunas e adicionar uma coluna com a data atual
spark.sql("select nome, salario, current_date() as today_date from DSATEMP").show()

# Executa uma consulta SQL para selecionar algumas colunas e adicionar uma coluna com a classificação com base no salário
spark.sql("select nome, salario, " +
          "case when salario < 4000 then 'A' " +
          "else 'B' END as nivel from DSATEMP").show()






