# Lab 4 - Linhagem, Observabilidade, Qualidade, Enriquecimento e Governança de Dados no Data Lake

# Use uma imagem base com Python
FROM python:3.11-slim

# Atualizar e instalar dependências do sistema
RUN apt-get update && \
    apt-get install -y --no-install-recommends \
    curl \
    unzip \
    less \
    groff \
    && rm -rf /var/lib/apt/lists/*

# Instalar o AWS CLI v2
RUN curl "https://awscli.amazonaws.com/awscli-exe-linux-aarch64.zip" -o "awscliv2.zip" && \
    unzip awscliv2.zip && \
    ./aws/install && \
    rm -rf awscliv2.zip aws

# Definir o diretório de trabalho dentro do container
WORKDIR /dsalab4

# Copiar o arquivo requirements.txt
COPY requirements.txt .

# Instalar as dependências Python
RUN pip install --no-cache-dir -r requirements.txt

# Copiar todos os scripts para o diretório de trabalho
COPY . .

# Comando padrão ao iniciar o container
CMD ["/bin/bash"]


