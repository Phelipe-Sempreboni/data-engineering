# Lab 4 - Automação de Tarefas no Linux com Shell Script

# Imagem base
FROM ubuntu:latest

# Definir o mantenedor da imagem
LABEL maintainer="suporte@datascienceacademy.com.br"

# Atualizar o SO e instalar dependências
RUN apt update && apt install -y \
    vim \
    nano \
    cron \
    bash \
    tree \
    sudo \
    net-tools

# Cria o diretório scripts para ser usado como volume
RUN mkdir -p /scripts

# Define o diretório scripts como um volume
VOLUME ["/scripts"]

# Definir diretório de trabalho
WORKDIR /scripts

# Entrar com Bash por padrão
CMD ["/bin/bash"]
