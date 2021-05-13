# projects-UAL
Neste repositório disponibilizo alguns dos trabalhos que realizei no âmbito da minha Licenciatura em Engenharia Informática na Universiade Autónoma de Lisboa.
Neste ficheiro descreve-se cada trabalho, servindo de índice para o repostitório.

In this repository are some of the projects I took part in during my Bachelor in Software Engineering @ Universidade Autónoma de Lisboa.
In this file I describe each project to serve as an index for the repository.



  PT

  Arquitetura de Computadores (AC) - Assembly MIPS

Nesta disciplina o professor apresentou um código (em assembly mips) que criava uma grelha em memória com um aspecto visual de um quadrado com 0s e 1s gerada aleatoriamente.
Nessa grelha era inserida uma forma geométrica específica (padrão de 1s predeterminado para cada grupo) que cada grupo tinha de detetar.
Havia um objectivo opcional que era mostrar a mesma coisa mas na ferramenta BitMap do simulador Mars MIPS (que foi o ambiente de desenvolvimento) que também foi conseguido.
É necessário alterar as definições de tamanho dos pixeis, Unit Width = 16 e Unit Height = 16.


  Algoritmos e Estruturas de Dados (AED) - Python
  
Neste projecto fez-se uma pequena aplicação com menus em linha de comandos que geria frotas.
O objectivo era aplicar os conhecimentos de Programação Orientada a Objectos e estruturas de dados estudados em aula como árvores e filas.


  Modelação de Base de Dados (MBD) - SQL

Primeira interação com bases de dados e SGBDs. Foi desenvolvido com auxílio do sistema Oracle APEX oferecido pela universidade.
Neste projecto simulava-se a criação de uma base de dados para uma entidade de segurança rodoviária que apontava diversas restrições para o que queria que fosse guardado.


  Sistemas Operativos (SO) - C
 
Aplicação do método de Monte Carlo para determinar o valor de PI e fazendo um estudo da aplicação do mesmo método com uma quantidade diferente de threads.
Gera pontos dentro de um quadrado de lado 1 e depois verifica se estes estão incluidos num circulo de raio 1 inserido no quadrado.


  Aplicação de Bases de Dados (ABD) - SQL
  
Em seguimento à unidade curricular de MBD expande-se a utilização do sistema Oracle APEX. Desta vez aplicada a Hollywood.
Utiliza triggers e funções em PLSQL.


   Inteligência Artificial (IA) - Python

Implementação dos algoritmos Naive Bayes, AC-3 e Percetrão em Python através do pseudo-código.
AC-3 aplicado a um jogo de sudoku. Naive Bayes e percetrão aplicados de modo a criar sistemas de deteção de e-mails spam.


  Sistemas Distribuidos e Paralelos (SDP)
  
  Lab2 - Java
  
No segundo laboratório desta UC o objectivo era criar uma estrutura de dados distribuída com um nó principal, que controla a rede e participa nela, e nós participantes que participam. Cada nó tem uma tabela de dispersão (map/HashMap).
O cliente do nó principal pede que algo seja guardado (ao nó principal) e este, utilizando uma função de hash, determina em que participante aquela informação é guardada.

  ProjFinal - Java, PostgreSQL, Node.js, HTML, CSS
  
Para o projecto final o objectivo era criar uma API REST, que servia uma base de dados a uma página web, sendo que todos estes componentes estão em máquinas diferentes.
A base de dados foi criada com PostgreSQL.
A API utiliza Wildfly para os serviços http e interage com a BD através de JDBC e as respetivas drivers para PostgreSQL.
A página web interage com a api através de node.js. A página mostra o conteúdo de algumas das tabelas da base de dados.
