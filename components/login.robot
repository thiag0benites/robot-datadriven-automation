*** Settings ***
Resource    ../resources/dependencies.robot


*** Keywords ***
login
    [Arguments]    &{data}
    Log To Console            ${EMPTY}
    Log To Console            ---------------------------------------------------
    Log Console And Report    *** Ambiente: ${AMBIENTE.PROD}
    Log Console And Report    *** Browser: ${data}[BROWSER]
    Log Console And Report    *** Local Execução: ${LOCAL_EXECUCAO}
    Log To Console            ---------------------------------------------------

    IF    "${LOCAL_EXECUCAO}" == "SELENOID"
        # ${remote_url}    Set Variable    http://automacao.local:4444/wd/hub
        ${remote_url}    Set Variable    http://localhost:4444/wd/hub
        &{desired_caps}    Create Dictionary    name=browser.test    enableVNC=${True}    enableVideo=${True}
        # Open Browser    ${AMBIENTE.PROD}    ${BROWSER.CHROME}    None    remote_url=${remote_url}   desired_capabilities=${desired_caps}  
        Open Browser    ${AMBIENTE.PROD}    ${data}[BROWSER]    None    remote_url=${remote_url}   desired_capabilities=${desired_caps}
    ELSE IF    "${LOCAL_EXECUCAO}" == "LOCAL"
        Open Browser    ${AMBIENTE.PROD}    ${data}[BROWSER]    ${OPTIONS} 
    END

    Maximize Browser Window
    Fill Field    ${input_username}    ${data}[login_user]
    Fill Field    ${input_password}    ${data}[login_pass]    True
    Perform Click Element   ${btn_login}

    IF    "${data}[login_msg_esperada]" == ""
        Wait Until Element Is Visible And Capture Screenshot    ${div_welcome}    ${time_out_element}
    ELSE
        ${present}    Wait Until Element Is Visible And Return Status    ${span_msg}    ${time_out_element}    True

        IF    ${present} == True
            ${current_msg}    Get Text    ${span_msg}

            IF    "${current_msg}" == "${data}[login_msg_esperada]"
                Passed Log    *** Mensagem esperada foi apresentada: ${current_msg}
            ELSE IF    "${current_msg}" != "${data}[login_msg_esperada]"
                Failure Log    *** Mensagem diferente do esperado | Esperado: ${data}[login_msg_esperada] | Obtido: ${current_msg}
            END
        END
    END