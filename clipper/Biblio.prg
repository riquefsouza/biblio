/*
  Nome : Sistema de Automacao de Biblioteca (Biblio)
  Autor : Henrique Figueiredo de Souza
  Linguagem : Clipper
  Compilador : clipper
  Ligador : linker
  Data de Realizacao : 4 de setembro de 1999
  Ultima Atualizacao : 15 de fevereiro de 2000
  Versao do Sistema : 1.0
  Nome do(s) Arquivo(s) e Como Compilar (nesta ordem) :
  1. Biblio.prg --> "clipper biblio.prg /b"
                    "rtlink file biblio"

  Descricao :
  O Sistema e composto dos seguintes modulos:
  1.Modulo de Livros da Biblioteca
    Onde se realiza a manutencao dos livros da biblioteca
  2.Modulo de Usuarios da Bilioteca
    Onde se realiza a manutencao dos usuarios da biblioteca
  3.Modulo de Emprestimos e Devolucoes da Biblioteca
    Onde se efetua os emprestimos e devolucoes da biblioteca
  4.Modulo de Opcoes do sistema
    Onde e possivel ver sobre o sistema e sair dele
*/
/* programa Biblio */

#include "Biblio.ch"

/* Definicoes do programa */

set date to british
set century on
set wrap on
set message to 24 center
set scoreboard off
set procedure to rotinas
set procedure to graficos
set procedure to mlivros
set procedure to musuario
set procedure to memprest
set procedure to mopcoes

/*-----------------------------------------------------------------*/

/* Bloco principal do programa */

  cls
  teladefundo("±",white,lightblue)
  cabecalho("Sistema de Automacao de Biblioteca"," ",white,blue)
  rodape(""," ",white,blue)
  DatadoSistema(1,1,white,blue)
  HoradoSistema(1,73,white,blue)

  vMenu[1]:="Acervo"
  vMenu[2]:="Usuarios"
  vMenu[3]:="Emprestimos e Devolucoes"
  vMenu[4]:="Opcoes"

  vSubMenu[1,1]:="Cadastrar livros"
  vSubMenu[1,2]:="Alterar livros"
  vSubMenu[1,3]:="Consultar livros >"

  vSubMenu[2,1]:="Cadastrar usuarios"
  vSubMenu[2,2]:="Alterar usuarios"
  vSubMenu[2,3]:="Consultar usuarios >"

  vSubMenu[3,1]:="Emprestar livros"
  vSubMenu[3,2]:="Devolver livros"
  vSubMenu[3,3]:="Consultar Emprestimos e Devolucoes"

  vSubMenu[4,1]:="Sobre o sistema"
  vSubMenu[4,2]:="Sair do sistema"

  vSubMenu[5,1]:="Todos os livros"
  vSubMenu[5,2]:="Por Titulo"
  vSubMenu[5,3]:="Por Autor"
  vSubMenu[5,4]:="Por Area"
  vSubMenu[5,5]:="Por Palavra-chave"

  vSubMenu[6,1]:="Todos os Usuarios"
  vSubMenu[6,2]:="Por Numero de Inscricao"
  vSubMenu[6,3]:="Por Nome"
  vSubMenu[6,4]:="Por Identidade"
    
  Menu(4,2,black,lightgray,red,lightgray,0,white,black,0)
  formSplash()

  do while true
    teladefundo("±",white,lightblue)

   nKey:=inkey()

   do case
      case nKey=K_ALT_A
           ControlaMenus("A",1,true)
      case nKey=K_ALT_U
           ControlaMenus("U",1,true)
      case nKey=K_ALT_E
           ControlaMenus("E",1,true)
      case nKey=K_ALT_O
           ControlaMenus("O",1,true)
      case nKey=K_ESC
           quit
   endcase

  enddo 

/*-----------------------------------------------------------------*/

/*
 Nome : ControlaMenus
 Descricao : procedimento que faz todo o controle de manuseio dos submenus.
 Parametros :
 ctipo - indica qual o submenu selecionado do menu
 nultpos - indica a ultima posicao da opcao de submenu selecionada
 ltf - indica se vai redesenhar a tela de fundo
*/
procedure ControlaMenus(ctipo,nultpos,ltf)
local nop;

if ltf=true 
  teladefundo("±",white,lightblue)
endif

if ctipo="A" 
    Menu(4,2,black,lightgray,red,lightgray,1,yellow,lightgray,1)
    rodape("Controle do Acervo da Biblioteca."," ",white,blue)
    formulario("",3,3,4,20,black,lightgray,"±",lightgray,black)
    nop:=SubMenu(1,3,16,4,5,nultpos,yellow,lightgray,black,lightgray)
    do case 
      case nop=1
           ControlaMenus("O",1,true)
      case nop=2
           ControlaMenus("U",1,true)
      case nop=3
           formLivros(1,"Cadastrar Livros",;
           "Cadastro dos Livros do Acervo da Biblioteca.")
      case nop=4
           formLivros(2,"Alterar Livros",;
           "Altera os Livros do Acervo da Biblioteca.") 
      case nop=5
           ControlaMenus("5",1,false)
    endcase
