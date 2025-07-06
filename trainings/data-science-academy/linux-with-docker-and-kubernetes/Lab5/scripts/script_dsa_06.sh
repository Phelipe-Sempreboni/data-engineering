#!/bin/bash
# ==============================
# Data Science Academy
# Script: script6.sh
# ==============================

# Case
clear
echo "MENU"
echo "========="
echo "1 FCD"
echo "2 FADA"
echo "3 FED"
echo "4 FAD"
echo "5 FEM"
echo "6 FEI"
echo "7 FAAIE"
echo "8 FARPA"
echo "9 FAE"
echo "10 FSPARK"
echo "11 FDOPS"
echo "12 FIAMED"
echo "13 FIAD"
echo "14 FAIN"
echo "15 FML"
echo "16 FLP"
echo "17 FPLN"
echo "18 FVC"
echo "S Sair"
echo "Digite o número da Formação que você está fazendo na DSA (ou S para sair e encerrar o script): "
read MENUCHOICE
case $MENUCHOICE in
 1)
  echo "Você escolheu a Formação Cientista de Dados. Parabéns!";;
 2)
  echo "Você escolheu a Formação Analista de Dados. Parabéns!";;
 3)
  echo "Você escolheu a Formação Engenheiro de Dados. Parabéns!";;
 4)
  echo "Você escolheu a Formação Arquiteto de Dados. Parabéns!";;
 5)
  echo "Você escolheu a Formação Engenheiro de Machine Learning. Parabéns!";;
 6)
  echo "Você escolheu a Formação Engenheiro de IA. Parabéns!";;
 7)
  echo "Você escolheu a Formação Agentic AI Engineer. Parabéns!";;
 8)
  echo "Você escolheu a Formação Arquiteto RPA. Parabéns!";;
 9)
  echo "Você escolheu a Formação Analytics Engineer. Parabéns!";;
 10)
  echo "Você escolheu a Formação Spark e Databbricks. Parabéns!";;
 11)
  echo "Você escolheu a Formação Engenheiro DataOps. Parabéns!";;
 12)
  echo "Você escolheu a Formação Inteligência Artificial Para Medicina. Parabéns!";;
 13)
  echo "Você escolheu a Formação Inteligência Artificial Para o Direito. Parabéns!";;
 14)
  echo "Você escolheu a Formação Analista de Inteligência de Negócios. Parabéns!";;
 15)
  echo "Você escolheu a Formação Machine Learning. Parabéns!";;
 16)
  echo "Você escolheu a Formação Linguagem Python Para Data Science. Parabéns!";;
 17)
  echo "Você escolheu a Formação Processamento de Linguagem Natural. Parabéns!";;
 18)
  echo "Você escolheu a Formação Visão Computacional. Parabéns!";;
 S)
  echo "Você pediu para encerrar o script!";;
esac
