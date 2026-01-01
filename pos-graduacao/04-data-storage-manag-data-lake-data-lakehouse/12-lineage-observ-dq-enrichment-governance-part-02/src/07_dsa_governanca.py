# Lab 4 - Linhagem, Observabilidade, Qualidade, Enriquecimento e Governança de Dados no Data Lake

# Imports
import pandas as pd
import boto3

# Ler o dataset enriquecido
df = pd.read_csv('temp/dados_enriquecidos.csv')

# Mascarar dados sensíveis (por exemplo, nome)
df['nome_mascarado'] = df['nome'].apply(lambda x: x[0] + '*' * (len(x) - 1) if isinstance(x, str) else '')

# Remover a coluna original
df = df.drop('nome', axis=1)

# Salvar dataset governado
df.to_csv('temp/dados_governados.csv', index=False)

# Enviar para o S3
s3 = boto3.client('s3')
bucket_name = 'dsa-data-lake-lab4-890582101704'
s3.upload_file('temp/dados_governados.csv', bucket_name, 'governed-data/dados_governados.csv')

print("\nDSA Log - Mascaramento de dados concluído e arquivo enviado para o Data Lake.\n")
