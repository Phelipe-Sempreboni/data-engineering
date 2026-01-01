# Data Science Academy

# Importa o módulo sys para manipulação de argumentos e interação com o sistema
import sys

# Importa o módulo logging para registro de logs
import logging

# Importa o módulo json para manipulação de dados no formato JSON
import json

# Importa o módulo re para manipulação de expressões regulares
import re

# Importa o módulo argparse para manipulação de argumentos da linha de comando
import argparse

# Importa a classe Cluster do Cassandra para criar conexões ao banco de dados
from cassandra.cluster import Cluster

# Importa o módulo SparkSession para criar sessões Spark
from pyspark.sql import SparkSession

# Importa funções do PySpark para manipulação de dados com Spark
from pyspark.sql.functions import from_json, col, instr

# Importa tipos de dados estruturados do PySpark
from pyspark.sql.types import StructType, StructField, StringType

# Configura o logger para exibir mensagens de log com nível INFO
logging.basicConfig(
    level=logging.INFO, 
    format="%(asctime)s - %(levelname)s - %(message)s",
)

# Função para criar um keyspace no Cassandra
def dsa_cria_keyspace(session):

    # Executa a instrução a partir da sessão recebida como argumento
    session.execute(
        """
        CREATE KEYSPACE IF NOT EXISTS dsa_dados_usuarios
        WITH replication = {'class': 'SimpleStrategy', 'replication_factor': '1'};
        """
    )

    print("Keyspace criada com sucesso!")

# Função para criar uma tabela no Cassandra
def dsa_cria_tabela(session):

    # Executa a instrução a partir da sessão recebida como argumento
    session.execute(
        """
        CREATE TABLE IF NOT EXISTS dsa_dados_usuarios.tb_usuarios (
            id TEXT PRIMARY KEY,
            first_name TEXT,
            last_name TEXT,
            gender TEXT,
            address TEXT,
            post_code TEXT,
            email TEXT,
            username TEXT,
            dob TEXT,
            registered_date TEXT,
            phone TEXT,
            picture TEXT);
        """
    )

    print("Table criada com sucesso!")

# Função para formatar strings antes de inseri-las no Cassandra
def dsa_formata_string_cassandra(text: str):
    return re.sub(r"'", r"''", text)

# Função para inserir dados formatados no Cassandra
def dsa_insere_dados(session, row):

    # Formata e extrai campos do registro recebido
    user_id         = dsa_formata_string_cassandra(row.id)
    first_name      = dsa_formata_string_cassandra(row.first_name)
    last_name       = dsa_formata_string_cassandra(row.last_name)
    email           = dsa_formata_string_cassandra(row.email)
    username        = dsa_formata_string_cassandra(row.username)
    gender          = dsa_formata_string_cassandra(row.gender)
    address         = dsa_formata_string_cassandra(row.address)
    post_code       = dsa_formata_string_cassandra(row.post_code)
    dob             = dsa_formata_string_cassandra(row.dob)
    registered_date = dsa_formata_string_cassandra(row.registered_date)
    phone           = dsa_formata_string_cassandra(row.phone)
    picture         = dsa_formata_string_cassandra(row.picture)

    try:
        # Cria a query
        query = f"""
            INSERT INTO dsa_dados_usuarios.tb_usuarios(
                id, first_name, last_name, gender, address, post_code, email, username, dob, registered_date, phone, picture
            ) VALUES (
                '{user_id}', '{first_name}', '{last_name}', '{gender}', '{address}', '{post_code}', 
                '{email}', '{username}', '{dob}', '{registered_date}', '{phone}', '{picture}'
            )
        """
        
        # Insere dados formatados na tabela do Cassandra
        session.execute(query)
        logging.info(f"DSA Log - Dados inseridos para o registro: {user_id} - {first_name} {last_name} - {email}")
    except Exception as e:
        # Exibe erro no caso de falha ao inserir os dados
        logging.error(f"DSA Log - Os dados não podem ser inseridos devido ao erro: {e}")
        print(f"DSA Log - Esta é a query:\n{query}")

# Função para criar uma conexão Spark
def dsa_cria_spark_connection():

    try:
        # Configura e cria a conexão com o Spark
        s_conn = (
            SparkSession.builder.appName("DSAProjeto")
            .master("spark://spark-master:7077")
            .config(
                "spark.jars.packages",
                "com.datastax.spark:spark-cassandra-connector_2.12:3.4.1,"
                "org.apache.spark:spark-sql-kafka-0-10_2.12:3.4.1",
            )
            .config("spark.cassandra.connection.host", "cassandra")
            .config("spark.cassandra.connection.port", "9042")
            .config("spark.executor.memory", "1g")
            .config("spark.executor.cores", "1")
            .config("spark.cores.max", "2")
            .getOrCreate()
        )

        # Define o nível de log
        s_conn.sparkContext.setLogLevel("ERROR")
        logging.info("DSA Log - Spark Connection criada com sucesso!")
        return s_conn
    except Exception as e:
        logging.error(f"DSA Log - Não foi possível criar a Spark Connection devido ao erro: {e}")
        return None

