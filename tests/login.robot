*** Settings ***
Documentation     Testes de Login

Resource          ../resources/base.resource

Test Setup       Start session
Test Teardown    Finish session

*** Test Cases ***
Deve Logar com sucesso

  Input Text       xpath=//*[@resource-id="apiIp"]       192.168.15.3
  Click Element    xpath=//*[@resource-id="signInButton"] 

  Wait Until Page Contains    Minhas tarefas    5
