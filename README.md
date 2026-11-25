# ☕ Automação E2E — Café Regional (Robot Framework + Browser Library)

Projeto didático de automação web do site **https://cafezao-regional.lovable.app**.

**Regras do projeto (para a turma):**
- Todas as keywords personalizadas são montadas **somente com keywords da Browser Library**
  (`New Browser`, `New Page`, `Go To`, `Fill Text`, `Click`, `Check Checkbox`,
  `Select Options By`, `Get Text`, `Get Property`, `Get Element Count`, `Get Url`, …).
- Elementos localizados **só por `id=`** (e um `css=` simples para contar os cards).
- Padrão **Page Object**: um arquivo `.resource` por tela, com *Variables* (elementos) e *Keywords* (ações).

## 📁 Estrutura

```
cafe-regional-robot/
├── tests/
│   ├── 01_login.robot           # 9 cenários
│   ├── 02_filtros.robot         # 8 cenários
│   ├── 03_carrinho_cep.robot    # 7 cenários
│   └── 04_compra.robot          # 6 cenários
├── resources/
│   ├── base.resource            # Library Browser + imports + abrir/fechar
│   ├── data/dados.resource      # massa de dados e mensagens esperadas
│   └── pages/
│       ├── login.resource
│       ├── catalogo.resource
│       ├── carrinho.resource
│       ├── endereco.resource
│       ├── pagamento.resource
│       └── sucesso.resource
├── requirements.txt
└── results/
```

## 🧪 Cenários (30)

| Suíte | Cenários |
|---|---|
| **Login** | sucesso só com keywords da Browser Library · sucesso com keywords personalizadas · senha incorreta · e-mail não cadastrado · e-mail em branco · e-mail inválido · senha em branco · conta bloqueada · logout |
| **Filtros** | todos os produtos (15) · região Sul de Minas (4) · tipo cápsula (2) · torra clara (3) · Mogiana + torra escura (1) · sem resultado (0 + mensagem) · limpar filtros · busca por nome |
| **Carrinho + CEP** | adicionar · dois produtos · aumentar quantidade · remover (carrinho vazio) · CEP válido · SEDEX soma no total · CEP inexistente |
| **Compra** | sucesso à vista · sucesso 3x com 2 unidades · carrinho zera após compra · endereço sem CEP · pagamento em branco · pagamento recusado |

## ⚙️ Instalação

```bash
python -m venv .venv
source .venv/bin/activate          # Windows: .venv\Scripts\activate
pip install -r requirements.txt
rfbrowser init chromium            # baixa o Playwright (precisa do Node.js)
```

## 🔐 Contas e senhas fora do código

Contas (e-mails) e senhas **não** ficam nos arquivos `.robot`/`.resource`. Elas são lidas de variáveis de ambiente
com a sintaxe do Robot `%{NOME}` (ex.: `${SENHA_COMPRADOR}    %{SENHA_COMPRADOR}`).

1. Copie o modelo: `cp .env.example .env` e preencha contas e senhas no `.env`.
2. Antes de rodar, carregue as variáveis no terminal:
   - macOS / Linux: `source .env`
   - Windows (PowerShell): `$env:EMAIL_COMPRADOR='...'`, `$env:SENHA_COMPRADOR='...'`,
     `$env:EMAIL_CONTA_ERRO='...'` e `$env:SENHA_CONTA_ERRO='...'`
3. Rode normalmente: `robot -d results tests/`

O `.env` está no `.gitignore`, então **não sobe para o GitHub**. Se a variável não estiver
carregada, o Robot avisa: `Environment variable '%{SENHA_COMPRADOR}' not found`.

No **GitHub Actions**, cadastre contas e senhas em *Settings › Secrets and variables › Actions*
e passe para o job:

```yaml
    env:
      EMAIL_COMPRADOR: ${{ secrets.EMAIL_COMPRADOR }}
      SENHA_COMPRADOR: ${{ secrets.SENHA_COMPRADOR }}
      EMAIL_CONTA_ERRO: ${{ secrets.EMAIL_CONTA_ERRO }}
      SENHA_CONTA_ERRO: ${{ secrets.SENHA_CONTA_ERRO }}
```

## ▶️ Execução

```bash
source .env                                      # carrega contas e senhas (1x por terminal)
robot -d results tests/                          # tudo
robot -d results tests/01_login.robot            # uma suíte
robot -d results -i smoke tests/                 # só os smoke (1 por suíte)
robot -d results -i carrinho tests/              # por tag
robot -d results -v HEADLESS:True tests/         # sem abrir o navegador
```

## 📌 Detalhes do site que viram aula

- **Esperar o JavaScript carregar:** o site é React. Se o robô digitar antes do carregamento terminar,
  os campos são apagados. Por isso, depois de `New Page` / `Go To` usamos `Wait For Load State    networkidle`.

- **Preço com espaço especial:** o site escreve `R$ 32,90` com um espaço não separável
  entre `R$` e o número. Por isso os preços são validados com `contains 32,90`.
- **Frete:** depois do CEP aparecem PAC (R$ 14,90), SEDEX (R$ 24,90) e Expressa (R$ 39,90).
- **Pagamento recusado:** nome do titular contendo `erro`.
- **Conta bloqueada:** a conta `EMAIL_CONTA_ERRO` do `.env` sempre falha no login.
- **CEP inexistente:** `00000000` → "CEP não encontrado.".
- Cada teste abre um **contexto novo** (`New Context`), então o carrinho começa vazio.

## 🏋️ Exercícios sugeridos

1. Filtrar por faixa de preço.
2. Escolher a entrega Expressa e validar o total.
3. Testar o cadastro (`/cadastro`).
4. Transformar os cenários negativos de login em um **Test Template**.
