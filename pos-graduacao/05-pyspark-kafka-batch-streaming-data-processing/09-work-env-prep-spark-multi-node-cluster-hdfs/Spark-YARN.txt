

# Execução de Job com Gerenciamento de Cluster do Spark:

docker exec dsa-pyspark-master spark-submit --deploy-mode client ./apps/projeto1.py


# Execução de Job com Gerenciamento de Cluster via YARN:

docker exec dsa-spark-master-yarn spark-submit --master yarn --deploy-mode cluster ./examples/src/main/python/pi.py