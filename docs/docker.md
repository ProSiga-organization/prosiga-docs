# 🐳 Docker - Guia Completo

Este guia explica como executar o PróSiga usando Docker e Docker Compose.

## 📋 Pré-requisitos

- Docker 20.10+
- Docker Compose 2.0+

### Instalar Docker (Ubuntu/Debian)

```bash
# Atualizar pacotes
sudo apt update

# Instalar dependências
sudo apt install -y apt-transport-https ca-certificates curl software-properties-common

# Adicionar chave GPG oficial do Docker
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo gpg --dearmor -o /usr/share/keyrings/docker-archive-keyring.gpg

# Adicionar repositório do Docker
echo "deb [arch=$(dpkg --print-architecture) signed-by=/usr/share/keyrings/docker-archive-keyring.gpg] https://download.docker.com/linux/ubuntu $(lsb_release -cs) stable" | sudo tee /etc/apt/sources.list.d/docker.list > /dev/null

# Instalar Docker
sudo apt update
sudo apt install -y docker-ce docker-ce-cli containerd.io docker-compose-plugin

# Adicionar usuário ao grupo docker (para não precisar de sudo)
sudo usermod -aG docker $USER

# Reiniciar sessão ou executar
newgrp docker
```

### Verificar instalação

```bash
docker --version
docker compose version
```

## 🏗️ Estrutura dos Dockerfiles

### Backend Principal

**Arquivo**: `back-prosiga/Dockerfile`

```dockerfile
FROM python:3.10-slim

WORKDIR /app

COPY requirements.txt .
RUN pip install --no-cache-dir -r requirements.txt

COPY . .

CMD ["uvicorn", "app.main:app", "--host", "0.0.0.0", "--port", "8000"]
```

### Serviço de Autenticação

**Arquivo**: `prosiga-login/Dockerfile`

```dockerfile
FROM python:3.10-slim

WORKDIR /app

COPY requirements.txt .
RUN pip install --no-cache-dir -r requirements.txt

COPY . .

CMD ["uvicorn", "app.main:app", "--host", "0.0.0.0", "--port", "9000"]
```

## 📦 Docker Compose

### Backend Principal

**Arquivo**: `back-prosiga/docker-compose.yml`

```yaml
version: '3.8'

services:
  db:
    image: postgres:15
    environment:
      POSTGRES_USER: prosiga_user
      POSTGRES_PASSWORD: prosiga_pass
      POSTGRES_DB: prosiga_db
    ports:
      - "5432:5432"
    volumes:
      - postgres_data:/var/lib/postgresql/data
    healthcheck:
      test: ["CMD-SHELL", "pg_isready -U prosiga_user"]
      interval: 5s
      timeout: 5s
      retries: 5

  backend:
    build: .
    ports:
      - "8000:8000"
    environment:
      DB_CONNECT_URL: postgresql://prosiga_user:prosiga_pass@db:5432/prosiga_db
      AUTH_SERVICE_URL: http://auth:9000/login/me
    depends_on:
      db:
        condition: service_healthy
    volumes:
      - ./app:/app/app
    command: uvicorn app.main:app --host 0.0.0.0 --port 8000 --reload

volumes:
  postgres_data:
```

### Serviço de Autenticação

**Arquivo**: `prosiga-login/docker-compose.yml`

```yaml
version: '3.8'

services:
  auth:
    build: .
    ports:
      - "9000:9000"
    environment:
      DB_CONNECT_URL: postgresql://prosiga_user:prosiga_pass@host.docker.internal:5432/prosiga_db
      SECRET_KEY: your-secret-key-change-in-production
      ALGORITHM: HS256
      ACCESS_TOKEN_EXPIRE_MINUTES: 30
    command: uvicorn app.main:app --host 0.0.0.0 --port 9000 --reload
```

## 🚀 Como Usar

### Executar Backend com Banco de Dados

```bash
cd back-prosiga
docker-compose up --build
```

Serviços disponíveis:
- Backend API: http://localhost:8000
- PostgreSQL: localhost:5432
- Swagger Docs: http://localhost:8000/docs

### Executar Serviço de Autenticação

Em outro terminal:

```bash
cd prosiga-login
docker-compose up --build
```

Serviços disponíveis:
- Auth API: http://localhost:9000
- Swagger Docs: http://localhost:9000/docs

### Executar em Background

```bash
# Backend
cd back-prosiga
docker-compose up -d

# Auth
cd prosiga-login
docker-compose up -d
```

