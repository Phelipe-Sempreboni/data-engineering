# Lab 8 - Deploy e Orquestração de Aplicação de IA com Docker e Kubernetes

# Imagem base
FROM python:3.12-slim

# Pasta de trabalho
WORKDIR /app

# Copia o arquivo para a imagem
COPY requirements.txt .

# Executa a instalação das dependências
RUN pip install --upgrade pip && pip install -r requirements.txt

# Copia os demais arquivos
COPY . .

# Porta usada pelo Streamlit
EXPOSE 8501

# Executa a app
CMD ["streamlit", "run", "app.py", "--server.port=8501", "--server.address=0.0.0.0"]
