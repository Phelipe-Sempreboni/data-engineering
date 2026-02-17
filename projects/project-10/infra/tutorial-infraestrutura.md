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

**Executar UM comando como root (sem abrir shell):**
```bash
docker exec -u 0:0 apps               sh -lc 'mkdir -p /workspace/teste && ls -ld /workspace/teste'
docker exec -u 0:0 airflow-webserver  sh -lc 'mkdir -p /opt/airflow/dags && ls -ld /opt/airflow/dags'
docker exec -u 0:0 database           sh -lc 'ls -la /var/opt/mssql | head'
```

> Saia do root assim que terminar (`exit`). Mantenha o **processo principal** do serviço sempre **não-root**.

---

#### (Opcional) Mapa de identidades recomendadas

| Container  | Usuário   | UID   | GID   | Observações |
|------------|-----------|------:|------:|-------------|
| Apps       | `app`     | 20000 | 20000 | Criado no **Dockerfile** (dono de `/workspace`). |
| Airflow    | `airflow` | 50000 | 50000 | Nativo da imagem oficial; pode apenas explicitar no **Compose**. |
| SQL Server | `mssql`   | ~10001| 0     | Nativo da imagem oficial; **não** alterar na imagem. |

---

### 🧪 6. Validar se os pacotes foram instalados corretamente e quais as suas versões
- Os comandos terão que ser a partir de dentro do container, ou seja, o que foi criado e o serviço iniciado
- Abra o terminal de sua preferência: bash, prompt cmd, via visual studio code
- Execute os comandos abaixo, onde podem ser executados a partir de um prompt local na sua máquina
- Deixaremos aberto um terminal para cada container e usuário conforme os comandos abaixo
- Notar que você pode entrar com o usuário (root), mas o mais correto é ter um usuário nominal ou de serviço com determinadas permissões em vez de utilizar o (root) diretamente
- Iremos deixar abaixo como entrar com o usuário do container, igual comentamos no item, e também como utilizamos o usuário (root)

> Não iremos e não precisamos acessar diretamente o container do Airflow, onde só iremos seguir utilizando a interface na web

**Utilizando o usuário do container - Método 1:**
> docker exec -it <container> bash abre um shell com o usuário padrão do container (definido por USER ou root por default).
```bash
docker exec -it <nome-container> bash
docker exec -it apps bash
docker exec -it sqlserver bash
python3 --version
aws --version
terraform --version
```

**Utilizando o usuário do container - Método 2:**
> docker exec -u <usuario> -it <container> bash abre o shell como um usuário específico, forçando UID/GID e permitindo testar permissões e comportamento exatamente como o processo do container roda.
```bash
docker exec -u <nome-usuario> -it <nome-container> bash
docker exec -u app -it apps bash | docker exec -u 20000:20000 -it apps bash
docker exec -u mssql -it sqlserver bash | docker exec -u 10001:10001 -it sqlserver bash
python3 --version
aws --version
terraform --version
```

**Utilizando o usuário root:**
> docker exec -u <usuario> -it <container> bash abre o shell como um usuário específico, forçando UID/GID e permitindo testar permissões e comportamento exatamente como o processo do container roda.
```bash
docker exec -u <nome-usuario> -it <nome-container> bash
docker exec -u root -it sqlserver bash
docker exec -u root -it apps bash
python3 --version
aws --version
terraform --version
```

---

### 🌐 7. Testes de rede nos containers que formam o Compose Stack
- Essas validações são importantes para verificar se os containers realmente estão se comunicando entre si, visto que criamos dentro da mesma rede

Liste todas as redes existentes no Docker
```bash
docker network ls
```

Inspecione uma rede específica, no caso a que você está utilizando na comunicação entre os containers
```bash
docker network inspect sirius_net01
```

Realize um ping no container do serviço (sqlserver) via o container do serviço (apps)
```bash
ping sqlserver
```

Realize um teste na porta do banco de dados (SQL Server), que está no serviço do container do (sqlserver), a partir do container (apps)
```bash
telnet sqlserver 1433
```

---

