# Lab 4 - Linhagem, Observabilidade, Qualidade, Enriquecimento e Governança de Dados no Data Lake

# Imports
import pandas as pd
import boto3

# Ler o dataset
df = pd.read_csv('temp/dados_brutos.csv')

# Limpeza e validação de dados

# 1. Tratar 'id': converter para numérico e remover entradas inválidas
df['id'] = pd.to_numeric(df['id'], errors='coerce')

# Remover registros com ID nulo
df = df[df['id'].notna()]

# 2. Tratar 'idade': converter para numérico, substituir valores fora do intervalo por NaN
df['idade'] = pd.to_numeric(df['idade'], errors='coerce')
df['idade'] = df['idade'].apply(lambda x: x if 0 <= x <= 120 else None)

# Preencher valores ausentes de 'idade' com a média (interpolação)
df['idade'] = df['idade'].fillna(df['idade'].mean()).round(1)

# 3. Tratar 'salario': converter para numérico e substituir NaN ou negativos por um valor padrão (por exemplo, média)
df['salario'] = pd.to_numeric(df['salario'], errors='coerce')
df['salario'] = df['salario'].apply(lambda x: x if x is None or x >= 0 else None)

# Preencher valores ausentes de 'salario' com a média
df['salario'] = df['salario'].fillna(df['salario'].mean())

# 4. Tratar 'nome': preencher valores ausentes com uma string padrão
df['nome'] = df['nome'].fillna('Desconhecido')

# Salvar dataset limpo
df.to_csv('temp/dados_limpos.csv', index=False)

# Enviar para o S3
s3 = boto3.client('s3')
bucket_name = 'dsa-data-lake-lab4-890582101704'
s3.upload_file('temp/dados_limpos.csv', bucket_name, 'processed-data/dados_limpos.csv')

print("\nDSA Log - Validação de qualidade concluída e dados limpos enviados para o Data Lake.\n")
