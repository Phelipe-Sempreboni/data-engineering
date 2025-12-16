# Projeto 2 - Deploy do Stack de Treinamento Distribuído de Machine Learning com PySpark no Amazon EMR
# Geração de Log

# Instala pacote Python dentro de código Python
import subprocess
comando = "pip install pendulum"
subprocess.run(comando.split())

# Importa o módulo os para interagir com o sistema operacional
import os

# Importa o módulo os.path para manipulação de caminhos de arquivo
import os.path

# Importa o módulo pendulum para trabalhar com datas e horas (para nome dos arquivos de log)
import pendulum

# Importa o módulo traceback para rastrear exceções
import traceback

# Define a função dsa_grava_log que recebe um texto e um objeto bucket como parâmetros
def dsa_grava_log(texto, bucket):
    
    # Define o caminho para armazenar os logs como o diretório atual se "logs" for um diretório; caso contrário, usa "/home/hadoop"
    path = "." if (os.path.isdir("logs")) else "/home/hadoop"
    
    # Obtém o momento atual usando pendulum
    agora = pendulum.now()
    
    # Formata a data atual para o nome do arquivo de log
    data_arquivo = agora.format('YYYYMMDD')
    
    # Formata a data e hora atuais para registrar no log
    data_hora_log = agora.format('YYYY-MM-DD HH:mm:ss')
    
    # Monta o nome do arquivo de log com o caminho, a data e o prefixo -log_spark.txt
    nome_arquivo = path + "/logs/" + data_arquivo + "-log_spark.txt"
    
    # Inicializa a variável texto_log como uma string vazia
    texto_log = ''
    
    # Tenta abrir o arquivo de log para escrita, em modo append se o arquivo já existir, ou cria um novo arquivo
    try:

        # Verifica se o arquivo já existe
        if os.path.isfile(nome_arquivo):  

            # Abre o arquivo em modo de adição
            arquivo = open(nome_arquivo, "a")

            # Adiciona uma nova linha se o arquivo já existir  
            texto_log = texto_log + '\n'  

        else:

            # Cria um novo arquivo se ele não existir
            arquivo = open(nome_arquivo, "w")  
    
    # Captura qualquer exceção durante a tentativa de abrir o arquivo
    except:
        print("Erro na tentativa de acessar o arquivo para criar os logs")

        # Relança a exceção com o traceback para diagnóstico
        raise Exception(traceback.format_exc())  
    
    # Adiciona a data, hora e o texto do log à variável texto_log
    texto_log = texto_log + "[" + data_hora_log + "] - " + texto

    # Escreve o log no arquivo
    arquivo.write(texto_log)  

    # Imprime o texto do log
    print(texto)  

    # Fecha o arquivo após a escrita
    arquivo.close()  
    
    # Carrega o arquivo de log para o bucket especificado com um nome de arquivo que inclui a data
    bucket.upload_file(nome_arquivo, 'logs/' + data_arquivo + "-log_spark.txt")
