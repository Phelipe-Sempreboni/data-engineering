### Comandos para utilizar durante o módulo

---

1. Comandos manuais para a construção da imagem, ou seja, sem utilizar o docker compose - instalação do python, aws cli e terraform
- Abra o terminal de sua preferência: bash, prompt cmd, via visual studio code
- Navegue até o diretório criado e que está o arquivo do Dockerfile
- Execute o comando abaixo para construção da imagem no Docker
- Mas antes, uma explicação breve sobre o que os comandos querem dizer:
  - ***_docker build_***: construir a imagem
  - ***_-t apps-image_***: atribuí um nome (tag) para a imagem
  - ***_Versão_***: v1 - define a versão atual do container e útil para identificar versões específicas
  - ***_-f Dockerfile.app_***: especifica o nome do Dockerfile, onde poderia ser somente Dockerfile, mas usamos nome um customizado com (.app) no final, facilitando a identificação do arquivo
  - ***_. (ponto no final do comando)_***:  Define o contexto de build como o diretório atual, ou seja, onde está o arquivo para construção da imagem no momento da execução do comando
- Vale ressaltar que, se estivessemos utilizando o arquivo com o nome (Dockerfile), ou seja, sem a extensão (.app), não seria necessário utilizar a parte (-f Dockerfile.app), pois seria reconhecido automaticamente
- O uso de extensões em um arquivo (Dockerfile) facilita a diferenciação em projetos, principalmente em casos que você tem múltiplos arquivos (Dockerfile) no mesmo repositório, pois facilitará a visualização e gerenciamento
- O nosso caso já tem a estrutura de diretórios via pastas, mas estamos utilizando a extensão para te mostrar que também é possível seguir dessa maneira

```
docker build -t apps-image:v1 -f Dockerfile.app .
```
- Se o arquivo (Dockerfile) não tivesse extensão
```
docker build -t apps-image:v1 .
```

---

2. Comandos manuais para a construção do container a partir da imagem e com o arquivo do Docker Compose
- Abra o terminal de sua preferência: bash, prompt cmd, via visual studio code
- Navegue até a pasta com onde está o arquivo docker-compose.yml
- Caso o arquivo (docker-compose.yaml) esteja nomeado dessa maneira, então não é necessário apontar o nome, visto que o Docker reconhece o comando automaticamente
- Notar que se o arquivo não estiver nomeado com o padrão (docker-compose), então será necessário executar o comando que aponta para o nome
- Execute o comando abaixo para construir e executar os serviços definidos no arquivo do Docker Compose

```
docker compose up --build -d
docker compose -f <nome-docker-compose> up --build -d
```

- Se quisermos construir os containers com um nome pré-definido, por exemplo: sirius 
- Esse nome (sirius) define o prefixo da stack usada para o nome da rede, volumes e containers
- Por padrão, se você rodasse docker compose up -p sirius, isso padronizaria os nomes internos como:
  - ***_sirius_sqlserver_***
  - ***_sirius_apps_***
  - ***_sirius_net01_***
- No nosso caso já definimos um nome do próprio arquivo do Docker Compose, logo, não iremos utilizar esse tipo de ação nesse projeto
- Se executarmos sem o nome configurado no início e no próprio arquivo do Docker Compose, e também não definirmos no comando, então o nome será baseado no nome do diretório

```
docker compose -p sirius up --build -d
```

- Uma breve explicação sobe os comandos:

| Comando                                  | O que faz                                            |
| ---------------------------------------- | ---------------------------------------------------- |
| `docker compose up -d`                   | Sobe os containers em segundo plano                  |
| `docker compose up --build -d`           | Reconstrói as imagens antes de subir os containers   |
| `docker compose -p sirius up -d`         | Usa o nome de projeto `sirius` (prefixando recursos) |
| `docker compose -p sirius up --build -d` | Reconstrói e sobe, com nome do projeto `sirius`      |

---

3. Comandos manuais para a reconstrução do container a partir da imagem e com o arquivo do Docker Compose
- Aguarde cerca de 5 minutos antes de acessar a app pela primeira vez (tempo para baixar o SLM na primeira execução)
- Caso seja necessário reconstruir os containers, execute o comando abaixo, que desliga e reconstrói os serviços

