# Data Science Academy

# Imagem base
FROM python:3.11-slim

# Instala dependências do sistema 
RUN apt-get update && apt-get install -y \
    openjdk-17-jre \
    curl && \
    apt-get clean

# Instala dependências Python
RUN pip install pyspark==3.5.4 kafka-python==2.0.2 cassandra-driver==3.29.2

# Copia o script para o container
COPY dsa_consumer_stream.py /app/dsa_consumer_stream.py

# Configura diretório de trabalho
WORKDIR /app

# Comando de entrada padrão
#CMD ["python", "dsa_consumer_stream.py", "--mode", "append"]