elseif ctipo="U" 
    Menu(4,2,black,lightgray,red,lightgray,10,yellow,lightgray,2)
    rodape("Controle de Usuarios da Biblioteca."," ",white,blue)
    formulario("",3,12,4,22,black,lightgray,"±",lightgray,black)
    nop:=SubMenu(2,3,18,4,14,nultpos,yellow,lightgray,black,lightgray)
    do case  
      case nop=1
           ControlaMenus("A",1,true)
      case nop=2
           ControlaMenus("E",1,true)
      case nop=3
           formUsuarios(1,"Cadastrar Usuarios",;
           "Cadastro dos Usuarios da Biblioteca.")
      case nop=4
           formUsuarios(2,"Alterar Usuarios",;
           "Altera os Usuarios da Biblioteca.") 
      case nop=5
           ControlaMenus("6",1,false)
    endcase
elseif ctipo="E" 
    Menu(4,2,black,lightgray,red,lightgray,21,yellow,lightgray,3)
    rodape("Controle de Emprestimos e Devolucoes da Biblioteca."," ",;
    white,blue)
    formulario("",3,23,4,37,black,lightgray,"±",lightgray,black)
    nop:=SubMenu(3,3,16,4,25,nultpos,yellow,lightgray,black,lightgray)
    do case
      case nop=1
           ControlaMenus("U",1,true)
      case nop=2
           ControlaMenus("O",1,true)
      case nop=3
        formEmprestimos(1,"Emprestar Livros",;
        "Efetua os Emprestimos de Livros da Biblioteca.")
      case nop=4
        formEmprestimos(2,"Devolver Livros",;
        "Efetua a Devolucao dos Livros da Biblioteca.")
      case nop=5
        formEmprestimos(3,"Consultar Emprestimos e Devolucoes",;
        "Consulta os Emprestimos e Devolucoes dos Livros da Biblioteca.") 
    endcase
elseif ctipo="O" 
    Menu(4,2,black,lightgray,red,lightgray,48,yellow,lightgray,4)
    rodape("Opcoes do Sistema de Biblioteca."," ",white,blue)
    formulario("",3,50,3,18,black,lightgray,"±",lightgray,black)
    nop:=SubMenu(4,2,16,4,52,nultpos,yellow,lightgray,black,lightgray)
    do case
      case nop=1
           ControlaMenus("E",1,true)
      case nop=2
           ControlaMenus("A",1,true)
      case nop=3
           formSobre()
      case nop=4
           formSair()
    endcase
elseif ctipo="5"
    formulario("",6,23,6,20,black,lightgray,"±",lightgray,black)
    nop:=SubMenu(5,5,18,7,25,nultpos,yellow,lightgray,black,lightgray)
    do case
      case nop=1
           ControlaMenus("A",3,true)
      case nop=2
           ControlaMenus("U",1,true)
      case nop=4
        formLivros(3,"Consultar Livros por Titulo",;
        "Consulta os Livros por Titulo do Acervo da Biblioteca.")
      case nop=5
        formLivros(4,"Consultar Livros por Autor",;
        "Consulta os Livros por Autor do Acervo da Biblioteca.")
      case nop=6
        formLivros(5,"Consultar Livros por Area",;
        "Consulta os Livros por Area do Acervo da Biblioteca.")
      case nop=7
        formLivros(6,"Consultar Livros por Palavra-chave",;
        "Consulta os Livros por Palavra-chave do Acervo da Biblioteca.")
      case nop=3
        formLivros(7,"Consultar Todos os Livros",;
        "Consulta Todos os Livros do Acervo da Biblioteca.") 
    endcase
elseif ctipo="6"
    formulario("",6,34,5,26,black,lightgray,"±",lightgray,black)
    nop:=SubMenu(6,4,24,7,36,nultpos,yellow,lightgray,black,lightgray)
    do case
      case nop=1
           ControlaMenus("U",3,true)
      case nop=2
           ControlaMenus("E",1,true)
      case nop=4
        formUsuarios(3,"Consultar Usuarios por Numero de Inscricao",;
        "Consulta os Usuarios por Numero de Inscricao.")
      case nop=5
        formUsuarios(4,"Consultar Usuarios por Nome",;
        "Consulta os Usuarios por Nome.")
      case nop=6
        formUsuarios(5,"Consultar Usuarios por Identidade",;
        "Consulta os Usuarios por Numero de Identidade.")
      case nop=3
        formUsuarios(6,"Consultar Todos os Usuarios",;
        "Consulta Todos os Usuarios da Biblioteca.") 
    endcase
endif

return

