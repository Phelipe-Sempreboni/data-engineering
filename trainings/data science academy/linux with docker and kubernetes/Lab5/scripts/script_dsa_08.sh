#!/bin/bash
# ==============================
# Data Science Academy
# Script: script8.sh
# ==============================

clear
echo "Relatório de Uso de Espaço em Disco na máquina: $HOSTNAME"
echo ""
echo "Todos os pontos de montagem:"
echo ""
df -TH 
echo ""
echo "Verificando estes pontos de montagem:"
echo ""
df -H | grep -vE '^Filesystem|tmpfs|cdrom' 
echo ""
echo "Simplificando os dados:"
echo ""
df -H | grep -vE '^Filesystem|tmpfs|cdrom' | awk '{ print $5 " " $1 }'
echo ""
echo "Loop pelos itens encontrados para checar o espaço disponível:"
echo ""

# Loop
df -H | grep -vE '^Filesystem|tmpfs|cdrom' | awk '{ print $5 " " $1 }' | while read output;
do
  echo $output
  espaco_usado=$(echo $output | awk '{ print $1}' | cut -d'%' -f1  )
  partition=$(echo $output | awk '{ print $2 }' )
  if [ $espaco_usado -ge 80 ]; then
    echo "Ficando sem espaço no disco \"$partition ($espaco_usado%)\" on $(hostname) as on $(date)" 
  fi
done

