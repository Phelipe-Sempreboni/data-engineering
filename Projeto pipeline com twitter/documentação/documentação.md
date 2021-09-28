### Projeto de pipeline com o twitter

---

#### Este projeto tem o intuito de construir, do zero, um projeto com o Twitter e o Apache Airflow.

#### Falaremos desde como virtualizar um Linux no Windows, até a alimentação dos dados em um Datalake.

---

## Inicio do bloco I para virtualização do Linux no Windows.

Iremos utilizar uma virtualização no Windows, chamada WSL 2, que não possuí todas distribuições do Linux como uma Hyper-V, porém, irá atender este projeto.

1º - Instalação da WSL 2 para virtualização do Linux no Windows da maneira mais prática e simplista para caso você esteja com a versão mais recente do build do Windows. Caso tenha essa última versão, é só executar o comando abaixo e que executa as seguintes opções:
  - Habilita os componentes opcionais WSL e Plataforma de Máquina Virtual.
  - Baixa e instala o kernel do Linux mais recente.
  - Define WSL 2 como o padrão.
  - Baixa e instala a distribuição Ubuntu Linux aplicativo (a reinicialização pode ser necessária).
  ```powershell
  wsl --install
  ```
  
  Documentação de referência: https://docs.microsoft.com/pt-br/windows/wsl/install
  
  ---
  
  2º - Instalação da WSL 2 para virtualização do Linux no Windows caso você esteja com um build mais antigo do Windows, ou seja, não esteja com o build atual.
  
   - Etapa 1 – Habilitar o Subsistema do Windows para Linux:
   
     - Antes de instalar qualquer distribuição do Linux no Windows, você precisará primeiro habilitar o recurso opcional "Subsistema do Windows para Linux".

     - Abra o PowerShell como administrador e execute:
     
     ```powershell
     dism.exe /online /enable-feature /featurename:Microsoft-Windows-Subsystem-Linux /all /norestart
     ```
     
   - Agora, é recomendável passar para a etapa 2, de atualização para o WSL 2. Mas, se você desejar instalar apenas o WSL 1, será possível reiniciar o computador e passar para a Etapa 6 – Instalar a distribuição do Linux de sua escolha. Para atualizar para o WSL 2, aguarde o seu computador ser reiniciado e passe para a próxima etapa.
  
  ---
  
  - Etapa 2 – Verificar os requisitos para executar o WSL 2:
  
  - Para atualizar para o WSL 2, você precisa estar executando o Windows 10.

    - Para sistemas x64: Versão 1903 ou superiores, com o Build 18362 ou superiores.
    
    - Para sistemas ARM64: Versão 2004 ou superiores, com o Build 19041 ou superiores.
    
    - Os builds inferiores a 18362 não dão suporte a WSL 2. Use o Assistente do Windows Update para atualizar a sua versão do Windows.
    
    - Para verificar a sua versão e o número de build, selecione a tecla do logotipo do Windows + R, digite winver e selecione OK. Atualize para a versão mais recente do Windows no menu Configurações.
    
    ---
    
   - Etapa 3 – Habilitar o recurso de Máquina Virtual
    
     - Antes de instalar o WSL 2, você precisa habilitar o recurso opcional Plataforma de Máquina Virtual. Seu computador exigirá funcionalidades de virtualização para usar esse recurso.

     - Abra o PowerShell como administrador e execute:
     
     ```powershell
     dism.exe /online /enable-feature /featurename:VirtualMachinePlatform /all /norestart
     ```
     
   ### Reinicie o computador para concluir a instalação do WSL e a atualização para o WSL 2.     
