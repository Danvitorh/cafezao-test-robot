*** Settings ***
Documentation       Page Object da Confirmação do pedido (/sucesso).
Library             Browser


*** Variables ***
${SUC_TITULO}               id=success-title
${SUC_NUMERO_PEDIDO}        id=success-order-number
${SUC_BOTAO_VOLTAR}         id=btn-back-to-home


*** Keywords ***
Validar Compra Realizada Com Sucesso
    Validar Que Estou Na Página    /sucesso
    Get Text    ${SUC_TITULO}           ==          ${MSG_SUCESSO}
    Get Text    ${SUC_NUMERO_PEDIDO}    contains    Pedido #

Voltar Para A Loja
    Click    ${SUC_BOTAO_VOLTAR}
    Validar Que Estou Na Página    /
