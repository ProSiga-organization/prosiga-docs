# 🚀 Deploy - Guia Completo

Este guia explica como fazer deploy do PróSiga em produção.

## 🌐 Arquitetura de Deploy

```
GitHub Repos
     │
     ├─► prosiga-front ────► Vercel ────► https://prosiga-frontend.vercel.app
     │
     ├─► back-prosiga ─────► Render ────► https://prosiga-backend.onrender.com
     │
     └─► prosiga-login ────► Render ────► https://prosiga-login.onrender.com
                                │
                                └─► PostgreSQL (Render)
```

## 📦 Frontend - Vercel

### Preparação

1. **Crie conta na Vercel**: [vercel.com](https://vercel.com)
2. **Conecte GitHub**: Autorize acesso aos repositórios
3. **Importe projeto**: Selecione `prosiga-front`

### Configuração

**Framework Preset**: Next.js

**Build Command**:
```bash
npm run build
```

**Output Directory**: `.next`

**Install Command**:
```bash
npm install
```

### Variáveis de Ambiente

Configure em: Settings → Environment Variables

```env
NEXT_PUBLIC_API_BACKEND_URL=https://prosiga-backend.onrender.com
NEXT_PUBLIC_API_AUTH_URL=https://prosiga-login.onrender.com
```

### Deploy

**Automático**:
- Push para `main` → Deploy em produção
- Pull Request → Preview deployment

**Manual**:
```bash
# Instalar Vercel CLI
npm i -g vercel

# Deploy
cd prosiga-front
vercel --prod
```

### Custom Domain (Opcional)

1. Settings → Domains
2. Adicione seu domínio
3. Configure DNS conforme instruções

### Monitoramento

- **Analytics**: Vercel Analytics integrado
- **Logs**: Real-time logs no dashboard
- **Performance**: Web Vitals automáticos

## 🐍 Backend - Render

### Preparação

1. **Crie conta no Render**: [render.com](https://render.com)
2. **Conecte GitHub**: Autorize acesso aos repositórios

### Deploy do Backend Principal

#### 1. Criar PostgreSQL Database

1. New → PostgreSQL
2. Configure:
   - **Name**: prosiga-db
   - **Database**: prosiga_db
   - **User**: prosiga_db_user
   - **Region**: Oregon (ou mais próximo)
   - **Plan**: Free

3. Copie as connection strings:
   - **Internal Database URL**: Usado pelos serviços no Render
   - **External Database URL**: Usado para conexões externas (pgAdmin)

#### 2. Criar Web Service (Backend)

1. New → Web Service
2. Conecte repositório: `back-prosiga`
3. Configure:

**Configurações básicas:**
- **Name**: prosiga-backend
- **Region**: Oregon (mesmo do banco)
- **Branch**: main
- **Runtime**: Python 3

**Build & Deploy:**
- **Build Command**:
  ```bash
  pip install -r requirements.txt
  ```
- **Start Command**:
  ```bash
  uvicorn app.main:app --host 0.0.0.0 --port $PORT
  ```

**Environment Variables:**
```env
DB_CONNECT_URL=<Internal Database URL do PostgreSQL>
AUTH_SERVICE_URL=https://prosiga-login.onrender.com/login/me
PYTHON_VERSION=3.10.0
```

4. Create Web Service

### Deploy do Serviço de Autenticação

#### Criar Web Service (Auth)

1. New → Web Service
2. Conecte repositório: `prosiga-login`
3. Configure:

**Configurações básicas:**
- **Name**: prosiga-login
- **Region**: Oregon (mesmo do banco)
- **Branch**: main
- **Runtime**: Python 3

**Build & Deploy:**
- **Build Command**:
  ```bash
  pip install -r requirements.txt
  ```
- **Start Command**:
  ```bash
  uvicorn app.main:app --host 0.0.0.0 --port $PORT
  ```

**Environment Variables:**
```env
DB_CONNECT_URL=<Internal Database URL do PostgreSQL>
SECRET_KEY=<gere uma chave secreta segura>
ALGORITHM=HS256
ACCESS_TOKEN_EXPIRE_MINUTES=30
PYTHON_VERSION=3.10.0
```

**Gerar SECRET_KEY**:
```python
import secrets
print(secrets.token_urlsafe(32))
```

4. Create Web Service

### Verificar Deploy

Aguarde o build completar (5-10 minutos primeira vez).

**Testar endpoints:**

```bash
# Backend
curl https://prosiga-backend.onrender.com/

# Auth
curl https://prosiga-login.onrender.com/

# Swagger
# https://prosiga-backend.onrender.com/docs
# https://prosiga-login.onrender.com/docs
```

### Executar Seed

O seed é executado automaticamente na inicialização.

Para executar manualmente via shell (plano pago):
```bash
python -m app.seed
```

Alternativa (conectar localmente):
```bash
# Usar External Database URL
export DB_CONNECT_URL="<External Database URL>"
cd back-prosiga
python -m app.seed
```

### Monitoramento Render

- **Logs**: Dashboard → Logs (real-time)
- **Metrics**: CPU, Memory, Response time
- **Health Checks**: Configurar em Settings

## 🔄 CI/CD com GitHub Actions

### Frontend

**Arquivo**: `.github/workflows/frontend.yml`

```yaml
name: Frontend CI/CD

on:
  push:
    branches: [main]
    paths:
      - 'prosiga-front/**'
  pull_request:
    branches: [main]
    paths:
      - 'prosiga-front/**'

jobs:
  lint:
    runs-on: ubuntu-latest
    steps:
      - uses: actions/checkout@v3
      - uses: actions/setup-node@v3
        with:
          node-version: '18'
      - name: Install dependencies
        run: |
          cd prosiga-front
          npm ci
      - name: Lint
        run: |
          cd prosiga-front
          npm run lint
      
  test:
    runs-on: ubuntu-latest
    steps:
      - uses: actions/checkout@v3
      - uses: actions/setup-node@v3
        with:
          node-version: '18'
      - name: Install dependencies
        run: |
          cd prosiga-front
          npm ci
      - name: Run tests
        run: |
          cd prosiga-front
          npm run test:e2e
```

### Backend

**Arquivo**: `.github/workflows/backend.yml`

```yaml
name: Backend CI/CD

on:
  push:
    branches: [main]
    paths:
      - 'back-prosiga/**'
  pull_request:
    branches: [main]
    paths:
      - 'back-prosiga/**'

jobs:
  test:
    runs-on: ubuntu-latest
    
    services:
      postgres:
        image: postgres:15
        env:
          POSTGRES_USER: test_user
          POSTGRES_PASSWORD: test_pass
          POSTGRES_DB: test_db
        ports:
          - 5432:5432
        options: >-
          --health-cmd pg_isready
          --health-interval 10s
          --health-timeout 5s
          --health-retries 5
    
    steps:
      - uses: actions/checkout@v3
      
      - name: Set up Python
        uses: actions/setup-python@v4
        with:
          python-version: '3.10'
      
      - name: Install dependencies
        run: |
          cd back-prosiga
          pip install -r requirements.txt
      
      - name: Run tests
        env:
          DB_CONNECT_URL: postgresql://test_user:test_pass@localhost:5432/test_db
        run: |
          cd back-prosiga
          pytest --cov=app
      
      - name: Upload coverage
        uses: codecov/codecov-action@v3
        with:
          file: ./back-prosiga/coverage.xml
```

## 🗄️ Banco de Dados

### Backup

**Render Dashboard**:
1. Databases → prosiga-db
2. Backups → Create Backup

**Via CLI**:
```bash
# Fazer backup
pg_dump -h <host> -U prosiga_db_user -d prosiga_db > backup.sql

# Restaurar
psql -h <host> -U prosiga_db_user -d prosiga_db < backup.sql
```

### Migrações

Para mudanças no schema:

```bash
# Criar migração (Alembic)
cd back-prosiga
alembic revision --autogenerate -m "descrição"

# Aplicar migração
alembic upgrade head
```

### Conectar via pgAdmin

1. Abra pgAdmin
2. Add New Server:
   - **Name**: ProSiga Production
   - **Host**: (copiar do External Database URL)
   - **Port**: 5432
   - **Database**: prosiga_db
   - **Username**: prosiga_db_user
   - **Password**: (copiar do External Database URL)
   - **SSL Mode**: Require

## 🔐 Segurança

### Checklist

- [ ] Variáveis de ambiente configuradas (não hardcoded)
- [ ] SECRET_KEY única e segura
- [ ] CORS configurado corretamente
- [ ] Senhas hasheadas (bcrypt)
- [ ] HTTPS habilitado (Vercel/Render fazem automaticamente)
- [ ] Rate limiting configurado
- [ ] Backup do banco configurado
- [ ] Logs sendo monitorados

### Variáveis Sensíveis

**NUNCA commitar**:
- `.env`
- `.env.local`
- Senhas
- Tokens
- Secret keys

**Usar**:
- Variáveis de ambiente da plataforma
- GitHub Secrets (para CI/CD)
- Gerenciadores de secrets (AWS Secrets Manager, etc.)

## 📊 Monitoramento

### Logs

**Vercel**:
- Dashboard → Projeto → Logs
- Real-time logs
- Filtros por deployment

**Render**:
- Dashboard → Service → Logs
- Real-time tail
- Download histórico

### Alertas

Configure em Render:
- Falhas de deploy
- Uso de recursos
- Downtime
- Erros de aplicação

### Performance

**Vercel Analytics**:
- Web Vitals automáticos
- Core Web Vitals
- Tempo de resposta

**Render Metrics**:
- CPU usage
- Memory usage
- Response time
- Request count

## 🐛 Troubleshooting

### Build falha na Vercel

```bash
# Testar build localmente
cd prosiga-front
npm run build

# Ver logs detalhados
vercel logs <deployment-url>
```

### Deploy falha no Render

```bash
# Ver logs de build
# Dashboard → Service → Events

# Verificar requirements.txt
pip install -r requirements.txt

# Verificar variáveis de ambiente
# Settings → Environment
```

### Erro de conexão com banco

- Verificar DB_CONNECT_URL
- Confirmar que banco está running
- Usar Internal URL para serviços Render
- Usar External URL para acesso externo

### CORS errors

Verificar configuração no backend:

```python
app.add_middleware(
    CORSMiddleware,
    allow_origin_regex=r"https?://(localhost|.*\.vercel\.app)(:\d+)?",
    allow_credentials=True,
    allow_methods=["*"],
    allow_headers=["*"],
)
```

### 502 Bad Gateway

- Serviço pode estar iniciando (aguarde 1-2 minutos)
- Verificar se porta está correta (`$PORT`)
- Ver logs para erros de inicialização

## 💰 Custos

### Vercel (Frontend)

- **Hobby (Free)**:
  - 100 GB bandwidth/mês
  - Builds ilimitados
  - Preview deployments ilimitados
  - Ideal para desenvolvimento

### Render (Backend + DB)

- **Free Tier**:
  - Web Service: $0 (spins down após inatividade)
  - PostgreSQL: $0 (90 dias, depois $7/mês)
  - 750 horas/mês grátis

- **Starter ($7/mês cada)**:
  - Sem spin down
  - PostgreSQL 1GB RAM

## 📝 Checklist de Deploy

### Antes do Deploy

- [ ] Código testado localmente
- [ ] Testes passando (E2E + unitários)
- [ ] Variáveis de ambiente documentadas
- [ ] README atualizado
- [ ] Logs de debug removidos
- [ ] Secrets não commitados

### Durante o Deploy

- [ ] Variáveis de ambiente configuradas
- [ ] Build command correto
- [ ] Start command correto
- [ ] Região selecionada (mesma para todos)
- [ ] Seed executado

### Após o Deploy

- [ ] Testar endpoints manualmente
- [ ] Verificar autenticação
- [ ] Testar fluxo completo
- [ ] Configurar monitoramento
- [ ] Documentar URLs de produção
- [ ] Criar backup do banco
