## Módulo de construção da infraestrutura local com Docker

#### Construção de containers com os serviços:
  - Python
  - AWS CLI
  - Terraform
  - SQL Server
  - Apache Airflow
---

### 📦 1. Construção Manual da Imagem Docker (sem Docker Compose)

> [!NOTE]
> Comandos para criar a imagem Docker a partir de um Dockerfile customizado (`Dockerfile.app`)  
> Inclui explicações sobre os parâmetros do comando `docker build`

- Abra o terminal de sua preferência: bash, prompt cmd ou via Visual Studio Code
- Navegue até o diretório onde está o arquivo do `Dockerfile`
- Execute o comando abaixo para construir a imagem no Docker

Observações:

- O uso de extensões como `.app` em `Dockerfile.app` facilita a organização em projetos com múltiplos Dockerfiles
- No nosso caso, mesmo com a estrutura de diretórios organizada, optamos por usar a extensão para fins didáticos

```bash
docker build -t apps-image:v1 -f Dockerfile.app .
```
- Se o arquivo se chamasse apenas Dockerfile (sem extensão), o comando seria simplificado:
```bash
docker build -t apps-image:v1 .
```
#
📘 Explicação dos comandos e parâmetros
| Comando                                  | Ação executada                                                                                                                 |
| ---------------------------------------- | ------------------------------------------------------------------------------------------------------------------------------ |
| `docker build`                           | inicia o processo de construção da imagem                                                                                      |
| `-t apps-image:v1`                       | define o nome e a tag da imagem, onde "apps-image" é o nome e "v1" representa a versão                                         |
| `-f Dockerfile.app`                      | especifica o arquivo Dockerfile com nome customizado. Se o nome fosse apenas `Dockerfile`, este parâmetro não seria necessário |
| `. (ponto)`                              | define o contexto de build como o diretório atual, onde está o Dockerfile                                                      |

---

### 🐳 2. Construção de Containers com Docker Compose (modo automatizado)

> [!NOTE]
> Explica como executar containers com `docker compose up`, com ou sem nome customizado para o projeto  
> Inclui tabela comparativa com variações de comando e seus significados

- Abra o terminal de sua preferência: bash, prompt cmd ou Visual Studio Code
- Navegue até a pasta onde está localizado o arquivo `docker-compose.yml`
- Caso o arquivo esteja nomeado como `docker-compose.yaml` ou `docker-compose.yml`, **não é necessário utilizar a flag `-f`**
- Caso esteja com outro nome (ex: `compose.dev.yaml`), será necessário informar o nome do arquivo explicitamente usando `-f`

Execute um dos comandos abaixo, conforme o caso:

```bash
docker compose up --build -d
docker compose -f <nome-docker-compose> up --build -d
```
#

### 🔧 Utilizando nome customizado para o projeto (ex: sirius)

O parâmetro `-p` define o nome da stack usada como prefixo dos recursos criados (rede, volumes, containers)

- Exemplo: `docker compose -p sirius up --build -d` resultará em nomes como:
  - `sirius_sqlserver`
  - `sirius_apps`
  - `sirius_net01`

- No nosso projeto, o nome da stack já está configurado dentro do arquivo docker-compose, por isso esse parâmetro é opcional neste caso
- Se nenhum nome for definido, o nome da stack será baseado no nome do diretório onde o comando for executado
```bash
docker compose -p sirius up --build -d
```
#
📘 Variações de comando
| Comando                                  | Ação executada                                        |
| ---------------------------------------- | ----------------------------------------------------- |
| `docker compose up -d`                   | Executa os containers em background (modo detached)   |
| `docker compose up --build -d`           | Reconstrói as imagens antes de iniciar os containers  |
| `docker compose -p sirius up -d`         | Usa o nome de projeto `sirius` (prefixo nos recursos) |
| `docker compose -p sirius up --build -d` | Reconstrói e executa com nome de projeto `sirius`     |


#

Glossário de parâmetros principais:
- `--build`: força rebuild das imagens antes da execução
- `-d`: executa em modo detached (segundo plano)
- `-p`: define nome da stack (prefixo do projeto)
- `-f`: permite especificar um arquivo docker-compose diferente do padrão

---

### 🔄 3. Reconstrução e Reinicialização de Containers com Docker Compose

> [!NOTE]
> Instruções para desligar, reconstruir ou reiniciar containers e imagens, com explicações sobre `--build`, `--no-deps`, `-d`, entre outros parâmetros

#

#### 🕒 Tempo de inicialização
Aguarde cerca de **5 minutos** antes de acessar a aplicação pela primeira vez, para garantir que todos os serviços dentro do container sejam inicializados corretamente.

#

#### 🔁 Reconstrução completa dos containers

