#!/bin/bash
# ==============================
# Data Science Academy
# Script: script10.sh
# ==============================

# Auditoria de Segurança

# Nome do arquivo de saída
OUTPUT="relatorio_auditoria_$(date +%Y-%m-%d_%H-%M-%S).txt"

clear
{
echo "###############################################"
echo "###############################################"
echo "Relatório de Auditoria de Segurança no Linux."
echo "###############################################"
echo "###############################################"
echo "Vamos começar a auditoria em 3 segundos..."
sleep 3
echo
echo "Este é o nome da máquina: $HOSTNAME"
echo
echo "Começando a auditoria..."
START=$(date +%s)
echo
echo "1. Detalhes do Kernel Linux"
uname -a
echo
echo "2. Versão desta Distribuição Linux"
cat /etc/os-release | grep -e VERSION=
echo
echo "3. Buscando arquivos com permissão 777"
find / -type f -perm 0777
echo
echo "4. Conexões Ativas e Portas Abertas"
netstat -natp
echo
echo "5. Histórico de Comandos Executados"
history
echo
echo "6. Interfaces de Rede"
ifconfig -a
echo
echo "7. Lista de todos os pacotes instalados"
apt-cache pkgnames
echo
echo "8. Parâmetros de Rede"
cat /etc/sysctl.conf
echo
echo "9. Políticas de Senha"
cat /etc/pam.d/common-password
echo
echo "10. Source List"
cat /etc/apt/sources.list
echo
echo "11. Checando Dependências Quebradas"
apt-get check
echo
echo "12. Listando pacotes que podem ser atualizados"
apt list --upgradeable
echo
echo "13. Usuários com acesso ao SO"
cut -d: -f1 /etc/passwd
echo
echo "14. Checando Null Passwords"
users="$(cut -d: -f 1 /etc/passwd)"
for x in $users
do
  passwd -S $x | grep "NP"
done
echo
echo "15. Informações da CPU e do Sistema"
cat /proc/cpuinfo
echo
END=$(date +%s)
DIFF=$(( $END - $START ))
echo Auditoria concluída em $DIFF segundos!
echo
echo Data de geração do relatório:
date
echo
echo "Parabéns por estar aprendendo Linux aqui na Data Science Academy!"
} | tee "$OUTPUT"
