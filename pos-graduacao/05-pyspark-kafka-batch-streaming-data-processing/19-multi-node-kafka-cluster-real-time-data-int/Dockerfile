# Projeto 8 - Simulação de Erros e Recuperação de Falhas em Multi-Node Kafka Cluster Para Gestão de Vendas em Tempo Real

# Imagem base
FROM jupyter/datascience-notebook:latest

# Usuário para instalar as dependências
USER root

# Atualiza o SO e instala pacotes
RUN apt-get update && \
    apt-get install -y --no-install-recommends \
      sudo \
      curl \
      vim \
      nano \
      unzip \
      rsync \
      openjdk-11-jdk \
      build-essential \
      software-properties-common \
      ssh && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/*

# Variável de ambiente do Spark
ENV SPARK_HOME=/opt/spark

# Faz o download dos binários do Spark
RUN wget https://archive.apache.org/dist/spark/spark-3.5.4/spark-3.5.4-bin-hadoop3.tgz && \
    tar -xvzf spark-3.5.4-bin-hadoop3.tgz && \
    mv spark-3.5.4-bin-hadoop3 ${SPARK_HOME} && \
    rm spark-3.5.4-bin-hadoop3.tgz

# Ajusta as variáveis de ambiente no PATH
ENV PATH=${PATH}:${SPARK_HOME}/bin
ENV PYTHONPATH=${SPARK_HOME}/python:${SPARK_HOME}/python/lib/py4j-0.10.9.7-src.zip

# Perfil do usuário que vai executar o jupyter notebook
USER ${NB_UID}

# Instala os pacotes Python
RUN pip install confluent-kafka==2.8.0 protobuf==4.24.3 fastavro==1.10.0 pyspark==3.5.4 psycopg2-binary==2.9.10

# Pasta de trabalho
WORKDIR /notebooks

# Porta do jupyter
EXPOSE 8888

# Start do Jupyter Notebook
CMD ["jupyter", "notebook", "--ip=0.0.0.0", "--port=8888", "--no-browser", "--allow-root"]


