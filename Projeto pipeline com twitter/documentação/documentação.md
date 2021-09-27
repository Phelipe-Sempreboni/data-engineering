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

   - Instalação finalizada e distribuição Linux totalmente integrada ao sistema operacional Windows.

## Fim do bloco I para virtualização do Linux no Windows.

---
     
