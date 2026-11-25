*** Settings ***
Documentation       Massa de dados dos testes. Para trocar um valor sem mexer
...                 no código: robot -v NOME_DA_VARIAVEL:novo_valor tests/


*** Variables ***
# --- Ambiente -------------------------------------------------------------
${URL_LOGIN}                https://cafezao-regional.lovable.app/login
${NAVEGADOR}                chromium
${HEADLESS}                 ${False}

# --- Usuários de teste ----------------------------------------------------
# Contas e senhas NÃO ficam no código: %{NOME} lê uma variável de ambiente
# carregada do arquivo .env (veja o .env.example e o README).
${EMAIL_COMPRADOR}          %{EMAIL_COMPRADOR}
${SENHA_COMPRADOR}          %{SENHA_COMPRADOR}
${NOME_COMPRADOR}           Comprador
${EMAIL_CONTA_ERRO}         %{EMAIL_CONTA_ERRO}
${SENHA_CONTA_ERRO}         %{SENHA_CONTA_ERRO}

# --- Produtos (o número é o id do produto na página) ----------------------
${PRODUTO_1}                1
${PRODUTO_1_NOME}           Café Arábica Sul de Minas 250g
${PRODUTO_1_PRECO}          32,90
${PRODUTO_3}                3
${PRODUTO_3_NOME}           Café em Grãos Mogiana 1kg

# --- Entrega --------------------------------------------------------------
${CEP_VALIDO}               01001000
${CEP_INVALIDO}             00000000
${CIDADE_ESPERADA}          São Paulo - SP
${NUMERO_ENDERECO}          100

# --- Pagamento (cartão FICTÍCIO de teste) ---------------------------------
${NOME_TITULAR}             Aluno Testador
${NUMERO_CARTAO}            4111111111111111
${VALIDADE_CARTAO}          12/30
${CVV_CARTAO}               123

# --- Mensagens esperadas --------------------------------------------------
${MSG_LOGIN_INVALIDO}       Usuário ou senha inválidos.
${MSG_EMAIL_VAZIO}          Informe o e-mail.
${MSG_EMAIL_INVALIDO}       E-mail inválido.
${MSG_SENHA_VAZIA}          Informe a senha.
${MSG_SEM_PRODUTOS}         Nenhum produto encontrado.
${MSG_CARRINHO_VAZIO}       Seu carrinho está vazio.
${MSG_CEP_NAO_ENCONTRADO}   CEP não encontrado.
${MSG_CEP_OBRIGATORIO}      Informe o CEP.
${MSG_SUCESSO}              Compra realizada com sucesso!
${MSG_PAGAMENTO_RECUSADO}   Pagamento recusado. Verifique os dados do cartão e tente novamente.
