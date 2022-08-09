*** Settings ***
Resource    ../config.robot

*** Keywords ***
Log Console And Report
    [Arguments]    ${msg}
    Log    ${msg}
    Log To Console    ${msg}

Passed Log
    [Arguments]    ${msg}
    Log Console And Report    ${msg}

Failure Log
    [Arguments]    ${msg}
    Run Keyword And Continue On Failure    Fail    ${msg}