```
docker-compose down && docker compose up --build -d
```

- Se quisermos reconstruir os containers (Compose Stack) com um nome pré-definido, por exemplo: sirius
- Notar que no arquivo (docker-compose) que estamos utilizando, já temos apontado dentro a variável (name:sirius), para criação do Compose Stack nomeado
```
docker-compose down && docker compose up -p sirius
```

---

4. Validar se os pacotes foram instalados corretamente e quais as suas versões
- Os comandos terão que ser a partir de dentro do container, ou seja, o que foi criado e o serviço iniciado
- Abra o terminal de sua preferência: bash, prompt cmd, via visual studio code
- Execute os comandos abaixo, onde podem ser executados a partir de um prompt local na sua máquina
- Deixaremos aberto um terminal para cada container e usuário conforme os comandos abaixo
- Notar que você pode entrar com o usuário (root), mas o mais correto é ter um usuário nominal ou de serviço com determinadas permissões em vez de utilizar o (root) diretamente
- No nosso cenário, vamos seguir com o usuário (root), e posteriormente criaremos um ou mais usuários de serviço
```
docker exec -u <nome-usuario> -it <nome-container> bash
docker exec -u root -it sqlserver bash
docker exec -u mssql -it sqlserver bash
docker exec -u root -it apps bash
python3 --version
aws --version
terraform --version
```
---

5. Vamos realizar alguns testes de rede nos containers que formam o Compose Stack
- Essas validações são importantes para verificar se os containers realmente estão se comunicando entre si, visto que criamos dentro da mesma rede
- Liste todas as redes existentes no Docker
```
docker network ls
```
---
- Inspecione uma rede específica, no caso a que você está utilizando na comunicação entre os containers
```
docker network inspect sirius_net01
```
---
- Realize um ping no container do serviço (sqlserver) via o container do do serviço (apps)
- Faça via o container do serviço (apps)
```
ping sqlserver
```
---
- Realize um teste na porta do banco de dados (SQL Server), que está no serviço do container do (sqlserver)
- Faça via o container do serviço (apps)
```
telnet sqlserver 1433
```
---

