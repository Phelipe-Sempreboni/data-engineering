# Projeto 5 - Databricks Cluster Deploy com Terraform Para Processamento Distribuído

# Importa as funções col e current_timestamp do módulo pyspark.sql.functions
from pyspark.sql.functions import col, current_timestamp

# Define o caminho do dataset
file_path = "/databricks-datasets/structured-streaming/events"

# Obtém o nome de usuário atual e o formata para ser usado como parte do nome da tabela
username = spark.sql("SELECT regexp_replace(current_user(), '[^a-zA-Z0-9]', '_')").first()[0]

# Define o nome da tabela utilizando o nome de usuário
table_name = f"{username}_dsa_projeto5"

# Define o caminho do checkpoint para controle de progresso
checkpoint_path = f"/tmp/{username}/_checkpoint/dsa_projeto5"

# Remove a tabela existente, se existir
spark.sql(f"DROP TABLE IF EXISTS {table_name}")

# Remove o diretório de checkpoint existente, se existir
dbutils.fs.rm(checkpoint_path, True)

# Lê o stream de dados do arquivo, adiciona colunas para o caminho do arquivo fonte e o tempo de processamento,
# e grava os dados em uma tabela no formato de stream
(spark.readStream
  .format("cloudFiles")
  .option("cloudFiles.format", "json")
  .option("cloudFiles.schemaLocation", checkpoint_path)
  .load(file_path)
  .select("*", col("_metadata.file_path").alias("source_file"), current_timestamp().alias("processing_time"))
  .writeStream
  .option("checkpointLocation", checkpoint_path)
  .trigger(availableNow=True)
  .toTable(table_name))

# Lê os dados da tabela criada
df = spark.read.table(table_name)

# Exibe os dados lidos
display(df)
