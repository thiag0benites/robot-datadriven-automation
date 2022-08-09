*** Comments ***
##################################################################################################################################
# Autor: Thiago Benites
# Decrição: Configurações iniciais
##################################################################################################################################


*** Settings ***
### Interagir com Browser
Library     Collections
Library     Process
Library     OperatingSystem
# Library    AutoRecorder
Library     SeleniumLibrary    #timeout=10
### Trabalha com stings
Library     String
Library     DateTime
### Banco de dados
Library     DatabaseLibrary
### Biblioteca Faker para geração de dados aleatórios
Library     FakerLibrary    locale=pt_BR
### Bibliotecas Personalizadas
Library     libraries/bd_get_data.py
Library     libraries/random_data.py
Library     libraries/command.py


*** Variables ***
${PROJECT_PATH}         ${CURDIR}

### Define local da execução:
### SELENOID
# ${LOCAL_EXECUCAO}       SELENOID
### LOCAL
${LOCAL_EXECUCAO}       LOCAL

### Dados de conexão com DATA MANAGER
&{DATAMANAGER}          DBNAME=mv_automation
...                     DBUSER=root
...                     DBPASSWORD=root
...                     DBHOST=localhost
...                     DBPORT=3306

### Configurações do Browser
&{BROWSER}              CHROME=chrome
...                     CHROMEHEADLESS=headlesschrome
...                     EDGE=edge
...                     EDGEHEADLESS=headlessedge
...                     FIREFOX=firefox
...                     FIREFOXHEADLESS=headlessfirefox

### Ambientes
&{AMBIENTE}             QA=https://opensource-demo.orangehrmlive.com/
...                     HML=https://opensource-demo.orangehrmlive.com/
...                     PROD=https://opensource-demo.orangehrmlive.com/

### Browser capabilites
${OPTIONS}              add_argument("--disable-dev-shm-usage");
...                     add_argument("--no-sandbox");
# ...    add_argument("--start-maximized")
