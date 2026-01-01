# Projeto 5 - Extração, Processamento e Armazenamento de Dados em Tempo Real com Kafka e Spark Streaming
# Kafka Producer

# Importa o módulo Producer da biblioteca confluent_kafka para interagir com o Kafka
from confluent_kafka import Producer

# Importa a biblioteca json para manipular objetos JSON
import json

# Importa a biblioteca time para trabalhar com timestamps
import time

# Importa a biblioteca random para gerar valores aleatórios
import random

# Configurações do Kafka
conf = {

    # Define o endereço do broker Kafka
    'bootstrap.servers': 'kafka:9092', 

    # Identifica o cliente que enviará os dados
    'client.id': 'dsa-producer'
}

# Função para gerar dados simulados
def dsa_gera_dados():

    return {

        # Gera um ID de usuário aleatório entre 1 e 1000
        "user_id": random.randint(1, 1000),

        # Escolhe aleatoriamente uma ação entre "acesso", "clique" e "compra"
        "action": random.choice(["acesso", "clique", "compra"]),
        
        # Captura o timestamp atual
        "timestamp": time.time()
    }

# Inicializa o produtor Kafka com as configurações definidas
producer = Producer(conf)

# Define o tópico Kafka onde os dados serão enviados
topic = "dsa_topic"

# Exibe uma mensagem indicando que o envio de dados começou
print("Enviando dados para o tópico Kafka...")

# Loop infinito para gerar e enviar dados continuamente
while True:

    # Gera um conjunto de dados simulados
    data = dsa_gera_dados()

    # Produz e envia a mensagem para o Kafka, com chave baseada no user_id
    producer.produce(topic, key = str(data["user_id"]), value = json.dumps(data))
    
    # Imprime os dados enviados no console
    print(f"Enviado: {data}")

    # Aguarda 1 segundo antes de gerar o próximo dado
    time.sleep(1)
    
    # Garante que os dados são enviados ao Kafka
    producer.flush()