O comando abaixo **remove todos os containers existentes** e os **recria a partir da imagem atual**:

```bash
docker-compose down && docker compose up --build -d
```
#

🧱 Reconstrução com stack nomeada (ex: sirius)
- Se você estiver usando um nome de projeto definido no próprio arquivo `docker-compose.yml`, como:
- Então não é necessário nomear a stack com esse nome, visto que será capturado do arquivo
```yaml
name: sirius
```
- Se não estiver usando um nome de projeto definido no próprio arquivo `docker-compose.yml`
- Então você pode usar o comando abaixo para manter o mesmo nome em toda a stack (containers, rede, volumes):
```bash
docker-compose down && docker compose -p sirius up --build -d
```
#

🔨 Reconstruir a imagem de um único serviço
- Se quiser recompilar apenas a imagem de um serviço específico (sem afetar os demais), use:
```bash
docker compose build <nome-do-serviço>
```
- Exemplos:
```bash
docker compose build app
docker compose build sqlserver
```
#

🔄 Reiniciar somente um serviço específico
- Se quiser reiniciar apenas o container de um serviço, sem afetar os serviços dependentes:
```bash
docker compose up -d --no-deps <nome-do-serviço>
```
#

- Para forçar o rebuild da imagem antes de reiniciar:
```bash
docker compose up -d --no-deps --build <nome-do-serviço>
```
Exemplos:
```bash
docker compose up -d --no-deps app
docker compose up -d --no-deps --build app
docker compose up -d --no-deps sqlserver
docker compose up -d --no-deps --build sqlserver
```
#
📘 Explicação dos parâmetros
| Parâmetro   | Função                                                                 |
| ----------- | ---------------------------------------------------------------------- |
| `-d`        | Executa os containers em segundo plano (modo "detached")               |
| `--no-deps` | Evita reiniciar containers dependentes (como `sqlserver`)              |
| `--build`   | Garante que a imagem do serviço será reconstruída antes de subir       |
| `-p <nome>` | Define um nome para o projeto (prefixo em redes, volumes e containers) |

---

### 🛑 4. Paralisação e exclusão de container via linha de comando

> [!NOTE]
> Notar que é possível realizar essas ações diretamente no Docker ou via extensões do Visual Studio Code

Pare o container (se estiver em execução):
```bash
docker stop <ID_ou_Nome_do_Container>
```

Remova o container:
```bash
docker rm <ID_ou_Nome_do_Container>
```

Para remover um container em execução sem parar primeiro, use a opção `-f` (force):
```bash
docker rm -f <ID_ou_Nome_do_Container>
```

Excluir múltiplos containers  
- Remover todos os containers parados – use o comando prune para limpar todos os containers que não estão sendo usados:
```bash
docker container prune
```

Remover todos os containers (parados e em execução):  
- Primeiro, pare todos os containers em execução:
```bash
docker stop $(docker ps -q)
```

Em seguida, remova todos os containers:
```bash
docker rm $(docker ps -a -q)
```

---

### 👥 5. Usuários e Grupos de Acesso (Containers Isolados)

> [!NOTE]
> **Objetivo:** explicar como funcionam **UID/GID**, como **ver usuários e grupos** dentro de cada container e como **acessar** ou **elevar** permissões quando necessário — no **modo isolado** (sem volumes compartilhados).  
>
> **Padrão adotado:**
> - **Apps**: usuário e grupo **criados no Dockerfile** (ex.: `app:app`, UID 20000, GID 20000) e fixados no Compose (`user: "20000:20000"`).
> - **Airflow**: usa o **usuário não-root nativo** da imagem oficial (`airflow`, UID 50000, GID 50000). Ajuste só via Compose se quiser explicitar (`user: "50000:50000"`).
> - **SQL Server**: usa o **usuário não-root nativo** (`mssql`, UID ~10001). Em geral não altera; se quiser, apenas explicite no Compose (`user: "10001:10001"`).
>
> **Princípio:** **não manter** “usuário admin” permanente. Para tarefas administrativas, **elevação temporária** para `root` com `docker exec -u 0:0 …`.
> 
> **Uso do container do Airflow** Não iremos e não precisamos acessar diretamente o container do Airflow, onde só iremos seguir utilizando a interface na web.

---

#### I) O que são **UID** e **GID**
- **UID** (*User ID*): número inteiro que identifica **um usuário** para o kernel (ex.: `50000`).  
- **GID** (*Group ID*): número inteiro que identifica **um grupo** (ex.: `50000`).  
- Arquivos/pastas possuem permissões para **dono (UID)**, **grupo (GID)** e **outros**.  
- Cada processo carrega **um UID** (dono do processo) e **GIDs** (primário + suplementares).  
- Avaliação de acesso: **dono → grupo → outros** (nessa ordem).