### Ver Logs

```bash
# Backend
docker-compose logs -f backend

# Auth
docker-compose logs -f auth

# Banco de dados
docker-compose logs -f db
```

### Parar Serviços

```bash
docker-compose down
```

### Limpar Volumes (CUIDADO: Apaga dados do banco)

```bash
docker-compose down -v
```

## 🔧 Comandos Úteis

### Acessar Container

```bash
# Backend
docker exec -it back-prosiga-backend-1 bash

# Auth
docker exec -it prosiga-login-auth-1 bash

# Banco de dados
docker exec -it back-prosiga-db-1 psql -U prosiga_user -d prosiga_db
```

### Executar Seed no Container

```bash
docker exec -it back-prosiga-backend-1 python -m app.seed
```

### Executar Testes no Container

```bash
docker exec -it back-prosiga-backend-1 pytest
```

### Reconstruir Imagens

```bash
# Reconstruir sem cache
docker-compose build --no-cache

# Reconstruir e reiniciar
docker-compose up --build --force-recreate
```

### Verificar Containers Rodando

```bash
docker ps
```

### Ver Uso de Recursos

```bash
docker stats
```

## 🌐 Docker Compose Completo (Todos os Serviços)

Para rodar todos os serviços juntos, você pode criar um arquivo `docker-compose.yml` na raiz do projeto:

```yaml
version: '3.8'

services:
  db:
    image: postgres:15
    environment:
      POSTGRES_USER: prosiga_user
      POSTGRES_PASSWORD: prosiga_pass
      POSTGRES_DB: prosiga_db
    ports:
      - "5432:5432"
    volumes:
      - postgres_data:/var/lib/postgresql/data
    healthcheck:
      test: ["CMD-SHELL", "pg_isready -U prosiga_user"]
      interval: 5s
      timeout: 5s
      retries: 5

  backend:
    build: ./back-prosiga
    ports:
      - "8000:8000"
    environment:
      DB_CONNECT_URL: postgresql://prosiga_user:prosiga_pass@db:5432/prosiga_db
      AUTH_SERVICE_URL: http://auth:9000/login/me
    depends_on:
      db:
        condition: service_healthy
    volumes:
      - ./back-prosiga/app:/app/app
    command: uvicorn app.main:app --host 0.0.0.0 --port 8000 --reload

  auth:
    build: ./prosiga-login
    ports:
      - "9000:9000"
    environment:
      DB_CONNECT_URL: postgresql://prosiga_user:prosiga_pass@db:5432/prosiga_db
      SECRET_KEY: development-secret-key
      ALGORITHM: HS256
      ACCESS_TOKEN_EXPIRE_MINUTES: 30
    depends_on:
      db:
        condition: service_healthy
    command: uvicorn app.main:app --host 0.0.0.0 --port 9000 --reload

volumes:
  postgres_data:
```

**Usar:**
```bash
docker-compose up --build
```

Todos os serviços estarão disponíveis:
- Backend: http://localhost:8000
- Auth: http://localhost:9000
- PostgreSQL: localhost:5432

## 🐛 Troubleshooting

### Erro: "port is already allocated"

```bash
# Ver processo usando a porta
sudo lsof -i :8000

# Matar processo
sudo kill -9 <PID>

# Ou mudar a porta no docker-compose.yml
ports:
  - "8001:8000"  # 8001 no host, 8000 no container
```

### Erro: "database does not exist"

```bash
# Recriar banco
docker-compose down -v
docker-compose up --build
```

### Container não inicia

```bash
# Ver logs detalhados
docker-compose logs backend

# Verificar configuração
docker-compose config
```

### Permissão negada

```bash
# Adicionar usuário ao grupo docker
sudo usermod -aG docker $USER
newgrp docker
```

## 📝 Boas Práticas

1. **Não versione senhas**: Use `.env` e adicione ao `.gitignore`
2. **Use volumes nomeados**: Para persistência de dados
3. **Defina health checks**: Para garantir ordem de inicialização
4. **Use multi-stage builds**: Para imagens menores em produção
5. **Limite recursos**: Use `deploy.resources` para limitar CPU/memória

## 🔒 Segurança

- Nunca use senhas padrão em produção
- Mantenha SECRET_KEY segura e única
- Use redes Docker isoladas
- Não exponha portas desnecessárias
- Mantenha imagens atualizadas
