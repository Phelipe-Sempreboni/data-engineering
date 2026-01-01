# Projeto 5 - Extração, Processamento e Armazenamento de Dados em Tempo Real com Kafka e Spark Streaming
# Script Para Visualizar o Conteúdo de Arquivo Parquet

# Import
import pandas as pd

# Cria o dataframe do pandas a partir de arquivo parquet
df = pd.read_parquet("/Users/dmpm/Dropbox/DSA4.0/PySpark-Kafka/Cap16/projeto5/parquet_files/part-00194-7caad1be-0cb5-4e93-8fec-9344899662c3-c000.snappy.parquet")

print(df)
