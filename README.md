# PróSiga Docs

Documentação oficial do Sistema de Gerenciamento Acadêmico PróSiga.

## 📖 Conteúdo

- **Início**: Visão geral do sistema e arquitetura
- **Backlog**: Product backlog com épicos e user stories
- **Diagrama de Classes**: Modelo lógico do sistema
- **Banco de Dados**: Estrutura e relacionamentos do banco
- **Docker**: Guia completo para rodar com Docker
- **Deploy**: Guia de deploy em produção (Vercel + Render)
- **Testes**: Como executar testes E2E e unitários

## 🌐 Acesso Online

A documentação está disponível em:
**https://prosiga-organization.github.io/prosiga-docs/**

## 🚀 Visualizar Localmente

### Pré-requisitos

```bash
pip install mkdocs-material
```

### Executar servidor local

```bash
mkdocs serve
```

Acesse: http://localhost:8000

### Gerar site estático

```bash
mkdocs build
```

Os arquivos serão gerados na pasta `site/`.

## 📁 Estrutura

```
prosiga-docs/
├── docs/                       # Arquivos Markdown
│   ├── index.md               # Página inicial
│   ├── backlog.md             # Product backlog
│   ├── diagrama.md            # Diagrama de classes
│   ├── DB.md                  # Documentação do banco
│   ├── docker.md              # Guia Docker
│   ├── deploy.md              # Guia de deploy
│   ├── testes.md              # Guia de testes
│   └── assets/                # Imagens e recursos
├── site/                       # Site gerado (não versionar)
├── mkdocs.yml                 # Configuração do MkDocs
└── README.md
```

## ✏️ Contribuir

### Adicionar nova página

1. Crie arquivo `.md` em `docs/`
2. Adicione no `mkdocs.yml`:
   ```yaml
   nav:
     - Nova Página: nova-pagina.md
   ```
3. Build e visualize:
   ```bash
   mkdocs serve
   ```

### Markdown Extensions

O projeto usa:
- **Admonitions**: Blocos de nota/aviso/info
- **Code highlighting**: Syntax highlight para código
- **Emoji**: :rocket: :fire: :tada:
- **Tables**: Tabelas Markdown
- **Footnotes**: Notas de rodapé
- **MathJax**: Equações matemáticas

### Exemplos

**Admonition:**
```markdown
!!! note "Título"
    Conteúdo da nota
```

**Código:**
````markdown
```python
def hello():
    print("Hello!")
```
````

**Tabela:**
```markdown
| Coluna 1 | Coluna 2 |
|----------|----------|
| Valor 1  | Valor 2  |
```

## 🎨 Tema

- **Material for MkDocs**: Tema moderno e responsivo
- **Light/Dark mode**: Alternância automática
- **Busca integrada**: Busca full-text
- **Navigation**: Navegação por tabs e índice

## 🚀 Deploy Automático

O deploy é feito automaticamente via GitHub Actions quando há push para `main`.

**Workflow**: `.github/workflows/deploy.yml`

```yaml
name: Deploy Docs
on:
  push:
    branches:
      - main
jobs:
  deploy:
    runs-on: ubuntu-latest
    steps:
      - uses: actions/checkout@v3
      - uses: actions/setup-python@v4
        with:
          python-version: 3.x
      - run: pip install mkdocs-material
      - run: mkdocs gh-deploy --force
```

## 🔗 Links Úteis

- **Frontend**: https://prosiga-frontend.vercel.app
- **Backend API**: https://prosiga-backend.onrender.com
- **Auth Service**: https://prosiga-login.onrender.com
- **API Docs**: https://prosiga-backend.onrender.com/docs

## 📝 Licença

Este projeto é parte do sistema acadêmico PróSiga.
