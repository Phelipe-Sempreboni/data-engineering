# Projeto 1 - Pipeline PySpark Para Extrair, Transformar e Carregar Arquivos JSON em Banco de Dados

# Imports
import os
from pyspark.sql import SparkSession, types
from pyspark.sql.functions import col, regexp_replace

# Inicializa a SparkSession
spark = SparkSession.builder \
    .appName("Projeto1") \
    .getOrCreate()

# Define o schema dos dados
schema = types.StructType([
    types.StructField("nome", types.StringType(), True),
    types.StructField("idade", types.IntegerType(), True),
    types.StructField("email", types.StringType(), True),
    types.StructField("salario", types.IntegerType(), True),
    types.StructField("cidade", types.StringType(), True)
])

# Carrega o arquivo JSON com o schema definido
df_dsa = spark.read.schema(schema).json("data/usuarios.json")

# Drop da coluna email (filtro no nível de coluna)
df_dsa_sem_email = df_dsa.drop("email")

# Filtra os dados (filtro no nível de linha)
df = df_dsa_sem_email.filter(
    (col("idade") > 35) & 
    (col("cidade") == "Natal") & 
    (col("salario") < 7000))

# Verifica o schema e os dados
df.printSchema()
df.show()

# Verifica se o DataFrame está vazio ou não
if df.rdd.isEmpty():
    print("Nenhum dado encontrado no arquivo JSON. Verifique o formato do arquivo.")
else:
    # Limpa os dados removendo '@' (se existir) da coluna nome
    df_clean = df.withColumn("nome", regexp_replace(col("nome"), "@", ""))

    # Define o caminho do banco de dados SQLite
    sqlite_db_path = os.path.abspath("data/usuarios.db")

    # Define a URL de conexão JDBC
    sqlite_uri = "jdbc:sqlite://" + sqlite_db_path

    # Define o driver JDBC
    properties = {"driver": "org.sqlite.JDBC"}

    # Verifica se a tabela 'dsa_usuarios' existe e define o modo de gravação
    try:
        # Tenta ler a tabela 'usuarios'
        spark.read.jdbc(url=sqlite_uri, table='dsa_usuarios', properties=properties)
        write_mode = "append"
    except:
        # Se a tabela não existir, o modo de gravação será 'overwrite'
        write_mode = "overwrite"

    # Grava os dados no banco de dados SQLite
    df_clean.write.jdbc(url=sqlite_uri, table="dsa_usuarios", mode=write_mode, properties=properties)

    print(f"Dados gravados no banco de dados SQLite em 'usuarios.db' usando o modo '{write_mode}'")
