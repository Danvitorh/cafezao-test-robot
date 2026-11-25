*** Settings ***
Documentation       Cenários de CARRINHO e cálculo de frete por CEP.
Library             Browser
Resource            ../resources/base.resource
Test Setup          Abrir O Site Logado
Test Teardown       Fechar O Site
Test Tags           carrinho


*** Test Cases ***
CT01 - Adicionar produto ao carrinho
    [Tags]    smoke
    Adicionar Produto Ao Carrinho    ${PRODUTO_1}
    Validar Contador Do Carrinho    1
    Ir Para O Carrinho
    Validar Produto No Carrinho    ${PRODUTO_1}    ${PRODUTO_1_NOME}    ${PRODUTO_1_PRECO}
    Validar Subtotal    32,90

CT02 - Adicionar dois produtos diferentes
    Adicionar Produto Ao Carrinho    ${PRODUTO_1}
    Adicionar Produto Ao Carrinho    ${PRODUTO_3}
    Validar Contador Do Carrinho    2
    Ir Para O Carrinho
    Validar Subtotal    107,80

CT03 - Aumentar a quantidade no carrinho atualiza o subtotal
    Adicionar Produto Ao Carrinho    ${PRODUTO_1}
    Ir Para O Carrinho
    Aumentar Quantidade No Carrinho    ${PRODUTO_1}
    Validar Quantidade No Carrinho    ${PRODUTO_1}    2
    Validar Subtotal    65,80

CT04 - Remover produto deixa o carrinho vazio
    Adicionar Produto Ao Carrinho    ${PRODUTO_1}
    Ir Para O Carrinho
    Remover Produto Do Carrinho    ${PRODUTO_1}
    Validar Carrinho Vazio

CT05 - Calcular frete com CEP válido
    Adicionar Produto Ao Carrinho    ${PRODUTO_1}
    Ir Para O Carrinho
    Calcular Frete    ${CEP_VALIDO}
    Validar Cidade Do Frete    ${CIDADE_ESPERADA}

CT06 - Escolher SEDEX soma o frete ao total
    Adicionar Produto Ao Carrinho    ${PRODUTO_1}
    Ir Para O Carrinho
    Calcular Frete    ${CEP_VALIDO}
    Escolher Tipo De Frete    sedex
    Validar Valor Do Frete    24,90
    Validar Total    57,80

CT07 - Calcular frete com CEP inexistente
    Adicionar Produto Ao Carrinho    ${PRODUTO_1}
    Ir Para O Carrinho
    Calcular Frete    ${CEP_INVALIDO}
    Validar CEP Não Encontrado
