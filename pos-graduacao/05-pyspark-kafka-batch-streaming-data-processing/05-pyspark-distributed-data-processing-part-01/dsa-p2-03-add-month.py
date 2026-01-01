# DSA Projeto 2 - Script 03 - Operações com Datas

# Imports
import os
from pyspark.sql import SparkSession
from pyspark.sql.functions import col, expr

# Ambiente
os.environ['TERM'] = 'xterm'
os.system('clear')

print('\nDSA Projeto 2 - Script 03 - Operações com Datas:\n')

# Cria uma sessão Spark com um nome específico para a aplicação
spark = SparkSession.builder.appName('DSAProjeto2-Script03').getOrCreate()

# Define dados de exemplo com datas e incrementos
dados_dsa = [("2024-01-23",1), ("2024-06-14",2), ("2024-09-29",3)]

# Cria um DataFrame a partir dos dados, define os nomes das colunas e realiza a seleção e transformação dos dados
spark.createDataFrame(dados_dsa).toDF("data","incremento") \
          .select(col("data"),col("incremento"), \
            expr("add_months(to_date(data,'yyyy-MM-dd'),cast(incremento as int))") \
            .alias("inc_data")) \
          .show()

# A linha acima define os títulos das colunas com a função col e então adiciona o número de meses conforme o incremento.

# A função expr serve para avaliar a expressão SQL e executá-la.

# A linha acima seria equivalente a isso aqui:

# Cria um DataFrame a partir dos dados
df = spark.createDataFrame(dados_dsa).toDF("data","incremento")

# Cria uma view temporária para a consulta SQL
df.createOrReplaceTempView("DSATEMP")

# Executa a consulta SQL
spark.sql("""
    SELECT
        data,
        incremento,
        ADD_MONTHS(TO_DATE(data, 'yyyy-MM-dd'), CAST(incremento AS INT)) AS inc_data
    FROM
        DSATEMP
""").show()