> No nosso cenário, cada container tem **seu próprio** usuário não-root com posse das pastas internas do serviço; **não há** compartilhamento entre containers.

---

#### II) Listar **grupos** dentro de um container
> Compatível com Debian/Alpine/BusyBox. Se houver `bash`, pode trocar `sh` por `bash` - nesse caso iremos manter o uso do `bash`.

**Genérico (substitua `<container>`):**
```bash
docker exec -it <container> bash -lc 'id; echo; echo "--- grupos (primeiros 20) ---"; head -n 20 /etc/group'
```

**Exemplos:**
```bash
docker exec -it apps bash -lc 'id; echo; echo "--- grupos ---"; head -n 20 /etc/group'

docker exec -it sqlserver bash -lc 'id; echo; echo "--- grupos ---"; head -n 20 /etc/group'
```

---

#### III) Listar **usuários** dentro de um container
**Genérico:**
```bash
docker exec -it <container> bash -lc 'echo "user:uid:gid:shell"; awk -F: "{print \$1\":\"\$3\":\"\$4\":\"\$7}" /etc/passwd | head -n 20'
```

**Exemplos:**
```bash
docker exec -it apps bash -lc 'echo "user:uid:gid:shell"; awk -F: "{print \$1\":\"\$3\":\"\$4\":\"\$7}" /etc/passwd | head -n 20'

docker exec -it sqlserver bash -lc 'echo "user:uid:gid:shell"; awk -F: "{print \$1\":\"\$3\":\"\$4\":\"\$7}" /etc/passwd | head -n 20'
```

**Ver apenas um usuário específico - exemplo:**
```bash
docker exec -it apps bash -lc 'getent passwd app || grep "^app:" /etc/passwd || true'

docker exec -it sqlserver bash -lc 'getent passwd mssql || grep "^mssql:" /etc/passwd || true'
```

---

#### IV) Acessar o container com o **usuário do serviço** (não-root)
**Entrar com o usuário padrão do processo:**
> docker exec -it <container> bash abre um shell com o usuário padrão do container (definido por USER ou root por default).
```bash
# Apps (usuário: app)
docker exec -it apps bash

# SQL Server (usuário: mssql)
docker exec -it sqlserver bash
```

**Forçar UID:GID específico:**
```bash
# app:app (20000:20000)
docker exec -u 20000:20000 -it apps bash

# mssql (~10001)
docker exec -u 10001:10001 -it sqlserver bash
```

> Dicas úteis dentro do container: `whoami`, `id -u`, `id -g`, `umask`, `pwd`, `ls -l`.

---

#### V) Elevar permissões para **root** (temporariamente)
> Boa prática: **sem** `sudo` na imagem. Use root só para a ação pontual.

**Abrir um shell root temporário:**
```bash
docker exec -u 0:0 -it apps bash

docker exec -u 0:0 -it sqlserver bash
```

**Executar um comando como root (sem abrir um shell):**
```bash
docker exec -u 0:0 sqlserver bash -lc 'ls -la /var/opt/mssql | head'
```

> Saia do root assim que terminar (`exit`). Mantenha o **processo principal** do serviço sempre **não-root**.

---

#### Mapa de identidades do nosso cenário:

| Container  | Usuário   | UID   | GID   | Observações |
|------------|-----------|------:|------:|-------------|
| Apps       | `app`     | 20000 | 20000 | Criado no **Dockerfile** (dono de `/workspace`). |
| Airflow    | `airflow` | 50000 | 50000 | Nativo da imagem oficial; pode apenas explicitar no **Compose**. |
| SQL Server | `mssql`   | 10001| 10001     | Nativo da imagem oficial; **não** alterar na imagem. |

---

### 🧪 6. Validar se os pacotes foram instalados corretamente e quais as suas versões

> [!NOTE]
> Esta etapa valida se os pacotes e ferramentas essenciais (Python, AWS CLI e Terraform) foram instalados corretamente dentro dos containers, confirmando também as versões.  
> Os comandos serão executados **de dentro do container**, usando o usuário padrão, um usuário específico (nome/UID:GID) ou `root`, para comparar permissões e comportamento.

- Os comandos terão que ser a partir de dentro do container, ou seja, o que foi criado e o serviço iniciado
- Abra o terminal de sua preferência: bash, prompt cmd, via visual studio code
- Execute os comandos abaixo, onde podem ser executados a partir de um prompt local na sua máquina
- Deixaremos aberto um terminal para cada container e usuário conforme os comandos abaixo
- Notar que você pode entrar com o usuário (root), mas o mais correto é ter um usuário nominal ou de serviço com determinadas permissões em vez de utilizar o (root) diretamente
- Iremos deixar abaixo como entrar com o usuário do container, igual comentamos no item 5, e também como utilizamos o usuário (root)

