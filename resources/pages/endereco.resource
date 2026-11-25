*** Settings ***
Documentation       Page Object do Endereço de entrega (/endereco).
Library             Browser


*** Variables ***
${END_CAMPO_CEP}            id=input-address-cep
${END_BOTAO_BUSCAR_CEP}     id=btn-address-cep-search
${END_ERRO_CEP}             id=error-address-cep
${END_CAMPO_RUA}            id=input-address-street
${END_CAMPO_NUMERO}         id=input-address-number
${END_BOTAO_PAGAMENTO}      id=btn-address-submit


*** Keywords ***
Buscar Endereço Pelo CEP
    [Documentation]    Busca e ESPERA a rua ser preenchida
    [Arguments]    ${cep}
    Fill Text       ${END_CAMPO_CEP}    ${cep}
    Click           ${END_BOTAO_BUSCAR_CEP}
    Get Property    ${END_CAMPO_RUA}    value    !=    ${EMPTY}

Preencher Número
    [Arguments]    ${numero}
    Fill Text    ${END_CAMPO_NUMERO}    ${numero}

Clicar Em Ir Para Pagamento
    Click    ${END_BOTAO_PAGAMENTO}

Validar Erro No CEP Do Endereço
    [Arguments]    ${mensagem}
    Get Text    ${END_ERRO_CEP}    ==    ${mensagem}

Informar Endereço De Entrega
    [Documentation]    Keyword de alto nível da tela de endereço.
    [Arguments]    ${cep}    ${numero}
    Buscar Endereço Pelo CEP    ${cep}
    Preencher Número    ${numero}
    Clicar Em Ir Para Pagamento
    Validar Que Estou Na Página    /pagamento
