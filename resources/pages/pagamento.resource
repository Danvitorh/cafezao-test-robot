*** Settings ***
Documentation       Page Object do Pagamento (/pagamento).
...                 Regra do site: nome do titular com "erro" = pagamento recusado.
Library             Browser


*** Variables ***
${PAG_CAMPO_NOME}           id=input-card-name
${PAG_CAMPO_NUMERO}         id=input-card-number
${PAG_CAMPO_VALIDADE}       id=input-card-expiry
${PAG_CAMPO_CVV}            id=input-card-cvv
${PAG_SELECT_PARCELAS}      id=input-installments
${PAG_BOTAO_PAGAR}          id=btn-payment-submit
${PAG_ALERTA_ERRO}          id=alert-payment-error
${PAG_ERRO_NOME}            id=error-card-name
${PAG_ERRO_NUMERO}          id=error-card-number
${PAG_ERRO_VALIDADE}        id=error-card-expiry
${PAG_ERRO_CVV}             id=error-card-cvv


*** Keywords ***
Preencher Dados Do Cartão
    [Arguments]    ${titular}=${NOME_TITULAR}    ${parcelas}=1
    Fill Text            ${PAG_CAMPO_NOME}        ${titular}
    Fill Text            ${PAG_CAMPO_NUMERO}      ${NUMERO_CARTAO}
    Fill Text            ${PAG_CAMPO_VALIDADE}    ${VALIDADE_CARTAO}
    Fill Text            ${PAG_CAMPO_CVV}         ${CVV_CARTAO}
    Select Options By    ${PAG_SELECT_PARCELAS}    value    ${parcelas}

Clicar Em Pagar Agora
    Click    ${PAG_BOTAO_PAGAR}

Validar Pagamento Recusado
    Get Text    ${PAG_ALERTA_ERRO}    ==    ${MSG_PAGAMENTO_RECUSADO}
    Validar Que Estou Na Página    /pagamento

Validar Erros Dos Campos Do Cartão
    Get Text    ${PAG_ERRO_NOME}        ==    Informe o nome do titular.
    Get Text    ${PAG_ERRO_NUMERO}      ==    Número de cartão inválido.
    Get Text    ${PAG_ERRO_VALIDADE}    ==    Validade inválida (MM/AA).
    Get Text    ${PAG_ERRO_CVV}         ==    CVV inválido.