# Função para criar uma conexão com o Kafka no Spark
def dsa_cria_kafka_connection(spark_conn, stream_mode):

    try:
        # Configura e cria um DataFrame Spark para leitura de dados do Kafka
        spark_df = (
            spark_conn.readStream.format("kafka")
            .option("kafka.bootstrap.servers", "broker:29092")
            .option("subscribe", "dsa_kafka_topic")
            .option("startingOffsets", stream_mode)
            .load()
        )
        logging.info("DSA Log - Dataframe Kafka criado com sucesso")
        return spark_df
    except Exception as e:
        # Exibe um aviso no caso de falha ao criar o DataFrame Kafka
        logging.warning(f"DSA Log - O dataframe Kafka não pôde ser criado devido ao erro: {e}")
        return None

# Função para criar um DataFrame estruturado a partir dos dados do Kafka
def dsa_cria_df_from_kafka(spark_df):

    # Define o esquema dos dados recebidos no formato JSON
    schema = StructType(
        [
            StructField("id", StringType(), False),
            StructField("first_name", StringType(), False),
            StructField("last_name", StringType(), False),
            StructField("gender", StringType(), False),
            StructField("address", StringType(), False),
            StructField("post_code", StringType(), False),
            StructField("email", StringType(), False),
            StructField("username", StringType(), False),
            StructField("dob", StringType(), False),
            StructField("registered_date", StringType(), False),
            StructField("phone", StringType(), False),
            StructField("picture", StringType(), False),
        ]
    )

    # Processa os dados do Kafka para extrair e filtrar os registros
    return (
        spark_df.selectExpr("CAST(value AS STRING)")            # Converte os dados para string
        .select(from_json(col("value"), schema).alias("data"))  # Converte JSON para colunas estruturadas
        .select("data.*")                                       # Extrai todas as colunas do campo "data"
        .filter(instr(col("email"), "@") > 0)                   # Filtra e retorna somente registros onde o email contém '@'
    )

# Função para criar uma conexão com o Cassandra
def dsa_cria_cassandra_connection():

    try:
        # Cria um cluster e retorna a sessão de conexão com o Cassandra
        cluster = Cluster(["cassandra"])
        return cluster.connect()
    except Exception as e:
        # Exibe um erro no caso de falha ao conectar ao Cassandra
        logging.error(f"DSA Log - Não foi possível criar a conexão Cassandra devido ao erro: {e}")
        return None

# Ponto de entrada principal do programa
if __name__ == "__main__":
    
    # Configura o parser para argumentos de linha de comando
    parser = argparse.ArgumentParser(description = "Real Time ETL.")
    
    # Adiciona o argumento para o modo de consumo dos dados
    parser.add_argument(
        "--mode",
        required=True,
        help="Modo de consumo dos dados",
        choices=["initial", "append"],
        default="append",
    )

    # Analisa os argumentos fornecidos
    args = parser.parse_args()

    # Define o modo de consumo com base no argumento fornecido
    stream_mode = "earliest" if args.mode == "initial" else "latest"

    # Cria conexões com o Cassandra e Spark
    session = dsa_cria_cassandra_connection()
    spark_conn = dsa_cria_spark_connection()

    # Se tiver sessão criada
    if session and spark_conn:

        # Cria o keyspace e a tabela no Cassandra
        dsa_cria_keyspace(session)
        dsa_cria_tabela(session)

        # Cria uma conexão com o Kafka e obtém um DataFrame
        kafka_df = dsa_cria_kafka_connection(spark_conn, stream_mode)

        if kafka_df:

            # Cria um DataFrame estruturado a partir dos dados do Kafka
            structured_df = dsa_cria_df_from_kafka(kafka_df)

            # Função para processar lotes de dados
            def process_batch(batch_df, batch_id):
                
                # Itera sobre as linhas do lote e insere os dados no Cassandra
                for row in batch_df.collect():
                    dsa_insere_dados(session, row)

            # Configura o processamento contínuo do DataFrame estruturado
            query = (
                structured_df.writeStream
                .foreachBatch(process_batch)  # Define o processamento por lote
                .start()                      # Inicia o processamento
            )
        
            # Aguarda a conclusão do fluxo
            query.awaitTermination()

