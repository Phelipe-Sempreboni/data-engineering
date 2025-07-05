# Lab 1 - Primeiros Passos com Linux e Docker

# Imagem base
FROM ubuntu:latest

# Definir o mantenedor da imagem
LABEL maintainer="suporte@datascienceacademy.com.br"

# Atualizar pacotes e instalar alguns utilitários essenciais
RUN apt-get update && apt-get install -y \
    curl \
    wget \
    vim \
    nano \
    && rm -rf /var/lib/apt/lists/*

# Definir diretório de trabalho
WORKDIR /dsa

# Comando padrão ao iniciar o container
CMD ["bash"]
