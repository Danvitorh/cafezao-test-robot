*** Settings ***
Documentation       Page Object da tela de Login (/login).
Library             Browser


*** Variables ***
${LOGIN_CAMPO_EMAIL}        id=input-email
${LOGIN_CAMPO_SENHA}        id=input-password
${LOGIN_BOTAO_ENTRAR}       id=btn-login-submit
${LOGIN_ERRO_EMAIL}         id=error-email
${LOGIN_ERRO_SENHA}         id=error-password
${LOGIN_ALERTA_ERRO}        id=alert-login-error
${HEADER_NOME_USUARIO}      id=user-nickname
${HEADER_BOTAO_SAIR}        id=btn-logout


*** Keywords ***
Acessar A Página De Login
    [Documentation]    Espera o JavaScript carregar ANTES de digitar;
    ...                senão o site apaga o que foi digitado.
    Go To    ${URL_LOGIN}
    Wait For Load State    networkidle

Preencher E-mail
    [Arguments]    ${email}
    Fill Text    ${LOGIN_CAMPO_EMAIL}    ${email}

Preencher Senha
    [Arguments]    ${senha}
    Fill Text    ${LOGIN_CAMPO_SENHA}    ${senha}

Clicar Em Entrar
    Click    ${LOGIN_BOTAO_ENTRAR}

Fazer Login
    [Documentation]    Abre a tela e envia o formulário
    [Arguments]    ${email}    ${senha}
    Acessar A Página De Login
    Preencher E-mail    ${email}
    Preencher Senha     ${senha}
    Clicar Em Entrar

Validar Usuário Logado
    [Arguments]    ${nome_esperado}
    Get Text    ${HEADER_NOME_USUARIO}    ==    ${nome_esperado}
    Validar Que Estou Na Página    /

Validar Alerta De Login Inválido
    Get Text    ${LOGIN_ALERTA_ERRO}    ==    ${MSG_LOGIN_INVALIDO}

Validar Erro No Campo E-mail
    [Arguments]    ${mensagem}
    Get Text    ${LOGIN_ERRO_EMAIL}    ==    ${mensagem}

Validar Erro No Campo Senha
    [Arguments]    ${mensagem}
    Get Text    ${LOGIN_ERRO_SENHA}    ==    ${mensagem}

Sair Do Sistema
    Click    ${HEADER_BOTAO_SAIR}
    Validar Que Estou Na Página    /login
