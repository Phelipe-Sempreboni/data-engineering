#!/bin/bash
# ==============================
# Data Science Academy
# Script: script7.sh
# ==============================

# Pasta atual (corrente) contendo scripts
SCRIPT_DIR="."

# Diretório de backup (diretório corrente/backup)
BACKUP_DIR="./backup"

# Nome do backup com data atual
BACKUP_NAME="scripts_backup_$(date +%Y-%m-%d_%H-%M-%S).tar.gz"

# Cria diretório de backup no diretório corrente caso não exista
[ ! -d "$BACKUP_DIR" ] && mkdir "$BACKUP_DIR"

# Compacta arquivos .sh em um tar.gz dentro da pasta backup
tar -czvf "$BACKUP_DIR/$BACKUP_NAME" "$SCRIPT_DIR"/*.sh

# Exibe mensagem de sucesso
echo "Backup realizado com sucesso em: $BACKUP_DIR/$BACKUP_NAME"