---
     
   - Etapa 4 – Baixar o pacote de atualização do kernel do Linux
   
   1. Baixar o pacote mais recente:
   
   - Pacote de atualização do kernel do Linux do WSL2 para computadores x64 - Baixe no site da documentação oficial -> https://docs.microsoft.com/pt-br/windows/wsl/install-manual
   
   2. Execute o pacote de atualização baixado na etapa anterior. (Clique duas vezes para executar. Você receberá uma solicitação para fornecer permissões elevadas; selecione 'sim' para aprovar essa instalação).
   
   - Depois que a instalação for concluída, vá para a próxima etapa: configurar o WSL 2 como a sua versão padrão ao instalar novas distribuições do Linux (ignore essa etapa se você quiser que as novas instalações do Linux sejam definidas como WSL 1).
   
   ---
   
   - Etapa 5 – Definir o WSL 2 como a sua versão padrão:
   
     - Abra o PowerShell e execute este comando para definir o WSL 2 como a versão padrão ao instalar uma nova distribuição do Linux:
     ```powershell
     wsl --set-default-version 2
     ```  
   ---
   
   - Etapa 6 – Instalar a distribuição do Linux de sua escolha:
   
   1. Abra a Microsoft Store e escolha sua distribuição do Linux favorita. Neste caso estamos utilizando a Ubuntu para o projeto, mas fique á vontade para escolher.
   
   2. Na página da distribuição, selecione "Obter".
   
   - Na primeira vez que você iniciar uma distribuição do Linux recém-instalada, uma janela de console será aberta e será solicitado que você aguarde um ou dois minutos para que os arquivos sejam descompactados e armazenados em seu PC. Todas as futuras inicializações deverão levar menos de um segundo.

   - Em seguida, você precisará criar uma conta de usuário e uma senha para sua nova distribuição do Linux.
   
   ![image](https://user-images.githubusercontent.com/57469401/135000594-26d754ea-a2d4-4451-8b77-ee0da3326204.png)
 
  3. Abra a Microsoft Store e procure por "Windows Terminal", clique em "Obter" e "Instalar". Com esse terminal é possível rodar a distribuição que foi feita o download no item (1) anterior e é um terminal mais prático e acessível para quem está começando.
  
   - Instalação finalizada e distribuição Linux totalmente integrada ao sistema operacional Windows.

   - Nota: Se você quiser desinstalar a WSL 2 e a distribuição do Ubuntu, é só desinstalar como um programa convencional do Windows no Painel de Controle.

Documentação de referência: https://docs.microsoft.com/pt-br/windows/wsl/install-manual

## Fim do bloco I para virtualização do Linux no Windows.

---

## Inicio do bloco II para configurações no ambiente Linux.

1º - Abra o Windows Terminal como administrador.

---

2º - Deixe uma guia aberta com o PowerShell e uma com Ubuntu ou a distribuição que foi feita a instalação de sua escolha.

---

3º - Configurando e ajustando os parâmetos conexão com a internet, onde neste caso, configuraremos pensando que na máquina utilizada possua uma VPN, que hoje em dia é comum, porém, se sua máquina não tiver VPN é capaz que as configurações padrões de instalação do WSL funcionem, logo, execute o passo I. Se não obtiver sucesso, execute o passo II.

I. Realizar um teste de conexão com o comando abaixo no terminal do Linux. Caso o comando seja executado com sucesso e com retorno de rede, não será necessário executar o passo II.
```linux
ping google.com
```

II. Abra o PowerShell e execute os comandos abaixo no terminal do Ububtu ou distribuição escolhida na instalação.
```powershell
Get-NetIPInterface -InterfaceAlias "vEthernet (WSL)" | Set-NetIPInterface -InterfaceMetric 1  #Esta linha seta a interface do WSL como uma das principais.
Get-NetAdapter | Where-Object {$_.InterfaceDescription -Match "Cisco AnyConnect"} | Set-NetIPInterface -InterfaceMetric 6000  #Esta linha diminui a prioridade da rede VPN, para ficar menor do que a rede virtual WSL.
```
Após executar esses dois comandos no PowerShell, abra o temrinal do Linux e realize um teste de conexão com os comandos abaixo.
```linux
ping google.com
ping minha.intranet #Nesta linha em vez de executar uma url como o google, teste uma url que só funciona conectado a VPN.
```

Caso os comandos e os testes sejam executados com sucesso, agora estamos com acesso a rede e podemos seguir para os próximos passos.

---

4º - Abra o terminal Linux e digite o comando abaixo para atualizar e realizar um upgrade se necessário no ambiente virtualizado do Linux.
```linux
sudo apt update && sudo apt upgrade
```
Notar que também podemos executar os comandos separadamente conforme abaixo:
```linux
sudo apt-get update
sudo apt-get upgrade
```
---
