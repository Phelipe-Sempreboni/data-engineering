# Projeto 4 - Processamento e Análise de Dados em Tempo Real com PySpark Streaming

# Abra o terminal ou prompt de comando e acesse a pasta onde estão os arquivos no seu computador

# Execute o comando abaixo para criar e inicializar o Cluster

docker compose -f docker-compose.yml up -d --scale spark-worker-dsa=2

# Execute este comando no host para treinar e salvar o modelo e o padronizador

docker exec spark-master-dsa spark-submit --deploy-mode client ./jobs/projeto4-modelo.py

NOTA: Depois de treinar o modelo pare o cluster Spark e inicialize novamente para liberar memória para o deploy!!!

# Execute este comando dentro do node master para carregar um shell de dados em tempo real

nc -lk 9999

# Execute este comando no host para capturar dados em tempo real e entregar a previsão

docker exec spark-master-dsa spark-submit --deploy-mode client ./jobs/projeto4-stream.py

# De volta ao container, digite cada uma das linhas abaixo, pressione Enter e observe o modelo fazendo a previsão em tempo real
# As linhas 3, 4 e 6 são anomalias

{"id_sensor": "sensor_1", "timestamp": "2025-04-11T21:00:00Z", "umidade": 21.3, "nivelenxofre": 44.0, "rpm": 1014.0}
{"id_sensor": "sensor_3", "timestamp": "2025-04-11T21:01:00Z", "umidade": 25.0, "nivelenxofre": 46.3, "rpm": 1015.2}
{"id_sensor": "sensor_2", "timestamp": "2025-04-11T21:02:00Z", "umidade": 192.0, "nivelenxofre": 50.0, "rpm": 1012.5}
{"id_sensor": "sensor_3", "timestamp": "2025-04-11T21:03:00Z", "umidade": 26.5, "nivelenxofre": 99.0, "rpm": 1012.2}
{"id_sensor": "sensor_2", "timestamp": "2025-04-11T22:01:00Z", "umidade": 24.1, "nivelenxofre": 52.0, "rpm": 1014.5}
{"id_sensor": "sensor_2", "timestamp": "2025-04-11T22:02:00Z", "umidade": 21.9, "nivelenxofre": 49.2, "rpm": 1.5}

# Copie o banco de dados do container para o host

docker cp spark-master-dsa:/opt/spark/modelos/dbdsap4.db .

# Spark Master
http://localhost:9090

# History Server
http://localhost:18080

# Para desligar o Cluster
docker compose -f docker-compose.yml down