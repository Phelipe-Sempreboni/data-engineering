# Lab 5 - Analytics Engineering - Python, SQL e LLM Para Extrair Insights em Pipelines de Engenharia de Dados
# Python - Executa o Pipeline

# Imports
import subprocess

# Função para executar outros scripts Python
def dsa_run_pipeline(script_name):
    try:
        result = subprocess.run(['python', script_name], check=True, capture_output=True, text=True)
        print(f"\nScript {script_name} executado com sucesso.")
        print("\nSaída:\n", result.stdout)
    except subprocess.CalledProcessError as e:
        print(f"\nErro ao executar o script {script_name}.")
        print("\nErro:\n", e.stderr)

# Lista de scripts
scripts = [
    'Lab5-02-CriaDB.py',
    'Lab5-03-Carga.py',
    'Lab5-05-ConsultaDB.py',
    'Lab5-06-LLM.py'
]

# Executa os scripts em um loop
for script in scripts:
    dsa_run_pipeline(script)


print(f"\nPipeline executado com sucesso.\n")