> Não iremos e não precisamos acessar diretamente o container do Airflow, onde só iremos seguir utilizando a interface na web

**Utilizando o usuário do container - abre diretamente o usuário padrão:**
> docker exec -it <container> bash abre um shell com o usuário padrão do container (definido por USER ou root por default).
```bash
docker exec -it <nome-container> bash
docker exec -it apps bash
docker exec -it sqlserver bash
python3 --version
aws --version
terraform --version
```

**Utilizando o usuário do container - com nome de usuário:**
> docker exec -u <usuario> -it <container> bash abre o shell como um usuário específico, forçando UID/GID e permitindo testar permissões e comportamento exatamente como o processo do container roda.
```bash
docker exec -u <nome-usuario> -it <nome-container> bash
docker exec -u app -it apps bash
docker exec -u mssql -it sqlserver bash
python3 --version
aws --version
terraform --version
```

**Utilizando o usuário do container - com número de usuário:**
```bash
docker exec -u <nome-usuario> -it <nome-container> bash
docker exec -u 20000:20000 -it apps bash
docker exec -u 10001:10001 -it sqlserver bash
python3 --version
aws --version
terraform --version
```

**Utilizando o usuário root - com nome de usuário:**
> docker exec -u <usuario> -it <container> bash abre o shell como um usuário específico, forçando UID/GID e permitindo testar permissões e comportamento exatamente como o processo do container roda.
```bash
docker exec -u <nome-usuario> -it <nome-container> bash
docker exec -u root -it apps bash
docker exec -u root -it sqlserver bash
python3 --version
aws --version
terraform --version
```

**Utilizando o usuário root - com número de usuário:**
> docker exec -u <usuario> -it <container> bash abre o shell como um usuário específico, forçando UID/GID e permitindo testar permissões e comportamento exatamente como o processo do container roda.
```bash
docker exec -u <nome-usuario> -it <nome-container> bash
docker exec -u 0:0 -it apps bash
docker exec -u 0:0 -it sqlserver bash
python3 --version
aws --version
terraform --version
```

---

### 🌐 7. Testes de rede nos containers que formam o Compose Stack

> [!NOTE]
> Esta etapa valida se os containers do Compose Stack estão realmente se comunicando entre si dentro da mesma rede criada pelo Docker Compose.  
> O foco é confirmar **resolução de DNS interna do Docker**, **rede compartilhada** e principalmente **conectividade TCP na porta do serviço** (ex.: SQL Server 1433).

Essas validações são fundamentais para verificar se os containers realmente estão se comunicando entre si dentro da mesma rede criada pelo Docker Compose.

> 💡 Importante: Em ambientes modernos (microservices, cloud, Kubernetes), validar apenas com `ping` não é suficiente. Aplicações utilizam TCP, não ICMP. Portanto, o teste correto é validar a porta do serviço.

**📡 Listando as redes existentes no Docker**

Liste todas as redes existentes:

```bash
docker network ls
```

Você verá algo como:

```text
NETWORK ID     NAME                DRIVER    SCOPE
xxxxx          bridge              bridge    local
xxxxx          host                host      local
xxxxx          none                null      local
xxxxx          sirius_net01        bridge    local
```

A rede `sirius_net01` é a rede criada pelo Compose Stack.

**🔍 Inspecionando a rede utilizada pelo Compose**

Para visualizar detalhes da rede:

```bash
docker network inspect sirius_net01
```

Esse comando permite verificar:

- Containers conectados
- Endereços IP internos
- Gateway
- Configuração do driver (bridge)
- Subnet utilizada

Isso confirma que os containers `apps` e `sqlserver` estão na mesma rede.

**🧠 Entendendo o teste de conectividade correto**

Muitas vezes se utiliza:

```bash
ping sqlserver
```

Porém:

- `ping` utiliza ICMP (camada 3)
- Aplicações utilizam TCP (camada 4)
- Alguns containers bloqueiam ICMP por padrão
- ICMP não valida se a porta da aplicação está aberta

Portanto, o teste correto é validar a porta do serviço.

**🚀 Teste profissional de conectividade com Netcat (nc)**

O `nc` (Netcat) é conhecido como:

> "The Swiss Army Knife of Networking"

Ele permite testar portas TCP sem enviar dados.

Dentro do container `apps`, execute:

```bash
nc -zv sqlserver 1433
```

### 📌 O que significa esse comando?

