# 🧪 Testes - Guia Completo

Este guia explica como executar todos os tipos de testes do PróSiga.

## 📋 Tipos de Testes

### 1. Testes E2E (End-to-End) com Selenium
### 2. Testes Unitários com Pytest
### 3. Testes de Integração

## 🎭 Testes E2E com Selenium

Os testes E2E simulam a interação real do usuário com o navegador.

### Pré-requisitos

- Node.js 18+
- Chrome/Chromium instalado
- ChromeDriver compatível

### Instalação

```bash
cd prosiga-front
npm install
```

As dependências de teste já estão no `package.json`:
- `selenium-webdriver`
- `@types/selenium-webdriver`
- `chromedriver`
- `jest`
- `@types/jest`
- `ts-jest`

### Estrutura dos Testes

```
prosiga-front/tests/
├── setup.ts                    # Configuração do Selenium
├── e2e/
│   ├── login.test.ts          # Testes de autenticação
│   └── navigation.test.ts     # Testes de navegação
└── README.md
```

### Executar Testes

**Rodar todos os testes E2E:**
```bash
npm run test:e2e
```

**Rodar teste específico:**
```bash
npm test tests/e2e/login.test.ts
```

**Rodar em modo watch:**
```bash
npm run test:watch
```

### Configuração

Os testes rodam por padrão contra **produção** (`https://prosiga-frontend.vercel.app`).

Para testar localmente, edite `tests/setup.ts`:

```typescript
// Local
testSetup = new TestSetup('http://localhost:3000')

// Produção
testSetup = new TestSetup('https://prosiga-frontend.vercel.app')
```

### Modo Visual vs Headless

Por padrão, os testes abrem o navegador para você acompanhar (modo visual).

Para rodar sem interface (headless), edite `tests/setup.ts`:

```typescript
async initialize() {
  const options = new chrome.Options()
  options.addArguments('--headless')  // Adicione esta linha
  options.addArguments('--no-sandbox')
  // ...
}
```

### Credenciais de Teste

Os testes usam:
- **Email**: `bruno@email.com`
- **Senha**: `teste-bruno`

Para mudar, edite `tests/e2e/login.test.ts`:

```typescript
const email = 'seu@email.com'
const password = 'sua_senha'
```

### Testes Implementados

#### Login (login.test.ts)

1. ✅ Carrega a página de login
2. ✅ Testa credenciais inválidas (exibe erro)
3. ✅ Faz login com credenciais válidas
4. ✅ Redireciona para dashboard correto

#### Navegação (navigation.test.ts)

1. ✅ Navega para página inicial
2. ✅ Verifica presença do widget VLibras

### Criar Novos Testes

```typescript
import { By, until } from 'selenium-webdriver'
import { TestSetup } from '../setup'

describe('Meu Teste', () => {
  let testSetup: TestSetup

  beforeAll(async () => {
    testSetup = new TestSetup('https://prosiga-frontend.vercel.app')
    await testSetup.initialize()
  })

  afterAll(async () => {
    await testSetup.quit()
  })

  test('Deve fazer algo específico', async () => {
    const driver = testSetup.driver!
    await testSetup.navigateTo('/pagina')
    await driver.sleep(2000)

    // Encontrar elemento
    const button = await driver.findElement(By.css('.meu-botao'))
    await button.click()

    // Verificar resultado
    const resultado = await driver.findElement(By.css('.resultado'))
    const texto = await resultado.getText()
    expect(texto).toContain('sucesso')

    await driver.sleep(2000)
  })
})
```

### Seletores Úteis

```typescript
// Por ID
By.css('#elemento-id')
By.id('elemento-id')

// Por classe
By.css('.minha-classe')

// Por atributo
By.css('input[type="email"]')
By.css('button[type="submit"]')

// Por texto
By.xpath("//button[contains(text(), 'Login')]")

// Múltiplos seletores
By.css('input#email, input[type="email"]')
```

### Waits e Timeouts

```typescript
// Aguardar elemento aparecer
const element = await driver.wait(
  until.elementLocated(By.css('.elemento')),
  10000  // timeout em ms
)

// Aguardar elemento ser clicável
await driver.wait(until.elementIsVisible(element), 5000)

// Sleep simples
await driver.sleep(2000)

// Aguardar URL mudar
await driver.wait(until.urlContains('/dashboard'), 10000)
```

### Troubleshooting E2E

**Erro: ChromeDriver version mismatch**

```bash
# Verificar versão do Chrome
google-chrome --version

# Instalar ChromeDriver compatível
npm install --save-dev chromedriver@<versao>
```

**Erro: Element not found**

- Aumentar timeout
- Adicionar `await driver.sleep()` antes de buscar elemento
- Verificar se o seletor está correto
- Verificar se a página carregou completamente

**Teste passa localmente mas falha em produção**

- Verificar variáveis de ambiente
- Confirmar que dados de teste existem no banco de produção
- Aumentar timeouts (produção pode ser mais lenta)

## 🧪 Testes Unitários com Pytest

Os testes unitários testam funções e classes isoladamente.

### Pré-requisitos

```bash
cd back-prosiga
pip install -r requirements.txt
```

### Estrutura dos Testes

```
back-prosiga/app/
├── aviso/
│   └── test_aviso.py
├── matricula/
│   └── test_matricula.py
├── periodo_letivo/
│   └── test_periodo_letivo.py
└── test_main.py
```

### Executar Testes

**Rodar todos os testes:**
```bash
pytest
```

**Rodar com saída detalhada:**
```bash
pytest -v
```

**Rodar teste específico:**
```bash
pytest app/matricula/test_matricula.py
```

**Rodar função específica:**
```bash
pytest app/matricula/test_matricula.py::test_criar_matricula
```