### 🗄️ 8. Ver a versão do SQL Server via o próprio container do serviço (sqlserver)

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
- No host (fora do container), invoque o container interativamente:
```bash
docker exec -u <nome-usuario> -it <nome-container> bash
docker exec -u 0 -it sqlserver bash   # ou
docker exec -u root -it sqlserver bash
```

Verifique usuário atual, liste usuários e altere para `mssql`:
```bash
whoami   # ou: id -un
getent passwd
su - mssql
```

Crie pasta `db`, entre nela e crie um `.env` com `vim`:
```bash
mkdir db
cd db

apt-get update
apt-get install -y vim
vim --version
```

Crie o arquivo e preencha a variável (no `vim`):
```bash
vim .env
i
SA_PASSWORD=<insira sua senha>
SA_PASSWORD=Senh@forte!
SA_PASSWORD="Senh@forte!"
:w
:q
cat .env
```

Troque para o usuário `mssql` (se ainda não estiver), valide e leia o `.env`, depois conecte:
```bash
getent passwd
su - mssql
whoami   # ou: id -un
ls -la
cd db
ls -la
cat .env
cd ..

source /db/.env
/opt/mssql-tools18/bin/sqlcmd -S localhost -U sa -P "$SA_PASSWORD" -N -C
```

Crie um script bash para automatizar a conexão:
```bash
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

Ajuste permissão e execute:
```bash
ls -la
chmod +x con_sql.sh
ls -la
./con_sql.sh
```

Teste copiar o script para outro diretório e executar:
```bash
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

### 🔗 9. Ver a versão do SQL Server via o container do serviço (apps), acessando o container (sqlserver)

- Agora dentro do container `apps` (não no `sqlserver`)
- Conecte com `sqlcmd` de `apps` para `sqlserver`:
```bash
sqlcmd -S sqlserver -U sa -P 'insira sua senha ou o arquivo .env*' -N -C
```

Abra shell no `apps`:
```bash
docker exec -u <nome-usuario> -it <nome-container> bash
docker exec -u 0 -it apps bash   # ou
docker exec -u root -it apps bash
```

Confirme usuário atual, crie pasta `db` e `.env` (se necessário):
```bash
whoami   # ou: id -un
getent passwd
su - mssql

mkdir db
cd db

apt-get update
apt-get install -y vim
vim --version
```

Crie o `.env` com `vim`:
```bash
vim .env
i
SA_PASSWORD=<insira sua senha>
SA_PASSWORD=Senh@forte!
SA_PASSWORD="Senh@forte!"
:w
:q
cat .env
```

Validações e leitura do `.env`:
```bash
getent passwd
whoami   # ou: id -un
ls -la
cd db
ls -la
cat .env
cd ..

source /db/.env
sqlcmd -S sqlserver -U sa -P "$SA_PASSWORD" -N -C
```

Script bash no `apps` para automatizar:
```bash
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

Permissão e execução:
```bash
ls -la
chmod +x con_sql.sh
ls -la
./con_sql.sh
```

Copiar e executar de outro diretório:
```bash
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

Consultas de teste:
```sql
select @@version;
go
```

```sql
select name from sys.databases;
go
```

Execução de duas consultas:
```sql
select @@version;
select name from sys.databases;
go
```

Sair do `sqlcmd`:
```
exit ou quit ou ctrl+c
```

---

### 🐍 10. Script Python no container (apps) para testar leitura no SQL Server (container sqlserver)

Verificar se o `pyodbc` está instalado:
```bash
python3 -c "import pyodbc; print(pyodbc.version)"
```

Listar pacotes Python e filtrar `pyodbc`:
```bash
pip3 list
pip3 list | grep pyodbc
```

Checar drivers ODBC:
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

Criar `apps/teste.py` com `vim`:
```bash
pwd
ls -la
cd apps
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

#### Troubleshooting (exemplo com erro de indentação)

> Use o ChatGPT com um prompt que inclua: erro recebido, script original e script colado no `vim` (com indentação alterada).  
> **Erro exemplo:** `IndentationError: unexpected indent`

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
