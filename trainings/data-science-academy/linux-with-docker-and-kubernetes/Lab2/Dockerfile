# Lab 2 - Deploy de Aplicação de Machine Learning com Docker e Streamlit

# Imagem base
FROM python:3.12-slim

# Definir o mantenedor da imagem
LABEL maintainer="suporte@datascienceacademy.com.br"

# Pasta de trabalho
WORKDIR /app

# Copiar arquivos da aplicação
COPY . .

# Instalar dependências
RUN pip install --upgrade pip && pip install -r requirements.txt

# Executar treinamento do modelo
RUN python dsa_treina_modelo.py

# Expor porta padrão do Streamlit
EXPOSE 8501

# Comando para executar o Streamlit
CMD ["streamlit", "run", "app.py", "--server.port=8501", "--server.address=0.0.0.0"]
