# Lab 6 - Deploy de API Para Aplicação de IA com Ollama, Streamlit e Docker Compose

# Imagem base com Python 3.12 slim
FROM python:3.12-slim

# Definir o mantenedor da imagem
LABEL maintainer="suporte@datascienceacademy.com.br"

# Define o diretório de trabalho da aplicação
WORKDIR /app

# Copia o arquivo requirements.txt para o diretório atual
COPY requirements.txt .

# Instala as dependências listadas no arquivo requirements.txt
RUN pip install --no-cache-dir -r requirements.txt

# Copia todos os arquivos da aplicação para o diretório atual
COPY . .

# Expõe a porta 8000 para acesso externo
EXPOSE 8000

# Executa o servidor uvicorn na porta 8000
CMD ["uvicorn", "app:app", "--host", "0.0.0.0", "--port", "8000"]
