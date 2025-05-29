# Lab 6 - Deploy de API Para Aplicação de IA com Ollama, Streamlit e Docker Compose

# Usa imagem base Python 3.12 slim
FROM python:3.12-slim

# Define o diretório de trabalho da aplicação
WORKDIR /app

# Copia as dependências para o container
COPY requirements.txt .

# Instala as dependências listadas em requirements.txt
RUN pip install --no-cache-dir -r requirements.txt

# Copia todos os arquivos da aplicação para o container
COPY . .

# Expõe a porta padrão usada pelo Streamlit
EXPOSE 8501

# Inicia a aplicação Streamlit 
CMD ["streamlit", "run", "app.py", "--server.port", "8501", "--server.address", "0.0.0.0"]
