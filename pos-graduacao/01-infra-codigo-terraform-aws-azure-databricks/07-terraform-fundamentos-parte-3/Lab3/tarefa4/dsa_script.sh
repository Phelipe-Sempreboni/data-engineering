#!/bin/bash
sudo yum update -y
sudo yum install httpd -y
sudo systemctl start httpd
sudo bash -c 'echo Criando o Terceiro Web Server com Terraform na DSA > /var/www/html/index.html'