- `nc` → executa o Netcat
- `-z` → modo "zero I/O" (apenas testa a conexão, não envia dados)
- `-v` → modo verbose (exibe detalhes)
- `sqlserver` → nome do container (resolvido via DNS interno do Docker)
- `1433` → porta padrão do SQL Server

### ✅ Se a conexão estiver funcionando:

```text
Connection to sqlserver 1433 port [tcp/ms-sql-s] succeeded!
```

Isso confirma que:

- O DNS interno do Docker está funcionando
- Os containers estão na mesma rede
- O SQL Server está escutando na porta 1433
- A comunicação TCP entre os containers está ativa

### ❌ Possíveis erros e significados

**Connection refused**
- O serviço ainda não subiu
- A porta não está aberta

**Name or service not known**
- Containers não estão na mesma rede

**Operation timed out**
- Firewall
- Problema de rede
- Serviço travado

**📦 Alternativa moderna ao Telnet**

Antigamente era comum utilizar:

```bash
telnet sqlserver 1433
```

Porém:

- Telnet é antigo
- Nem sempre vem instalado
- Não é recomendado para troubleshooting moderno

Hoje, o recomendado é:

```bash
nc -zv sqlserver 1433
```

Ou, se for testar HTTP:

```bash
curl http://nome-do-servico:porta
```

**🧪 Teste usando Python (caso não tenha nc instalado)**

Se o container `apps` possuir Python, é possível testar a conexão TCP assim:

```bash
python3 - <<'PY'
import socket
host="sqlserver"
port=1433
s=socket.socket()
s.settimeout(3)
try:
    s.connect((host,port))
    print("OK: conexão estabelecida com", host, port)
except Exception as e:
    print("ERRO:", e)
finally:
    s.close()
PY
```

Esse teste valida:

- DNS
- Rede Docker
- Porta aberta
- Handshake TCP

**🎯 Conclusão Técnica**

Em ambientes modernos:

- ICMP (ping) ≠ validação real de aplicação
- O teste correto é validar a porta TCP
- `nc` é ferramenta padrão profissional para troubleshooting
- Sempre teste a porta do serviço, não apenas a conectividade básica

Essa abordagem está alinhada com boas práticas de:

- Engenharia de Software
- DevOps
- DevSecOps
- Cloud Native Architecture
- Microservices

---

### 🗄️ 8. Visualizar a versão do SQL Server via o próprio container do serviço (sqlserver)

> [!NOTE]
> Esta etapa valida a versão do SQL Server **diretamente no container do serviço** (`sqlserver`), conectando via `sqlcmd` e executando consultas SQL.  
> O objetivo é confirmar que o banco está acessível internamente, e também ensinar um padrão mais seguro para senha usando `.env` e automação com script bash.

- Será necessário entrar no banco de dados e executar uma consulta SQL
- Os comandos precisam ser executados a partir e de dentro do container
- Caso esse comando falhe, investigue se o caminho mencionado, principalmente a parte `mssql-tools18`, está correto (pode variar por versão)

Explicação dos parâmetros:
- `/opt/mssql-tools18/bin/sqlcmd`: caminho completo para o executável do cliente sqlcmd  
- `-S localhost`: alvo é o próprio container  
- `-U sa`: usuário de autenticação (System Administrator)  
- `-P 'senha'`: senha do usuário `sa`  
- `-N`: usa conexão criptografada (SSL)  
- `-C`: confirma o certificado mesmo se não for confiável (usado com `-N`)

```bash
/opt/mssql-tools18/bin/sqlcmd -S localhost -U sa -P 'insira sua senha ou o arquivo .env*' -N -C
```

- Não é boa prática inserir a senha diretamente no comando; veremos como ler de um arquivo `.env`

- No host (fora do container), invoque o container interativamente

Com usuário root:
> Por boas práticas, não é recomendado ficar utilizando o usuário `root` para ações convencionais como criar pastas no container, somente se essa estiver sendo criada na raiz do filesystem, o que não faremos neste caso, mas deixaremos abaixo caso tenhamos que utilizar para algo específico.
```bash
docker exec -u <nome-usuario> -it <nome-container> bash
docker exec -u root -it sqlserver bash
docker exec -u 0:0 -it sqlserver bash
```

Com usuário do container:
> Por boas práticas, iremos utilizar este usuário para seguir com o tutorial, e não criaremos pastas na raiz do filesystem, mas sim no caminho do próprio SQL Server.
```bash
docker exec -u <nome-usuario> -it <nome-container> bash
docker exec -u mssql -it sqlserver bash
docker exec -u 10001:10001 -it sqlserver bash
```

Valide o usuário atual e liste todos os usuários disponíveis no container:
```bash
whoami #ou
id -un
getent passwd
```

