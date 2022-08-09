*** Settings ***
Resource    ../resources/dependencies.robot


*** Keywords ***
admin
    [Arguments]    &{data}
    Click Link    ${link_admin}
    Wait Until Element Is Visible And Capture Screenshot    ${btn_add}    ${time_out_element}
    Perform Click Element    ${btn_add}
    Wait Until Element Is Visible And Capture Screenshot     ${select_user_role}    ${time_out_element}