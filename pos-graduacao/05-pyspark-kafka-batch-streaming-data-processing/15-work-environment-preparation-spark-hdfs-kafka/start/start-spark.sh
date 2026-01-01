#!/bin/bash

# Start Spark Master ou Worker 
if [[ "$HOSTNAME" == "spark-master" ]]; then
    echo "Inicializando o Spark Master..."
    $SPARK_HOME/sbin/start-master.sh
    echo "Spark Master Inicializado no Cluster DSA."
elif [[ "$HOSTNAME" == *"spark-worker"* ]]; then
    cho "Inicializando o Spark Worker..."
    $SPARK_HOME/sbin/start-slave.sh $SPARK_MASTER
    echo "Spark Worker Inicializado no Cluster DSA."
fi

# Mantém o container em execução
tail -f /dev/null
