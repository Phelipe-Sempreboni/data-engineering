#!/bin/bash
# ==============================
# Data Science Academy
# Script: script5.sh
# ==============================

# Array 
SERVERLIST=("servidor01" "servidor02" "servidor03" "servidor04")
COUNT=0

# Loop
for INDEX in ${SERVERLIST[@]}; do
 echo "Servidor: ${SERVERLIST[COUNT]}"
 COUNT="`expr $COUNT + 1`"
done
