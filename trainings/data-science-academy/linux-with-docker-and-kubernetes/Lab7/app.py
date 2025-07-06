# Lab 7 - Orquestração de Containers Docker Para Escalabilidade de Web App e Banco de Dados

# Imports
import time
import redis
from flask import Flask

# Cria a app Flask
app = Flask(__name__)

# Conecta no host do Redis
cache = redis.Redis(host='dsadb', port=6379)

# Cria uma função para contagem de acessos
def get_hit_count():
    retries = 5
    while True:
        try:
            return cache.incr('hits')
        except redis.exceptions.ConnectionError as exc:
            if retries == 0:
                raise exc
            retries -= 1
            time.sleep(0.5)

# Cria a rota raiz com a função hello
@app.route('/')
def hello():

    # Obtém a contagem
    contador = get_hit_count()

    # Verifica o contador
    if contador == 1:
        contagem = 'Sucesso DSA! Esta página foi acessada {} vez.\n'.format(contador)
    else:
        contagem = 'Sucesso DSA! Esta página foi acessada {} vezes.\n'.format(contador)

    return contagem


