# Data Science Academy
# Preparação do Ambiente de Trabalho - Multi-Node Cluster Spark, HDFS e Kafka

# Abra o terminal ou prompt de comando, acesse a pasta com os arquivos e execute:

docker-compose up --build -d

# No mesmo terminal veja se os containers foram criados e inicializados com o comando abaixo:

docker-compose ps

# Acesse também pelo Docker Desktop.

# (Opcional) O comando abaixo pode ser usado para especificar o número de workers do Spark:

docker-compose up -d --scale spark-worker=4

# Use o comando abaixo para desligar o cluster:

docker-compose down -v

# Testando o Cluster

# No navegador, acesse http://localhost:50070 para verificar o status do HDFS.

# Use os comandos abaixo para testar o HDFS:

docker exec -it namenode bash
hdfs dfs -mkdir /dsateste
echo "Hello HDFS!" > /tmp/testfile
hdfs dfs -put /tmp/testfile /dsateste/
hdfs dfs -ls /dsateste
hdfs dfs -cat /dsateste/testfile

# No navegador, acesse http://localhost:8080 para verificar se os Spark Workers estão conectados ao Master.

# Use os comandos abaixo para testar o Spark com Linguagem Python:

docker exec -it spark-master bash

$SPARK_HOME/bin/pyspark

dados = sc.parallelize(range(1, 1001))
total = dados.reduce(lambda x, y: x + y)
print(f"Soma dos itens de 1 a 1000: {total}")

# Use os comandos abaixo para testar o Kafka (use dois terminais):

# Terminal 1:

docker exec -it kafka bash

$KAFKA_HOME/bin/kafka-topics.sh --create --topic test-topic --bootstrap-server kafka:9092 --partitions 1 --replication-factor 1

$KAFKA_HOME/bin/kafka-topics.sh --list --bootstrap-server kafka:9092

$KAFKA_HOME/bin/kafka-console-producer.sh --topic test-topic --bootstrap-server kafka:9092

# Terminal 2:

docker exec -it kafka bash

$KAFKA_HOME/bin/kafka-topics.sh --list --bootstrap-server kafka:9092

$KAFKA_HOME/bin/kafka-console-consumer.sh --topic test-topic --bootstrap-server kafka:9092 --from-beginning

# Cluster configurado com sucesso!