Validando usuário com permissão para ações na raiz do filesystem:
> Antes de criar a pasta, vamos verificar qual usuário tem permissão para realizar ações na raiz do filesystem, confirmando que é o usuário `root`.
```bash
pwd
ls -ld /
id
```

Crie a pasta `db`, entre nela e crie um `.env` com `vim`:
> Iremos criar a pasta fora da raiz do filesystem, mas sim no caminho do próprio SQL Server.

Opção 1:
```bash
cd /var/opt/mssql
mkdir db
cd db
```

Opção 2:
```bash
mkdir -p /var/opt/mssql/db
cd /var/opt/mssql/db
```

Crie o arquivo `.env` que irá conter a senha do banco de dados utiliando o `vim`:
> Em ambientes de produção, em vez de usar esse método, é mais seguro utilizar cofres, por exemplo da AWS ou Microsoft, onde o armazanamento de senhas, variáveis e outros objetos estará mais seguro e com acessso restrito somente a quem tiver as permissões necessárias.
```bash
vim --version
ls -la
vim .env
i
SA_PASSWORD=<insira sua senha> | SA_PASSWORD=Senh@forte! | SA_PASSWORD="Senh@forte!"
ESC
:w
:q
cat .env
```

Valide e leia o arquivo `.env`, analisando se a senha foi inserida corretamente, e depois conecte no banco de dados:

✅ **Por que usar `source .env` antes de conectar?**

> O comando `source .env` carrega as variáveis do arquivo `.env` no shell atual (ex.: `SA_PASSWORD`), permitindo que o `sqlcmd` use `"$SA_PASSWORD"` sem você precisar digitar a senha diretamente no comando.
```bash
ls -la
cat .env
source .env
/opt/mssql-tools18/bin/sqlcmd -S localhost -U sa -P "$SA_PASSWORD" -N -C
```

Crie um script bash para automatizar a conexão:

✅ **Por que usar `source .env` antes de conectar?**

> O comando `source .env` carrega as variáveis do arquivo `.env` no shell atual (ex.: `SA_PASSWORD`), permitindo que o `sqlcmd` use `"$SA_PASSWORD"` sem você precisar digitar a senha diretamente no comando.

> 💡 **Observação rápida (importante):** como copiamos o script para outro diretório depois, devemos usar o **caminho absoluto** no `source` (ex.: `/var/opt/mssql/db/.env`) para não depender do diretório atual.
```bash
ls -la
vim con_sql.sh
i
#!/bin/bash
source /var/opt/mssql/db/.env
/opt/mssql-tools18/bin/sqlcmd -S localhost -U sa -P "$SA_PASSWORD" -N -C
ESC
:w
:q
cat con_sql.sh
```

Ajuste permissão do arquivo para não somente leitura, mas para conseguir executar e então execute:
```bash
ls -la
./con_sql.sh
chmod +x con_sql.sh
ls -la
./con_sql.sh
```

Teste copiar o script para outro diretório e executar:
```bash
ls -la
cd /var/opt/mssql
ls -la
mkdir app
cd app
ls -la
cp /var/opt/mssql/db/con_sql.sh /var/opt/mssql/app/
ls -la
./con_sql.sh
```

Consultas de teste no `sqlcmd`:
```sql
select @@version;
go
```

```sql
select name from sys.databases;
go
```

Duas consultas na mesma execução:
```sql
select @@version;
select name from sys.databases;
go
```

Sair do `sqlcmd`:
```
exit
ou
quit
ou
ctrl+c
```

---

### 🔗 9. Visualizar a versão do SQL Server via o container do serviço (apps), acessando o container (sqlserver)

> [!NOTE]
> Esta etapa valida a versão do SQL Server **diretamente no container do serviço** (`apps`), conectando via `sqlcmd` e executando consultas SQL.  
> O objetivo é confirmar que o banco está acessível internamente, e também ensinar um padrão mais seguro para senha usando `.env` e automação com script bash, além de realizar a visualização via outro container, que não é onde está hospedado o SQL Server.

- Será necessário entrar no banco de dados e executar uma consulta SQL
- Os comandos precisam ser executados a partir e de dentro do container
- Caso esse comando falhe, investigue se o caminho mencionado, principalmente a parte `mssql-tools18`, está correto (pode variar por versão)

- Vamos conectar com o `sqlcmd` do container do serviço `apps` para visualizar o serviço do container do `sqlserver`:
```bash
sqlcmd -S sqlserver -U sa -P 'insira sua senha ou o arquivo .env*' -N -C
```
- Não é boa prática inserir a senha diretamente no comando; veremos como ler de um arquivo `.env`

- No host (fora do container), invoque o container interativamente:

