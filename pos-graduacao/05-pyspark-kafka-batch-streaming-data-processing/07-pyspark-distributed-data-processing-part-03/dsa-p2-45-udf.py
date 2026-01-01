# DSA Projeto 2 - Script 45 - UDF (User Defined Function)

# Imports
import os
from pyspark.sql import SparkSession
from pyspark.sql.functions import col, udf
from pyspark.sql.types import StringType

# Ambiente
os.environ['TERM'] = 'xterm'
os.system('clear')

print('\nDSA Projeto 2 - Script 45 - UDF:\n')

# Cria uma sessão Spark com um nome específico para a aplicação
spark = SparkSession.builder.appName('DSAProjeto2-Script45').getOrCreate()

# Definindo uma lista de tuplas com identificadores e nomes de jogadores de hóquei no gelo
dados_dsa = [("1", "Wayne Gretzky"),
             ("2", "Alex Ovechkin"),
             ("3", "Mario Lemieux")]

# Definindo as colunas do DataFrame
colunas = ["Seqno", "Nome"]

# Criando um DataFrame a partir dos dados especificados com as colunas definidas
df = spark.createDataFrame(data = dados_dsa, schema = colunas)

# Exibindo os dados do DataFrame sem truncar as informações para verificar os dados carregados
df.show(truncate=False)

# Definindo uma função para converter cada parte do nome 
def convertCase(str):
    resStr = ""
    arr = str.split(" ")
    for x in arr:
       resStr = resStr + x[0:1].upper() + x[1:len(x)] + " "
    return resStr

# Registrando a função como uma UDF (User Defined Function)
convertUDF = udf(lambda z: convertCase(z))

# Aplicando a UDF ao DataFrame e exibindo os resultados
df.select(col("Seqno"), convertUDF(col("Nome")).alias("Nome")).show(truncate=False)

# Definindo uma UDF com decorador para converter o nome em maiúsculas
@udf(returnType=StringType()) 
def upperCase(str):
    return str.upper()

# Criando uma UDF lambda para uso com a função upperCase
upperCaseUDF = udf(lambda z: upperCase(z), StringType())

# Aplicando a UDF para criar uma coluna com nomes em maiúsculas e exibindo os resultados
df.withColumn("Nome", upperCase(col("Nome"))).show(truncate=False)

# Registrando a UDF para uso em consultas SQL
spark.udf.register("convertUDF", convertCase, StringType())

# Criando uma visão temporária do DataFrame
df.createOrReplaceTempView("DSATABELA1")

# Executando uma consulta SQL que utiliza a UDF registrada e exibindo os resultados
spark.sql("select Seqno, convertUDF(Nome) as Nome from DSATABELA1").show(truncate=False)

# Executando uma consulta SQL para filtrar nomes que incluam 'Wayne' utilizando a UDF
spark.sql("select Seqno, convertUDF(Nome) as Nome from DSATABELA1 " + \
          "where Nome is not null and convertUDF(Nome) like '%Wayne%'") \
     .show(truncate=False)

# Atualizando a lista de tuplas para incluir um elemento com nome nulo
dados_dsa = [("1", "Wayne Gretzky"),
             ("2", "Alex Ovechkin"),
             ("3", "Mario Lemieux"),
             ('4', None)]

# Recriando o DataFrame com os novos dados
df2 = spark.createDataFrame(data = dados_dsa, schema = colunas)

# Exibindo os novos dados do DataFrame
df2.show(truncate=False)

# Criando uma nova visão temporária para o DataFrame atualizado
df2.createOrReplaceTempView("DSATABELA2")
    
# Registrando uma UDF que trata valores nulos de forma segura
spark.udf.register("_nullsafeUDF", lambda str: convertCase(str) if str is not None else "", StringType())

# Executando uma consulta SQL que utiliza a UDF segura para nulos
spark.sql("select _nullsafeUDF(Nome) from DSATABELA2").show(truncate=False)

# Executando uma consulta SQL para filtrar nomes que incluam 'Wayne' utilizando a UDF segura para nulos
spark.sql("select Seqno, _nullsafeUDF(Nome) as Nome from DSATABELA2 " + \
          "where Nome is not null and _nullsafeUDF(Nome) like '%Wayne%'") \
     .show(truncate=False)


# Um decorador em Python é uma função que modifica ou estende o comportamento de outra função ou método 
# sem alterá-lo diretamente. Decoradores são uma forma poderosa e elegante de aplicar aspectos transversais 
# (como logging, autenticação, caching, etc.) de forma modular e reutilizável.


