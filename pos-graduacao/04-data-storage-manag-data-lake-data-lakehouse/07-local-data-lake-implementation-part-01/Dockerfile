# Cria Imagem 

# Imagem do SO usada como base
FROM python:3.11-bullseye as spark-base

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

# Variáveis de ambiente
ENV SPARK_HOME=${SPARK_HOME:-"/opt/spark"}
ENV HADOOP_HOME=${HADOOP_HOME:-"/opt/hadoop"}

# Cria as pastas
RUN mkdir -p ${HADOOP_HOME} && mkdir -p ${SPARK_HOME}
WORKDIR ${SPARK_HOME}

# Download do arquivo de binários do Spark
RUN curl https://archive.apache.org/dist/spark/spark-3.5.1/spark-3.5.1-bin-hadoop3.tgz -o spark-3.5.1-bin-hadoop3.tgz \
 && tar xvzf spark-3.5.1-bin-hadoop3.tgz --directory /opt/spark --strip-components 1 \
 && rm -rf spark-3.5.1-bin-hadoop3.tgz

# Download do arquivo de binários do Hadoop
RUN curl https://dlcdn.apache.org/hadoop/common/hadoop-3.4.0/hadoop-3.4.0.tar.gz -o hadoop-3.4.0.tar.gz \
 && tar xfz hadoop-3.4.0.tar.gz --directory /opt/hadoop --strip-components 1 \
 && rm -rf hadoop-3.4.0.tar.gz

# Prepara o ambiente com PySpark
FROM spark-base as pyspark

# Instala as dependências Python
RUN pip3 install --upgrade pip
COPY requirements/requirements.txt .
RUN pip3 install -r requirements.txt

# Variável de ambiente do JAVA_HOME (atenção usuário MacOS)
ENV JAVA_HOME="/usr/lib/jvm/java-11-openjdk-amd64"
#ENV JAVA_HOME="/usr/lib/jvm/java-11-openjdk-arm64"

# Adiciona os binários do Spark, Hadoop e Java no PATH
ENV PATH="$SPARK_HOME/sbin:/opt/spark/bin:${PATH}"
ENV PATH="$HADOOP_HOME/bin:$HADOOP_HOME/sbin:${PATH}"
ENV PATH="${PATH}:${JAVA_HOME}/bin"

# Variáveis de ambiente
ENV SPARK_MASTER="spark://dsamaster:7077"
ENV SPARK_MASTER_HOST dsamaster
ENV SPARK_MASTER_PORT 7077
ENV PYSPARK_PYTHON python3
ENV HADOOP_CONF_DIR="$HADOOP_HOME/etc/hadoop"

# Hadoop native library 
ENV LD_LIBRARY_PATH="$HADOOP_HOME/lib/native:${LD_LIBRARY_PATH}"

# Usuário do HDFS e Yarn
ENV HDFS_NAMENODE_USER="root"
ENV HDFS_DATANODE_USER="root"
ENV HDFS_SECONDARYNAMENODE_USER="root"
ENV YARN_RESOURCEMANAGER_USER="root"
ENV YARN_NODEMANAGER_USER="root"

# Adiciona JAVA_HOME en haddop-env.sh
RUN echo "export JAVA_HOME=${JAVA_HOME}" >> "$HADOOP_HOME/etc/hadoop/hadoop-env.sh"

# Copia os arquivos de configuração
COPY yarn/spark-defaults.conf "$SPARK_HOME/conf/"
COPY yarn/*.xml "$HADOOP_HOME/etc/hadoop/"

# Faz com que os binários sejam executáveis
RUN chmod u+x /opt/spark/sbin/* && \
    chmod u+x /opt/spark/bin/*

# Python PATH
ENV PYTHONPATH=$SPARK_HOME/python/:$PYTHONPATH

# SSH para autenticação sem senha no Hadoop
RUN ssh-keygen -t rsa -P '' -f ~/.ssh/id_rsa && \
  cat ~/.ssh/id_rsa.pub >> ~/.ssh/authorized_keys && \
  chmod 600 ~/.ssh/authorized_keys

# Copia o arquivo de configuração do SSH
COPY ssh/ssh_config ~/.ssh/config

# Entrypoint script
COPY entrypoint.sh .

# Ajusta o privilégio
RUN chmod +x entrypoint.sh

EXPOSE 22

# Executa o script quando inicializar um container
ENTRYPOINT ["./entrypoint.sh"]

