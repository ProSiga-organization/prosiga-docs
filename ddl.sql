-- Criação dos tipos ENUM (específico do PostgreSQL)
CREATE TYPE "StatusContaEnum" AS ENUM ('ATIVO', 'INATIVO', 'NOVO');
CREATE TYPE "StatusAprovacaoEnum" AS ENUM ('APROVADO', 'REPROVADO', 'TRANCADO', 'EM_CURSO');

-- Tabela: cursos
CREATE TABLE cursos (
    id SERIAL PRIMARY KEY,
    codigo VARCHAR(20) NOT NULL UNIQUE,
    nome VARCHAR(100) NOT NULL
);

-- Tabela: disciplinas
CREATE TABLE disciplinas (
    id SERIAL PRIMARY KEY,
    codigo VARCHAR(20) NOT NULL UNIQUE,
    nome VARCHAR(100) NOT NULL,
    descricao TEXT,
    semestre_ideal INTEGER
);

-- Tabela: periodos_letivos
CREATE TABLE periodos_letivos (
    id SERIAL PRIMARY KEY,
    ano INTEGER NOT NULL,
    semestre INTEGER NOT NULL,
    inicio_matricula DATE,
    fim_matricula DATE,
    fim_trancamento DATE
);

-- Tabela: usuarios (combina Usuario, Aluno, Professor, Coordenador)
CREATE TABLE usuarios (
    id SERIAL PRIMARY KEY,
    cpf VARCHAR(11) NOT NULL UNIQUE,
    nome VARCHAR(100) NOT NULL,
    email VARCHAR(100) UNIQUE,
    senha_hash VARCHAR(255) NOT NULL,
    status "StatusContaEnum" DEFAULT 'NOVO',
    tipo_usuario VARCHAR(50) NOT NULL,
    
    -- Colunas de Aluno
    matricula VARCHAR(20) UNIQUE,
    id_curso INTEGER,
    
    -- Constraints
    CONSTRAINT fk_usuarios_curso FOREIGN KEY(id_curso) REFERENCES cursos(id)
);

-- Tabela: turmas
CREATE TABLE turmas (
    id SERIAL PRIMARY KEY,
    codigo VARCHAR(20) NOT NULL UNIQUE,
    vagas INTEGER NOT NULL,
    horario VARCHAR(100),
    local VARCHAR(100),
    id_disciplina INTEGER NOT NULL,
    id_professor INTEGER NOT NULL,
    id_periodo_letivo INTEGER NOT NULL,
    
    -- Constraints
    CONSTRAINT fk_turmas_disciplina FOREIGN KEY(id_disciplina) REFERENCES disciplinas(id),
    CONSTRAINT fk_turmas_professor FOREIGN KEY(id_professor) REFERENCES usuarios(id),
    CONSTRAINT fk_turmas_periodo_letivo FOREIGN KEY(id_periodo_letivo) REFERENCES periodos_letivos(id)
);

-- Tabela: avisos
CREATE TABLE avisos (
    id SERIAL PRIMARY KEY,
    titulo VARCHAR(255) NOT NULL,
    conteudo TEXT,
    data_publicacao TIMESTAMPTZ DEFAULT CURRENT_TIMESTAMP,
    id_autor INTEGER NOT NULL,
    id_turma INTEGER,
    id_curso INTEGER,
    
    -- Constraints
    CONSTRAINT fk_avisos_autor FOREIGN KEY(id_autor) REFERENCES usuarios(id),
    CONSTRAINT fk_avisos_turma FOREIGN KEY(id_turma) REFERENCES turmas(id),
    CONSTRAINT fk_avisos_curso FOREIGN KEY(id_curso) REFERENCES cursos(id)
);

-- Tabela: matriculas (Tabela de associação)
CREATE TABLE matriculas (
    id_aluno INTEGER NOT NULL,
    id_turma INTEGER NOT NULL,
    nota_final FLOAT,
    status "StatusAprovacaoEnum" DEFAULT 'EM_CURSO',
    
    -- Constraints
    PRIMARY KEY (id_aluno, id_turma),
    CONSTRAINT fk_matriculas_aluno FOREIGN KEY(id_aluno) REFERENCES usuarios(id),
    CONSTRAINT fk_matriculas_turma FOREIGN KEY(id_turma) REFERENCES turmas(id) ON DELETE CASCADE
);

-- Tabela: avaliacoes_turma
CREATE TABLE avaliacoes_turma (
    id SERIAL PRIMARY KEY,
    nome VARCHAR(100) NOT NULL,
    id_turma INTEGER NOT NULL,
    
    -- Constraints
    CONSTRAINT fk_avaliacoes_turma_turma FOREIGN KEY(id_turma) REFERENCES turmas(id) ON DELETE CASCADE,
    UNIQUE (id_turma, nome) -- Constraint: _turma_nome_uc
);

-- Tabela: notas_avaliacoes
CREATE TABLE notas_avaliacoes (
    id SERIAL PRIMARY KEY,
    nota FLOAT,
    id_avaliacao_turma INTEGER NOT NULL,
    id_matricula_aluno INTEGER NOT NULL,
    id_matricula_turma INTEGER NOT NULL,
    
    -- Constraints
    CONSTRAINT fk_notas_avaliacao_turma FOREIGN KEY(id_avaliacao_turma) REFERENCES avaliacoes_turma(id) ON DELETE CASCADE,
    CONSTRAINT fk_notas_matricula FOREIGN KEY(id_matricula_aluno, id_matricula_turma) REFERENCES matriculas(id_aluno, id_turma) ON DELETE CASCADE,
    UNIQUE (id_avaliacao_turma, id_matricula_aluno) -- Constraint: _aluno_avaliacao_uc
);