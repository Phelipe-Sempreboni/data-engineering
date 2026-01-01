# Usando uma imagem base com Python
FROM python:3.11-slim

# Definindo o mantenedor
LABEL maintainer="DSA"

# Atualizando a lista de pacotes e instalando dependências
RUN apt-get update && apt-get install -y --no-install-recommends \
    build-essential \
    git \
    vim \
    nano \
    sqlite3 \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/*

# Criar a pasta /iac como um ponto de montagem para um volume
RUN mkdir /dsa
VOLUME /dsa

# Criando um diretório de trabalho
WORKDIR /dsa

# Instalando DBT e adaptador para o BigQuery
RUN pip install dbt-core==1.8.8
RUN pip install dbt-bigquery==1.8.3

# Expor a porta
EXPOSE 8080

# Definir o comando padrão para execução quando o container for iniciado
CMD ["/bin/bash"]
