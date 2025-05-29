#!/bin/bash
# ==============================
# Data Science Academy
# Script: script2.sh
# ==============================

echo "Atualizando repositórios..."
sudo apt update

echo "Instalando o Python e ferramentas relacionadas..."
sudo apt install -y python3 python3-pip python3-venv

echo
echo "Verificando a instalação do Python..."
python3 --version

echo
echo "Instalação concluída!"
