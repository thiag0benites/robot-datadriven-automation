##################################################################################################################################
# Autor: Thiago Benites
# Decrição: Conexão com banco de dados MySql
##################################################################################################################################
*** Settings ***
### Configurações iniciais 
Resource    ../config.robot

*** Variables ***
${dbname}                ${DATAMANAGER.DBNAME}
${dbuser}                ${DATAMANAGER.DBUSER}
${dbpassword}            ${DATAMANAGER.DBPASSWORD}
# ${dbhost}                automacao.local
${dbhost}                ${DATAMANAGER.DBHOST}
# ${dbport}                3307
${dbport}                ${DATAMANAGER.DBPORT}

@{queryResults}

*** Keywords ***
Conectar ao Banco de Dados
    ## MySQL
    # Connect to Database      dbapiModuleName=PyMySQL     dbName=robot        dbUsername=root        dbPassword=${senha}        dbHost=localhost        dbPort=3306
    Connect To Database     pymysql     ${dbname}       ${dbuser}       ${dbpassword}     ${dbhost}       ${dbport}

Desconectar do Banco de Dados
    Disconnect From Database

Seleciona toda massa de dados da tabela "${tabela}"
    @{queryResults}        Query        SELECT * FROM ${tabela}
    Log Many               @{queryResults}

Seleciona massa de dados na suite "${suite}" do caso de teste "${filtro}"
    Conectar ao Banco de Dados
    @{colunas}            Description                 SELECT * FROM ${suite}
    @{valores}            Query                       SELECT * FROM ${suite} WHERE PRONTO = 'sim' AND CASO_TESTE = '${filtro}' LIMIT 1
    ${dados}              Cria Dicionario De Dados    ${colunas}    ${valores}
    Desconectar do Banco de Dados
    [Return]              ${dados}

Cria Lista Linhas Prontas Execucao "${suite}"
    Conectar ao Banco de Dados
    @{rows}            Query                       SELECT id FROM ${suite} WHERE PRONTO = 'sim'
    Desconectar do Banco de Dados
    [Return]              @{rows}

Seleciona massa de dados na suite "${suite}" da linha "${filtro}"
    Conectar ao Banco de Dados
    @{colunas}            Description                 SELECT * FROM ${suite}
    @{valores}            Query                       SELECT * FROM ${suite} WHERE PRONTO = 'sim' AND ID = '${filtro}' LIMIT 1
    ${dados}              Cria Dicionario De Dados    ${colunas}    ${valores}
    Desconectar do Banco de Dados
    [Return]              ${dados}

Cria Hash Dados "${suite}" Linha "${filtro}"
    Conectar ao Banco de Dados
    @{colunas}            Description                 SELECT * FROM ${suite}
    @{valores}            Query                       SELECT * FROM ${suite} WHERE PRONTO = 'sim' AND ID = '${filtro}' LIMIT 1
    ${dados}              Cria Dicionario De Dados Robot    ${colunas}    ${valores}
    Desconectar do Banco de Dados
    [Return]              ${dados}

Seleciona massa de dados na suite "${suite}" CT "${filtro}"
    Conectar ao Banco de Dados
    @{colunas}            Description                 SELECT * FROM ${suite}
    @{valores}            Query                       SELECT * FROM ${suite} WHERE PRONTO = 'sim' AND CASO_TESTE = '${filtro}' LIMIT 1
    ${dados}              Cria Dicionario De Dados    ${colunas}    ${valores}
    Desconectar do Banco de Dados
    [Return]              ${dados}

Altera massa de dados da "${suite}", linha "${id_linha}", coluna "${coluna}", valor "${valor}"
    Conectar ao Banco de Dados
    Execute Sql String        UPDATE ${suite} SET ${coluna} = '${valor}' WHERE id = '${id_linha}'
    Desconectar do Banco de Dados

Le Lista Componentes "${suite}"
    Conectar ao Banco de Dados
    @{colunas}            Description                 SELECT * FROM ${suite}
    ${components}         Cria Dicionario Componentes    ${colunas}
    Desconectar do Banco de Dados
    [Return]              ${components}