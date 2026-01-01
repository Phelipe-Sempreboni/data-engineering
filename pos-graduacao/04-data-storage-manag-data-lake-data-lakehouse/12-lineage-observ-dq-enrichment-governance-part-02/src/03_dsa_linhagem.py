# Lab 4 - Linhagem, Observabilidade, Qualidade, Enriquecimento e Governança de Dados no Data Lake

# Imports
import json
import boto3
import hashlib
import pandas as pd
from datetime import datetime

# Função para calcular o hash de um arquivo
def dsa_calcula_hash(file_name):

    # Cria um objeto hash SHA-256
    sha256_hash = hashlib.sha256()
    
    # Abre o arquivo no modo de leitura binária
    with open(file_name, "rb") as f:

        # Lê o arquivo em blocos de 4096 bytes e atualiza o hash para cada bloco
        for byte_block in iter(lambda: f.read(4096), b""):
            sha256_hash.update(byte_block)
    
    # Retorna o hash em formato hexadecimal
    return sha256_hash.hexdigest()


# Baixa o arquivo do S3 (Por que precisamos fazer isso?)
s3 = boto3.client('s3')
bucket_name = 'dsa-data-lake-lab4-890582101704'
object_name = 'raw-data/dados_brutos.csv'
s3.download_file(bucket_name, object_name, 'temp/dados_brutos.csv')

# Calcula o hash do arquivo original
hash_original = dsa_calcula_hash('temp/dados_brutos.csv')

# Carrega o dataset
df = pd.read_csv('temp/dados_brutos.csv')

# Registra informações de linhagem
linhagem = {
    'timestamp': datetime.utcnow().isoformat(),
    'arquivo_origem': object_name,
    'hash_origem': hash_original,
    'transformacoes_aplicadas': 'Nenhuma - dados brutos carregados',
    'arquivo_destino': 'processed-data/dados_brutos.csv'
}

# Salva informações de linhagem
with open('temp/linhagem.json', 'w') as f:
    json.dump(linhagem, f, indent=4)

# Enviar informações de linhagem para o S3
s3.upload_file('temp/linhagem.json', bucket_name, 'linhagem/linhagem_inicial.json')

print("\nDSA Log - Arquivo inicial de linhagem dos dados enviado para o Data Lake.\n")


