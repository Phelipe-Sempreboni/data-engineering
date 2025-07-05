#!/bin/bash
# ==============================
# Data Science Academy
# Script: script4.sh
# ==============================

# Input do Usuário
echo "Digite seu primeiro nome: "
read FIRSTNAME
echo "Digite seu sobrenome: "
read LASTNAME
echo ""
echo "Seu nome completo: $FIRSTNAME $LASTNAME"
echo ""
echo "Digite agora sua idade: "
read USERAGE
echo "Em 10 anos você estará com `expr $USERAGE + 10` anos."