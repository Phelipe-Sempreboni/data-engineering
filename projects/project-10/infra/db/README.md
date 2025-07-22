### Trilha de aprendizado do módulo: 2. Construção do ambiente local com Docker

1. Criação do dockerfile.app com:
   - SQL Server local
   - Terraform
   - AWS CLI
   - Python
   - Ferramentas Linux essenciais: wget, unzip, openssh, iputils-ping, vim
   - Boa prática: imagem leve, performática e com ponto de entrada via /bin/bash
   - Mapeamento de volumes locais

2. Criação do dockerfile.flow com:
   - Apache Airflow
   - Mesmo stack de ferramentas do dockerfile.app + Apache Airflow

3. docker-compose.yml para orquestração:
   - Container 1: SQL Server
   - Container 2: Apache Airflow
   - Container 3: Python, AWS CLI e Terraform
   - Comunicação entre os três via rede interna no Docker
   - Mapeamento de volumes locais

4. Versionamento de código com GitHub e CI/CD com GitHub Actions:
   - Build automático das imagens
   - Execução de testes unitários
   - Deploy e recriação dos containers

5. Criação de ETL em Python para:
   - Ingestão de dados abertos do Gov.br para o SQL Server
   - Validação de schema/tabelas (testes unitários)
   - Organização modular seguindo boas práticas de Clean Code e SOLID

6. Integração com Apache Airflow:
   - Orquestração do pipeline de ingestão e testes
   - Job DAGs organizados e legíveis (SoC e modularidade)

7. Aplicação de framework de Qualidade de Dados:
   - DQX e Great Expectations para comparação
   - Escolha do mais completo com base nos critérios técnicos
   - Scripts e validações reais

8. docker-compose final:
   - Orquestração dos três ambientes
   - Infraestrutura como código (IaC)

9. Desenho da arquitetura geral do projeto

10. Estrutura de diretórios e repositórios (com boas práticas)

11. Avaliação crítica do projeto (notas, sugestões e recomendações)

---

#### Como seguiremos nessa parte da trilha ?

- Iremos construir parte por parte, ou seja, em vez de entregar os containers e ambiente totalmente prontos, iremos entender passo a passo, construindo item por item

- Iremos construir primeiro o docker com Python, depois com AWS CLI, depois com Terraform e assim por diante

- Iremos unificar essas instalações e aprender como automatizar toda esse ambiente local com sua infraestrutura

---

Este projeto será executado de duas maneiras diferentes na parte de construção dos containers, até servindo de exemplo para você aprender um pouco mais, que será:

1º - Exemplo de como seria a construção como microserviços, onde o SQL Server e Apache Airflow ficariam em containers separados do Python, AWS CLI e Terraform

2º - Exemplo de como seria a construção unificada, onde o SQL Server e Apache Airflow ficariam no mesmo container do Python, AWS CLI e Terraform

---

#### Mapeamento e descrição da estrutura desse diretório e o que fazem:

Diretório: infra/db

.env -> para armazenar as variáveis mais sensíveis como chaves, segredos, senhas, entre outros
    - este arquivo precisa sempre estar dentro do (.gitignore), pois como é um arquivo que normalmente contém senhas, chaves, secrets, usuários e outras informações sensíveis, não deve ser comitado para o Github
    - sempre tome cuidado ao comitar seus arquivos, e valide que nenhum contenha informações sensíveis que possam prejudicar seus projetos

comandos.txt -> possuí os comandos que serão utilizados para manipular o docker, imagens, arquivos
    - este arquivo terá comandos que vão apoiar ao decorrer do aprendizado nesse diretório e ao decorrer da trilha

docker-compose.yml -> para definir, configurar e executar múltiplos containers Docker como um único serviço
    - instalação do banco de dados do sql server
    - instalação dos componentes necessários (sistema operacional, python, aws cli, terraform) a partir do dockerfile.app

dockerfile.app -> contém as configurações para: 
    - atualização dos pacotes do sistema
    - instalação de dependências necessárias
    - instalação de utilitários essenciais
    - instalação do python
    - instalação do aws cli
    - instalação do terraform
    - criação de diretório e mapeamento de volume
    - iniciar o sistema com o prompt de bash

Não é uma boa prática inserir senhas diretamente no arquivo (Dockerfile)
    - mesmo que seja utilizado os comandos de (arg ou env) no arquivo, as senhas ficarão expostas nas layers (docker history) do docker
    - a melhor maneira é utilizar um arquivo (docker compose) nesses casos, jutamente de um arquivo (.env), onde esse terá a variável e senha, e poderá ser inserido no arquivo (.gitignore)

---