Com usuário root:
> Por boas práticas, não é recomendado ficar utilizando o usuário root para ações convencionais como criar pastas no container, somente se essa estiver sendo criada na raiz do filesystem, o que não faremos neste caso, mas deixaremos abaixo caso tenhamos que utilizar para algo específico.
```bash
docker exec -u <nome-usuario> -it <nome-container> bash
docker exec -u root -it apps bash
docker exec -u 0:0 -it apps bash
```

Com usuário do container:
> Por boas práticas, iremos utilizar este usuário para seguir com o tutorial, e não criaremos pastas na raiz do filesystem, mas sim no caminho do próprio SQL Server.
```bash
docker exec -u <nome-usuario> -it <nome-container> bash
docker exec -u app -it apps bash
docker exec -u 20000:20000 -it apps bash
```

Valide o usuário atual e liste todos os usuários disponíveis no container:
```bash
whoami #ou
id -un
getent passwd
```

Validando usuário com permissão para ações na raiz do filesystem:
> Antes de criar a pasta, vamos verificar qual usuário tem permissão para realizar ações na raiz do filesystem, confirmando que é o usuário root.
```bash
pwd
ls -ld /
id
```

Crie a pasta `db`, entre nela e crie um `.env` com `vim`:
```bash
ls -la
mkdir db
cd db
```

Crie o arquivo `.env` que irá conter a senha do banco de dados utiliando o `vim`:
> Em ambientes de produção, em vez de usar esse método, é mais seguro utilizar cofres, por exemplo da AWS ou Microsoft, onde o armazanamento de senhas, variáveis e outros objetos estará mais seguro e com acessso restrito somente a quem tiver as permissões necessárias.
```bash
vim --version
ls -la
vim .env
i
SA_PASSWORD=<insira sua senha> | SA_PASSWORD=Senh@forte! | SA_PASSWORD="Senh@forte!"
ESC
:w
:q
cat .env
```

Valide e leia o arquivo `.env`, analisando se a senha foi inserida corretamente, e depois conecte no banco de dados:
```bash
ls -la
cat .env
source .env
sqlcmd -S sqlserver -U sa -P "$SA_PASSWORD" -N -C
```

Crie um script bash para automatizar a conexão:

✅ **Por que usar `source .env` antes de conectar?**

> O comando `source .env` carrega as variáveis do arquivo `.env` no shell atual (ex.: `SA_PASSWORD`), permitindo que o `sqlcmd` use `"$SA_PASSWORD"` sem você precisar digitar a senha diretamente no comando.

> 💡 **Observação rápida (importante):** como copiamos o script para outro diretório depois, devemos usar o **caminho absoluto** no `source` (ex.: `/workspace/db/.env`) para não depender do diretório atual.
```bash
ls -la
vim con_sql.sh
i
#!/bin/bash
source /workspace/db/.env
sqlcmd -S sqlserver -U sa -P "$SA_PASSWORD" -N -C
ESC
:w
:q
cat con_sql.sh
```

Ajuste permissão do arquivo para não somente leitura, mas para conseguir executar e então execute:
```bash
ls -la
./con_sql.sh
chmod +x con_sql.sh
ls -la
./con_sql.sh
```

Teste copiar o script para outro diretório e executar:
```bash
ls -la
cd /workspace
ls -la
mkdir app
cd app
ls -la
cp /workspace/db/con_sql.sh /workspace/app/
ls -la
./con_sql.sh
```

Consultas de teste no `sqlcmd`:
```sql
select @@version;
go
```

```sql
select name from sys.databases;
go
```

Duas consultas na mesma execução:
```sql
select @@version;
select name from sys.databases;
go
```

Sair do `sqlcmd`:
```
exit
ou
quit
ou
ctrl+c
```

---

### 🐍 10. Visualizar a versão do SQL Server via o container do serviço (apps), acessando o container (sqlserver) - Via script Python

> [!NOTE]
> Esta etapa valida a versão do SQL Server **diretamente no container do serviço** (`apps`), conectando via `Python` e executando consultas SQL.  
> O objetivo é confirmar que o banco está acessível internamente, e também ensinar um padrão mais seguro para senha usando `.env` e automação com script bash, além de realizar a visualização via outro container e com um script Python.

- Será necessário entrar no banco de dados e executar uma consulta SQL
- Os comandos precisam ser executados a partir e de dentro do container
- Caso esse comando falhe, investigue se o caminho mencionado, principalmente a parte `mssql-tools18`, está correto (pode variar por versão)

- No host (fora do container), invoque o container interativamente:

Com usuário root:
> Por boas práticas, não é recomendado ficar utilizando o usuário root para ações convencionais como criar pastas no container, somente se essa estiver sendo criada na raiz do filesystem, o que não faremos neste caso, mas deixaremos abaixo caso tenhamos que utilizar para algo específico.
```bash
docker exec -u <nome-usuario> -it <nome-container> bash
docker exec -u root -it apps bash
docker exec -u 0:0 -it apps bash
```

