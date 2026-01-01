#!/bin/bash

# Verifica se o diretório de logs do KRaft já foi formatado
LOG_DIR="/tmp/kraft-combined-logs"
if [ ! -d "$LOG_DIR" ] || [ -z "$(ls -A $LOG_DIR)" ]; then
    echo "Formatando os metadados do cluster KRaft..."
    CLUSTER_ID=$($KAFKA_HOME/bin/kafka-storage.sh random-uuid)
    $KAFKA_HOME/bin/kafka-storage.sh format -t $CLUSTER_ID -c $KAFKA_HOME/config/server.properties
    echo "Metadados do cluster KRaft formatados com ID: $CLUSTER_ID."
else
    echo "Metadados do cluster KRaft já formatados."
fi

# Inicia o servidor Kafka
echo "Inicializando o Kafka no modo KRaft..."
$KAFKA_HOME/bin/kafka-server-start.sh $KAFKA_HOME/config/server.properties
echo "Kafka Inicializado no Cluster DSA."
