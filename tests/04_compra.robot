*** Settings ***
Documentation       Cenários de COMPRA: do carrinho até a confirmação do pedido.
Library             Browser
Resource            ../resources/base.resource
Test Setup          Abrir O Site Logado
Test Teardown       Fechar O Site
Test Tags           compra


*** Test Cases ***
CT01 - Compra com sucesso à vista
    [Tags]    smoke
    Adicionar Produto Ao Carrinho    ${PRODUTO_1}
    Ir Para O Carrinho
    Calcular Frete    ${CEP_VALIDO}
    Escolher Tipo De Frete    pac
    Finalizar Compra
    Informar Endereço De Entrega    ${CEP_VALIDO}    ${NUMERO_ENDERECO}
    Preencher Dados Do Cartão
    Clicar Em Pagar Agora
    Validar Compra Realizada Com Sucesso

CT02 - Compra com sucesso parcelada em 3x com 2 unidades
    Aumentar Quantidade No Catálogo    ${PRODUTO_1}
    Adicionar Produto Ao Carrinho    ${PRODUTO_1}
    Validar Contador Do Carrinho    2
    Ir Para O Carrinho
    Finalizar Compra
    Informar Endereço De Entrega    ${CEP_VALIDO}    ${NUMERO_ENDERECO}
    Preencher Dados Do Cartão    parcelas=3
    Clicar Em Pagar Agora
    Validar Compra Realizada Com Sucesso

CT03 - Após a compra o carrinho fica vazio
    Adicionar Produto Ao Carrinho    ${PRODUTO_1}
    Ir Para O Carrinho
    Finalizar Compra
    Informar Endereço De Entrega    ${CEP_VALIDO}    ${NUMERO_ENDERECO}
    Preencher Dados Do Cartão
    Clicar Em Pagar Agora
    Validar Compra Realizada Com Sucesso
    Validar Contador Do Carrinho    0

CT04 - Endereço sem CEP não avança
    Adicionar Produto Ao Carrinho    ${PRODUTO_1}
    Ir Para O Carrinho
    Finalizar Compra
    Clicar Em Ir Para Pagamento
    Validar Erro No CEP Do Endereço    ${MSG_CEP_OBRIGATORIO}

CT05 - Pagamento com campos em branco
    Adicionar Produto Ao Carrinho    ${PRODUTO_1}
    Ir Para O Carrinho
    Finalizar Compra
    Informar Endereço De Entrega    ${CEP_VALIDO}    ${NUMERO_ENDERECO}
    Clicar Em Pagar Agora
    Validar Erros Dos Campos Do Cartão

CT06 - Pagamento recusado pela operadora
    Adicionar Produto Ao Carrinho    ${PRODUTO_1}
    Ir Para O Carrinho
    Finalizar Compra
    Informar Endereço De Entrega    ${CEP_VALIDO}    ${NUMERO_ENDERECO}
    Preencher Dados Do Cartão    titular=Cliente erro
    Clicar Em Pagar Agora
    Validar Pagamento Recusado
