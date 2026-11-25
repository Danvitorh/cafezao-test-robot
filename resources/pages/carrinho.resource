*** Settings ***
Documentation       Page Object do Carrinho (/carrinho): itens, frete e total.
...                 Obs.: o site coloca um espaço especial entre "R$" e o valor,
...                 por isso os preços são validados com "contains".
Library             Browser


*** Variables ***
${CAR_MSG_VAZIO}            id=cart-empty-state
${CAR_CAMPO_CEP}            id=input-shipping-cep
${CAR_BOTAO_CALCULAR}       id=btn-calculate-shipping
${CAR_CIDADE_FRETE}         id=shipping-city-result
${CAR_ERRO_CEP}             id=shipping-cep-error
${CAR_VALOR_SUBTOTAL}       id=cart-subtotal-value
${CAR_VALOR_FRETE}          id=cart-shipping-value
${CAR_VALOR_TOTAL}          id=cart-total-value
${CAR_BOTAO_FINALIZAR}      id=btn-go-checkout


*** Keywords ***
# --- Itens -------------------------------------------------------------------
Validar Produto No Carrinho
    [Arguments]    ${id_produto}    ${nome}    ${preco}
    Get Text    id=cart-item-name-${id_produto}     ==          ${nome}
    Get Text    id=cart-item-price-${id_produto}    contains    ${preco}

Aumentar Quantidade No Carrinho
    [Arguments]    ${id_produto}
    Click    id=cart-btn-increase-${id_produto}

Validar Quantidade No Carrinho
    [Arguments]    ${id_produto}    ${quantidade}
    Get Property    id=cart-input-qty-${id_produto}    value    ==    ${quantidade}

Remover Produto Do Carrinho
    [Arguments]    ${id_produto}
    Click    id=cart-btn-remove-${id_produto}

Validar Carrinho Vazio
    Get Text    ${CAR_MSG_VAZIO}    ==    ${MSG_CARRINHO_VAZIO}
    Get Element States    ${CAR_BOTAO_FINALIZAR}    contains    disabled

# --- Frete -------------------------------------------------------------------
Calcular Frete
    [Arguments]    ${cep}
    Fill Text    ${CAR_CAMPO_CEP}    ${cep}
    Click        ${CAR_BOTAO_CALCULAR}

Validar Cidade Do Frete
    [Arguments]    ${cidade}
    Get Text    ${CAR_CIDADE_FRETE}    contains    ${cidade}

Validar CEP Não Encontrado
    Get Text    ${CAR_ERRO_CEP}    ==    ${MSG_CEP_NAO_ENCONTRADO}

Escolher Tipo De Frete
    [Documentation]    Opções: pac, sedex ou expresso
    [Arguments]    ${tipo}
    Click    id=shipping-opt-${tipo}

# --- Valores -----------------------------------------------------------------
Validar Subtotal
    [Arguments]    ${valor}
    Get Text    ${CAR_VALOR_SUBTOTAL}    contains    ${valor}

Validar Valor Do Frete
    [Arguments]    ${valor}
    Get Text    ${CAR_VALOR_FRETE}    contains    ${valor}

Validar Total
    [Arguments]    ${valor}
    Get Text    ${CAR_VALOR_TOTAL}    contains    ${valor}

Finalizar Compra
    Click    ${CAR_BOTAO_FINALIZAR}
    Validar Que Estou Na Página    /endereco
