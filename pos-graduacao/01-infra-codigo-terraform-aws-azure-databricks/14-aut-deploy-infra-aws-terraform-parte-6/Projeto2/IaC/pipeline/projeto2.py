# Projeto 2 - Deploy do Stack de Treinamento Distribuído de Machine Learning com PySpark no Amazon EMR
# Script Principal

# Instala pacote Python dentro de código Python
import subprocess
comando = "pip install boto3"
subprocess.run(comando.split())

# Imports
import os
import boto3
import traceback
import pyspark 
from pyspark.sql import SparkSession
from p2_log import dsa_grava_log
from p2_processamento import dsa_limpa_transforma_dados
from p2_ml import dsa_cria_modelos_ml

# Nome do Bucket
NOME_BUCKET = "dsa-p2-<id-aws>"

# Chaves de acesso à AWS
AWSACCESSKEYID = "coloque-aqui-sua-chave-aws"
AWSSECRETKEY = "coloque-aqui-sua-chave-aws"

print("\nLog DSA - Inicializando o Processamento.")

# Cria um recurso de acesso ao S3 via código Python
s3_resource = boto3.resource('s3', aws_access_key_id = AWSACCESSKEYID, aws_secret_access_key = AWSSECRETKEY)

# Define o objeto de acesso ao bucket via Python
bucket = s3_resource.Bucket(NOME_BUCKET)

# Grava o log
dsa_grava_log("Log DSA - Bucket Encontrado.", bucket)

# Grava o log
dsa_grava_log("Log DSA - Inicializando o Apache Spark.", bucket)

# Cria a Spark Session e grava o log no caso de erro
try:
	spark = SparkSession.builder.appName("DSAProjeto2").getOrCreate()
	spark.sparkContext.setLogLevel("ERROR")
except:
	dsa_grava_log("Log DSA - Ocorreu uma falha na Inicialização do Spark", bucket)
	dsa_grava_log(traceback.format_exc(), bucket)
	raise Exception(traceback.format_exc())

# Grava o log
dsa_grava_log("Log DSA - Spark Inicializado.", bucket)

# Define o ambiente de execução do Amazon EMR
ambiente_execucao_EMR = False if os.path.isdir('dados/') else True

# Bloco de limpeza e transformação
try:
	DadosHTFfeaturized, DadosTFIDFfeaturized, DadosW2Vfeaturized = dsa_limpa_transforma_dados(spark, 
																							  bucket, 
																							  NOME_BUCKET, 
																							  ambiente_execucao_EMR)
except:
	dsa_grava_log("Log DSA - Ocorreu uma falha na limpeza e transformação dos dados", bucket)
	dsa_grava_log(traceback.format_exc(), bucket)
	spark.stop()
	raise Exception(traceback.format_exc())

# Bloco de criação dos modelos de Machine Learning
try:
	dsa_cria_modelos_ml (spark, 
					     DadosHTFfeaturized, 
					     DadosTFIDFfeaturized, 
					     DadosW2Vfeaturized, 
					     bucket, 
					     NOME_BUCKET, 
					     ambiente_execucao_EMR)
except:
	dsa_grava_log("Log DSA - Ocorreu Alguma Falha ao Criar os Modelos de Machine Learning", bucket)
	dsa_grava_log(traceback.format_exc(), bucket)
	spark.stop()
	raise Exception(traceback.format_exc())

# Grava o log
dsa_grava_log("Log DSA - Modelos Criados e Salvos no S3.", bucket)

# Grava o log
dsa_grava_log("Log DSA - Processamento Finalizado com Sucesso.", bucket)

# Finaliza o Spark (encerra o cluster EMR)
spark.stop()



