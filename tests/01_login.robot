*** Settings ***
Documentation       Cenários de LOGIN.
...                 CT01 usa SÓ keywords da Browser Library (conta e senha vêm do .env).
...                 Do CT02 em diante usamos as keywords personalizadas do login.resource.
Library             Browser
Resource            ../resources/base.resource
Test Setup          Abrir O Site
Test Teardown       Fechar O Site
Test Tags           login


*** Test Cases ***
CT01 - Login válido só com keywords da Browser Library
    [Tags]    smoke
    [Setup]    NONE
    New Browser    chromium    headless=False
    New Page       https://cafezao-regional.lovable.app/login
    Wait For Load State    networkidle
    Fill Text      id=input-email       %{EMAIL_COMPRADOR}
    Fill Text      id=input-password    %{SENHA_COMPRADOR}
    Click          id=btn-login-submit
    Get Text       id=user-nickname     ==    Comprador
    [Teardown]    Close Browser

CT02 - Login válido com keywords personalizadas
    [Tags]    smoke
    Fazer Login    ${EMAIL_COMPRADOR}    ${SENHA_COMPRADOR}
    Validar Usuário Logado    ${NOME_COMPRADOR}

CT03 - Login com senha incorreta
    Fazer Login    ${EMAIL_COMPRADOR}    SenhaErrada123
    Validar Alerta De Login Inválido

CT04 - Login com e-mail não cadastrado
    Fazer Login    naoexiste@cafe.com    ${SENHA_COMPRADOR}
    Validar Alerta De Login Inválido

CT05 - Login com e-mail em branco
    Fazer Login    ${EMPTY}    ${SENHA_COMPRADOR}
    Validar Erro No Campo E-mail    ${MSG_EMAIL_VAZIO}

CT06 - Login com e-mail em formato inválido
    Fazer Login    comprador.cafe.com    ${SENHA_COMPRADOR}
    Validar Erro No Campo E-mail    ${MSG_EMAIL_INVALIDO}

CT07 - Login com senha em branco
    Fazer Login    ${EMAIL_COMPRADOR}    ${EMPTY}
    Validar Erro No Campo Senha    ${MSG_SENHA_VAZIA}

CT08 - Login com conta bloqueada
    Fazer Login    ${EMAIL_CONTA_ERRO}    ${SENHA_CONTA_ERRO}
    Validar Alerta De Login Inválido

CT09 - Logout volta para a tela de login
    Fazer Login    ${EMAIL_COMPRADOR}    ${SENHA_COMPRADOR}
    Sair Do Sistema
