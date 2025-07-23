### Comandos para utilizar durante o módulo

---

1. Comandos manuais para a construção da imagem, ou seja, sem utilizar o docker compose - instalação do python, aws cli e terraform
- Navegue até o diretório criado e que está o arquivo do dockerfile
- Execute o comando abaixo para construção da imagem no Docker
- Mas antes, uma explicação breve sobre o que os comandos querem dizer:
  - ***_docker build_***: Construir a imagem
  - ***_-t apps-image_***: Atribuí um nome (tag) para a imagem
  - ***_Versão_***: v1 - define a versão atual do container e útil para identificar versões específicas
  - ***_-f dockerfile.app_***: Especifica o nome do Dockerfile, onde poderia ser somente Dockerfile, mas usamos nome um customizado com (.app) no final, facilitando a identificação do arquivo
  - ***_. (ponto no final do comando)_***:  Define o contexto de build como o diretório atual, ou seja, onde está o arquivo para construção da imagem no momento da execução do comando

```
docker build -t apps-image:v1 -f dockerfile.app .
```

---

2. Comandos manuais para a construção do container a partir da imagem e com o arquivo do Docker Compose
- Abra o terminal de sua preferência: bash, prompt cmd, via visual studio code
- Navegue até a pasta com onde está o arquivo docker-compose.yml
- Execute o comando abaixo para construir e executar os serviços definidos no arquivo do Docker Compose:

```
docker compose up --build -d
```

- Se quisermos construir os containers com um nome pré-definido, por exemplo: sirius 
- Esse nome (sirius) define o prefixo da stack usada para o nome da rede, volumes e containers.
- Por padrão, se você rodasse docker compose up -p sirius, isso padronizaria os nomes internos como:
  - ***_sirius_sqlserver_***
  - ***_sirius_apps_***
  - ***_sirius_net01_***

```
docker compose up -p sirius
```

---

3. Comandos manuais para a reconstrução do container a partir da imagem e com o arquivo do Docker Compose
- Aguarde cerca de 5 minutos antes de acessar a app pela primeira vez (tempo para baixar o SLM na primeira execução)
- Caso seja necessário reconstruir os containers, execute o comando abaixo, que desliga e reconstrói os serviços

```
docker-compose down && docker compose up --build -d
```

- Se quisermos reconstruir os containers com um nome pré-definido, por exemplo: sirius
```
docker-compose down && docker compose up -p sirius
```

---

4. Validar se os pacotes foram instalados corretamente e quais as suas versões
- Os comandos terão que ser a partir de dentro do container, ou seja, o que foi criado e o serviço iniciado
- Abra o terminal de sua preferência: bash, prompt cmd, via visual studio code
- Execute os comandos abaixo
```
python3 --version
aws --version
terraform --version
```
---

5. Para conseguir visualizar a versão do banco de dados do (SQL Server) via o container do serviço (sqlserver), ou seja, onde está instanciado o banco de dados, é necessário realizar algumas etapas
- Será necessário entrar no banco de dados e executar uma consulta sql
- Os comandos precisam ser executados a partir e de dentro do container
- Caso esse comando falhe, investigue se o caminho que mencionado, principalmente a parte (mssql-tools18) está correto, pois dependendo da versão do banco de dados (SQL Server), essa escrita pode mudar
- Mas antes, uma explicação breve sobre o que os comandos querem dizer:
  - ***_/opt/mssql-tools18/bin/sqlcmd_***: caminho completo para o executável do cliente sqlcmd
  - ***_S localhost_***: define o servidor de destino como localhost (ou seja, o próprio container onde o SQL Server está rodando)
  - ***_U sa_***:	usuário de autenticação (sa = System Administrator padrão do SQL Server)
  - ***_P 'senha'_***: senha correspondente ao usuário sa
  - ***_N_***: usa uma conexão criptografada (SSL)
  - ***_C_***: confirma o certificado do servidor mesmo se não for confiável (usado com -N)
```
/opt/mssql-tools18/bin/sqlcmd -S localhost -U sa -P 'insira sua senha ou o arquivo .env*' -N -C
```
- Realize um teste de uma consulta direto no terminal do container do serviço do banco de dados, que é o (sqlserver)
- Se for utilizado (;) depois do (go), é como se você estivesse informando ao banco de dados (SQL Server) que ainda virá outra consulta, logo, o resultado não irá aparecer
- Por exemplo, se você digitar as duas consultas abaixo, uma abaixo da outra e só utilizar o (go) depois, as duas consultas serão retornadas em conjunto
```
select @@version;
go
```
- Outro de exemplo de consulta para executar no banco de dados
```
select name from sys.databases;
go
```
- Mais um exemplo de consulta para executar no banco de dados
- Este é o caso explicao mais acima, sobre a execução de dois comandos sequenciais e só inserir o (go) após essas duas consultas
```
select @@version;
select name from sys.databases;
go
```
- Para sair do modo interativo do terminal com (sqlcmd), ou seja, sair do terminal do banco de dados do (SQL Server)
```
quit
ou
ctrl+c
```
---
