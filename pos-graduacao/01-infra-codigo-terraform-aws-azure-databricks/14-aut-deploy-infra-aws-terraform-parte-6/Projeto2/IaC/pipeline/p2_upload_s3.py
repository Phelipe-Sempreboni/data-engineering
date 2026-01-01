# Projeto 2 - Deploy do Stack de Treinamento Distribuído de Machine Learning com PySpark no Amazon EMR
# Upload Para o S3

# Imports
import os
import os.path
from p2_log import dsa_grava_log

# Define uma função para carregar um diretório no formato parquet para um bucket S3
def dsa_upload_dados_processados_bucket(df, path, s3_path, bucket, ambiente_execucao_EMR):
	
    # Verifica se a função está sendo executada em um ambiente EMR
    if ambiente_execucao_EMR:
        # Verifica se já existe algum objeto no caminho especificado no S3
        if len(list(bucket.objects.filter(Prefix=(s3_path)).limit(1))) > 0:
            # Se já existir, sobrescreve o arquivo parquet no caminho local
            df.write.mode("Overwrite").partitionBy("label").parquet(path)
        else:
            # Se não existir, escreve o arquivo parquet no caminho local sem sobrescrever
            df.write.partitionBy("label").parquet(path)
    else:
        # Grava no log
        dsa_grava_log("Log DSA - Este Script Executa Somente em Cluster EMR", bucket)

# Define uma função para carregar um modelo de machine learning para um bucket S3
def dsa_upload_modelos_ml_bucket(model, path, s3_path, bucket, ambiente_execucao_EMR):
	
    # Verifica se a função está sendo executada em um ambiente EMR
    if ambiente_execucao_EMR:
        # Verifica se já existe algum objeto no caminho especificado no S3
        if len(list(bucket.objects.filter(Prefix=(s3_path)).limit(1))) > 0:
            # Se já existir, sobrescreve o modelo no caminho especificado
            model.write().overwrite().save(path)
        else:
            # Se não existir, salva o modelo no caminho especificado sem sobrescrever
            model.save(path)
    else:
        # Grava no log
        dsa_grava_log("Log DSA - Este Script Executa Somente em Cluster EMR", bucket)

