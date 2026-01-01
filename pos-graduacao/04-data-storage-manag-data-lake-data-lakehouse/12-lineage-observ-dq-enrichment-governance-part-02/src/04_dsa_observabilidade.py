# Lab 4 - Linhagem, Observabilidade, Qualidade, Enriquecimento e Governança de Dados no Data Lake

# Imports
import pandas as pd
import boto3
import json

# Carrega o dataset
df = pd.read_csv('temp/dados_brutos.csv')

# Conversões para corrigir valores inválidos antes da análise
df['id'] = pd.to_numeric(df['id'], errors='coerce')
df['idade'] = pd.to_numeric(df['idade'], errors='coerce')
df['salario'] = pd.to_numeric(df['salario'], errors='coerce')

# Separar variáveis categóricas e quantitativas
variaveis_categoricas = df.select_dtypes(include=['object']).columns
variaveis_quantitativas = df.select_dtypes(include=['number']).columns

# Estatísticas para variáveis quantitativas
estatisticas_quantitativas = df[variaveis_quantitativas].describe().map(lambda x: float(x) if pd.notnull(x) else None).to_dict()

# Estatísticas para variáveis categóricas
estatisticas_categoricas = {
    coluna: {
        'total': int(df[coluna].count()),
        'valores_unicos': int(df[coluna].nunique()),
        'valor_mais_frequente': df[coluna].mode()[0] if not df[coluna].mode().empty else None,
        'frequencia_do_valor_mais_frequente': int(df[coluna].value_counts().iloc[0]) if not df[coluna].value_counts().empty else None
    }
    for coluna in variaveis_categoricas
}

# Calcula métricas de observabilidade, garantindo tipos compatíveis com JSON
observabilidade = {
    'total_linhas': int(len(df)),
    'colunas': df.columns.tolist(),
    'colunas_nulas': df.isnull().sum().astype(int).to_dict(),
    'tipos_dados': df.dtypes.astype(str).to_dict(),
    'estatisticas_quantitativas': estatisticas_quantitativas,
    'estatisticas_categoricas': estatisticas_categoricas
}

# Salva métricas de observabilidade
with open('temp/observabilidade.json', 'w') as f:
    json.dump(observabilidade, f, indent=4)

# Envia para o S3
s3 = boto3.client('s3')
bucket_name = 'dsa-data-lake-lab4-890582101704'
s3.upload_file('temp/observabilidade.json', bucket_name, 'observabilidade/observabilidade_inicial.json')

print("\nDSA Log - Arquivo de observabilidade dos dados enviado para o Data Lake.\n")