Com usuário do container:
> Por boas práticas, iremos utilizar este usuário para seguir com o tutorial, e não criaremos pastas na raiz do filesystem, mas sim no caminho do próprio SQL Server.
```bash
docker exec -u <nome-usuario> -it <nome-container> bash
docker exec -u app -it apps bash
docker exec -u 20000:20000 -it apps bash
```

Valide o usuário atual e liste todos os usuários disponíveis no container:
```bash
whoami #ou
id -un
getent passwd
```

Validando usuário com permissão para ações na raiz do filesystem:
> Antes de criar a pasta, vamos verificar qual usuário tem permissão para realizar ações na raiz do filesystem, confirmando que é o usuário root.
```bash
pwd
ls -ld /
id
```

Validar se temos o conector `pyodbc` instalado no container `apps`:
> É essencial que tenhamos esse conector instalado.
```bash
python3 -c "import pyodbc; print(pyodbc.version)"
```

Listar pacotes Python e filtrar `pyodbc`:
> É essencial que tenhamos esse conector instalado.
```bash
pip3 list
pip3 list | grep pyodbc
```

Checar drivers ODBC:
> É essencial que tenhamos esse conector instalado.
```bash
dpkg -l | grep odbc
odbcinst -j
odbcinst -q -d
```

Instalar `pyodbc` (via pip no container):
```bash
python3 -m pip install pyodbc
```

Se ocorrer erro por PEP 668 (ambiente protegido), opções:

**(1) APT (se existir pacote .deb):**
```bash
apt update
apt install python3-pyodbc   # ou: apt-get install -y python3-pyodbc
```

**(2) Virtualenv (projeto isolado):**
```bash
apt install python3-venv -y
python3 -m venv venv
source venv/bin/activate
pip install pyodbc
```

**(3) Forçar (último recurso, container/VM descartável):**
```bash
python3 -m pip install pyodbc --break-system-packages
```

Criar o script `python` para executar as ações no banco de dados com `vim`:
> Nesse caso devemos copiar o script, inserir as informações de usuário e senha, e somente depois colar no arquivo `teste.py` com o `vim`.
```bash
pwd
ls -la
mkdir scripts-ptyhon
cd scripts-ptyhon
ls -la
vim teste.py
i
import pyodbc
conn = pyodbc.connect(
    "DRIVER={ODBC Driver 17 for SQL Server};"
    "SERVER=sqlserver,1433;"
    "DATABASE=master;"
    "UID=<usuario>;"
    "PWD=<senha>"
)
cursor = conn.cursor()
cursor.execute("SELECT @@VERSION")
row = cursor.fetchone()
print(row[0])
:w
:q
cat teste.py
python3 teste.py
```

Caso uma mensagem como a abaixo seja retornada, quer dizer que o script Python conseguiu conectar corretamente no banco de dados:
```bash
Microsoft SQL Server 2022 (RTM-CU23) (KB5078297) - 16.0.4236.2 (X64) 
        Jan 22 2026 17:50:56 
        Copyright (C) 2022 Microsoft Corporation
        Developer Edition (64-bit) on Linux (Ubuntu 22.04.5 LTS) <X64>
```

#### Troubleshooting em casos de erros com indentação do script no `vim`

> Para fortalecer o aprendizado efetivo no uso de Agentes de IA como o ChatGPT ou Gemini, crie e inseira um prompt que inclua: erro recebido, script original e script colado no `vim`, onde a identação foi perdida e alterada no arquivo.  
> **Exemplo de erro para casos de identação:** `IndentationError: unexpected indent`

Para colar no `vim` mantendo indentação:
```bash
rm teste.py
vim teste.py
esc
:set paste
i
import pyodbc
conn = pyodbc.connect(
    "DRIVER={ODBC Driver 17 for SQL Server};"
    "SERVER=sqlserver,1433;"
    "DATABASE=master;"
    "UID=<usuario>;"
    "PWD=<senha>"
)
cursor = conn.cursor()
cursor.execute("SELECT @@VERSION")
row = cursor.fetchone()
print(row[0])
esc
:set nopaste
:w
:q
cat teste.py
python3 teste.py
```

Criar o mesmo arquivo com **nano** (mantém indentação ao colar):
```bash
rm teste.py
nano teste.py
# cole o conteúdo do script
# salve com: ctrl + o  (enter para confirmar o nome)
# saia com:  ctrl + x
cat teste.py
python3 teste.py
```

> Essa é uma das maneiras também de testar se as portas, rede e comunicação estão funcionando entre os containers.
