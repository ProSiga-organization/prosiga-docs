

Para representar o sistema **ProSiga**, foram elaborados dois diagramas com propósitos distintos e complementares:

1. **Diagrama de Classes Lógico**
   Este diagrama descreve as principais entidades do sistema, seus atributos, relacionamentos e especializações. Ele evidencia como os elementos fundamentais, como **Usuário**, **Aluno**, **Professor**, **Coordenador**, **Curso**, **Disciplina**, **Turma**, **Matrícula** e **Período Letivo**, se relacionam entre si. <br>
   <iframe frameborder="0" style="width:100%;height:1013px;" src="https://viewer.diagrams.net/?tags=%7B%7D&lightbox=1&highlight=0000ff&edit=_blank&layers=1&nav=1&title=ProSiga.drawio&transparent=1&dark=auto#Uhttps%3A%2F%2Fdrive.google.com%2Fuc%3Fid%3D1I-k8KKUcJ-9vpvbw7Zf8W_7wMUfyQMsn%26export%3Ddownload" allowtransparency="true"></iframe>

2. **Diagrama Arquitetural (MVC)**
   O segundo diagrama tem como objetivo mostrar a **organização arquitetural do sistema** de acordo com o padrão **Model-View-Controller (MVC)**. Nele, as classes foram distribuídas em três pacotes principais:

    **Model**: contém as entidades do sistema e suas regras de negócio.

    **Controller**: concentra a lógica de controle, como autenticação, matrícula e exportação de relatórios.

    **View**: representa a interface do usuário, com as telas de login, aluno, professor e coordenador.

    Essa separação reforça a modularidade e a independência entre as camadas, destacando como as **views** interagem apenas com os **controllers**, que por sua vez manipulam os **models**. <br>
    <iframe frameborder="0" style="width:100%;height:1221px;" src="https://viewer.diagrams.net/?tags=%7B%7D&lightbox=1&highlight=0000ff&edit=_blank&layers=1&nav=1&title=ProSiga.drawio&page-id=8XxgSxSN-SDqZBF82btg&transparent=1&dark=auto#Uhttps%3A%2F%2Fdrive.google.com%2Fuc%3Fid%3D1I-k8KKUcJ-9vpvbw7Zf8W_7wMUfyQMsn%26export%3Ddownload" allowtransparency="true"></iframe>
