# Projeto 4 - Processamento e Análise de Dados em Tempo Real com PySpark Streaming
# Módulo de Processamento de Stream

# Ajusta o nível de log do TensorFlow
import logging, os
logging.disable(logging.WARNING)
os.environ["TF_CPP_MIN_LOG_LEVEL"] = "3"

# Imports
import sqlite3
from pyspark.sql import SparkSession
from pyspark.sql.functions import from_json, col
from pyspark.sql.types import StructType, StructField, FloatType, StringType, TimestampType
from pyspark.ml.feature import VectorAssembler
from tensorflow.keras.models import load_model
import numpy as np
import json

# Inicializando sessão Spark
spark = SparkSession.builder.appName("Projeto4-Stream").getOrCreate()

# Schema para dados de sensores
schema = StructType([
    StructField("id_sensor", StringType(), True),
    StructField("timestamp", TimestampType(), True),
    StructField("umidade", FloatType(), True),
    StructField("nivelenxofre", FloatType(), True),
    StructField("rpm", FloatType(), True)
])

# Carregando o modelo Autoencoder salvo para detecção de anomalias
model = load_model("/opt/spark/modelos/modelo_dsa_autoencoder.keras")
print("\nModelo Autoencoder para detecção de anomalias carregado com sucesso.")

# Carregando os parâmetros de padronização
try:
    with open("/opt/spark/modelos/scaler_params.json", "r") as f:
        scaler_params = json.load(f)
        mean = np.array(scaler_params["mean"])
        std = np.array(scaler_params["std"])
    print("Parâmetros de padronização carregados com sucesso.\n")
except Exception as e:
    print(f"Erro ao carregar os parâmetros de padronização: {e}")
    exit(1)

# Função de detecção de anomalias com cálculo de erro de reconstrução e salvamento no banco de dados SQLite
def dsa_detecta_anomalias(batch_df, batch_id):
    
    # Configura uma nova conexão SQLite 
    conn = sqlite3.connect("/opt/spark/modelos/dbdsap4.db")
    cursor = conn.cursor()

    # Cria as tabelas se não existirem
    cursor.execute('''
        CREATE TABLE IF NOT EXISTS dsa_dados (
            id_sensor TEXT,
            timestamp TEXT,
            umidade REAL,
            nivelenxofre REAL,
            rpm REAL
        )
    ''')
    cursor.execute('''
        CREATE TABLE IF NOT EXISTS dsa_previsoes (
            id_sensor TEXT,
            timestamp TEXT,
            error REAL,
            is_anomaly INTEGER
        )
    ''')

    # Converte para vetor numpy
    batch_np = np.array([row['features'].toArray() for row in batch_df.collect()])

    # Verificar se o lote está vazio
    if batch_np.size == 0:
        print(f"Batch {batch_id} está vazio. Nada para processar.")
        conn.close()
        return

    # Aplica a padronização
    batch_np = (batch_np - mean) / std

    # Realiza a previsão com o modelo carregado
    predictions = model.predict(batch_np)

    # Calcula o erro de reconstrução
    threshold = 0.8  # Ajuste conforme necessário
    for i, pred in enumerate(predictions):
        error = np.mean(np.abs(pred - batch_np[i]))
        is_anomaly = int(error > threshold)
        sensor_id = batch_df.collect()[i]['id_sensor']
        timestamp = batch_df.collect()[i]['timestamp']
        umidade = batch_df.collect()[i]['umidade']
        nivelenxofre = batch_df.collect()[i]['nivelenxofre']
        rpm = batch_df.collect()[i]['rpm']
        
        # Exibe anomalia detectada
        if is_anomaly:
            print(f"Anomalia detectada no batch {batch_id} para o {sensor_id} com erro {error}")
        else:
            print(f"Anomalia não detectada no batch {batch_id}.")
        
        # Salva os dados de entrada no banco de dados
        cursor.execute('''
            INSERT INTO dsa_dados (id_sensor, timestamp, umidade, nivelenxofre, rpm)
            VALUES (?, ?, ?, ?, ?)
        ''', (sensor_id, timestamp, umidade, nivelenxofre, rpm))

        # Salva o resultado da previsão no banco de dados
        cursor.execute('''
            INSERT INTO dsa_previsoes (id_sensor, timestamp, error, is_anomaly)
            VALUES (?, ?, ?, ?)
        ''', (sensor_id, timestamp, error, is_anomaly))
        
        # Commit das operações de salvamento
        conn.commit()

    # Fecha a conexão com o banco de dados
    conn.close()

# Configuração do stream de dados usando socket
streaming_data = spark.readStream \
    .format("socket") \
    .option("host", "localhost") \
    .option("port", 9999) \
    .load()

# Transformando os dados de streaming e convertendo colunas para DoubleType
sensor_data = streaming_data \
    .selectExpr("CAST(value AS STRING)") \
    .select(from_json(col("value"), schema).alias("data")) \
    .select("data.*") \
    .withColumn("umidade", col("umidade").cast("double")) \
    .withColumn("nivelenxofre", col("nivelenxofre").cast("double")) \
    .withColumn("rpm", col("rpm").cast("double"))

# Preparação dos dados para o modelo
assembler = VectorAssembler(inputCols = ["umidade", "nivelenxofre", "rpm"], outputCol = "features")
assembled_data = assembler.transform(sensor_data)

# Aplicação do modelo no stream
print("\nPronto Para Realizar Detecção de Anomalias em Tempo Real...\n")
query = assembled_data.writeStream \
    .foreachBatch(dsa_detecta_anomalias) \
    .start()

query.awaitTermination()

spark.stop()
