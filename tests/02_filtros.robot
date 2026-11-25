*** Settings ***
Documentation       Cenários de BUSCA e FILTROS do catálogo (15 produtos).
Library             Browser
Resource            ../resources/base.resource
Test Setup          Abrir O Site Logado
Test Teardown       Fechar O Site
Test Tags           filtros


*** Test Cases ***
CT01 - Catálogo exibe todos os produtos
    [Tags]    smoke
    Validar Quantidade De Produtos Na Tela    15

CT02 - Filtrar por região Sul de Minas
    Marcar Filtro    filter-region-sul-minas
    Aplicar Filtros
    Validar Quantidade De Produtos Na Tela    4
    Validar Produto Na Tela    ${PRODUTO_1}    ${PRODUTO_1_NOME}

CT03 - Filtrar por tipo Café em Cápsula
    Marcar Filtro    filter-type-capsula
    Aplicar Filtros
    Validar Quantidade De Produtos Na Tela    2

CT04 - Filtrar por torra clara
    Escolher Torra    filter-roast-light
    Aplicar Filtros
    Validar Quantidade De Produtos Na Tela    3

CT05 - Combinar região Mogiana com torra escura
    Marcar Filtro     filter-region-mogiana
    Escolher Torra    filter-roast-dark
    Aplicar Filtros
    Validar Quantidade De Produtos Na Tela    1

CT06 - Filtro sem resultado mostra mensagem
    Marcar Filtro    filter-region-espirito-santo
    Marcar Filtro    filter-type-descafeinado
    Aplicar Filtros
    Validar Quantidade De Produtos Na Tela    0
    Validar Mensagem Sem Produtos

CT07 - Limpar filtros volta a mostrar tudo
    Marcar Filtro    filter-region-sul-minas
    Aplicar Filtros
    Validar Quantidade De Produtos Na Tela    4
    Limpar Filtros
    Validar Quantidade De Produtos Na Tela    15

CT08 - Buscar produto pelo nome
    Buscar Produto    Cappuccino
    Validar Quantidade De Produtos Na Tela    2
