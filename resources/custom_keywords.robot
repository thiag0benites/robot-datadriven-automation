*** Settings ***
Resource    ../config.robot
Resource    log.robot


*** Keywords ***
Wait Until Element Is Visible And Capture Screenshot
    [Documentation]    Verifica se elemento é visível e retorna status "True/False".
    ...    "timeout" assume 5 segundos se não for definido
    ...    Para capturar imagem definir o parâmetro "screenshot" como "True".
    [Arguments]    ${element}    ${timeout}=5
    ${visible}    Run Keyword And Return Status    Wait Until Element Is Visible    ${element}    ${timeout}
    Capture Page Screenshot
    IF    ${visible} == True
        Passed Log     Visible "${element}" element
    ELSE
        Fail    Element "${element}" not visible after ${timeout} seconds
    END

Wait Until Element Is Visible And Return Status
    [Documentation]    Verifica se elemento é visível e retorna status "True/False".
    ...    "timeout" assume 5 segundos se não for definido
    ...    Para capturar imagem definir o parâmetro "screenshot" como "True".
    [Arguments]    ${element}    ${timeout}=5    ${screenshot}=False
    ${visible}    Run Keyword And Return Status    Wait Until Element Is Visible    ${element}    ${timeout}
    IF    ${screenshot} == True    Capture Page Screenshot
    [Return]   ${visible}

Perform Click Element
    [Documentation]    Efetua click no elemento.
    ...    Para capturar imagem definir o parâmetro "screenshot" como "True".
    [Arguments]    ${element}    ${screenshot}=False
    ${visible}    Wait Until Element Is Visible And Return Status    ${element}

    IF    ${visible} == True
        Click Element    ${element}
    ELSE
        Failure Log    Unable to click on element "${element}"
    END

    IF    ${screenshot} == True    Capture Page Screenshot

Fill Field
    [Documentation]    Preenche input com texto.
    ...    Para capturar imagem definir o parâmetro "screenshot" como "True".
    [Arguments]    ${element}    ${text}    ${screenshot}=False
    ${visible}    Wait Until Element Is Visible And Return Status    ${element}

    IF    ${visible} == True
        Input Text    ${element}    ${text}
    ELSE
        Failure Log    Unable to fill in "${element}" field
    END

    IF    ${screenshot} == True    Capture Page Screenshot
