# Data Science Academy

# Importa o módulo `uuid` para gerar identificadores únicos universais
import uuid

# Importa classes relacionadas a data e hora
from datetime import datetime, timedelta

# Importa as classes principais do Airflow para criar DAGs
from airflow import DAG

# Importa o operador Python do Airflow para execução de funções Python como tarefas
from airflow.operators.python import PythonOperator

# Define os argumentos padrão da DAG, incluindo o proprietário e a data de início
default_args = {"owner": "Data Science Academy",
                "start_date": datetime(2025, 1, 9, 8, 10)}

# Define a função que obtém dados de uma API
def dsa_extrai_dados_api():

    # Importa o módulo `requests` para fazer requisições HTTP
    import requests

    # Faz uma requisição GET para obter dados de uma API de usuários aleatórios
    res = requests.get("https://randomuser.me/api/")

    # Converte a resposta para JSON
    res = res.json()

    # Obtém o primeiro resultado da resposta JSON
    res = res["results"][0]

    # Retorna os dados obtidos
    return res

# Define a função que formata os dados obtidos da API
def dsa_formata_dados(res):

    # Cria um dicionário vazio para armazenar os dados formatados
    data = {}

    # Obtém os dados de localização do resultado
    location = res["location"]

    # Gera um ID único para o usuário
    data["id"] = uuid.uuid4().hex

    # Extrai e armazena o primeiro nome do usuário
    data["first_name"] = res["name"]["first"]

    # Extrai e armazena o último nome do usuário
    data["last_name"] = res["name"]["last"]

    # Extrai e armazena o gênero do usuário
    data["gender"] = res["gender"]

    # Formata e armazena o endereço completo do usuário
    data["address"] = (
        f"{str(location['street']['number'])} {location['street']['name']}, "
        f"{location['city']}, {location['state']}, {location['country']}"
    )

    # Armazena o código postal do endereço do usuário
    data["post_code"] = location["postcode"]

    # Armazena o email do usuário
    data["email"] = res["email"]

    # Armazena o nome de usuário do login do usuário
    data["username"] = res["login"]["username"]

    # Armazena a data de nascimento do usuário
    data["dob"] = res["dob"]["date"]

    # Armazena a data de registro do usuário
    data["registered_date"] = res["registered"]["date"]

    # Armazena o telefone do usuário
    data["phone"] = res["phone"]

    # Armazena a URL da imagem de perfil do usuário
    data["picture"] = res["picture"]["medium"]

    # Retorna os dados formatados
    return data

# Define a função que faz o streaming de dados para o Kafka
def dsa_stream_dados():

    # Importa o módulo `json` para manipular dados JSON
    import json

    # Importa o produtor do Kafka
    from kafka import KafkaProducer

    # Importa o módulo `time` para gerenciar intervalos de tempo
    import time

    # Importa o módulo `logging` para registrar mensagens
    import logging

    try:

        # Cria uma conexão com o broker Kafka
        producer = KafkaProducer(bootstrap_servers = ["broker:29092"], max_block_ms = 5000)

        # Aguarda 5 segundos antes de iniciar o streaming
        time.sleep(5)

        # Loga o sucesso da conexão com o broker Kafka
        logging.info("DSA Log - Produtor Kafka conectado com sucesso.")

    except Exception as e:

        # Loga qualquer erro ao tentar conectar ao broker Kafka
        logging.error(f"DSA Log - Falha ao conectar ao corretor Kafka: {e}")
        return

    # Define o tempo inicial
    curr_time = time.time()

    # Executa o loop de streaming por 60 segundos
    while True:

        # Verifica se 60 segundos já se passaram
        if time.time() > curr_time + 60:  # 1 minute
            break
        try:

            # Obtém dados da API
            res = dsa_extrai_dados_api()

            # Formata os dados
            res = dsa_formata_dados(res)

            # Envia os dados para o tópico Kafka
            producer.send("dsa_kafka_topic", json.dumps(res).encode("utf-8"))

        except Exception as e:

            # Loga qualquer erro durante o streaming de dados
            logging.error(f"DSA Log - Um erro ocorreu: {e}")
            continue

# Define a DAG do Airflow
with DAG("dsa-real-time-etl-stack",
         # Define os argumentos padrão da DAG
         default_args=default_args,
         # Define o agendamento da DAG como uma vez por dia
         schedule=timedelta(days=1),
         # Impede a execução retroativa da DAG
         catchup=False,
) as dag:
    # Define a tarefa que faz o streaming de dados
    streaming_task = PythonOperator(task_id="dsa_stream_from_api", 
                                    python_callable=dsa_stream_dados)




