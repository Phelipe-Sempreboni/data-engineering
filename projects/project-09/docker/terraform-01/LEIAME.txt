# Instruções do Lab 1


# Abra o terminal ou prompt de comando e navegue até a pasta onde você colocou os arquivos do Lab1 (não use espaço ou acento em nome de pasta)


# Execute o comando abaixo para criar a imagem Docker

docker build -t dsa-terraform-image:lab1 .


# Execute o comando abaixo para criar o container Docker

docker run -dit --name dsa-lab1 dsa-terraform-image:lab1 /bin/bash


# Verifique as versões do Terraform e do AWS CLI com os comandos abaixo

terraform version
aws --version