6. Para conseguir visualizar a versão do banco de dados do (SQL Server) via o container do serviço (sqlserver), ou seja, onde está instanciado o banco de dados, é necessário realizar algumas etapas
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
- Não é uma boa prática inserir manualmente a senha diretamente no comando, então veremos maneiras de executar esse comando, mas chamando a senha de diretórios e arquivos
- Vá ao terminal que você executou o Docker Compose, ou seja, por onde construiu os serviços do Docker, que é fora do container do serviço
- Notar que não é necessário estar no diretório que você executou o Docker Compose, foi somente uma referência, pois você pode estar em qualquer local do seu terminal nesse momento
- Notar que no comando, já é apontado o container do serviço, nesse caso o (sqlserver)
- Notar que esse tipo de cenário que iremos executar só funciona em shells interativos (bash, sh). Se o container estiver usando ENTRYPOINT ou CMD, isso não se aplica diretamente a scripts automatizados e não irá funcionar
```
docker exec -u <nome-usuario> -it <nome-container> bash
docker exec -u 0 -it sqlserver bash ou docker exec -u root -it sqlserver bash
```
- Verifique em qual usuário você está logado e utilizando no momento
- Isso é para confirmar que você está no usuário (root)
- Você também um comando para verificar os usuários existentes no container
- Na sequência é um comando para trocar de usuário, nesse exemplo, saindo do (root) e indo para o (mssql) do container (sqlserver)
```
whoami ou id -un
getent passwd
su - mssql
```
- Crie uma pasta chamada (db) ou de sua preferência
- Notar que fizemos esse processo de entrar no usuário (root), pois se você estiver no usuário padrão desse container (sqlserver), ou seja, o usuário (mssql), ele não terá permissão para criação de pastas no sistema operacional
- É uma boa prática ficar utilizando o usuário (root) para executar ações ? Não, é recomendável criarmos e utilizarmos usuários de serviço, mas faremos em outros etapas
- Entre na pasta (db) que foi criada no sistema operacional
```
mkdir db
cd db
```
- Crie um arquivo chamado (.env) dentro dessa pasta que foi criada
- Para isso você terá que antes instalar um pacote chamado (vim), que é um editor de texto chamado (vim)
- Primeiro execute o comando de atualização do sistema operacional, que no caso dessa imagem do (sqlserver), é baseada em (Debian slim), e vem com o (apt) desatualizado e sem repositórios listados
- Na sequência execute o comando de instalação do (vim)
- Ambos comandos já estão na sequência para serem executados
- Na sequência verifique a versão do (vim), validando se foi instalado corretamente
```
apt-get update
apt-get install -y vim
vim --version
```
- Para criar o arquivo, execute o primeiro comando, onde será aberta uma tela, que é o editor do (vim)
- Você irá apertar e garantindo que está dentro do terminal, a letra (i), que irá ativar o modo de insert no editor de texto
- Você irá digitar o nome da variável e a senha, que seguirá o formato (chave-valor), onde deixamos um exemplo de como seria, e garanta que não ficarão espaços no final da senha, o que é comum acontecer
- Na sequência você irá apertar a tecla (esc) do seu teclado
- Na sequência você irá digitar o comando (:w) e aperta (enter), que é para escrever o que você digitou
- Na sequência você irá digitar o comando (:q) e aperta (enter), que é para salvar e sair do arquivo
- Na sequência você irá executar um e visualizar o arquivo que foi criado e seu conteúdo
- Notar que na senha, dependendo dos caracteres especiais que tiverem na senha como (*, !, &, ç) entre outros, pode causar erro na leitura ou até a exposição da senha via o arquivo (.env) no container, então é aconselhável colocar entre aspas
- Pronto, agora temos um arquivo de variável de ambiente criado
- Os comandos estão sequenciais para execução
```
vim .env
i
SA_PASSWORD=<insira sua senha>
SA_PASSWORD=Senh@forte!
SA_PASSWORD="Senh@forte!"
:w
:q
cat .env
```
- Você irá agora mudar para o usuário (mssql), que é o usuário padrão desse container de serviço do banco de dados
- Iremos listar os usuários existentes nesse container
- Iremos verificar se realmente o usuário do (mssql) existe
- Iremos alterar para o usuário (mssql) no container
- Iremos verificar e validar em qual usuário estamos
- Iremos verificar o conteúdo do arquivo (.env) e se realmente a senha foi inserida no arquivo
- Notar que quando temos senhas inseridas em arquivos do tipo (.env), temos que ter uma ótima gestão de acessos do arquivo (.env) e container e que seja extremamente controlada e restrita
- Por exemplo, esse arquivo (.env) só deveria ser acessado pelo usuário (root) e/ou por um usuário de serviço, onde a senha desse usuário de serviço estaria em algum cofre seguro
- Uma boa prática é utilizar cofres de provedoras de Cloud, como da AWS (AWS Secrets Manager) e Azure (Key Vault), onde você pode guardar as senhas e chamar via APIs ou de outras formas
- Você também pode utilizar cofres ou locais seguro de sua escolha, desde que a gestão de acesso senha bem controlada e gerida
```
getent passwd
su - mssql
whoami ou id -un
ls -la
cd db
ls -la
cat .env
cd ..
```
- Agora iremos entrar no banco de dados via um comando
- Notar que a partir de agora não vamos precisar colocar a senha diretamente na linha de comando, mas sim via uma variável de ambiente, que é a mesma do arquivo (.env)
- Primeiro indicamos o local que está o arquivo (.env)
- Na sequência executamos o comando que agora possuí a variável (SA_PASSWORD), e não digiando diretamente a senha
- O símbolo $ no final indica que você está como usuário não privilegiado, no caso, o mssql e não o usuário (root)
- E nesse caso está sendo utilizado para para referenciar o valor de uma variável
- Aqui já temos a conexão com o banco de dados (SQL Server) e é possível realizar consultas
- Utilize as consultas sql abaixo e as orientações para realizar os tests de conexão e versão
```
source /db/.env
/opt/mssql-tools18/bin/sqlcmd -S localhost -U sa -P "$SA_PASSWORD" -N -C
```
- Vamos ver outra forma de entrar no banco de dados, mas agora com mais automação no processo
- Iremos criar um script bash dentro do container, onde iremos encapsular esses comandos
- Mas antes, uma explicação breve sobre o que os comandos querem dizer:
  - ***_#!/bin/bash_***: diz ao sistema para executar o script usando o Bash Shell
  - Isso é essencial para que comandos como source e variáveis funcionem corretamente
  - Sem o shebang, o sistema pode tentar usar o shell padrão (sh), que não suporta todos os recursos do bash
