*** Settings ***
Documentation       Recurso base: Browser Library, massa de dados e páginas.
...                 Todo arquivo de teste importa APENAS este arquivo.
Library             Browser
Resource            data/dados.resource
Resource            pages/login.resource
Resource            pages/catalogo.resource
Resource            pages/carrinho.resource
Resource            pages/endereco.resource
Resource            pages/pagamento.resource
Resource            pages/sucesso.resource


*** Keywords ***
Abrir O Site
    [Documentation]    Navegador novo + contexto limpo (sem cookies e sem
    ...                carrinho salvo) + tela de login da loja.
    ...                networkidle = espera o site terminar de carregar o JavaScript.
    New Browser    ${NAVEGADOR}    headless=${HEADLESS}
    New Context
    New Page       ${URL_LOGIN}
    Wait For Load State    networkidle

Abrir O Site Logado
    [Documentation]    Abre o site e já faz login com o comprador.
    Abrir O Site
    Fazer Login    ${EMAIL_COMPRADOR}    ${SENHA_COMPRADOR}
    Validar Usuário Logado    ${NOME_COMPRADOR}

Fechar O Site
    Take Screenshot
    Close Browser

Validar Que Estou Na Página
    [Documentation]    Confere se a URL termina com o caminho informado.
    [Arguments]    ${caminho}
    Get Url    $=    ${caminho}
