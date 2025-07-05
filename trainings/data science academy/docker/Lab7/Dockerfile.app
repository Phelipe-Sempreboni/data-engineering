# Lab 7 - Orquestração de Containers Docker Para Escalabilidade de Web App e Banco de Dados

# Imagem base
FROM python:3.12-alpine

# Pasta de trabalho
WORKDIR /code

# Variável de ambiente com o arquivo da app
ENV FLASK_APP=app.py

# Variável de ambiente com o ip para a app
ENV FLASK_RUN_HOST=0.0.0.0

# Instala pacotes adicionais no SO
RUN apk add --no-cache gcc musl-dev linux-headers

# Copia o arquivo de requierements da máquina host para o container
COPY requirements.txt requirements.txt

# Instala as dependências
RUN pip install -r requirements.txt

# Expose da posta 5000
EXPOSE 5000

# Copia os arquivos do host para o container
COPY . .

# Executa a app com Flask
CMD ["flask", "run"]

