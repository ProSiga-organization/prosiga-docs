# PróSiga - Sistema de Gerenciamento Acadêmico 

O **PróSiga** é um sistema de gerenciamento acadêmico completo projetado para facilitar a administração de cursos, matrículas, notas e usuários em instituições de ensino.

## 🌐 Links do Sistema

- **Frontend (Produção)**: [https://prosiga-frontend.vercel.app](https://prosiga-frontend.vercel.app)
- **Backend API**: [https://prosiga-backend.onrender.com](https://prosiga-backend.onrender.com)
- **Auth Service**: [https://prosiga-login.onrender.com](https://prosiga-login.onrender.com)
- **API Docs (Swagger)**: [https://prosiga-backend.onrender.com/docs](https://prosiga-backend.onrender.com/docs)

## 🎯 Visão Geral

O PróSiga oferece uma solução integrada para gestão acadêmica, atendendo às necessidades de diferentes perfis de usuários:

- **👨‍🎓 Alunos**: Matrícula em disciplinas, consulta de notas e histórico acadêmico
- **👨‍🏫 Professores**: Gerenciamento de turmas, lançamento de notas e relatórios
- **👨‍💼 Coordenadores (Admin)**: Gestão de usuários, períodos letivos e relatórios gerenciais

## 🏗️ Arquitetura do Sistema

O sistema é composto por **3 serviços independentes**:

```
┌─────────────────┐
│  Frontend       │
│  (Next.js)      │ ← Interface do usuário
│  Vercel         │
└────────┬────────┘
         │
    ┌────┴─────┐
    │          │
┌───▼──────┐ ┌─▼────────────┐
│ Backend  │ │ Auth Service │
│ (FastAPI)│ │ (FastAPI)    │
│ Render   │ │ Render       │
└────┬─────┘ └──────┬───────┘
     │              │
     └──────┬───────┘
            │
      ┌─────▼──────┐
      │ PostgreSQL │
      │ (Render)   │
      └────────────┘
```

### Componentes

1. **Frontend (Next.js 14)**
   - Framework: React com App Router
   - Estilização: Tailwind CSS + shadcn/ui
   - Deploy: Vercel (CI/CD automático)
   - Acessibilidade: VLibras integrado

2. **Backend Principal (FastAPI)**
   - API REST completa
   - SQLAlchemy ORM
   - Autenticação JWT
   - Deploy: Render

3. **Serviço de Autenticação (FastAPI)**
   - Microserviço dedicado para login
   - Geração e validação de tokens JWT
   - Hash de senhas com bcrypt
   - Deploy: Render

4. **Banco de Dados (PostgreSQL)**
   - Banco compartilhado entre serviços
   - Seed automático de dados
   - Hospedagem: Render

## Funcionalidades Principais

### Gestão de Usuários
- Cadastro de usuários via importação CSV
- Sistema de login único com direcionamento por perfil
- Recuperação de senha por email
- Controle de acesso e desativação de contas

### Administração Acadêmica
- Gerenciamento de períodos letivos
- Criação e administração de turmas
- Matrículas manuais para casos excepcionais
- Relatórios gerenciais completos

### Jornada do Aluno
- Matrícula em disciplinas com validação de pré-requisitos
- Filtros avançados para seleção de disciplinas
- Consulta de notas em tempo real
- Exportação de histórico acadêmico em PDF
- Visualização de colegas de turma
- Solicitação de trancamento de disciplinas

### Jornada do Professor
- Visualização de turmas atribuídas
- Lançamento e atualização de notas
- Exportação de notas em planilha
- Geração de diários de classe em PDF

## 🚀 Tecnologias Utilizadas

### Frontend
- Next.js 14 (App Router)
- TypeScript
- Tailwind CSS
- shadcn/ui
- Selenium WebDriver (testes E2E)

### Backend
- Python 3.10+
- FastAPI
- SQLAlchemy
- PostgreSQL
- Pydantic
- Pytest

### DevOps & Deploy
- Docker & Docker Compose
- Vercel (Frontend)
- Render (Backend + Database)
- GitHub Actions (CI/CD)

## 📖 Documentação

Esta documentação está organizada nas seguintes seções:

| Seção | Descrição |
|-------|-----------|
| **[Backlog](backlog.md)** | Product backlog completo com épicos e user stories detalhadas |
| **[Diagrama de Classes](diagrama.md)** | Diagrama lógico do sistema |
| **[Documentação do Banco de Dados](DB.md)** | Estrutura do banco de dados |
| **[Guia de Deploy](deploy.md)** | Como fazer deploy dos serviços |
| **[Guia de Testes](testes.md)** | Como executar testes E2E e unitários |
| **[Docker](docker.md)** | Como rodar o sistema com Docker |

## 🎨 Recursos Especiais

### VLibras
Sistema integrado de tradução para Libras (Língua Brasileira de Sinais), proporcionando acessibilidade para pessoas surdas.

### Upload em Lote
Coordenadores podem fazer upload de múltiplos usuários via arquivo CSV, facilitando o cadastro no início do período letivo.

### Geração de Relatórios
Exportação de dados em PDF e planilhas para análise e arquivamento.

---