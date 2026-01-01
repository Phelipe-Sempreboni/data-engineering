# PySpark e Apache Kafka Para Processamento de Dados em Batch e Streaming
# Preparação do Ambiente de Trabalho - Multi-Node Cluster Spark e HDFS

# Inicializar o cluster
docker compose -f docker-compose.yml up -d --scale spark-worker-yarn=3

# Visualizar os logs
docker compose logs

# Testar o cluster
docker exec dsa-spark-master-yarn spark-submit --master yarn --deploy-mode cluster ./examples/src/main/python/pi.py

# Derrubar o cluster
docker compose down --volumes --remove-orphans

# Spark Master
http://localhost:9091

# History Server
http://localhost:18081