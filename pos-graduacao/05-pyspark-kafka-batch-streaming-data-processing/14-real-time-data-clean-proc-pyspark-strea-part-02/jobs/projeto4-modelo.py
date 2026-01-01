# Projeto 4 - Processamento e Análise de Dados em Tempo Real com PySpark Streaming
# Módulo de Análise com Machine Learning

# Ajusta o nível de log do TensorFlow
import logging, os
logging.disable(logging.WARNING)
os.environ["TF_CPP_MIN_LOG_LEVEL"] = "3"

# Imports
import json
import pandas as pd
import numpy as np
import tensorflow as tf
from pyspark.sql import SparkSession
from pyspark.sql.types import StructType, StructField, FloatType, StringType, TimestampType
from pyspark.ml.feature import VectorAssembler, StandardScaler
from tensorflow.keras.models import Sequential
from tensorflow.keras.layers import Dense, Input

# Inicializando sessão Spark
spark = SparkSession.builder.appName("Projeto4-Modelo").getOrCreate()

# Schema para os dados de sensores
schema = StructType([
    StructField("id_sensor", StringType(), True),
    StructField("timestamp", TimestampType(), True),
    StructField("umidade", FloatType(), True),
    StructField("nivelenxofre", FloatType(), True),
    StructField("rpm", FloatType(), True)
])

# Caminho do arquivo CSV
caminho_arquivo_csv = "/opt/spark/dados/dados.csv"

# Função para carregar os dados 
def dsa_carrega_dados(spark, file_path, schema):
    sensor_df = spark.read.csv(file_path, schema = schema, header = True)
    print(f"\nTotal de registros carregados: {sensor_df.count()}\n")
    return sensor_df

# Função para preparar os dados
def dsa_prepara_dados(sensor_df, padronizador = None):

    # Cria o Vector Assembler
    assembler = VectorAssembler(inputCols = ["umidade", "nivelenxofre", "rpm"], outputCol = "features")

    # Aplica o Vector Assembler
    assembled_data = assembler.transform(sensor_df)
    
    # Cria e treina o padronizador somente para dados de treino
    if padronizador is None:

        # Cria o padronizador
        scaler = StandardScaler(inputCol = "features", outputCol = "scaled_features", withMean = True, withStd = True)

        # Treina o padronizador
        padronizador = scaler.fit(assembled_data)

        # Extrai o que o padronizador aprendeu (média e desvio padrão)
        mean = padronizador.mean.toArray()
        std = padronizador.std.toArray()
        
        # Salva em disco
        with open("/opt/spark/modelos/scaler_params.json", "w") as f:
            json.dump({"mean": mean.tolist(), "std": std.tolist()}, f)
        
        print("\nParâmetros de padronização salvos com sucesso.\n")
    
    # O transform será aplicado em dados de treino e teste
    scaled_data = padronizador.transform(assembled_data).cache()
    
    return scaled_data, padronizador

# Função para criar o modelo Autoencoder
def dsa_cria_modelo_anomalia(input_shape):

    # Cria o objeto de sequência de camadas
    modelo_dsa = Sequential()

    # Codificador
    modelo_dsa.add(Input(shape = input_shape))
    modelo_dsa.add(Dense(64, activation = 'relu'))
    modelo_dsa.add(Dense(32, activation = 'relu'))

    # Codificação do espaço latente
    modelo_dsa.add(Dense(16, activation = 'relu'))

    # Decodificador
    modelo_dsa.add(Dense(32, activation = 'relu'))
    modelo_dsa.add(Dense(64, activation = 'relu'))
    modelo_dsa.add(Dense(input_shape[0], activation = 'linear'))

    # Compilação com backpropagation e função de erro
    modelo_dsa.compile(optimizer = 'adam', loss = 'mean_squared_error')

    return modelo_dsa

# Carrega os dados
sensor_data = dsa_carrega_dados(spark, caminho_arquivo_csv, schema)

# Divide os dados em treinamento (90%) e teste (10%)
train_data = sensor_data.sample(fraction = 0.9, seed = 123)
test_data = sensor_data.subtract(train_data)

# Prepara os dados de treinamento e aplica o padronizador
train_data_prepared, padronizador = dsa_prepara_dados(train_data)

# Prepara os dados de teste usando o mesmo padronizador
test_data_prepared, _ = dsa_prepara_dados(test_data, padronizador)

# Extrai e prepara os dados para o treinamento do modelo
X_treino_df = train_data_prepared.select("scaled_features").toPandas()
X_treino = np.array(X_treino_df["scaled_features"].tolist()).reshape(-1, 3)

# Extrai e prepara os dados para avaliação do modelo
X_teste_df = test_data_prepared.select("scaled_features").toPandas()
X_teste = np.array(X_teste_df["scaled_features"].tolist()).reshape(-1, 3)

# Cria o modelo Autoencoder
modelo_dsa_anomalia = dsa_cria_modelo_anomalia((3,))

# Treinamento do modelo
modelo_dsa_anomalia.fit(X_treino, X_treino, epochs = 15, batch_size = 16, verbose = 2)

# Avaliação do modelo no conjunto de teste
print("\nAvaliação do modelo com dados de teste.\n")
loss = modelo_dsa_anomalia.evaluate(X_teste, X_teste, verbose = 2)
print(f"\nErro no conjunto de teste: {loss}")

# Salvando o modelo
modelo_dsa_anomalia.save("/opt/spark/modelos/modelo_dsa_autoencoder.keras")
print("\nModelo Autoencoder para detecção de anomalias salvo com sucesso.\n")

# Encerrar sessão Spark
spark.stop()
