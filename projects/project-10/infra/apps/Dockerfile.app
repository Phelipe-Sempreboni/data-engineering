# Use a imagem oficial do Ubuntu como base
FROM ubuntu:latest

# Mantenedor da imagem (opcional)
LABEL maintainer="Sirius Hub Educação"
LABEL description="Imagem personalizada com Terraform + AWS CLI + Python"

# Atualizar os pacotes do sistema e instalar dependências necessárias
RUN apt-get update && apt-get upgrade -y

# Instalação de utilitários essenciais
RUN apt-get install -y \
    curl \
    wget \
    unzip \
    telnet \
    openssh-client \
    iputils-ping \
    vim \
    gnupg \
    gnupg2 \
    gcc \
    g++ \
    unixodbc \
    unixodbc-dev \
    libgssapi-krb5-2 \
    libpq-dev \
    libsasl2-dev \
    libssl-dev \
    libffi-dev \
    software-properties-common \
    apt-transport-https \
    ca-certificates \
    lsb-release

# Instalação do cliente SQLCMD (Microsoft SQL Server Command Line Tools)
RUN curl https://packages.microsoft.com/keys/microsoft.asc | apt-key add - && \
    curl https://packages.microsoft.com/config/debian/11/prod.list > /etc/apt/sources.list.d/mssql-release.list && \
    apt-get update && \
    ACCEPT_EULA=Y apt-get install -y mssql-tools18 unixodbc-dev && \
    echo 'export PATH="$PATH:/opt/mssql-tools18/bin"' >> ~/.bashrc && \
    ln -sfn /opt/mssql-tools18/bin/sqlcmd /usr/bin/sqlcmd && \
    apt-get clean && rm -rf /var/lib/apt/lists/*

# Instalação do Python 3.11
RUN add-apt-repository ppa:deadsnakes/ppa -y && \
    apt-get update && \
    apt-get install -y python3.11 python3.11-venv python3.11-dev python3-pip

# Criar a pasta Downloads e instalar o AWS CLI (para acessar a AWS)
RUN mkdir Downloads && \
    cd Downloads && \
    curl "https://awscli.amazonaws.com/awscli-exe-linux-x86_64.zip" -o "awscliv2.zip" && \
    unzip awscliv2.zip && \
    ./aws/install

# Definir a versão do Terraform (ajuste conforme necessário)
ENV TERRAFORM_VERSION=1.8.4

# Baixar e instalar Terraform
RUN wget https://releases.hashicorp.com/terraform/${TERRAFORM_VERSION}/terraform_${TERRAFORM_VERSION}_linux_amd64.zip && \
    unzip terraform_${TERRAFORM_VERSION}_linux_amd64.zip && \
    mv terraform /usr/local/bin/ && \
    rm terraform_${TERRAFORM_VERSION}_linux_amd64.zip

# Adiciona o repositório da Microsoft para o driver ODBC
# Sem isso a biblioteca (pyodbc) não irá funcionar, pois não terá um conector para ser reconhecido
RUN curl https://packages.microsoft.com/keys/microsoft.asc | apt-key add - && \
    curl https://packages.microsoft.com/config/ubuntu/20.04/prod.list > /etc/apt/sources.list.d/mssql-release.list && \
    apt-get update && \
    ACCEPT_EULA=Y apt-get install -y msodbcsql17

# Criar a pasta como um ponto de montagem para um volume
#RUN mkdir /projeto-dq
#VOLUME /projeto-dq

# Ponto de entrada padrão
CMD ["tail", "-f", "/dev/null"]