**Rodar com cobertura:**
```bash
pytest --cov=app
```

**Rodar com relatório de cobertura HTML:**
```bash
pytest --cov=app --cov-report=html
# Abrir htmlcov/index.html no navegador
```

### Configuração

**Arquivo**: `pytest.ini`

```ini
[pytest]
testpaths = app
python_files = test_*.py
python_classes = Test*
python_functions = test_*
addopts = -v --tb=short
```

### Exemplo de Teste

```python
from fastapi.testclient import TestClient
from app.main import app

client = TestClient(app)

def test_criar_periodo_letivo():
    """Testa criação de período letivo"""
    response = client.post(
        "/periodos-letivos",
        json={
            "nome": "2025.1",
            "data_inicio": "2025-03-01",
            "data_fim": "2025-06-30"
        }
    )
    assert response.status_code == 201
    data = response.json()
    assert data["nome"] == "2025.1"
    assert "id" in data

def test_listar_periodos():
    """Testa listagem de períodos"""
    response = client.get("/periodos-letivos")
    assert response.status_code == 200
    assert isinstance(response.json(), list)
```

### Fixtures

Fixtures são funções que fornecem dados para os testes:

```python
import pytest
from sqlalchemy.orm import Session
from app.database import SessionLocal

@pytest.fixture
def db():
    """Fornece uma sessão de banco para testes"""
    db = SessionLocal()
    try:
        yield db
    finally:
        db.close()

@pytest.fixture
def sample_curso(db: Session):
    """Cria um curso de exemplo"""
    curso = Curso(codigo="TEST", nome="Teste")
    db.add(curso)
    db.commit()
    db.refresh(curso)
    return curso

def test_com_fixture(db: Session, sample_curso):
    """Teste usando fixtures"""
    cursos = db.query(Curso).all()
    assert len(cursos) >= 1
    assert sample_curso.codigo == "TEST"
```

### Mocks

Para testar sem dependências externas:

```python
from unittest.mock import Mock, patch

def test_com_mock():
    """Testa com mock"""
    mock_db = Mock()
    mock_db.query().filter().first.return_value = None
    
    # Seu código aqui
    resultado = alguma_funcao(mock_db)
    
    assert resultado is None
    mock_db.query.assert_called_once()
```

### Cobertura de Testes

**Ver cobertura no terminal:**
```bash
pytest --cov=app --cov-report=term-missing
```

**Gerar relatório HTML:**
```bash
pytest --cov=app --cov-report=html
xdg-open htmlcov/index.html  # Linux
```

Meta: Manter cobertura acima de 80%

## 🔄 Testes de Integração

Testam a interação entre componentes.

### Exemplo

```python
def test_fluxo_completo_matricula():
    """Testa fluxo completo de matrícula"""
    client = TestClient(app)
    
    # 1. Criar período
    periodo = client.post("/periodos-letivos", json={...}).json()
    
    # 2. Criar turma
    turma = client.post("/turmas", json={
        "id_periodo": periodo["id"],
        ...
    }).json()
    
    # 3. Fazer matrícula
    response = client.post("/matriculas", json={
        "id_turma": turma["id"],
        "id_aluno": 1
    })
    
    assert response.status_code == 201
    
    # 4. Verificar matrícula
    matriculas = client.get(f"/matriculas/aluno/1").json()
    assert len(matriculas) == 1
```

## 🐳 Testes com Docker

### Executar testes no container

```bash
# Backend
docker exec -it back-prosiga-backend-1 pytest

# Com cobertura
docker exec -it back-prosiga-backend-1 pytest --cov=app
```

## 📊 Relatórios

### Gerar relatório JUnit (para CI/CD)

```bash
pytest --junitxml=report.xml
```

### Gerar relatório de cobertura

```bash
pytest --cov=app --cov-report=xml
```

## 🎯 Boas Práticas

### Testes E2E

1. ✅ Use IDs ou data-testid para seletores estáveis
2. ✅ Adicione sleeps para aguardar animações
3. ✅ Teste cenários de erro além do happy path
4. ✅ Limpe dados de teste após execução
5. ✅ Use fixtures para setup/teardown

### Testes Unitários

1. ✅ Um teste, uma asserção (quando possível)
2. ✅ Nomes descritivos (test_deve_criar_usuario_com_sucesso)
3. ✅ Arrange, Act, Assert (AAA pattern)
4. ✅ Teste casos de erro
5. ✅ Use mocks para dependências externas
6. ✅ Mantenha testes rápidos

## 🚀 CI/CD

### GitHub Actions

Exemplo de workflow:

```yaml
name: Tests

on: [push, pull_request]

jobs:
  backend-tests:
    runs-on: ubuntu-latest
    steps:
      - uses: actions/checkout@v2
      - name: Set up Python
        uses: actions/setup-python@v2
        with:
          python-version: '3.10'
      - name: Install dependencies
        run: |
          cd back-prosiga
          pip install -r requirements.txt
      - name: Run tests
        run: |
          cd back-prosiga
          pytest --cov=app

  frontend-e2e:
    runs-on: ubuntu-latest
    steps:
      - uses: actions/checkout@v2
      - name: Setup Node
        uses: actions/setup-node@v2
        with:
          node-version: '18'
      - name: Install dependencies
        run: |
          cd prosiga-front
          npm install
      - name: Run E2E tests
        run: |
          cd prosiga-front
          npm run test:e2e
```

## 📈 Métricas de Qualidade

- **Cobertura de código**: > 80%
- **Tempo de execução**: < 5 minutos (unitários)
- **Taxa de sucesso**: > 95%
- **Testes flaky**: 0 (testes instáveis devem ser corrigidos)
