*** Settings ***
Documentation       Page Object do Catálogo (página inicial "/"): busca,
...                 filtros e botão de adicionar ao carrinho.
Library             Browser


*** Variables ***
${CAT_CAMPO_BUSCA}          id=input-search-product
${CAT_BOTAO_BUSCAR}         id=btn-search-product
${CAT_BOTAO_APLICAR}        id=btn-apply-filters
${CAT_BOTAO_LIMPAR}         id=btn-clear-filters
${CAT_CARDS_PRODUTOS}       css=#products-grid article
${CAT_MSG_SEM_PRODUTOS}     id=products-empty-state
${HEADER_LINK_CARRINHO}     id=nav-link-cart
${HEADER_CONTADOR}          id=cart-count-badge


*** Keywords ***
# --- Busca e filtros ---------------------------------------------------------
Buscar Produto
    [Arguments]    ${termo}
    Fill Text    ${CAT_CAMPO_BUSCA}    ${termo}
    Click        ${CAT_BOTAO_BUSCAR}

Marcar Filtro
    [Documentation]    Marca um checkbox de filtro. Ex.: filter-region-mogiana
    [Arguments]    ${id_do_filtro}
    Check Checkbox    id=${id_do_filtro}

Escolher Torra
    [Documentation]    Ex.: filter-roast-light, filter-roast-medium, filter-roast-dark
    [Arguments]    ${id_da_torra}
    Click    id=${id_da_torra}

Aplicar Filtros
    Click    ${CAT_BOTAO_APLICAR}

Limpar Filtros
    Click    ${CAT_BOTAO_LIMPAR}

Validar Quantidade De Produtos Na Tela
    [Arguments]    ${quantidade}
    Get Element Count    ${CAT_CARDS_PRODUTOS}    ==    ${quantidade}

Validar Mensagem Sem Produtos
    Get Text    ${CAT_MSG_SEM_PRODUTOS}    ==    ${MSG_SEM_PRODUTOS}

Validar Produto Na Tela
    [Arguments]    ${id_produto}    ${nome}
    Get Text    id=product-name-${id_produto}    ==    ${nome}

# --- Carrinho a partir do catálogo -------------------------------------------
Aumentar Quantidade No Catálogo
    [Arguments]    ${id_produto}
    Click    id=btn-increase-qty-${id_produto}

Adicionar Produto Ao Carrinho
    [Arguments]    ${id_produto}
    Click    id=btn-add-to-cart-${id_produto}

Validar Contador Do Carrinho
    [Arguments]    ${quantidade}
    Get Text    ${HEADER_CONTADOR}    ==    ${quantidade}

Ir Para O Carrinho
    Click    ${HEADER_LINK_CARRINHO}
    Validar Que Estou Na Página    /carrinho
