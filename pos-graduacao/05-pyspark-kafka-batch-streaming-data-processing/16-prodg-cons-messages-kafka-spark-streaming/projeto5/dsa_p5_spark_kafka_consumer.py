# Projeto 5 - Extração, Processamento e Armazenamento de Dados em Tempo Real com Kafka e Spark Streaming
# Kafka Consumer

# Imports
from pyspark.sql import SparkSession
from pyspark.sql.functions import from_json, col, window, from_unixtime
from pyspark.sql.types import StructType, StringType, DoubleType, LongType

# Configuração do Spark
spark = SparkSession.builder \
    .appName("DSAProjeto5") \
    .config("spark.hadoop.fs.defaultFS", "hdfs://namenode:9000") \
    .getOrCreate()

# Configurações do Kafka
kafka_bootstrap_servers = "kafka:9092"
kafka_topic = "dsa_topic"

# Esquema dos dados
schema = StructType() \
    .add("user_id", StringType()) \
    .add("action", StringType()) \
    .add("timestamp", DoubleType())

# Leitura de dados do Kafka
raw_stream = spark.readStream \
    .format("kafka") \
    .option("kafka.bootstrap.servers", kafka_bootstrap_servers) \
    .option("subscribe", kafka_topic) \
    .option("startingOffsets", "latest") \
    .load()

# Decodificar os dados JSON
data_stream = raw_stream.selectExpr("CAST(value AS STRING)") \
    .select(from_json(col("value"), schema).alias("data")) \
    .select("data.*")

# Converte a coluna timestamp de double para timestamp
data_stream = data_stream.withColumn("timestamp", from_unixtime("timestamp").cast("timestamp"))

# Adicione o watermark para gerenciar os dados de streaming
result = data_stream \
    .withWatermark("timestamp", "10 seconds") \
    .groupBy(
        window(col("timestamp"), "10 seconds"),
        col("action")
    ).count()

# Gravar os resultados no HDFS
output_path = "hdfs://namenode:9000/output/kafka_stream"

query = result.writeStream \
    .outputMode("append") \
    .format("parquet") \
    .option("path", output_path) \
    .option("checkpointLocation", "hdfs://namenode:9000/checkpoints/kafka_stream") \
    .start()

print("Processando dados do Kafka e salvando no HDFS...")
query.awaitTermination()





