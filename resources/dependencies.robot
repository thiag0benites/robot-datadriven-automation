*** Settings ***
#### Configuracoes basicas
Resource    ../config.robot
#### Biblioteca de conexão com Banco de Dados
Resource    bd.robot
#### Logs
Resource    log.robot
Resource    custom_keywords.robot
#### Pageobjects
Resource    ../pages/login_page.robot
Resource    ../pages/home_page.robot
Resource    ../pages/admin_page.robot
Resource    ../pages/user_management_page.robot
#### Components
Resource    ../components/login.robot
Resource    ../components/admin.robot


*** Variables ***
${filled_file}          false
${time_out_element}     10

# Suite registrada no gerenciador de dados
${suite}                orange
# Recebe dados do gerenciador
${data}


*** Keywords ***
Run Tests
    # ${components}    Le Lista Componentes "${suite}"
    @{rows}    Cria Lista Linhas Prontas Execucao "${suite}"

    FOR    ${row}    IN    @{rows}
        ${row}    Convert To List    ${row}
        ${data}    Seleciona massa de dados na suite "${suite}" da linha "${row}[0]"
        ${hash}    Cria Hash Dados "${suite}" Linha "${row}[0]"

        IF    "${filled file}" == "false"
            ${value_file}    Set Variable
            ...    *** Settings ***${\n}Resource${SPACE}${SPACE}../resources/dependencies.robot${\n}Test Teardown${SPACE}${SPACE}Close Browser${\n}*** Test Cases ***${\n}${data}[CASO_TESTE]${\n}
            ${filled_file}    Set Variable    true
        ELSE
            ${value_file}    Set Variable    ${value_file}${\n}${data}[CASO_TESTE]${\n}
        END

        @{components}    Split String    ${data}[COMPONENTES]    |

        FOR    ${component}    IN    @{components}
            ${value_file}    Set Variable    ${value_file}${SPACE}${SPACE}${component}${SPACE}${SPACE}${hash}${\n}
        END
    END

    IF    "${filled_file}" == "false"
        Log Console And Report    *** Não existem testes marcados para execução no Data Manager!
        Fail
    ELSE
        Create Directory    ${project_path}/tests
        Wait Until Created    ${project_path}/tests
        Create File    ${project_path}/tests/tests.robot    ${value_file}
        Wait Until Created    ${project_path}/tests/tests.robot
        ${date}    Get Current Date    result_format=%d%m%Y%H%M%S
        ${cmd}    Set Variable    robot -d ./results/${date} tests/tests.robot
        Run Command Lines    ${cmd}
    END