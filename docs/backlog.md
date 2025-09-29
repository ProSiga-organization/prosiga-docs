# Product Backlog

O backlog do sistema foi organizado em **épicos**, que representam grandes blocos de funcionalidades. Cada épico é composto por **histórias de usuário (US)**, que descrevem de forma detalhada as necessidades dos diferentes perfis (aluno, professor, administrador e novo usuário).

---

## Organização do Backlog

O backlog está sendo estruturado e atualizado na ferramenta [Taiga](https://tree.taiga.io/project/manuvaladares-tppe/kanban). A seguir, estão listados os épicos e suas respectivas histórias de usuário.

### Épico: Gestão de Usuários e Acesso

| ID     | História de Usuário                                                                                                                                                                |
| ------ | ---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- |
| US-001 | Como novo usuário, quero realizar meu primeiro acesso informando meu perfil (Aluno, Professor ou Administrador), para que eu seja direcionado às funcionalidades adequadas ao meu papel. |
| US-002 | Como usuário cadastrado, quero acessar o sistema através de uma tela de login única, para que após a autenticação eu seja automaticamente direcionado para minha área correspondente. |
| US-003 | Como aluno em primeiro acesso, quero que o sistema gere automaticamente minha matrícula única e sequencial, para que eu tenha uma identificação oficial válida no sistema. |
| US-004 | Como usuário, quero recuperar minha senha através do meu e-mail cadastrado, para que eu possa restabelecer o acesso quando esquecer minhas credenciais. |
| US-005 | Como administrador, quero cadastrar novos usuários importando um arquivo CSV com seus dados e perfis, para que apenas usuários pré-cadastrados possam realizar o primeiro acesso ao sistema. |
| US-006 | Como administrador, quero desativar contas de usuários no sistema, para controlar o acesso e manter a segurança quando necessário. |

---

### Épico: Jornada Administrativa

| ID     | História de Usuário                                                                                                                                                                                |
| ------ | -------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- |
| US-009 | Como administrador, quero gerenciar períodos letivos (ex: 2025.1, 2025.2) abrindo e fechando matrículas, para organizar e controlar os ciclos acadêmicos da instituição. |
| US-010 | Como administrador, quero criar, editar, listar e excluir turmas por período letivo definindo professor responsável, número de vagas e critérios de aprovação, para disponibilizar disciplinas aos alunos de forma organizada. |
| US-011 | Como administrador, quero matricular alunos manualmente em turmas mesmo quando há restrições de vagas ou pré-requisitos, fornecendo justificativa, para resolver casos excepcionais e situações especiais. |
| US-012 | Como administrador, quero gerar relatórios gerenciais (lista de alunos por curso, turmas por professor, ocupação de vagas, histórico de disciplinas), para monitorar e acompanhar o funcionamento do sistema acadêmico. |
 

---

### Épico: Jornada do Aluno

| ID     | História de Usuário                                                                                                                                    |
| ------ | ------------------------------------------------------------------------------------------------------------------------------------------------------ |
| US-018 | Como aluno, quero filtrar disciplinas disponíveis por critérios (período, professor, horário, pré-requisitos), para facilitar o planejamento do meu curso e escolhas de matrícula. |
| US-019 | Como aluno, quero me matricular em disciplinas do meu curso respeitando disponibilidade de vagas, pré-requisitos cumpridos e período aberto, para progredir nos meus estudos de forma adequada. |
| US-022 | Como aluno, quero visualizar minhas notas atuais em disciplinas em andamento, para acompanhar meu desempenho acadêmico durante o semestre. |
| US-021 | Como aluno, quero exportar meu histórico acadêmico completo em formato PDF, para ter um documento oficial do meu desempenho e progresso no curso. |
| US-023 | Como aluno, quero visualizar a lista de colegas matriculados na mesma turma que eu, para conhecer minha turma e facilitar a interação acadêmica. |
| US-024 | Como aluno, quero solicitar trancamento de disciplinas dentro do prazo regulamentado, para reorganizar minha carga horária quando necessário sem prejuízos acadêmicos. |

---

### Épico: Jornada do Docente

| ID     | História de Usuário                                                                                                                 |
| ------ | ----------------------------------------------------------------------------------------------------------------------------------- |
| US-013 | Como professor, quero visualizar exclusivamente as turmas sob minha responsabilidade no período letivo atual, para focar no gerenciamento das minhas disciplinas de forma organizada. |
| US-015 | Como professor, quero lançar e atualizar as notas dos alunos das minhas turmas, para registrar e acompanhar o desempenho acadêmico de forma oficial. |
| US-016 | Como professor, quero exportar as notas dos meus alunos em formato de planilha (Excel/CSV), para facilitar análises e evitar erros de transcrição manual. |
| US-017 | Como professor, quero gerar um diário de classe em PDF contendo notas e status dos alunos por turma, para ter um relatório consolidado e oficial do desempenho da turma. |

---
