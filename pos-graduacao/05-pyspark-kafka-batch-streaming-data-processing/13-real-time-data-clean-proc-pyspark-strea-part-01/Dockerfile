# Cria Imagem Spark

# Imagem do SO usada como base
FROM python:3.11-bullseye 

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
      netcat \
      software-properties-common \
      ssh && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/*

# Variáveis de ambiente
ENV SPARK_HOME=${SPARK_HOME:-"/opt/spark"}
ENV HADOOP_HOME=${HADOOP_HOME:-"/opt/hadoop"}

# Cria as pastas
RUN mkdir -p ${HADOOP_HOME} && mkdir -p ${SPARK_HOME}
WORKDIR ${SPARK_HOME}
RUN mkdir modelos

# Download do arquivo de binários do Spark
RUN curl https://archive.apache.org/dist/spark/spark-3.5.2/spark-3.5.2-bin-hadoop3.tgz -o spark-3.5.2-bin-hadoop3.tgz \
 && tar xvzf spark-3.5.2-bin-hadoop3.tgz --directory /opt/spark --strip-components 1 \
 && rm -rf spark-3.5.2-bin-hadoop3.tgz

# Prepara o ambiente com PySpark

# Instala as dependências Python
COPY requirements/requirements.txt .
RUN pip3 install -r requirements.txt

# Mais variáveis de ambiente
ENV PATH="/opt/spark/sbin:/opt/spark/bin:${PATH}"
ENV SPARK_HOME="/opt/spark"
ENV SPARK_MASTER="spark://spark-master-dsa:7077"
ENV SPARK_MASTER_HOST spark-master-dsa
ENV SPARK_MASTER_PORT 7077
ENV PYSPARK_PYTHON python3

# Copia o arquivo de configuração do Spark para a imagem
COPY config/spark-defaults.conf "$SPARK_HOME/conf"
COPY config/log4j2.properties "$SPARK_HOME/conf"

# Permissões
RUN chmod u+x /opt/spark/sbin/* && \
    chmod u+x /opt/spark/bin/*

# Variável PYTHONPATH
ENV PYTHONPATH=$SPARK_HOME/python/:$PYTHONPATH

# Copia o script de inicialização dos serviços para a imagem
COPY entrypoint.sh .

# Ajusta o privilégio
RUN chmod +x entrypoint.sh

EXPOSE 22 9999

# Executa o script quando inicializar um container
ENTRYPOINT ["./entrypoint.sh"]

