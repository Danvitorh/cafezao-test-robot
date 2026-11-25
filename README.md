# ☕ Automação E2E — Café Regional (Robot Framework + Browser Library)

Projeto didático de automação web do site **https://cafezao-regional.lovable.app**.

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

## ▶️ Execução

```bash
source .env                                      # carrega contas e senhas (1x por terminal)
robot -d results tests/                          # tudo
robot -d results tests/01_login.robot            # uma suíte
robot -d results -i smoke tests/                 # só os smoke (1 por suíte)
robot -d results -i carrinho tests/              # por tag
robot -d results -v HEADLESS:True tests/         # sem abrir o navegador
```