- Entre no diretório onde está o arquivo (.env)
- Para criar o arquivo, execute o primeiro comando, onde será aberta uma tela, que é o editor do (vim)
- Você irá apertar e garantindo que está dentro do terminal, a letra (i), que irá ativar o modo de insert no editor de texto
- Você irá digitar o texto com os comandos para o script bash, onde deixamos o texto junto dos comandos
- Na sequência você irá apertar a tecla (esc) do seu teclado
- Na sequência você irá digitar o comando (:w) e aperta (enter), que é para escrever o que você digitou
- Na sequência você irá digitar o comando (:q) e aperta (enter), que é para salvar e sair do arquivo
- Na sequência você irá executar um e visualizar o arquivo que foi criado e seu conteúdo
- Pronto, agora temos um script bash criado
- Os comandos estão sequenciais para execução
```
cd db
vim con_sql.sh
i
#!/bin/bash
source /db/.env
/opt/mssql-tools18/bin/sqlcmd -S localhost -U sa -P "$SA_PASSWORD" -N -C
:w
:q
cat con_sql.sh
```
- Precisaremos alterar a permissão do arquivo, para que o usuário consiga executar, caso contrário teremos as permissões negadas
- Antes execute um comando para lista os arquivos do diretório, e acompanhe como os acessos e permissões serão alterados para permitir a execução
- Realize a alteração de permissão do arquivo para permitir a execução
- Execute novamente um comando para lista os arquivos do diretório, e acompanhe como os acessos e permissões serão alterados para permitir a execução
```
ls -la
chmod +x con_sql.sh
ls -la
```
- Execute o comando abaixo para que seja possível executar o script, onde os comandos foram encapsulados
- Nesse caso o arquivo está no mesmo diretório que o arquivo (.env), mas se não estivesse, você teria que navegar até o diretório e executar
```
./con_sql.sh
```
- Realize um teste e tente executar das duas formas, onde uma você já executou, que é o arquivo no mesmo diretório, mas agora iremos copiar o arquivo para outro diretório e tentar executar
- Primeiro vá ou permaneça no diretório onde o script bash que criamos já existe, onde você deve listar o que temos no diretório e confirmar
- Agora volte ao diretório raíz e crie os diretórios (pastas) em (/app/automacao), onde você deve garantir que os diretórios foram criados
- Agora entre no diretório onde existe o script bash, garantindo sempre que o arquivo está no diretório
- Agora copie o script bash para o diretório que foi criado anteriormente (/app/automacao)
- Vá até o diretório (/app/automacao) e garanta que o arquivo foi criado no diretório
- Agora execute o script bash e valide que conseguiu entrar no banco de dados do (SQL Server)
- Siga para os testes das consultas
- 
```
ls -la
mkdir app
cd app
mkdir automacao
cd automacao
cd db
ls -la
cp con_sql.sh /app/automacao
cd /app/automacao
ls -la
/app/automacao/con_sql.sh
```
---
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
exit
ou
quit
ou
ctrl+c
```
---
7. Para conseguir visualizar a versão do banco de dados do (SQL Server) via o container do serviço (apps), ou seja, lendo o container do serviço (sqlserver), é necessário realizar algumas etapas
- Notar que a partir de agora, estaremos dentro do container (apps) e não no container do serviço (sqlserver), onde o banco de dados (SQL Server) está instanciado
- Será necessário entrar no banco de dados e executar uma consulta sql
- Os comandos precisam ser executados a partir e de dentro do container
- Caso esse comando falhe, investigue se o client (o mesmo do dockerfile.app) executou corretamente e conseguiu criar o client no container
- Mas antes, uma explicação breve sobre o que os comandos querem dizer:
  - ***sqlcmd_***: executável do cliente sqlcmd
  - ***_S nome-do-container-serviço_***: define o servidor de destino com o nome do container onde o banco de dados está instanciado (ou seja, no container onde o SQL Server está rodando)
  - ***_U sa_***:	usuário de autenticação (sa = System Administrator padrão do SQL Server)
  - ***_P 'senha'_***: senha correspondente ao usuário sa
  - ***_N_***: usa uma conexão criptografada (SSL)
  - ***_C_***: confirma o certificado do servidor mesmo se não for confiável (usado com -N)
```
sqlcmd -S sqlserver -U sa -P 'insira sua senha ou o arquivo .env*' -N -C
```
- Não é uma boa prática inserir manualmente a senha diretamente no comando, então veremos maneiras de executar esse comando, mas chamando a senha de diretórios e arquivos
- Vá ao terminal que você executou o Docker Compose, ou seja, por onde construiu os serviços do Docker, que é fora do container do serviço
- Notar que não é necessário estar no diretório que você executou o Docker Compose, foi somente uma referência, pois você pode estar em qualquer local do seu terminal nesse momento
- Notar que no comando, já é apontado o container do serviço, nesse caso o (sqlserver)
- Notar que esse tipo de cenário que iremos executar só funciona em shells interativos (bash, sh). Se o container estiver usando ENTRYPOINT ou CMD, isso não se aplica diretamente a scripts automatizados e não irá funcionar
```
docker exec -u <nome-usuario> -it <nome-container> bash
docker exec -u 0 -it apps bash ou docker exec -u root -it apps bash
```
- Verifique em qual usuário você está logado e utilizando no momento
- Isso é para confirmar que você está no usuário (root)
- Você também um comando para verificar os usuários existentes no container
- Na sequência é um comando para trocar de usuário, nesse exemplo, saindo do (root) e indo para o (mssql) do container (sqlserver)
```
whoami ou id -un
getent passwd
su - mssql
```
- Crie uma pasta chamada (db) ou de sua preferência
- Notar que fizemos esse processo de entrar no usuário (root), pois se você estiver com outro usuário e que não tiver as permissões necessárias, ele não terá permissão para criação de pastas no sistema operacional
- É uma boa prática ficar utilizando o usuário (root) para executar ações ? Não, é recomendável criarmos e utilizarmos usuários de serviço, mas faremos em outros etapas
- Entre na pasta (db) que foi criada no sistema operacional
```
mkdir db
cd db
```
- Crie um arquivo chamado (.env) dentro dessa pasta que foi criada
- Para isso você terá que antes instalar um pacote chamado (vim), que é um editor de texto chamado (vim)
- Primeiro execute o comando de atualização do sistema operacional, que no caso dessa imagem do (sqlserver), é baseada em (Debian slim), e vem com o (apt) desatualizado e sem repositórios listados
- Na sequência execute o comando de instalação do (vim)
- Ambos comandos já estão na sequência para serem executados
- Na sequência verifique a versão do (vim), validando se foi instalado corretamente
```
apt-get update
apt-get install -y vim
vim --version
```
- Para criar o arquivo, execute o primeiro comando, onde será aberta uma tela, que é o editor do (vim)
- Você irá apertar e garantindo que está dentro do terminal, a letra (i), que irá ativar o modo de insert no editor de texto
- Você irá digitar o nome da variável e a senha, que seguirá o formato (chave-valor), onde deixamos um exemplo de como seria, e garanta que não ficarão espaços no final da senha, o que é comum acontecer
- Na sequência você irá apertar a tecla (esc) do seu teclado
- Na sequência você irá digitar o comando (:w) e aperta (enter), que é para escrever o que você digitou
- Na sequência você irá digitar o comando (:q) e aperta (enter), que é para salvar e sair do arquivo
- Na sequência você irá executar um e visualizar o arquivo que foi criado e seu conteúdo
- Notar que na senha, dependendo dos caracteres especiais que tiverem na senha como (*, !, &, ç) entre outros, pode causar erro na leitura ou até a exposição da senha via o arquivo (.env) no container, então é aconselhável colocar entre aspas
- Pronto, agora temos um arquivo de variável de ambiente criado
- Os comandos estão sequenciais para execução
```
vim .env
i
SA_PASSWORD=<insira sua senha>
SA_PASSWORD=Senh@forte!
SA_PASSWORD="Senh@forte!"
:w
:q
cat .env
```
- Nesse momento, iremos continuar no usuário (root), pois como falamos anteriormente, em outras etapas faremos a criação de um usuário, e você poderá testar essas etapas com o usuário criado e as permissões concedidas
- Iremos listar os usuários existentes nesse container
- Iremos verificar o conteúdo do arquivo (.env) e se realmente a senha foi inserida no arquivo
- Notar que quando temos senhas inseridas em arquivos do tipo (.env), temos que ter uma ótima gestão de acessos do arquivo (.env) e container e que seja extremamente controlada e restrita
- Por exemplo, esse arquivo (.env) só deveria ser acessado pelo usuário (root) e/ou por um usuário de serviço, onde a senha desse usuário de serviço estaria em algum cofre seguro
- Uma boa prática é utilizar cofres de provedoras de Cloud, como da AWS (AWS Secrets Manager) e Azure (Key Vault), onde você pode guardar as senhas e chamar via APIs ou de outras formas
- Você também pode utilizar cofres ou locais seguro de sua escolha, desde que a gestão de acesso senha bem controlada e gerida
```
getent passwd
whoami ou id -un
ls -la
cd db
ls -la
cat .env
cd ..
```
- Agora iremos entrar no banco de dados via um comando
- Notar que a partir de agora não vamos precisar colocar a senha diretamente na linha de comando, mas sim via uma variável de ambiente, que é a mesma do arquivo (.env)
- Primeiro indicamos o local que está o arquivo (.env)
- Na sequência executamos o comando que agora possuí a variável (SA_PASSWORD), e não digiando diretamente a senha
- O símbolo $ no final indica que você está como usuário não privilegiado, no caso, o mssql e não o usuário (root)
- E nesse caso está sendo utilizado para para referenciar o valor de uma variável
- Aqui já temos a conexão com o banco de dados (SQL Server) e é possível realizar consultas
- Utilize as consultas sql abaixo e as orientações para realizar os tests de conexão e versão
```
source /db/.env
sqlcmd -S sqlserver -U sa -P "$SA_PASSWORD" -N -C
```
- Vamos ver outra forma de entrar no banco de dados, mas agora com mais automação no processo
- Iremos criar um script bash dentro do container, onde iremos encapsular esses comandos
- Mas antes, uma explicação breve sobre o que os comandos querem dizer:
  - ***_#!/bin/bash_***: diz ao sistema para executar o script usando o Bash Shell
  - Isso é essencial para que comandos como source e variáveis funcionem corretamente
  - Sem o shebang, o sistema pode tentar usar o shell padrão (sh), que não suporta todos os recursos do bash
- Entre no diretório onde está o arquivo (.env)
- Para criar o arquivo, execute o primeiro comando, onde será aberta uma tela, que é o editor do (vim)
- Você irá apertar e garantindo que está dentro do terminal, a letra (i), que irá ativar o modo de insert no editor de texto
- Você irá digitar o texto com os comandos para o script bash, onde deixamos o texto junto dos comandos
- Na sequência você irá apertar a tecla (esc) do seu teclado
- Na sequência você irá digitar o comando (:w) e aperta (enter), que é para escrever o que você digitou
- Na sequência você irá digitar o comando (:q) e aperta (enter), que é para salvar e sair do arquivo
- Na sequência você irá executar um e visualizar o arquivo que foi criado e seu conteúdo
- Pronto, agora temos um script bash criado
- Os comandos estão sequenciais para execução
```
cd db
vim con_sql.sh
i
#!/bin/bash
source /db/.env
sqlcmd -S sqlserver -U sa -P "$SA_PASSWORD" -N -C
:w
:q
cat con_sql.sh
```
- Precisaremos alterar a permissão do arquivo, para que o usuário consiga executar, caso contrário teremos as permissões negadas
- Antes execute um comando para lista os arquivos do diretório, e acompanhe como os acessos e permissões serão alterados para permitir a execução
- Realize a alteração de permissão do arquivo para permitir a execução
- Execute novamente um comando para lista os arquivos do diretório, e acompanhe como os acessos e permissões serão alterados para permitir a execução
```
ls -la
chmod +x con_sql.sh
ls -la
```
- Execute o comando abaixo para que seja possível executar o script, onde os comandos foram encapsulados
- Nesse caso o arquivo está no mesmo diretório que o arquivo (.env), mas se não estivesse, você teria que navegar até o diretório e executar
```
./con_sql.sh
```
- Realize um teste e tente executar das duas formas, onde uma você já executou, que é o arquivo no mesmo diretório, mas agora iremos copiar o arquivo para outro diretório e tentar executar
- Primeiro vá ou permaneça no diretório onde o script bash que criamos já existe, onde você deve listar o que temos no diretório e confirmar
- Agora volte ao diretório raíz e crie os diretórios (pastas) em (/app/automacao), onde você deve garantir que os diretórios foram criados
- Agora entre no diretório onde existe o script bash, garantindo sempre que o arquivo está no diretório
- Agora copie o script bash para o diretório que foi criado anteriormente (/app/automacao)
- Vá até o diretório (/app/automacao) e garanta que o arquivo foi criado no diretório
- Agora execute o script bash e valide que conseguiu entrar no banco de dados do (SQL Server)
- Siga para os testes das consultas
```
ls -la
mkdir app
cd app
mkdir automacao
cd automacao
cd db
ls -la
cp con_sql.sh /app/automacao
cd /app/automacao
ls -la
/app/automacao/con_sql.sh
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
exit ou quit ou ctrl+c
```
---
8. Criar um script Python para testar a leitura de dados via o container do serviço (apps), lendo diretamente o banco de dados do (SQL Server) do container do serviço (sqlserver)
- Iremos aproveitar e ensinar alguns outros comandos para auxiliar nessa validação
- Também iremos aprender como criar um script do Python dentro do container do serviço (apps), onde esse script irá realizar a leitura de dados do (SQL Server) que está no container do serviço (sqlserver)
- Vamos verificar o pacote (pyodbc) já existe instalado com o Python
- Execute o comando abaixo, onde se o pacote estiver instalado, o comando retornará a versão do pyodbc.
- Se o pacote não estiver instalado, retornará um erro como: **_ModuleNotFoundError: No module named 'pyodbc'_**
```
python3 -c "import pyodbc; print(pyodbc.version)"
```
---
- Liste os pacotes do Python que estão instalados no container do serviço (apps)
- Depois tente listar se o pacote do (pyodbc) está instalado
- Se aparecer algo como (pyodbc 4.0.34), então está instalado
- Se nada for exibido, então o pacote não está instalado
```
pip3 list
pip3 list | grep pyodbc
```
---
- Adicionalmente vamos avaliar se temos drivers ODBCs instalados no serviço do container (apps)
- Se quiser saber se o driver ODBC do sistema (como unixODBC) está instalado, que é um (requisito do pyodbc), execute um dos comandos abaixo
```
dpkg -l | grep odbc
odbcinst -j
```
- Agora iremos realizar a instalação do pacote do (pyodbc) com a execução do comando abaixo
- Realize a instalação da biblioteca do (pyodbc) do Python no serviço do container (apps)
```
python3 -m pip install pyodbc
```
- Valide se o conector ODBC chamado (ODBC Driver 17 for SQL Server) está instalado no container do serviço (apps)
- Caso o ODBC não esteja instalado, irá retornar uma mensagem de não encontrado, logo, se a instalação falha, possivelmente retornará um texto de erro ou comando não existente
- O comando abaixo lista todos os drivers ODBC disponíveis configurados no sistema
- Sobre os comandos:
  - odbcinst: é o utilitário de linha de comando para gerenciar drivers e fontes de dados ODBC no Linux
  - q: query (consulta) – pede ao utilitário para listar algo
  - d: drivers – especifica que queremos consultar os drivers ODBC instalados no sistema
```
odbcinst -q -d
```
- Execute o script de teste para ler dados do container (sqlserver) pelo container (apps)
- Iremos aprender a criar um arquivo no container e executar esse script, para que seja possível ler os dados do (SQL Server) via o container (apps)
- Essa é uma das maneiras também de testar se as portas, rede e comunicação estão funcionando entre os containers
```
python3 teste.py
```
---
