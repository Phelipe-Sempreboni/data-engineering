#!/bin/bash

SPARK_WORKLOAD=$1

echo "SPARK_WORKLOAD: $SPARK_WORKLOAD"

/etc/init.d/ssh start

if [ "$SPARK_WORKLOAD" == "master" ];
then

  hdfs namenode -format

  # Inicializa os processos no master
  hdfs --daemon start namenode
  hdfs --daemon start secondarynamenode
  yarn --daemon start resourcemanager

  # Cria as pastas necessárias
  while ! hdfs dfs -mkdir -p /spark-logs;
  do
    echo "Falha ao criar a pasta /spark-logs no hdfs"
  done
  
  echo "Criada a pasta /spark-logs no hdfs"
  hdfs dfs -mkdir -p /opt/spark/data
  echo "Criada a pasta /opt/spark/data no hdfs"


  # Copia os dados para o HDFS
  hdfs dfs -copyFromLocal /opt/spark/data/* /opt/spark/data
  hdfs dfs -ls /opt/spark/data

elif [ "$SPARK_WORKLOAD" == "worker" ];
then

  # Inicializa processos no worker
  hdfs --daemon start datanode
  yarn --daemon start nodemanager

elif [ "$SPARK_WORKLOAD" == "history" ];
then

  while ! hdfs dfs -test -d /spark-logs;
  do
    echo "spark-logs não existe ainda...criando"
    sleep 1;
  done
  echo "Exit loop"

  # Inicializa o history server
  start-history-server.sh
fi

tail -f /dev/null
