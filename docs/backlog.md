# Product Backlog

O backlog do sistema foi organizado em **épicos**, que representam grandes blocos de funcionalidades. Cada épico é composto por **histórias de usuário (US)**, que descrevem de forma detalhada as necessidades dos diferentes perfis (aluno, professor, administrador e novo usuário).

---

## Organização do Backlog

O backlog está sendo estruturado e atualizado na ferramenta [Taiga](https://tree.taiga.io/project/manuvaladares-tppe/kanban). A seguir, estão listados os épicos e suas respectivas histórias de usuário.

### Épico: Gestão de Usuários e Acesso

| ID     | História de Usuário                                                                                                                                                                |
| ------ | ---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- |
| US-001 | Como usuário, quero realizar o primeiro acesso no sistema com informações específicas do meu perfil (Aluno, Professor ou Administrador), para que eu possa acessar as funcionalidades adequadas. |
| US-002 | Como usuário, quero acessar o sistema através de uma tela de login única, para que após a autenticação eu seja direcionado automaticamente para minha área correspondente.         |
| US-003 | Como aluno, quero que o sistema gere automaticamente minha matrícula única e sequencial no momento do priemeiro acesso, para que eu tenha uma identificação oficial no sistema.            |
| US-004 | Como usuário, quero recuperar minha senha através de e-mail, para que eu possa restabelecer o acesso em caso de esquecimento.                                                      |
| US-005 | Como administrador, quero cadastrar novos usuários no sistema, para garantir a segurança e manter os acessos atualizados.     |

---

### Épico: Jornada Administrativa

| ID     | História de Usuário                                                                                                                                                                                |
| ------ | -------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- |
| US-009 | Como administrador, quero gerenciar os períodos letivos (ex: 2025.1, 2025.2), abrindo e fechando-os para matrícula, para organizar os ciclos acadêmicos.                                           |
| US-010 | Como administrador, quero criar, editar, listar e excluir turmas em cada período letivo, definindo professor, vagas e critérios de aprovação, para disponibilizar as disciplinas aos alunos.       |
| US-011 | Como administrador, quero matricular alunos manualmente em turmas, ignorando regras de vagas e pré-requisitos com justificativa, para resolver exceções.                                            |
| US-012 | Como administrador, quero emitir relatórios gerenciais (lista de alunos por curso, turmas por professor, ocupação de vagas, histórico de disciplinas), para acompanhar o funcionamento do sistema. |
 

---

### Épico: Jornada do Aluno

| ID     | História de Usuário                                                                                                                                    |
| ------ | ------------------------------------------------------------------------------------------------------------------------------------------------------ |
| US-018 | Como aluno, quero filtrar as disciplinas ao me matricular, para planejar meu curso.                                      |
| US-019 | Como aluno, quero me matricular em disciplinas do meu curso, desde que haja vaga, pré-requisitos cumpridos e período aberto, para avançar nos estudos. |
| US-022 | Como aluno, quero visualizar minhas notas em disciplinas em andamento, para acompanhar meu progresso.                                                  |
| US-021 | Como aluno, quero exportar meu histórico acadêmico em PDF, para acompanhar meu desempenho ao longo do curso.                                           |
| US-023 | Como aluno, quero listar os colegas matriculados na mesma turma, para saber quem estuda comigo.                                                        |
| US-024 | Como aluno, quero solicitar o trancamento de disciplinas dentro do prazo estabelecido, para reorganizar minha carga horária no semestre.               |

---

### Épico: Jornada do Docente

| ID     | História de Usuário                                                                                                                 |
| ------ | ----------------------------------------------------------------------------------------------------------------------------------- |
| US-013 | Como professor, quero visualizar apenas as turmas atribuídas a mim no período letivo atual, para organizar meu trabalho acadêmico.  |
| US-015 | Como professor, quero lançar as notas dos alunos da turma, para acompanhar o desempenho acadêmico.                                  |
| US-016 | Como professor, quero exportar as notas dos meus alunos para uma planilha, para evitar erros manuais.                               |
| US-017 | Como professor, quero emitir um diário por turma (notas e status) em PDF, para ter um relatório consolidado do desempenho da turma. |

---
