# Lab 4 - Linhagem, Observabilidade, Qualidade, Enriquecimento e Governança de Dados no Data Lake

# Imports
import pandas as pd
import numpy as np

# Criar um dicionário provocando problemas comuns nos dados
data = {
    'id': [1, 2, 3, 4, 5, 'seis', 7],
    'nome': ['Alice', 'Bob', 'Charlie', None, 'Eve', 'Frank', 'Grace'],
    'idade': [25, None, 37, 29, -5, 42, 'unknown'],
    'salario': [50000, 60000, None, 70000, 80000, 90000, 100000]
}

# Converte o dicionário em dataframe
df_dsa = pd.DataFrame(data)

# Salvar o DataFrame como CSV
df_dsa.to_csv('temp/dados_brutos.csv', index=False)

print("\nDSA Log - Dados brutos gerados e salvos com sucesso.\n")
