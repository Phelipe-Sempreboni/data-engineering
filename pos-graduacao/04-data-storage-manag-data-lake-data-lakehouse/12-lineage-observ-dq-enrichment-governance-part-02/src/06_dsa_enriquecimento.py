# Lab 4 - Linhagem, Observabilidade, Qualidade, Enriquecimento e Governança de Dados no Data Lake

# Imports
import pandas as pd
import boto3

# Ler o dataset limpo
df = pd.read_csv('temp/dados_limpos.csv')

# Exemplo de enriquecimento: Calcular a faixa salarial
def faixa_salarial(salario):
    if pd.isnull(salario) or salario < 0:
        return 'Desconhecido'
    elif salario < 70000:
        return 'Baixa'
    elif 70000 <= salario < 80000: 
        return 'Média'
    else:
        return 'Alta'

# Aplica a função
df['faixa_salarial'] = df['salario'].apply(faixa_salarial)

# Salvar dataset enriquecido
df.to_csv('temp/dados_enriquecidos.csv', index=False)

# Enviar para o S3
s3 = boto3.client('s3')
bucket_name = 'dsa-data-lake-lab4-890582101704'
s3.upload_file('temp/dados_enriquecidos.csv', bucket_name, 'enriched-data/dados_enriquecidos.csv')

print("\nDSA Log - Enriquecimento concluído e dados enriquecidos enviados para o Data Lake.\n")