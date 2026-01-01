#!/bin/bash

# Start SSH service
service ssh start

# Configura log4j do Hadoop
LOG4J_PROPERTIES="$HADOOP_HOME/etc/hadoop/log4j.properties"
if [ ! -f "$LOG4J_PROPERTIES" ]; then
    echo "Criando arquivo log4j.properties para configurar os logs..."
    cat <<EOF > "$LOG4J_PROPERTIES"
log4j.rootCategory=WARN, console
log4j.appender.console=org.apache.log4j.ConsoleAppender
log4j.appender.console.target=System.err
log4j.appender.console.layout=org.apache.log4j.PatternLayout
log4j.appender.console.layout.ConversionPattern=%d{yy/MM/dd HH:mm:ss} %p %c{1}: %m%n
log4j.logger.org.apache.hadoop.util.NativeCodeLoader=ERROR
EOF
    echo "Arquivo log4j.properties criado."
fi

# Formata o HDFS 
if [ ! -d "/hdfs/namenode/current" ]; then
    echo "Formatando o Namenode..."
    $HADOOP_HOME/bin/hdfs namenode -format
fi

# Start Namenode ou Datanode 
if [[ "$HOSTNAME" == "namenode" ]]; then
    echo "Inicializando Namenode e Secondary Namenode..."
    hdfs --daemon start namenode
    hdfs --daemon start secondarynamenode
    echo "Namenode e Secondary Namenode Inicializados no Cluster DSA."

    # Criar o diretório /spark-logs no HDFS
    echo "Criando o diretório /spark-logs no HDFS..."
    hdfs dfs -mkdir -p /spark-logs
    hdfs dfs -chmod 1777 /spark-logs
    hdfs dfs -ls /
    echo "Diretório /spark-logs configurado com sucesso."

elif [[ "$HOSTNAME" == "datanode" ]]; then
    echo "Inicializando o Datanode..."
    hdfs --daemon start datanode
    echo "Datanode Inicializado no Cluster DSA."
fi

# Mantém o container em execução
tail -f /dev/null
