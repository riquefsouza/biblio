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
                    "linker file biblio.prg"

  Descricao :
  O Sistema e composto dos seguintes modulos:
  1.Modulo de Acervos da Biblioteca
    Onde se realiza a manutencao dos livros da biblioteca
  2.Modulo de Usuarios da Bilioteca
    Onde se realiza a manutencao dos usuarios da biblioteca
  3.Modulo de Emprestimos e Devolucoes da Biblioteca
    Onde se efetua os emprestimos e devolucoes da biblioteca
  4.Modulo de Opcoes do sistema
    Onde e possivel ver sobre o sistema e sair dele
*/
/* programa Biblio */

#include "Inkey.ch"
#include "Achoice.ch"
#include "Fileio.ch"
#include "Setcurs.ch"
#include "Box.ch"

/* Declaracao de constantes */

 #define true .t.
 #define false .f.

 #define white "W+"
 #define lightblue "B+"
 #define blue "B"
 #define black "N"
 #define lightgray "W"
 #define red "R"
 #define yellow "GR+"

 #define TamLiv 150 
 #define TamUsu 133
 #define TamEmp 33

/* Declaracao de tipos */

 /* Registros de Enderecos */

     public cEndLogra    /* Logradouro (30) */
     public nEndNumero   /* Numero do Endereco (5) */
     public cEndCompl    /* Complemento (10) */
     public cEndBairro   /* Bairro do Endereco (20) */
     public cEndCep      /* Cep do Endereco (8) */
     
  /* Registro de Livros */

     public nLivNinsc      /* Numero de Inscricao do Livro (5) */
     public cLivTitulo     /* Titulo do Livro (30) */
     public cLivAutor      /* Autor do Livro (30) */
     public cLivArea       /* Area de atuacao do Livro (30) */
     public cLivPChave     /* Palavra-Chave para pesquisar o Livro (10) */
     public nLivEdicao     /* Edicao do Livro (4) */
     public nLivAnoPubli   /* Ano de publicacao do Livro (4) */
     public cLivEditora    /* Editora do Livro (30) */
     public nLivVolume     /* Volume do Livro (4) */
     public cLivEstado     /* Estado Atual - (D)isponivel ou (E)mprestado (1) */

  /* Registro de Usuarios */

     public nUsuNinsc      /* Numero de inscricao do Usuario (5) */
     public cUsuNome       /* Nome completo do Usuario (30) */
     public cUsuIdent      /* Identidade do Usuario (10) */
 /*  public Endereco : Enderecos;     Endereco completo do Usuario (73) */
     public cUsuTelefone   /* Telefone do Usuario (11) */
     public cUsuCategoria  /* Categoria - (A)luno,(P)rofessor,(F)uncionario (1) */
     public nUsuSituacao   /* Situacao - Numero de Livros em sua posse (1) */
  
  /* Registro de Emprestimos */

     public nEmpNinscUsuario /* Numero de inscricao do Usuario (5) */
     public nEmpNinscLivro   /* Numero de inscricao do Livro (5) */
     public cEmpDtEmprestimo /* Data de Emprestimo do Livro (10) */
     public cEmpDtDevolucao  /* Data de Devolucao do Livro (10) */
     public lEmpRemovido     /* Removido - Indica exclusao logica (1) */

/* Declaracao de variaveis globais */

 /* variaveis gerais */

 public nKey
 public cS
 public nI
 public nC

 /* variaveis de menu */

 public vMenu[10]  // 30
 public vSubMenu[10,10] // 35
 public nMenu

 /* variaveis de lista */

 public vLista[51]
 public nListapos
 public nListacol

 /* variaveis do modulo de livros */

 public cLivros
 public LivrosFile
 public nTamLivros
 public vLivros[10] // 30

 /* variaveis do modulo de Usuarios */

 public cUsuarios
 public UsuariosFile
 public nTamUsuarios
 public vUsuarios[11]  // 30

 /* variaveis do modulo de Emprestimos */

 public cEmprestimos
 public EmprestimosFile
 public nTamEmprestimos
 public vEmprestimos[5] // 10

 /* variaveis do modulo de Opcoes */

 public SobreFile
 public nTamSobre

/* Definicoes do programa */

set date to british
set century on
set wrap on
set message to 24 center
set scoreboard off

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

/* Rotinas Fundamentais */

/*
 Nome : Center
 Descricao : Procedimento que centraliza um texto na tela.
 Parametros :
 ny - posicao de linha na tela
 cs - texto a ser centralizado
 cfg - cor do texto
 cbg - cod de fundo
*/
procedure center(ny,cs,cfg,cbg)
local nx:=0

 nx:=int(40-(len(cs) / 2))
 etexto(nx,ny,cfg,cbg,cs)
return

/*------------------------------------------*/

/*
 Nome : Beep
 Descricao : Procedimento que gera um beep.
 Parametros :
 nfreq - frequencia do beep.
 ntime - duracao do beep.
*/
procedure beep(nfreq,ntime)
 tone(nfreq,ntime)
return

/*-------------------------------------------*/

/*
 Nome : Etexto
 Descricao : procedimento que escreve o texto na tela com determinada cor.
 Parametros :
 nc - posicao de coluna do texto
 nl - posicao de linha do texto
 cfg - cor do texto
 cbg - cor de fundo
 ctexto - o texto a ser escrito
*/
procedure Etexto(nc,nl,cfg,cbg,ctexto)
 @ nl-1,nc-1 say ctexto color cfg+"/"+cbg
return

/*-------------------------------------------*/

/*
 Nome : Digita
 Descricao : Procedimento que permite ter um maior controle da digitacao
 de um texto, tambem permitindo indicar um texto maior do que o permitido
 pelo espaco limite definido.
 Parametros :
 ctexto - e o resultado da digitacao
 maxlen - indica o tamanho maximo do texto a ser digitado
 nx - posicao da coluna na tela
 ny - posicao da linha na tela
 cfg - cor do texto
 cbg - cor de fundo
 ctipo - indica o tipo de caracter a ser digitado se (N)umero ou (T)exto
*/
function Digita(ctexto,maxlen,nx,ny,cfg,cbg,ctipo)

 setcursor(SC_NORMAL)
 if valtype(ctexto)!="L" 
    if ctexto=""
       ctexto:=space(maxlen)
    else
       @ ny,nx-2 say ctexto color cfg+"/"+cbg
       ctexto:=ctexto+space(int(maxlen-len(ctexto)))
    endif
 else
    ctexto:=space(maxlen)
 endif
 if ctipo="T"
    @ ny,nx-2 get ctexto picture replicate("X",maxlen) color cfg+"/"+cbg
 elseif ctipo="N"
    @ ny,nx-2 get ctexto picture replicate("9",maxlen) color cfg+"/"+cbg
 endif
 read
 setcursor(SC_NONE)

return(alltrim(ctexto))

/*-------------------------------------------*/

/*
 Nome : Teladefundo
 Descricao : procedimento que desenha os caracteres do fundo da tela.
 Parametros :
 ctipo - o caracter a ser escrito no fundo
 cfg - cor do texto
 cbg - cor de fundo
*/
procedure TeladeFundo(ctipo,cfg,cbg)
local nl:=0
local nc:=0

for nl:=3 to 24 
  for nc:=1 to 80 
    etexto(nc,nl,cfg,cbg,ctipo)
  next
next
return

/*-------------------------------------------*/

/*
 Nome : cabecalho
 Descricao : procedimento que escreve o texto de cabecalho do sistema.
 Parametros :
 ctexto - o texto a ser escrito
 ctipo - o caracter de fundo.
 cfg - cor do texto
 cbg - cor de fundo
*/
procedure cabecalho(ctexto,ctipo,cfg,cbg)
local nc:=0

for nc:=1 to 80 
  Etexto(nc,1,cfg,cbg,ctipo)
next
center(1,ctexto,cfg,cbg)
return

/*-------------------------------------------*/

/*
 Nome : rodape
 Descricao : procedimento que escreve o texto no rodape da tela.
 Parametros :
 ctexto - o texto a ser escrito
 ctipo - o caracter de fundo.
 cfg - cor do texto
 cbg - cor de fundo
*/
procedure rodape(ctexto,ctipo,cfg,cbg)
local nc:=0

for nc:=1 to 80 
  Etexto(nc,25,cfg,cbg,ctipo)
next
center(25,ctexto,cfg,cbg)
return

/*-------------------------------------------*/

/*
 Nome : DatadoSistema
 Descricao : procedimento que escreve a data do sistema na tela.
 Parametros :
 nl - posicao da linha na tela
 nc - posicao da coluna na tela
 cfg - cor do texto
 cbg - cor de fundo
*/
procedure DatadoSistema(nl,nc,cfg,cbg)
local  dias:={"Domingo","Segunda","Terca",;
       "Quarta","Quinta","Sexta","Sabado"}
local cdw

  do case
     case cdow(Date())="Sunday"
          cdw:=dias[1]
     case cdow(Date())="Monday"
          cdw:=dias[2]
     case cdow(Date())="Tuesday"
          cdw:=dias[3]
     case cdow(Date())="Wednesday"
          cdw:=dias[4]
     case cdow(Date())="Thursday"
          cdw:=dias[5]
     case cdow(Date())="Friday"
          cdw:=dias[6]
     case cdow(Date())="Saturday"
          cdw:=dias[7]
  endcase

  Etexto(nc,nl,cfg,cbg, cdw+", "+dtoc(date()))
return

/*-------------------------------------------*/

/*
 Nome : HoradoSistema
 Descricao : procedimento que escreve a Hora do sistema na tela.
 Parametros :
 nl - posicao da linha na tela
 nc - posicao da coluna na tela
 cfg - cor do texto
 cbg - cor de fundo
*/
procedure HoradoSistema(nl,nc,cfg,cbg)
  etexto(nc,nl,cfg,cbg,time())
return

/*-------------------------------------------*/

/*
 Nome : formulario
 Descricao : procedimento que desenha um formulario na tela.
 Parametros :
 ctitulo - titulo do formulario
 ntopo - posicao da linha inicial na tela
 nesquerda - posicao da coluna inicial na tela
 naltura - a altura do formulario
 nlargura - a largura do formulario
 cfg - cor do texto
 cbg - cor de fundo
 csombra - o caracter que vai ser a sobra do formulario
 csfg - cor do texto da sombra
 csbg - cor de fundo da sombra
*/
procedure formulario(ctitulo,ntopo,nesquerda,;
                     naltura,nlargura,cfg,cbg,csombra,csfg,csbg)

  @ ntopo,nesquerda,ntopo+naltura,nesquerda+nlargura;
   box replicate(csombra,8) color csfg+"/"+csbg
  @ ntopo-1,nesquerda-1,naltura+ntopo-1,nlargura+nesquerda-1;
   box B_SINGLE+space(1) color cfg+"/"+cbg
  @ ntopo-1,nesquerda+1 say ctitulo color cfg+"/"+cbg 
return

/*-------------------------------------------*/

/*
 Nome : SubMenu
 Descricao : funcao que permite criar um controle de submenu, retornando
 a opcao selecionada.
 Parametros :
 nnumero - indica qual e o submenu
 nqtd - indica a quantidade de linhas do submenu
 nmaxtam - indica a largura maxima do submenu
 ntopo - posicao da linha inicial na tela
 nesquerda - posicao da coluna inicial na tela
 nultpos - indica a ultima opcao referenciada pelo usuario
 clfg - cor do texto selecionado
 clbg - cor de fundo selecionado
 cfg - cor do texto
 cbg - cor de fundo
*/
function SubMenu(nnumero,nqtd,nmaxtam,ntopo,nesquerda,nultpos,;
                 clfg,clbg,cfg,cbg)
local ncont
local ncont2

 setcolor(cfg+"/"+cbg)
 for ncont:=0 to nqtd-1 
    @ ntopo+ncont-1,nesquerda-1 say vSubMenu[nnumero,ncont+1]+;
    replicate(" ",nmaxtam-len(vSubMenu[nnumero,ncont+1]))
 next
 Etexto(nesquerda,ntopo+nultpos-1,clfg,clbg,vSubMenu[nnumero,nultpos]+;
 replicate(" ",nmaxtam-len(vSubMenu[nnumero,nultpos])))

 ncont:=nultpos-2
 ncont2:=nultpos-1

 do while true
   nKey:=inkey()

   if nkey=K_UP
       ncont--
       ncont2--
       if ncont2=-1 
          ncont:=-2
          ncont2:=nqtd-1
       endif

       Etexto(nesquerda,ntopo+ncont+2,cfg,cbg,vSubMenu[nnumero,ncont+3]+;
       replicate(" ",nmaxtam-len(vSubMenu[nnumero,ncont+3])))
       Etexto(nesquerda,ntopo+ncont2,clfg,clbg,vSubMenu[nnumero,ncont2+1]+;
       replicate(" ",nmaxtam-len(vSubMenu[nnumero,ncont2+1])))

       if ncont=-2 
          ncont:=nqtd-2
       endif

   endif

   if nKey=K_DOWN
       ncont++
       ncont2++
       if ncont2=nqtd 
          ncont2:=0
       endif

       Etexto(nesquerda,ntopo+ncont,cfg,cbg,vSubMenu[nnumero,ncont+1]+;
       replicate(" ",nmaxtam-len(vSubMenu[nnumero,ncont+1])))
       Etexto(nesquerda,ntopo+ncont2,clfg,clbg,vSubMenu[nnumero,ncont2+1]+;
       replicate(" ",nmaxtam-len(vSubMenu[nnumero,ncont2+1])))

       if ncont=nqtd-1 
          ncont:=-1
       endif

   endif

   if nKey=K_LEFT
      return(1)
   elseif nKey=K_RIGHT
      return(2)
   elseif nKey=K_RETURN
      return(ncont2+3)
   endif

 enddo

return(true)

/*-------------------------------------------*/

/*
 Nome : Menu
 Descricao : procedimento que escreve a linha de opcoes do menu.
 Parametros :
 nqtd - indica a quantidade de opcoes no menu
 ntopo - posicao da linha inicial na tela
 cfg - cor do texto
 cbg - cor de fundo
 clfg - cor do texto do primeiro caracter de cada opcao do menu
 clbg - cor de fundo do primeiro caracter de cada opcao do menu
 npos2 - indica a ultima opcao de menu referenciada pelo usuario
 cmfg - cor do texto do selecionado
 cmbg - cor de fundo do selecionado
 ncont2 - indica a ultima posicao da descricao da opcao de menu
 referenciada pelo usuario
*/
procedure Menu(nqtd,ntopo,cfg,cbg,clfg,clbg,npos2,cmfg,cmbg,ncont2)
local ncont
local npos
local nentre

   for ncont:=1 to 80 
      Etexto(ncont,ntopo,cfg,cbg," ")
   next
   npos:=0
   nentre:=0
   for ncont:=1 to nqtd 
      Etexto(npos+4+nentre,ntopo,clfg,clbg,substr(vMenu[ncont],1,1))
      Etexto(npos+5+nentre,ntopo,cfg,cbg,substr(vMenu[ncont],2,len(vMenu[ncont])))
      nentre:=nentre+3
      npos:=npos+len(vMenu[ncont])
   next
   if npos2 > 0 
      Etexto(npos2+2,ntopo,clfg,cmbg," "+substr(vMenu[ncont2],1,1))
      Etexto(npos2+4,ntopo,cmfg,cmbg,substr(vMenu[ncont2],2,len(vMenu[ncont2]))+" ")
   endif
return

/*-------------------------------------------*/

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

/*-------------------------------------------*/

/*
 Nome : DesenhaBotao
 Descricao : procedimento que desenha um botao na tela
 Parametros :
 ntopo - posicao da linha inicial na tela
 nesquerda - posicao da coluna inicial na tela
 cfg - cor do texto
 cbg - cor de fundo
 csfg - cor do texto da sombra
 csbg - cor de fundo da sombra
 ctexto - o texto a ser escrito no botao
 lfoco - indica se o botao esta focado ou nao
*/
procedure DesenhaBotao(ntopo,nesquerda,cfg,cbg,csfg,csbg,;
                       ctexto,lfoco)
local ntam:=0
local ncont:=0

ntam:=len(ctexto)
if lfoco=false 
   Etexto(nesquerda,ntopo,cfg,cbg," "+ctexto+" ")
endif
if lfoco=true 
  Etexto(nesquerda,ntopo,cfg,cbg,chr(16)+ctexto+chr(17))
endif
Etexto(nesquerda+ntam+2,ntopo,csfg,csbg,chr(220))
for ncont:=1 to ntam+2 
  Etexto(nesquerda+ncont,ntopo+1,csfg,csbg,chr(223))
next
return

/*-------------------------------------------*/

/*
 Nome : Botao
 Descricao : funcao que realiza a acao de apertar o botao.
 Parametros :
 ntopo - posicao da linha inicial na tela
 nesquerda - posicao da coluna inicial na tela
 cfg - cor do texto
 cbg - cor de fundo
 csfg - cor do texto da sombra
 csbg - cor de fundo da sombra
 ctexto - o texto a ser escrito no botao
 lfoco - indica se o botao esta focado ou nao
*/
function Botao(ntopo,nesquerda,cfg,cbg,csfg,csbg,;
               ctexto,lfoco)
local ntam:=0
local ncont:=0

ntam:=len(ctexto)
DesenhaBotao(ntopo,nesquerda,cfg,cbg,csfg,csbg,ctexto,lfoco)

do while true

nKey:=inkey()

if lfoco=true
  if nKey=K_RETURN
      Etexto(nesquerda+1,ntopo,cfg,cbg,chr(16)+ctexto+chr(17))
      Etexto(nesquerda,ntopo,csfg,csbg," ")
      for ncont:=1 to ntam+2 
        Etexto(nesquerda+ncont,ntopo+1,csfg,csbg," ")
      next
      inkey(1)
      return(2)
  endif
endif

if nKey=K_TAB
  return(1)
endif

enddo

return(true)

/*-------------------------------------------*/

/*
 Nome : DesenhaLista
 Descricao : procedimento que desenha uma Lista rolavel na tela
 Parametros :
 ntipo - indica o numero de qual arquivo a ser aberto
 ntopo - posicao da linha inicial na tela
 nesquerda - posicao da coluna inicial na tela
 naltura - indica a altura da lista
 nlargura - indica a largura da lista
 cfg - cor do texto
 cbg - cor de fundo
 npos - indica a ultima posicao da linha da lista na tela
 ncol - indica a ultima posicao da coluna da lista na tela
 lfoco - indica se a lista esta focada ou nao
*/
procedure DesenhaLista(ntipo,ntopo,nesquerda,naltura,nlargura,;
                       cfg,cbg,npos,ncol,lfoco)
local ncont:=0
local cposicao
local ccoluna
local csLista

if lfoco=true 
   Etexto(nesquerda-1,ntopo-1,cfg,cbg,"Ú")
   Etexto(nesquerda+nlargura+1,ntopo-1,cfg,cbg,"¿")
   Etexto(nesquerda-1,ntopo+naltura,cfg,cbg,"À")
   Etexto(nesquerda+nlargura+1,ntopo+naltura,cfg,cbg,"Ù")
else
   Etexto(nesquerda-1,ntopo-1,cfg,cbg," ")
   Etexto(nesquerda+nlargura+1,ntopo-1,cfg,cbg," ")
   Etexto(nesquerda-1,ntopo+naltura,cfg,cbg," ")
   Etexto(nesquerda+nlargura+1,ntopo+naltura,cfg,cbg," ")
endif
AbrirArquivo(ntipo)
csLista:=TiposLista(ntipo,nlargura,npos+1,ncol+1)
Etexto(nesquerda,ntopo,cfg,cbg,csLista+replicate(" ",nlargura-len(csLista)))
for ncont:=1 to naltura-2 
  csLista:=TiposLista(ntipo,nlargura,npos+ncont+1,ncol+1)
  Etexto(nesquerda,ntopo+ncont,cfg,cbg,csLista+;
  replicate(" ",nlargura-len(csLista)))
next
csLista:=TiposLista(ntipo,nlargura,npos+naltura,ncol+1)
Etexto(nesquerda,ntopo+naltura-1,cfg,cbg,csLista+;
Replicate(" ",nlargura-len(csLista)))

cposicao:=alltrim(str(npos+1))
Etexto(nesquerda,ntopo+naltura+1,cfg,cbg,"Linha : "+;
replicate("0",4-len(cposicao))+cposicao)
ccoluna:=alltrim(str(ncol+1))
Etexto(nesquerda+14,ntopo+naltura+1,cfg,cbg,"Coluna : "+;
replicate("0",4-len(ccoluna))+ccoluna)

return

/*-------------------------------------------*/

/*
 Nome : TiposLista
 Descricao : funcao que indica quais arquivos serao usados com a lista,
 como tambem a formatacao do cabecalho desses arquivos na lista
 Parametros :
 ntipo - indica o numero de qual arquivo a ser aberto
 nlargura - indica a largura do texto
 npos - indica a posicao do texto na lista
 ncol - indica a posicao da coluna do texto na lista
*/
function TiposLista(ntipo,nlargura,npos,ncol)
local sAux

if ntipo=1 
    if npos=1 
        sAux:="Numero de Inscricao ³ Titulo                         ³ "
        sAux:=sAux+"Autor                          ³ "
        sAux:=sAux+"Area                           ³ Palavra-Chave ³ "
        sAux:=sAux+"Edicao ³ Ano de Publicacao ³ "
        sAux:=sAux+"Editora                        ³ Volume ³ Estado Atual"
        return(substr(sAux,ncol,nlargura))
    endif
    if npos=2
      return(replicate("-",nlargura))
    endif
    if npos > 2 
      if nTamLivros > (npos-3) 
        fseek(LivrosFile,(npos-3)*TamLiv,FS_SET)
        cLivros:=space(TamLiv)
        fread(LivrosFile,@cLivros,TamLiv)
        fatribuir(1,true)

          cS:=alltrim(str(nLivNinsc))
          sAux:=replicate(" ",19-len(cS))+cS+" ³ "
          sAux:=sAux+cLivTitulo+replicate(" ",31-len(cLivTitulo))+"³ "
          sAux:=sAux+cLivAutor+replicate(" ",31-len(cLivAutor))+"³ "
          sAux:=sAux+cLivArea+replicate(" ",31-len(cLivArea))+"³ "
          sAux:=sAux+cLivPchave+replicate(" ",14-len(cLivPchave))+"³ "
          cS:=alltrim(Str(nLivEdicao))
          sAux:=sAux+replicate(" ",6-len(cS))+cS+" ³ "
          cS:=alltrim(Str(nLivAnoPubli))
          sAux:=sAux+replicate(" ",17-len(cS))+cS+" ³ "
          sAux:=sAux+cLivEditora+replicate(" ",31-len(cLivEditora))+"³ "
          cS:=alltrim(Str(nLivVolume))
          sAux:=sAux+replicate(" ",6-len(cS))+cS+" ³ "
          if cLivEstado="D" 
             sAux:=sAux+"Disponivel"
          else
             sAux:=sAux+"Emprestado"
          endif
         
         return(substr(sAux,ncol,nlargura))
      else
         return("")
      endif
    endif

elseif ntipo=2 
    if npos=1 
        sAux:="Numero de Inscricao ³ Nome                           ³ "
        sAux:=sAux+"Identidade ³ Logradouro                     ³ "
        sAux:=sAux+"Numero ³ Complemento ³ "
        sAux:=sAux+"Bairro               ³ Cep      ³ "
        sAux:=sAux+"Telefone    ³ Categoria   ³ Situacao"
        return(substr(sAux,ncol,nlargura))
    endif
    if npos=2 
      return(replicate("-",nlargura))
    endif
    if npos > 2 
      if nTamUsuarios > (npos-3) 
        fseek(UsuariosFile,(npos-3)*TamUsu,FS_SET)
        cUsuarios:=space(TamUsu)
        fread(UsuariosFile,@cUsuarios,TamUsu)
        fatribuir(2,true)

          cS:=alltrim(str(nUsuNinsc))
          sAux:=replicate(" ",19-len(cS))+cS+" ³ "
          sAux:=sAux+cUsuNome+replicate(" ",31-len(cUsuNome))+"³ "
          sAux:=sAux+replicate(" ",10-len(cUsuIdent))+cUsuIdent+" ³ "
          sAux:=sAux+cEndlogra+replicate(" ",31-len(cEndlogra))+"³ "
          cS:=alltrim(str(nEndnumero))
          sAux:=sAux+replicate(" ",6-len(cS))+cS+" ³ "
          sAux:=sAux+cEndcompl+replicate(" ",12-len(cEndcompl))+"³ "
          sAux:=sAux+cEndBairro+replicate(" ",21-len(cEndBairro))+"³ "
          sAux:=sAux+replicate(" ",8-len(cEndCep))+cEndCep+" ³"
          sAux:=sAux+replicate(" ",12-len(cUsuTelefone))+cUsuTelefone+" ³ "
          if cUsuCategoria="A" 
             sAux:=sAux+"Aluno"+replicate(" ",12-len("Aluno"))+"³ "
          elseif cUsuCategoria="P" 
             sAux:=sAux+"Professor"+replicate(" ",12-len("Professor"))+"³ "
          elseif cUsuCategoria="F" 
             sAux:=sAux+"Funcionario"+;
             replicate(" ",12-len("Funcionario"))+"³ "
          endif
          cS:=alltrim(str(nUsuSituacao))
          sAux:=sAux+replicate(" ",8-len(cS))+cS

         return(substr(sAux,ncol,nlargura))
      else
         return("")
      endif
     endif
  
elseif ntipo=3 
    if npos=1 
        sAux:="Numero de Inscricao do Usuario ³ "
        sAux:=sAux+"Numero de Inscricao do Livro ³ "
        sAux:=sAux+"Data do Emprestimo ³ Data da Devolucao ³ "
        sAux:=sAux+"Removido"
        return(substr(sAux,ncol,nlargura))
    endif
    if npos=2 
      return(replicate("-",nlargura))
    endif
    if npos > 2 
      if nTamEmprestimos > (npos-3)        
        fseek(EmprestimosFile,(npos-3)*TamEmp,FS_SET)
        cEmprestimos:=space(TamEmp)
        fread(EmprestimosFile,@cEmprestimos,TamEmp)
        fatribuir(3,true)

          cS:=""
          cS:=alltrim(str(nEmpNinscUsuario))
          sAux:=replicate(" ",30-len(cS))+cS+" ³ "
          cS:=alltrim(str(nEmpNinscLivro))
          sAux:=sAux+replicate(" ",28-len(cS))+cS+" ³ "
          sAux:=sAux+cEmpDtEmprestimo+replicate(" ",19-len(cEmpDtEmprestimo))+"³ "
          sAux:=sAux+cEmpDtDevolucao+replicate(" ",18-len(cEmpDtDevolucao))+"³ "
          if lEmpRemovido=true 
             sAux:=sAux+"Sim"
          else
             sAux:=sAux+"Nao"
          endif
         return(substr(sAux,ncol,nlargura))

      else
         return("")
      endif
     endif
  
elseif ntipo=4 
    return(substr(vLista[npos],ncol,len(vLista[npos])))
endif

return("")

/*-------------------------------------------*/

/*
 Nome : Lista
 Descricao : funcao que executa a acao de rolamento da lista.
 Parametros :
 ntipo - indica o numero de qual arquivo a ser aberto
 ntopo - posicao da linha inicial na tela
 nesquerda - posicao da coluna inicial na tela
 nlargura - indica a largura da lista
 ntlinhas - indica o numero total de linhas da lista
 ntcolunas - indica o numero total de colunas da lista
 cfg - cor do texto
 cbg - cor de fundo
 nlistapos - indica a ultima posicao da linha da lista na tela
 nlitacol - indica a ultima posicao da coluna da lista na tela
 lfoco - indica se a lista esta focada ou nao
*/
function Lista(ntipo,ntopo,nesquerda,naltura,nlargura,ntlinhas,ntcolunas,;
               cfg,cbg,lfoco)
local ncont2:=0
local cposicao
local ccoluna
local csLista

DesenhaLista(ntipo,ntopo,nesquerda,naltura,nlargura,cfg,cbg,;
nListapos,nListacol,lfoco)

do while true

nKey:=inkey()

  if nKey=K_UP 
     if nListapos > 0 
         nListapos--
         for ncont2:=0 to naltura-1 
              csLista:=TiposLista(ntipo,nlargura,nListapos+ncont2+1,nlistacol+1)
              Etexto(nesquerda,ntopo+ncont2,cfg,cbg,csLista+;
              replicate(" ",nlargura-len(csLista)))
         next
         cposicao:=alltrim(str(nlistapos+1))
         Etexto(nesquerda,ntopo+naltura+1,cfg,cbg,"Linha : "+;
         replicate("0",4-len(cposicao))+cposicao)
     endif
  endif

  if nKey=K_DOWN
     if nListapos < (ntlinhas-naltura) 
         nListapos++
         for ncont2:=0 to naltura-1 
             csLista:=TiposLista(ntipo,nlargura,nListapos+ncont2+1,nlistacol+1)
             Etexto(nesquerda,ntopo+ncont2,cfg,cbg,csLista+;
             replicate(" ",nlargura-len(csLista)))
         next
         cposicao:=alltrim(str(nlistapos+1))
         Etexto(nesquerda,ntopo+naltura+1,cfg,cbg,"Linha : "+;
         replicate("0",4-len(cposicao))+alltrim(cposicao))
     endif
  endif

  if nKey=K_RIGHT
     if nListacol < (ntcolunas-nlargura) 
         nlistacol++
         for ncont2:=0 to naltura-1 
            csLista:=TiposLista(ntipo,nlargura,nListapos+ncont2+1,nListacol+1)
            Etexto(nesquerda,ntopo+ncont2,cfg,cbg,csLista+;
            replicate(" ",nlargura-len(csLista)))
         next
         ccoluna:=alltrim(str(nlistacol+1))
         Etexto(nesquerda+14,ntopo+naltura+1,cfg,cbg,"Coluna : "+;
         replicate("0",4-len(ccoluna))+ccoluna)
     endif
  endif

  if nKey=K_LEFT
     if nListacol > 0 
         nlistacol--
         for ncont2:=0 to naltura-1 
            csLista:=TiposLista(ntipo,nlargura,nListapos+ncont2+1,nListacol+1)
            Etexto(nesquerda,ntopo+ncont2,cfg,cbg,csLista+;
            replicate(" ",nlargura-len(csLista)))
         next
         ccoluna:=alltrim(str(nlistacol+1))
         Etexto(nesquerda+14,ntopo+naltura+1,cfg,cbg,"Coluna : "+;
         replicate("0",4-len(ccoluna))+ccoluna)
     endif
  endif

   if nKey=K_TAB
      return(1)
   endif
enddo 

return(true)

/*-----------------------------------------------------*/

/*
 Nome : fAtribuir
 Descricao : procedimento atribui os dados tanto na string de buffer
 como tambem nas variaves do registro especifico
 Parametros :
 ntipo - indica o numero do registro
 ltipo - indica se vai atribuir ou nao
*/
procedure fAtribuir(nTipo,ltipo)
if nTipo=1
 if lTipo=true
   if len(cLivros) > 0
     nLivNinsc:=val(alltrim(substr(cLivros,1,5)))
     cLivTitulo:=alltrim(substr(cLivros,6,30))   
     cLivAutor:=alltrim(substr(cLivros,36,30))   
     cLivArea:=alltrim(substr(cLivros,66,30))    
     cLivPChave:=alltrim(substr(cLivros,96,10))  
     nLivEdicao:=val(alltrim(substr(cLivros,106,4)))  
     nLivAnoPubli:=val(alltrim(substr(cLivros,110,4)))
     cLivEditora:=alltrim(substr(cLivros,114,30))
     nLivVolume:=val(alltrim(substr(cLivros,144,4)))
     cLivEstado:=alltrim(substr(cLivros,148,1))      
   endif
 else
     cLivros:=alltrim(str(nLivNinsc))+replicate(" ",5-len(alltrim(str(nLivNinsc))))+;
     cLivTitulo+replicate(" ",30-len(cLivTitulo))+;
     cLivAutor+replicate(" ",30-len(cLivAutor))+;
     cLivArea+replicate(" ",30-len(cLivArea))+;
     cLivPChave+replicate(" ",10-len(cLivPChave))+;
     alltrim(str(nLivEdicao))+replicate(" ",4-len(alltrim(str(nLivEdicao))))+;
     alltrim(str(nLivAnoPubli))+replicate(" ",4-len(alltrim(str(nLivAnoPubli))))+;
     cLivEditora+replicate(" ",30-len(cLivEditora))+;
     alltrim(str(nLivVolume))+replicate(" ",4-len(alltrim(str(nLivVolume))))+;
     cLivEstado+chr(13)+chr(10)
 endif
elseif nTipo=2
 if lTipo=true
   if len(cUsuarios) > 0
     nUsuNinsc:=val(alltrim(substr(cUsuarios,1,5)))
     cUsuNome:=alltrim(substr(cUsuarios,6,30))  
     cUsuIdent:=alltrim(substr(cUsuarios,36,10)) 

     cEndLogra:=alltrim(substr(cUsuarios,46,30)) 
     nEndNumero:=val(alltrim(substr(cUsuarios,76,5))) 
     cEndCompl:=alltrim(substr(cUsuarios,81,10))
     cEndBairro:=alltrim(substr(cUsuarios,91,20))
     cEndCep:=alltrim(substr(cUsuarios,111,8))    

     cUsuTelefone:=alltrim(substr(cUsuarios,119,11))
     cUsuCategoria:=alltrim(substr(cUsuarios,130,1))
     nUsuSituacao:=val(alltrim(substr(cUsuarios,131,1)))        
   endif
 else
     cUsuarios:=alltrim(str(nUsuNinsc))+replicate(" ",5-len(alltrim(str(nUsuNinsc))))+;
     cUsuNome+replicate(" ",30-len(cUsuNome))+;
     cUsuIdent+replicate(" ",10-len(cUsuIdent))+;
     cEndLogra+replicate(" ",30-len(cEndLogra))+;
     alltrim(str(nEndNumero))+replicate(" ",5-len(alltrim(str(nEndNumero))))+;
     cEndCompl+replicate(" ",10-len(cEndCompl))+;
     cEndBairro+replicate(" ",20-len(cEndBairro))+;
     cEndCep+replicate(" ",8-len(cEndCep))+;
     cUsuTelefone+replicate(" ",11-len(cUsuTelefone))+;
     cUsuCategoria+replicate(" ",1-len(cUsuCategoria))+;
     alltrim(str(nUsuSituacao))+chr(13)+chr(10)
 endif
elseif nTipo=3
 if lTipo=true
   if len(cEmprestimos) > 0
      nEmpNinscUsuario:=val(alltrim(substr(cEmprestimos,1,5)))
      nEmpNinscLivro:=val(alltrim(substr(cEmprestimos,6,5)))
      cEmpDtEmprestimo:=alltrim(substr(cEmprestimos,11,10))
      cEmpDtDevolucao:=alltrim(substr(cEmprestimos,21,10))
      if alltrim(substr(cEmprestimos,31,1))="T"
         lEmpRemovido:=true
      elseif alltrim(substr(cEmprestimos,31,1))="F"
         lEmpRemovido:=false
      endif
   endif
 else
    cEmprestimos:=alltrim(str(nEmpNinscUsuario))+;
    replicate(" ",5-len(str(nEmpNinscUsuario)))+;
    alltrim(str(nEmpNinscLivro))+replicate(" ",5-len(alltrim(str(nEmpNinscLivro))))+;
    cEmpDtEmprestimo+replicate(" ",10-len(cEmpDtEmprestimo))+;
    cEmpDtDevolucao+replicate(" ",10-len(cEmpDtDevolucao))
    if lEmpRemovido=true
       cEmprestimos:=cEmprestimos+"T"+chr(13)+chr(10)
    else
       cEmprestimos:=cEmprestimos+"F"+chr(13)+chr(10)
    endif
  endif
endif

return

/*-----------------------------------------------------*/

/*
 Nome : AbrirArquivo
 Descricao : procedimento que Abri o tipo de arquivo selecionado.
 Parametros :
 ntipo - indica o numero de qual arquivo a ser aberto
*/
procedure AbrirArquivo(nTipo)

  if nTipo=1
     if file("Livros.dat")=true
        if (LivrosFile:=fopen("Livros.dat",FO_READWRITE)) >= 0
           nTamLivros:=fseek(LivrosFile,0,FS_END)
           nTamLivros:=int(nTamLivros / TamLiv)
           fseek(LivrosFile,0,FS_SET)
        endif  
     else
        if (LivrosFile:=fcreate("Livros.dat",FC_NORMAL))>=0
           nTamLivros:=0
        endif
     endif
  endif
  if ntipo=2 
     if file("Usuarios.dat")=true
        if (UsuariosFile:=fopen("Usuarios.dat",FO_READWRITE)) >= 0
           nTamUsuarios:=fseek(UsuariosFile,0,FS_END)
           nTamUsuarios:=int(nTamUsuarios / TamUsu)
           fseek(UsuariosFile,0,FS_SET)
        endif  
     else
        if (UsuariosFile:=fcreate("Usuarios.dat",FC_NORMAL))>=0
           nTamUsuarios:=0
        endif
     endif
  endif
  if nTipo=3 
     if file("Empresti.dat")=true
        if (EmprestimosFile:=fopen("Empresti.dat",FO_READWRITE)) >= 0
           nTamEmprestimos:=fseek(EmprestimosFile,0,FS_END)
           nTamEmprestimos:=int(nTamEmprestimos / TamEmp)
           fseek(EmprestimosFile,0,FS_SET)
        endif  
     else
        if (EmprestimosFile:=fcreate("Empresti.dat",FC_NORMAL)) >=0
           nTamEmprestimos:=0
        endif
     endif
  endif
  if nTipo=4 
     if file("Sobre.dat")=true
        SobreFile:=fopen("Sobre.dat",FO_READWRITE)
           // nTamSobre:=fseek(SobreFile,0,FS_END)
           // nTamSobre:=nTamSobre / TamSobre
           // fseek(SobreFile,0) 
     else
        SobreFile:=fcreate("Sobre.dat",FC_NORMAL)
        nTamSobre:=0
     endif
  endif

return

/******************Modulo de Acervos**********************/

/*
 Nome : PesLivros
 Descricao : funcao que pesquisa as informacoes contidas no arquivo de
 livros
 Parametros :
 ctipo - indica se e o valor e (N)umerico ou (S)tring
 ccampo - qual o campo a ser pesquisado
 nCod2 - codigo do campo se numerico
 sCod2 - codigo do campo se string
 nTamsCod - tamanho caracteres do campo de string
*/
function PesLivros(ctipo,ccampo,nCod2,sCod2,nTamsCod)
local nPosicao
local nCod
local sCod
local bFlag
local nRet

fseek(LivrosFile,0,FS_SET)
nPosicao:=0
bFlag:=false
nCod:=0
sCod:=""
do while (.Not.(nTamLivros=nPosicao)) // Eof(LivrosFile) 
   cLivros:=space(TamLiv)
   fread(LivrosFile,@cLivros,TamLiv)
   fatribuir(1,true)

   if ctipo="N" 
       if ccampo="Ninsc" 
          nCod:=nLivNinsc
       endif
       if (nCod=nCod2) 
          nRet:=nPosicao
          fseek(LivrosFile,nPosicao*TamLiv,FS_SET)
          bFlag:=true
          exit
       endif
   elseif ctipo="S" 
       if ccampo="Titulo" 
          sCod:=cLivtitulo
       elseif ccampo="Area" 
          sCod:=cLivArea
       elseif ccampo="Autor" 
          sCod:=cLivAutor
       elseif ccampo="Pchave" 
          sCod:=cLivPChave
       endif
       if (substr(sCod,1,nTamsCod)=sCod2) 
          nRet:=nPosicao
          fseek(LivrosFile,nPosicao*TamLiv,FS_SET)
          bFlag:=true
          exit
       endif
   endif
   nPosicao++
enddo
 if (nTamLivros=nPosicao) .and. (bFlag=false)  /* (Eof(LivrosFile)) */
    return(-1)
 endif
return(nRet)

/*-----------------------------------------------------*/

/*
 Nome : formLivros
 Descricao : procedimento que desenha o formulario de livros na tela, e
 tambem indica qual acao a tomar.
 Parametros :
 ntipo - indica qual a acao do formulario
 ctitulo - o titulo do formulario
 crod - o texto do rodape sobre o formulario
*/
procedure formLivros(ntipo,ctitulo,crod)

  teladefundo("±",white,lightblue)
  rodape(crod," ",white,blue) 
  formulario(chr(180)+ctitulo+chr(195),4,2,18,76,white,blue,"±",lightgray,black)

  vLivros[1]:=replicate(" ",5)
  AtrvLivros(true)
  AbrirArquivo(1)
  if ((ntipo=1) .or. (ntipo=2)) 
     RotformLivros(0)
     DesenhaBotao(20,45,black,lightgray,black,blue," Salvar ",false)
     DesenhaBotao(20,60,black,lightgray,black,blue," Fechar ",false)
  endif
  if ((ntipo=3) .or. (ntipo=4) .or. (ntipo=5) .or. (ntipo=6)) 
     DesenhaBotao(20,60,black,lightgray,black,blue," Fechar ",false)
     RotformLivros(2)
     Etexto(2,7,white,blue,chr(195)+replicate(chr(196),75)+chr(180))
  endif
  if ntipo=7 
     DesenhaBotao(20,60,black,lightgray,black,blue," Fechar ",false)
  endif
  if ntipo=3 
     Etexto(5,6,white,blue,"Titulo : ")
     Etexto(14,6,black,lightgray,replicate(" ",30))
  endif
  if ntipo=4 
     Etexto(5,6,white,blue,"Autor : ")
     Etexto(13,6,black,lightgray,replicate(" ",30))
  endif
  if ntipo=5 
     Etexto(5,6,white,blue,"Area : ")
     Etexto(12,6,black,lightgray,replicate(" ",30))
  endif
  if ntipo=6 
     Etexto(5,6,white,blue,"Palavra-Chave : ")
     Etexto(21,6,black,lightgray,replicate(" ",10))
  endif

  LimpLivros()
  if ntipo=1 
     CformLivros("2",1,0,0,crod,false)  /* cadastrar */
  elseif ntipo=2 
     CformLivros("1",2,0,0,crod,false)  /* alterar */
  elseif ntipo=3 
     CformLivros("3",3,0,0,crod,false) /* consultar por titulo */
  elseif ntipo=4 
     CformLivros("4",4,0,0,crod,false) /* consultar por Autor */
  elseif ntipo=5 
     CformLivros("5",5,0,0,crod,false) /* consultar por Area */
  elseif ntipo=6 
     CformLivros("6",6,0,0,crod,false) /* consultar por Palavra-chave */
  elseif ntipo=7 
     CformLivros("7",7,0,0,crod,true) /* consultar todos */
  endif

return

/*-------------------------------------------*/

/*
 Nome : LimpLivros
 Descricao : procedimento limpa as variaveis do registro de livros.
*/
procedure LimpLivros()
     nLivNinsc:=0
     cLivTitulo:=""
     cLivAutor:=""
     cLivArea:=""
     cLivPchave:=""
     nLivEdicao:=0
     nLivAnoPubli:=0
     cLivEditora:=""
     nLivVolume:=0
     cLivEstado:=""
return

/*-------------------------------------------*/

/*
 Nome : RotformLivros
 Descricao : procedimento que escreve os rotulos do formulario de livros.
 Parametros :
 nl - indica um acrescimo na linha do rotulo
*/
procedure RotformLivros(nl)

  Etexto(5,6+nl,white,blue,"Numero de Inscricao : ")
  Etexto(27,6+nl,black,lightgray,vlivros[1])
  Etexto(35,6+nl,white,blue,"Titulo : ")
  Etexto(44,6+nl,black,lightgray,vlivros[2])
  Etexto(5,8+nl,white,blue,"Autor : ")
  Etexto(13,8+nl,black,lightgray,vlivros[3])
  Etexto(5,10+nl,white,blue,"Area : ")
  Etexto(12,10+nl,black,lightgray,vlivros[4])
  Etexto(5,12+nl,white,blue,"Palavra-Chave : ")
  Etexto(21,12+nl,black,lightgray,vlivros[5])
  Etexto(35,12+nl,white,blue,"Edicao : ")
  Etexto(44,12+nl,black,lightgray,vlivros[6])
  Etexto(5,14+nl,white,blue,"Ano de Publicacao : ")
  Etexto(25,14+nl,black,lightgray,vlivros[7])
  Etexto(35,14+nl,white,blue,"Editora : ")
  Etexto(45,14+nl,black,lightgray,vlivros[8])
  Etexto(5,16+nl,white,blue,"Volume : ")
  Etexto(14,16+nl,black,lightgray,vlivros[9])
  Etexto(22,16+nl,white,blue,"Estado Atual : ")
  Etexto(37,16+nl,black,lightgray,vlivros[10])
  Etexto(40,16+nl,white,blue,"(D)isponivel ou (E)mprestado")

return

/*-------------------------------------------*/

/*
 Nome : CformLivros
 Descricao : procedimento que realiza todo o controle de manuseio do
 formulario de livros.
 Parametros :
 ctipo - indica qual a acao do formulario
 ntipo2 - indica a acao original do formulario nao manipulado pela funcao
 npos - indica a ultima posicao da linha da lista de livros
 ncol - indica a ultima posicao da coluna da lista de livros
 crod - o texto do rodape sobre o formulario
 lfoco - se os objetos do formulario estao focados ou nao
*/
procedure CformLivros(ctipo,ntipo2,npos,ncol,crod,lfoco)
local nop

if ctipo="1"

      cS:=Digita(cS,5,28,5,black,lightgray,"N")  /* N insc */          
      I:=Val(cS)
      nLivNinsc:=I
      if (len(cS) > 0) .and. (cS<>replicate(" ",len(cS))) 
         DesenhaBotao(20,45,black,lightgray,black,blue," Salvar ",false)
         if PesLivros("N","Ninsc",I,"",0)<>-1 
                AtrvLivros(false)
                RotformLivros(0)
                rodape(crod," ",white,blue)
                CformLivros("2",ntipo2,npos,ncol,crod,false)
         else
            cS:=alltrim(str(I))
            AtrvLivros(true) 
            RotformLivros(0) 
            rodape("Numero de Inscricao, nao encontrado !"," ",yellow,red) 
            CformLivros("Fechar",ntipo2,npos,ncol,crod,true) 
         endif
      else
        CformLivros("Fechar",ntipo2,npos,ncol,crod,true) 
      endif
elseif ctipo="2" 
        if ntipo2=1
            nTamLivros:=fseek(LivrosFile,0,FS_END)
            nTamLivros:=int(nTamLivros / TamLiv)
            fseek(LivrosFile,0,FS_SET)
            
            if nTamLivros = 0 
               nLivNinsc:=1
            else                
                nLivNinsc:=nTamLivros + 1 
            endif 
            I:=nLivNinsc 
            cS:=alltrim(str(nLivNinsc)) 
            Etexto(27,6,black,lightgray,cS) 
            cS:="" 
        elseif ntipo2=2 
            AbrirArquivo(1) 
            if PesLivros("N","Ninsc",I,"",0)=-1 
              rodape("Numero de Inscricao, nao encontrado !"," ",yellow,red)
            endif
        endif 
          DformLivros() 
      
      CformLivros("Salvar",ntipo2,npos,ncol,crod,true) 

elseif ctipo="3" 

      cS:="" 
      cS:=Digita(cS,30,15,5,black,lightgray,"T") 
      cLivTitulo:=cS 
      if (len(cS) > 0) .and. (cS<>replicate(" ",len(cS))) 
         if PesLivros("S","Titulo",0,cS,len(cS))<>-1 
              AtrvLivros(false) 
              RotformLivros(2) 
              rodape(crod," ",white,blue) 
         else
            AtrvLivros(true) 
            RotformLivros(2) 
            rodape("Titulo do Livro, nao encontrado !"," ",yellow,red) 
         endif 
      endif 
        CformLivros("Fechar",ntipo2,npos,ncol,crod,true) 

elseif ctipo="4" 
    
      cS:="" 
      cS:=Digita(cS,30,14,5,black,lightgray,"T") 
      cLivAutor:=cS 
      if (len(cS) > 0) .and. (cS<>replicate(" ",len(cS))) 
         if PesLivros("S","Autor",0,cS,len(cS))<>-1 
              AtrvLivros(false) 
              RotformLivros(2) 
              rodape(rod," ",white,blue) 
         else
            AtrvLivros(true) 
            RotformLivros(2) 
            rodape("Autor do Livro, nao encontrado !"," ",yellow,red) 
         endif 
      endif 
        CformLivros("Fechar",ntipo2,npos,ncol,crod,true)     
elseif ctipo="5" 

      cS:="" 
      cS:=Digita(cS,4,13,5,black,lightgray,"T") 
      cLivArea:=cS 
      if (len(cS) > 0) .and. (cS<>replicate(" ",len(cS))) 
         if PesLivros("S","Area",0,cS,len(cS))<>-1 
              AtrvLivros(false) 
              RotformLivros(2) 
              rodape(rod," ",white,blue) 
         else
            AtrvLivros(true) 
            RotformLivros(2) 
            rodape("Area do Livro, nao encontrada !"," ",yellow,red) 
         endif 
      endif 
        CformLivros("Fechar",ntipo2,npos,ncol,crod,true) 

elseif ctipo="6" 

      cS:="" 
      cS:=Digita(cS,10,22,5,black,lightgray,"T") 
      cLivPChave:=cS 
      if (len(cS) > 0) .and. (cS<>replicate(" ",len(cS))) 
         if PesLivros("S","Pchave",0,cS,len(cS))<>-1 
              AtrvLivros(false) 
              RotformLivros(2) 
              rodape(rod," ",white,blue) 
         else
            AtrvLivros(true) 
            RotformLivros(2) 
            rodape("Palavra-Chave do Livro, nao encontrado !"," ",yellow,red) 
         endif 
      endif 
        CformLivros("Fechar",ntipo2,npos,ncol,crod,true) 

elseif ctipo="7" 
    nListacol=ncol
    nListapos=npos
    if lista(1,6,5,13,70,nTamLivros+2,220,white,blue,lfoco)=1 
        desenhalista(1,6,5,13,70,white,blue,npos,ncol,false) 
        CformLivros("Fechar",ntipo2,npos,ncol,crod,true) 
    endif 

elseif ctipo="Salvar" 
    nop:=Botao(20,45,black,lightgray,black,blue," Salvar ",lfoco)
    do case 
      case nop=1
          DesenhaBotao(20,45,black,lightgray,black,blue," Salvar ",false) 
          CformLivros("Fechar",ntipo2,npos,ncol,crod,true) 
      case nop=2
          SalvarLivros(ntipo2) 
          DesenhaBotao(20,45,black,lightgray,black,blue," Salvar ",false) 
          CformLivros("Fechar",ntipo2,npos,ncol,crod,true) 
    endcase 
elseif ctipo = "Fechar" 
    nop:=Botao(20,60,black,lightgray,black,blue," Fechar ",lfoco)
    do case  
      case nop=1
          DesenhaBotao(20,60,black,lightgray,black,blue," Fechar ",false) 
          if ntipo2=1 
            CformLivros("2",ntipo2,npos,ncol,crod,true)
          elseif ntipo2=2 
            CformLivros("1",ntipo2,npos,ncol,crod,false)
          elseif ntipo2=3 
            CformLivros("3",ntipo2,npos,ncol,crod,false)
          elseif ntipo2=4 
            CformLivros("4",ntipo2,npos,ncol,crod,false)
          elseif ntipo2=5 
            CformLivros("5",ntipo2,npos,ncol,crod,false)
          elseif ntipo2=6 
            CformLivros("6",ntipo2,npos,ncol,crod,false)
          elseif ntipo2=7 
            CformLivros("7",ntipo2,npos,ncol,crod,true)
          endif 
      case nop=2
         rodape(""," ",white,blue) 
         fclose(LivrosFile) 
    endcase 
endif 

return

/*-------------------------------------------------------*/

/*
 Nome : AtrvLivros
 Descricao : procedimento que atribui ou limpa o vetor de livros.
 Parametros :
 llimpar - indica se vai limpar ou atribuir os vetores
*/
procedure AtrvLivros(llimpar) 

if llimpar=false 
      cS:=alltrim(str(nLivNinsc)) 
      vLivros[1]:=cS 
      vLivros[2]:=cLivTitulo 
      vLivros[3]:=cLivAutor 
      vLivros[4]:=cLivArea 
      vLivros[5]:=cLivPchave 
      cS:=alltrim(Str(nLivEdicao)) 
      vLivros[6]:=cS 
      cS:=alltrim(Str(nLivAnoPubli)) 
      vLivros[7]:=cS 
      vLivros[8]:=cLivEditora 
      cS:=alltrim(Str(nLivVolume)) 
      vLivros[9]:=cS 
      vLivros[10]:=cLivEstado 
else
  vLivros[2]:=replicate(" ",30) 
  vLivros[3]:=replicate(" ",30) 
  vLivros[4]:=replicate(" ",30) 
  vLivros[5]:=replicate(" ",10) 
  vLivros[6]:=replicate(" ",4) 
  vLivros[7]:=replicate(" ",4) 
  vLivros[8]:=replicate(" ",30) 
  vLivros[9]:=replicate(" ",4) 
  vLivros[10]:=replicate(" ",1) 
endif 
return

/*-------------------------------------------------------*/

/*
 Nome : DformLivros
 Descricao : procedimento que realiza o cotrole de digitacao dos dados no
 formulario de livros.
*/
procedure DformLivros() 
        cS:=cLivTitulo 
        cS:=Digita(cS,30,45,5,black,lightgray,"T")           
        cLivTitulo:=cS 
        cS:=cLivAutor 
        cS:=Digita(cS,30,14,7,black,lightgray,"T")
        cLivAutor:=cS 
        cS:=cLivArea 
        cS:=Digita(cS,30,13,9,black,lightgray,"T") 
        cLivArea:=cS 
        cS:=cLivPChave 
        cS:=Digita(cS,10,22,11,black,lightgray,"T") 
        cLivPchave:=cS 
        cS:=alltrim(Str(nLivEdicao)) 
        cS:=Digita(cS,4,45,11,black,lightgray,"N") 
        I:=Val(cS) 
        nLivEdicao:=I 
        cS:=alltrim(Str(nLivAnoPubli)) 
        cS:=Digita(cS,4,26,13,black,lightgray,"N") 
        I:=Val(cS) 
        nLivAnoPubli:=I 
        cS:=cLivEditora 
        cS:=Digita(cS,30,46,13,black,lightgray,"T") 
        cLivEditora:=cS 
        cS:=alltrim(str(nLivVolume)) 
        cS:=Digita(cS,4,15,15,black,lightgray,"N") 
        I:=Val(cS) 
        nLivVolume:=I 
        cS:=cLivEstado 
        cS:=Digita(cS,1,38,15,black,lightgray,"T") 
        cLivEstado:=cS
        cS:=""
      
return

/*-------------------------------------------------------*/

/*
 Nome : VerificaLivros
 Descricao : funcao que verifica se os dados no formulario de livros
 foram digitados.
*/
function VerificaLivros()
  cS:=alltrim(str(nLivNinsc)) 
  if (len(cS) = 0) .and. (cS=replicate(" ",len(cS)))   
      rodape("Numero de Inscricao, nao cadastrado !"," ",yellow,red) 
      return(false)    
  endif 
  if (len(cLivTitulo) = 0) .and. (cLivTitulo=replicate(" ",len(cLivTitulo))) 
      rodape("Titulo, nao cadastrado !"," ",yellow,red) 
      return(false)   
  endif 
  if (len(cLivAutor) = 0) .and. (cLivAutor=replicate(" ",len(cLivAutor)))     
      rodape("Autor, nao cadastrado !"," ",yellow,red) 
      return(false)      
  endif 
  if (len(cLivArea) = 0) .and. (cLivArea=replicate(" ",len(cLivArea)))     
      rodape("Area, nao cadastrada !"," ",yellow,red) 
      return(false)      
  endif 
  if (len(cLivPchave) = 0) .and. (cLivPchave=replicate(" ",len(cLivPchave)))     
      rodape("Palavra-Chave, nao cadastrada !"," ",yellow,red) 
      return(false)      
  endif 
  cS:=alltrim(str(nLivEdicao)) 
  if (len(cS) = 0) .and. (cS=replicate(" ",len(cS)))     
      rodape("Edicao, nao cadastrada !"," ",yellow,red) 
      return(false)      
  endif 
  cS:=alltrim(str(nLivAnoPubli)) 
  if (len(cS) = 0) .and. (cS=replicate(" ",len(cS)))     
      rodape("Ano de Publicacao, nao cadastrado !"," ",yellow,red) 
      return(false)      
  endif 
  if (len(cLivEditora) = 0) .and. (cLivEditora=replicate(" ",len(cLivEditora)))     
      rodape("Editora, nao cadastrada !"," ",yellow,red) 
      return(false)      
  endif 
  cS:=alltrim(str(nLivVolume)) 
  if (len(cS) = 0) .and. (cS=replicate(" ",len(cS)))     
      rodape("Volume, nao cadastrado !"," ",yellow,red) 
      return(false)      
  endif 
  if (len(cLivEstado) = 0) .and. (cLivEstado=replicate(" ",len(cLivEstado)))     
      rodape("Estado, nao cadastrado !"," ",yellow,red) 
      return(false)      
  endif 

return(true) 

/*---------------------------------------------------------------*/

/*
 Nome : SalvarLivros
 Descricao : procedimento que salva os dados digitados no
 formulario de livros.
 Parametros :
 ntipo - indica qual acao a salvar
*/
procedure SalvarLivros(ntipo) 

if VerificaLivros()=true 
 if (cLivEstado="D") .or. (cLivEstado="E") 
    if ntipo=1 
        fseek(LivrosFile,nTamLivros*TamLiv,FS_SET)
        fatribuir(1,false)
        fwrite(LivrosFile,@cLivros,TamLiv) 
        AtrvLivros(true) 
        RotformLivros(0) 
        LimpLivros() 
    elseif ntipo=2
       fatribuir(1,false)
       fwrite(LivrosFile,@cLivros,TamLiv) 
    endif
 else
  rodape("Estado Atual, Cadastrado Incorretamente !"," ",yellow,red)
 endif
endif 

return

/******************Modulo de Usuarios**********************/

/*
 Nome : PesUsuarios
 Descricao : funcao que pesquisa as informacoes contidas no arquivo de
 usuarios.
 Parametros :
 ctipo - indica se e o valor e (N)umerico ou (S)tring
 ccampo - qual o campo a ser pesquisado
 nCod2 - codigo do campo se numerico
 sCod2 - codigo do campo se string
 nTamsCod - tamanho caracteres do campo de string
*/
function PesUsuarios(ctipo,ccampo,nCod2,sCod2,nTamsCod)
local nPosicao
local nCod
local sCod
local bFlag
local nRet

fseek(UsuariosFile,0,FS_SET) 
nPosicao:=0 
bFlag:=false 
nCod:=0 
sCod:="" 
do while (.Not.(nTamUsuarios=nPosicao)) 
   cUsuarios:=space(TamUsu)
   fread(UsuariosFile,@cUsuarios,TamUsu)
   fatribuir(2,true)

   if ctipo="N" 
       if ccampo="Ninsc" 
          nCod:=nUsuNinsc
       endif
       if (nCod=nCod2) 
          nRet:=nPosicao 
          fseek(UsuariosFile,nPosicao*TamUsu,FS_SET)
          bFlag:=true 
          exit 
       endif
   elseif ctipo="S" 
       if ccampo="Nome" 
          sCod:=cUsuNome
       elseif ccampo="Ident" 
          sCod:=cUsuIdent 
       endif

       if (substr(sCod,1,nTamsCod)=sCod2) 
          nRet:=nPosicao 
          fseek(UsuariosFile,nPosicao) 
          bFlag:=true 
          exit 
       endif 
   endif 
   nPosicao++
enddo 
 if (nTamUsuarios=nPosicao) .and. (bFlag=false)  
    return(-1)
 endif
return(nRet)

/*-----------------------------------------------------*/

/*
 Nome : PesBinaria
 Descricao : funcao que realiza uma pesquisa binaria
 por numero de inscricao do usuario.
 Parametros :
 nChave - numero de inscricao do usuario a pesquisar
*/
function PesBinaria(nChave)
local ninicio
local nfim
local nmeio
local lachou

 ninicio:=1 
 nfim:=nTamUsuarios+1 
 lachou:=false 
 do while ((.not.(lachou)) .and. (ninicio <= nfim)) 
   nmeio:=int((ninicio+nfim) / 2) 

   fseek(UsuariosFile,(nmeio-1)*TamUsu,FS_SET)
   cUsuarios:=space(TamUsu)
   fread(UsuariosFile,@cUsuarios,TamUsu)
   fatribuir(2,true)

   if (nchave=nUsuNinsc) 
      lachou:=true
   else
      if (nchave > nUsuNinsc) 
        ninicio:=nmeio+1
      else
        nfim:=nmeio-1
      endif
   endif 
 enddo 
 if lachou=true 
    return(nmeio-1)
 else
    return(-1)
 endif
return(1) 

/*-----------------------------------------------------*/

/*
 Nome : formUsuarios
 Descricao : procedimento que desenha o formulario de Usuarios na tela, e
 tambem indica qual acao a tomar.
 Parametros :
 ntipo - indica qual a acao do formulario
 ctitulo - o titulo do formulario
 crod - o texto do rodape sobre o formulario
*/
procedure formUsuarios(ntipo,ctitulo,crod) 

  teladefundo("±",white,lightblue) 
  rodape(crod," ",white,blue) 
  formulario(chr(180)+ctitulo+chr(195),4,2,18,76,white,blue,"±",lightgray,black) 

  vUsuarios[1]:=replicate(" ",5) 
  AtrvUsuarios(true) 
  AbrirArquivo(2) 
  if (ntipo=1) .or. (ntipo=2) 
     RotformUsuarios(0) 
     DesenhaBotao(20,48,black,lightgray,black,blue," Salvar ",false) 
     DesenhaBotao(20,63,black,lightgray,black,blue," Fechar ",false) 
  endif 
  if (ntipo=3) .or. (ntipo=4) .or. (ntipo=5) 
     DesenhaBotao(20,63,black,lightgray,black,blue," Fechar ",false) 
     RotformUsuarios(2) 
     Etexto(2,7,white,blue,chr(195)+replicate(chr(196),75)+chr(180)) 
  endif 
  if ntipo=6 
     DesenhaBotao(20,63,black,lightgray,black,blue," Fechar ",false)
  endif

  if ntipo=3 
     Etexto(5,6,white,blue,"Numero de Inscricao : ") 
     Etexto(27,6,black,lightgray,replicate(" ",5)) 
  endif 
  if ntipo=4 
     Etexto(5,6,white,blue,"Nome : ") 
     Etexto(12,6,black,lightgray,replicate(" ",30)) 
  endif 
  if ntipo=5 
     Etexto(5,6,white,blue,"Identidade : ") 
     Etexto(18,6,black,lightgray,replicate(" ",10)) 
  endif 

  LimpUsuarios() 
  if ntipo=1 
     CformUsuarios("2",1,0,0,crod,false)  /* cadastrar */
  elseif ntipo=2 
     CformUsuarios("1",2,0,0,crod,false)  /* alterar */
  elseif ntipo=3 
     CformUsuarios("3",3,0,0,crod,false) /* consultar por NInsc */
  elseif ntipo=4 
     CformUsuarios("4",4,0,0,crod,false) /* consultar por Nome */
  elseif ntipo=5 
     CformUsuarios("5",5,0,0,crod,false) /* consultar por Identidade */
  elseif ntipo=6 
     CformUsuarios("6",6,0,0,crod,true)  /* consultar todos */
  endif
return

/*-------------------------------------------*/

/*
 Nome : LimpUsuarios
 Descricao : procedimento limpa as iaveis do registro de usuarios.
*/
procedure LimpUsuarios()
     nUsuNinsc:=0 
     cUsuNome:="" 
     cUsuIdent:="0" 
     cEndLogra:="" 
     nEndNumero:=0 
     cEndCompl:="" 
     cEndBairro:="" 
     cEndCep:="0" 
     cUsuTelefone:="0" 
     cUsuCategoria:="" 
     nUsuSituacao:=0 
return

/*-------------------------------------------*/

/*
 Nome : RotformUsuarios
 Descricao : procedimento que escreve os rotulos do formulario de Usuarios.
 Parametros :
 nl - indica um acrescimo na linha do rotulo
*/
procedure RotformUsuarios(nl) 
  Etexto(5,6+nl,white,blue,"Numero de Inscricao : ") 
  Etexto(27,6+nl,black,lightgray,vUsuarios[1]) 
  Etexto(35,6+nl,white,blue,"Nome : ") 
  Etexto(42,6+nl,black,lightgray,vUsuarios[2]) 
  Etexto(5,8+nl,white,blue,"Identidade : ") 
  Etexto(18,8+nl,black,lightgray,vUsuarios[3]) 
  Etexto(2,10+nl,white,blue,chr(195)+replicate("Ä",75)+chr(180)) 
  Etexto(5,10+nl,white,blue,"Endereco") 
  Etexto(5,12+nl,white,blue,"Logradouro : ") 
  Etexto(18,12+nl,black,lightgray,vUsuarios[4]) 
  Etexto(51,12+nl,white,blue,"Numero : ") 
  Etexto(60,12+nl,black,lightgray,vUsuarios[5]) 
  Etexto(5,14+nl,white,blue,"Complemento : ") 
  Etexto(19,14+nl,black,lightgray,vUsuarios[6]) 
  Etexto(32,14+nl,white,blue,"Bairro : ") 
  Etexto(41,14+nl,black,lightgray,vUsuarios[7]) 
  Etexto(63,14+nl,white,blue,"Cep : ") 
  Etexto(69,14+nl,black,lightgray,vUsuarios[8]) 
  Etexto(2,16+nl,white,blue,chr(195)+replicate("Ä",75)+chr(180)) 
  Etexto(31,8+nl,white,blue,"Telefone : ") 
  Etexto(42,8+nl,black,lightgray,vUsuarios[9]) 
  Etexto(5,17+nl,white,blue,"Categoria : ") 
  Etexto(17,17+nl,black,lightgray,vUsuarios[10]) 
  Etexto(20,17+nl,white,blue,"(A)luno ou (P)rofessor ou (F)uncionario") 
  Etexto(5,19+nl,white,blue,"Situacao : ") 
  Etexto(16,19+nl,black,lightgray,vUsuarios[11]) 
return
/*-------------------------------------------*/

/*
 Nome : CformUsuarios
 Descricao : procedimento que realiza todo o controle de manuseio do
 formulario de Usuarios.
 Parametros :
 ctipo - indica qual a acao do formulario
 ntipo2 - indica a acao original do formulario nao manipulado pela funcao
 npos - indica a ultima posicao da linha da lista de usuarios
 ncol - indica a ultima posicao da coluna da lista de usuarios
 crod - o texto do rodape sobre o formulario
 lfoco - se os objetos do formulario estao focados ou nao
*/
procedure CformUsuarios(ctipo,ntipo2,npos,ncol,crod,lfoco) 
local nop

if ctipo="1" 
      cS:=Digita(cS,5,28,5,black,lightgray,"N")  /* N insc */
      I:=Val(cS) 
      nUsuNinsc:=I 
      if (len(cS) > 0) .and. (cS<>replicate(" ",len(cS)))       
         DesenhaBotao(20,48,black,lightgray,black,blue," Salvar ",false) 
         if PesUsuarios("N","Ninsc",I,"",0)<>-1 
                AtrvUsuarios(false) 
                RotformUsuarios(0) 
                rodape(crod," ",white,blue) 
                CformUsuarios("2",ntipo2,npos,ncol,crod,false) 
         else
            cS:=alltrim(str(I)) 
            AtrvUsuarios(true) 
            RotformUsuarios(0) 
            rodape("Numero de Inscricao, nao encontrado !"," ",yellow,red) 
            CformUsuarios("Fechar",ntipo2,npos,ncol,crod,true) 
         endif 
      else
        CformUsuarios("Fechar",ntipo2,npos,ncol,crod,true) 
      endif
elseif ctipo="2" 
        if ntipo2=1
            nTamUsuarios:=fseek(UsuariosFile,0,FS_END)
            nTamUsuarios:=int(nTamUsuarios / TamUsu)
            fseek(UsuariosFile,0,FS_SET)

            if nTamUsuarios = 0 
               nUsuNinsc:=1
            else
                nUsuNinsc:=nTamUsuarios + 1 
            endif 
            I:=nUsuNinsc 
            cS:=alltrim(str(nUsuNinsc)) 
            Etexto(27,6,black,lightgray,cS) 
            cS:="" 
        elseif ntipo2=2 
            AbrirArquivo(2) 
            if PesUsuarios("N","Ninsc",I,"",0)=-1 
              rodape("Numero de Inscricao, nao encontrado !"," ",yellow,red)
            endif
        endif 
          DformUsuarios() 
      
      CformUsuarios("Salvar",ntipo2,npos,ncol,crod,true) 

elseif ctipo="3" 

      cS:="" 
      cS:=Digita(cS,5,28,5,black,lightgray,"N")  /* N insc */
      I:=Val(cS)
      nUsuNinsc:=I 
      if (len(cS) > 0) .and. (cS<>replicate(" ",len(cS))) 
         if PesBinaria(I)<>-1 
            AtrvUsuarios(false) 
            RotformUsuarios(2) 
            rodape(crod," ",white,blue) 
         else
            AtrvUsuarios(true) 
            RotformUsuarios(2) 
            rodape("Numero de Inscricao, nao encontrado !"," ",yellow,red) 
         endif 
      endif 
        CformUsuarios("Fechar",ntipo2,npos,ncol,crod,true) 

elseif ctipo="4" 

      cS:="" 
      cS:=Digita(cS,30,13,5,black,lightgray,"T") 
      cUsuNome:=cS 
      if (len(cS) > 0) .and. (cS<>replicate(" ",len(cS))) 
         if PesUsuarios("S","Nome",0,cS,len(cS))<>-1 
              AtrvUsuarios(false) 
              RotformUsuarios(2) 
              rodape(crod," ",white,blue) 
         else
            AtrvUsuarios(true) 
            RotformUsuarios(2) 
            rodape("Nome do Usuario, nao encontrado !"," ",yellow,red) 
         endif 
      endif 
        CformUsuarios("Fechar",ntipo2,npos,ncol,crod,true) 

elseif ctipo="5" 

      cS:="" 
      cS:=Digita(cS,10,19,5,black,lightgray,"N") 
      cUsuIdent:=cS 
      if (len(cS) > 0) .and. (cS<>replicate(" ",len(cS))) 
         if PesUsuarios("N","Ident",0,cS,len(cS))<>-1 
              AtrvUsuarios(false) 
              RotformUsuarios(2) 
              rodape(crod," ",white,blue) 
         else
            AtrvUsuarios(true) 
            RotformUsuarios(2) 
            rodape("Identidade do Usuario, nao encontrada !"," ",yellow,red) 
         endif 
      endif 
        CformUsuarios("Fechar",ntipo2,npos,ncol,crod,true) 

elseif ctipo="6" 
    nListapos:=npos
    nListacol:=ncol
    if lista(2,6,5,13,70,nTamUsuarios+2,194,white,blue,lfoco)=1 
        desenhalista(2,6,5,13,70,white,blue,npos,ncol,false) 
        CformUsuarios("Fechar",ntipo2,npos,ncol,crod,true) 
    endif 
elseif ctipo="Salvar" 
    nop:=Botao(20,48,black,lightgray,black,blue," Salvar ",lfoco)
    do case
      case nop=1
          DesenhaBotao(20,48,black,lightgray,black,blue," Salvar ",false) 
          CformUsuarios("Fechar",ntipo2,npos,ncol,crod,true) 
      case nop=2
          SalvarUsuarios(ntipo2) 
          DesenhaBotao(20,48,black,lightgray,black,blue," Salvar ",false) 
          CformUsuarios("Fechar",ntipo2,npos,ncol,crod,true) 
    endcase 

elseif ctipo = "Fechar" 
    nop:=Botao(20,63,black,lightgray,black,blue," Fechar ",lfoco)
    do case
      case nop=1
          DesenhaBotao(20,63,black,lightgray,black,blue," Fechar ",false) 
          if ntipo2=1 
            CformUsuarios("2",ntipo2,npos,ncol,crod,true)
          elseif ntipo2=2 
            CformUsuarios("1",ntipo2,npos,ncol,crod,false)
          elseif ntipo2=3 
            CformUsuarios("3",ntipo2,npos,ncol,crod,false)
          elseif ntipo2=4 
            CformUsuarios("4",ntipo2,npos,ncol,crod,false)
          elseif ntipo2=5 
            CformUsuarios("5",ntipo2,npos,ncol,crod,false)
          elseif ntipo2=6 
            CformUsuarios("6",ntipo2,npos,ncol,crod,true)
          endif
      case nop=2
         rodape(""," ",white,blue) 
         fclose(UsuariosFile) 
    endcase 
endif 

return

/*-------------------------------------------------------*/

/*
 Nome : AtrvUsuarios
 Descricao : procedimento que atribui ou limpa o vetor de Usuarios.
 Parametros :
 llimpar - indica se vai limpar ou atribuir os vetores
*/
procedure AtrvUsuarios(llimpar) 

if llimpar=false 
      cS:=alltrim(str(nUsuNinsc)) 
      vUsuarios[1]:=cS 
      vUsuarios[2]:=cUsuNome 
      vUsuarios[3]:=cUsuIdent 
      vUsuarios[4]:=cEndLogra 
      cS:=alltrim(str(nEndnumero)) 
      vUsuarios[5]:=cS 
      vUsuarios[6]:=cEndCompl 
      vUsuarios[7]:=cEndBairro 
      vUsuarios[8]:=cEndCep 
      vUsuarios[9]:=cUsuTelefone 
      vUsuarios[10]:=cUsuCategoria 
      cS:=alltrim(str(nUsuSituacao)) 
      vUsuarios[11]:=cS 
else
  vUsuarios[2]:=replicate(" ",30) 
  vUsuarios[3]:=replicate(" ",10) 
  vUsuarios[4]:=replicate(" ",30) 
  vUsuarios[5]:=replicate(" ",5) 
  vUsuarios[6]:=replicate(" ",10) 
  vUsuarios[7]:=replicate(" ",20) 
  vUsuarios[8]:=replicate(" ",8) 
  vUsuarios[9]:=replicate(" ",11) 
  vUsuarios[10]:=replicate(" ",1) 
  vUsuarios[11]:=replicate(" ",1) 
endif 
return

/*-------------------------------------------------------*/

/*
 Nome : DformUsuarios
 Descricao : procedimento que realiza o cotrole de digitacao dos dados no
 formulario de usuarios.
*/
procedure DformUsuarios()
        cS:=cUsuNome 
        cS:=Digita(cS,30,43,5,black,lightgray,"T") 
        cUsuNome:=cS 
        cS:=cUsuIdent 
        cS:=Digita(cS,10,19,7,black,lightgray,"N") 
        cUsuIdent:=cS 
        cS:=cUsuTelefone 
        cS:=Digita(cS,11,43,7,black,lightgray,"N") 
        cUsuTelefone:=cS 
        cS:=cEndLogra 
        cS:=Digita(cS,30,19,11,black,lightgray,"T") 
        cEndLogra:=cS 
        cS:=alltrim(Str(nEndnumero)) 
        cS:=Digita(cS,5,61,11,black,lightgray,"N") 
        I:=Val(cS)
        nEndnumero:=I 
        cS:=cEndcompl 
        cS:=Digita(cS,10,20,13,black,lightgray,"T") 
        cEndcompl:=cS 
        cS:=cEndBairro 
        cS:=Digita(cS,20,42,13,black,lightgray,"T") 
        cEndBairro:=cS 
        cS:=cEndCep 
        cS:=Digita(cS,8,70,13,black,lightgray,"N") 
        cEndCep:=cS 
        cS:=cUsuCategoria 
        cS:=Digita(cS,1,18,16,black,lightgray,"T") 
        cUsuCategoria:=cS 
        cS:=alltrim(str(nUsuSituacao)) 
        cS:=Digita(cS,1,17,18,black,lightgray,"N") 
        I:=Val(cS)
        nUsuSituacao:=I 
        cS:="" 
return

/*-------------------------------------------------------*/

/*
 Nome : VerificaUsuarios
 Descricao : funcao que verifica se os dados no formulario de usuarios
 foram digitados.
*/
function VerificaUsuarios()

  cS:=alltrim(str(nUsuNinsc)) 
  if (len(cS) = 0) .and. (cS=replicate(" ",len(cS))) 
      rodape("Numero de Inscricao, nao cadastrado !"," ",yellow,red) 
      return(false) 
  endif 
  if (len(cUsuNome) = 0) .and. (cUsuNome=replicate(" ",len(cUsuNome)))  
      rodape("Nome do Usuario, nao cadastrado !"," ",yellow,red) 
      return(false)      
  endif 
  if (len(cUsuIdent) = 0) .and. (cUsuIdent=replicate(" ",len(cUsuIdent)))     
      rodape("Identidade, nao cadastrada !"," ",yellow,red) 
      return(false)      
  endif 
  if (len(cEndlogra) = 0) .and. (cEndlogra=replicate(" ",len(cEndlogra)))     
      rodape("Logradouro, nao cadastrado !"," ",yellow,red) 
      return(false)      
  endif 
  cS:=alltrim(str(nEndnumero))
  if (len(cS) = 0) .and. (cS=replicate(" ",len(cS)))     
      rodape("Numero do Endereco, nao cadastrado !"," ",yellow,red) 
      return(false)      
  endif 
  if (len(cEndcompl) = 0) .and. (cEndcompl=replicate(" ",len(cEndcompl)))     
      rodape("Complemento do Endereco, nao cadastrado !"," ",yellow,red) 
      return(false)      
  endif 
  if (len(cEndBairro) = 0) .and. (cEndBairro=replicate(" ",len(cEndBairro)))     
      rodape("Bairro, nao cadastrado !"," ",yellow,red) 
      return(false)      
  endif 
  if (len(cEndCep) = 0) .and. (cEndCep=replicate(" ",len(cEndCep)))     
      rodape("Cep, nao cadastrado !"," ",yellow,red) 
      return(false)      
  endif 
  if (len(cUsuTelefone) = 0) .and. (cUsuTelefone=replicate(" ",len(cUsuTelefone)))     
      rodape("Telefone, nao cadastrado !"," ",yellow,red) 
      return(false)      
  endif 
  if (len(cUsuCategoria) = 0) .and.;
     (cUsuCategoria=replicate(" ",len(cUsuCategoria)))     
      rodape("Categoria, nao cadastrada !"," ",yellow,red) 
      return(false)      
  endif 

return(true) 

/*---------------------------------------------------------------*/

/*
 Nome : SalvarUsuarios
 Descricao : procedimento que salva os dados digitados no
 formulario de usuarios.
 Parametros :
 ntipo - indica qual acao a sal
*/
procedure SalvarUsuarios(ntipo) 

if VerificaUsuarios()=true 
 if (cUsuCategoria="A") .or. (cUsuCategoria="P") .or. (cUsuCategoria="F") 
    if ntipo=1 
        fseek(UsuariosFile,nTamUsuarios*TamUsu,FS_SET)
        fatribuir(2,false)
        fwrite(UsuariosFile,@cUsuarios,TamUsu) 

        AtrvUsuarios(true) 
        RotformUsuarios(0) 
        LimpUsuarios()
    elseif ntipo=2 
        fatribuir(2,false)
        fwrite(UsuariosFile,@cUsuarios,TamUsu) 
    endif
 else
  rodape("Categoria, Cadastrada Incorretamente !"," ",yellow,red)
 endif
endif 

return

/***************Modulo de Emprestimos e Devolucoes*******************/

/*
 Nome : RetDataAtual
 Descricao : funcao que retorna a data atual do sistema
*/
function RetDataAtual()
return(dtoc(date()))

/*--------------------------------------------------------*/

/*
 Nome : ConverteData
 Descricao : funcao que converte a data em string para numero.
 Parametros :
 cdt - data a ser convertida
*/
function ConverteData(cdt)
local sAux
local nAux

 sAux:=substr(cdt,7,4)+substr(cdt,4,2)+substr(cdt,1,2) 
 nAux:=Val(sAux) 

return(nAux)

/*--------------------------------------------------------*/

/*
 Nome : SubtraiDatas
 Descricao : funcao que subtrai duas datas e retorna o numero de dias
 Parametros :
 cdt1 - data inicial
 cdt2 - data final
*/
function SubtraiDatas(cdt1,cdt2)
local ndia;local nmes;local nano;local ndia1;local nmes1;local nano1
local ndia2;local nmes2;local nano2;local ni;local nc;local ndias
local nudiames[12]

 ndias:=0 
 nudiames[1]:=31 
 nudiames[2]:=28 
 nudiames[3]:=31 
 nudiames[4]:=30 
 nudiames[5]:=31 
 nudiames[6]:=30 
 nudiames[7]:=31 
 nudiames[8]:=31 
 nudiames[9]:=30 
 nudiames[10]:=31 
 nudiames[11]:=30 
 nudiames[12]:=31 

 ni:=val(substr(cdt1,1,2)) 
 ndia1:=ni 
 ni:=val(substr(cdt1,4,2)) 
 nmes1:=ni 
 ni:=val(substr(cdt1,7,4)) 
 nano1:=ni 

 ni:=val(substr(cdt2,1,2)) 
 ndia2:=ni 
 ni:=val(substr(cdt2,4,2)) 
 nmes2:=ni 
 ni:=val(substr(cdt2,7,4)) 
 nano2:=ni 

 for nano:=nano1 to nano2 
    for nmes:=nmes1 to 12 
       /* ano bissexto */
       if (nano % 4)=0 
         nudiames[2]:=29
       endif
       /* data final */
       if (nano=nano2) .and. (nmes=nmes2) 
         nudiames[nmes2]:=ndia2
       endif
       for ndia:=ndia1 to nudiames[nmes] 
          ndias++
       next
       if (nano=nano2) .and. (nmes=nmes2) 
           return(ndias-1) 
           exit
       endif
       ndia1:=1
    next
    nmes1:=1 
 next

return(1)

/*--------------------------------------------------------*/

/*
 Nome : SomaDias
 Descricao : funcao que soma um determinado numero de dias a uma data.
 Parametros :
 cdt1 - a data a ser somada
 nqtddias - numero de dias a serem somados
*/
function SomaDias(cdt1,nqtddias)
local ndia;local nmes;local nano;local ndia1;local nmes1;local nano1
local ndia2;local nmes2;local nano2;local ni;local nc;local ndias
local nudiames[12]
local sAux;local sAux2

 ndias:=0 
 nudiames[1]:=31 
 nudiames[2]:=28 
 nudiames[3]:=31 
 nudiames[4]:=30 
 nudiames[5]:=31 
 nudiames[6]:=30 
 nudiames[7]:=31 
 nudiames[8]:=31 
 nudiames[9]:=30 
 nudiames[10]:=31 
 nudiames[11]:=30 
 nudiames[12]:=31 

 ni:=val(substr(cdt1,1,2)) 
 ndia1:=ni 
 ni:=val(substr(cdt1,4,2)) 
 nmes1:=ni 
 ni:=val(substr(cdt1,7,4)) 
 nano1:=ni 

 nano2:=nano1 + int(nqtddias / 365) 

 for nano:=nano1 to nano2 
    for nmes:=nmes1 to 12 
       /* ano bissexto */
       if (nano % 4)=0 
         nudiames[2]:=29
       endif
       for ndia:=ndia1 to nudiames[nmes] 
            ndias++
            if ndias=nqtddias+1 
                sAux:=alltrim(str(ndia)) 
                sAux2:=replicate("0",2-len(sAux))+sAux+"/" 
                sAux:=alltrim(str(nmes)) 
                sAux2:=sAux2+replicate("0",2-len(sAux))+sAux+"/" 
                sAux:=alltrim(str(nano)) 
                sAux2:=sAux2+replicate("0",4-len(sAux))+sAux 
                return(sAux2) 
                exit 
            endif 
       next
       ndia1:=1 
    next
    nmes1:=1 
 next 

return(1)

/*--------------------------------------------------------*/

/*
 Nome : PesEmprestimos
 Descricao : funcao que pesquisa as informacoes contidas no arquivo de
 Emprestimos.
 Parametros :
 nCodUsuario - codigo do campo de numero de inscricao do usuario
 nCodLivro - codigo do campo de numero de inscricao do livro
*/
function PesEmprestimos(nCodUsuario,nCodLivro)
local nPosicao
local bFlag
local nRet

fseek(EmprestimosFile,0,FS_SET) 
nPosicao:=0 
bFlag:=false 
do while (.Not.(nTamEmprestimos=nPosicao))
   cEmprestimos:=space(TamEmp)
   fread(EmprestimosFile,@cEmprestimos,TamEmp)
   fatribuir(3,true)

   if (nEmpNinscUsuario=nCodUsuario) .and. (nEmpNinscLivro=nCodLivro) 
      nRet:=nPosicao 
      fseek(EmprestimosFile,nPosicao*TamEmp,FS_SET)
      bFlag:=true 
      exit 
   endif 
   nPosicao++
enddo 
 if (nTamEmprestimos=nPosicao) .and. (bFlag=false)
    nEmpNinscUsuario:=nCodUsuario
    nEmpNinscLivro:=nCodLivro
    return(-1)
 endif
return(nRet)

/*-----------------------------------------------------*/

/*
 Nome : formEmprestimos
 Descricao : procedimento que desenha o formulario de Emprestimos
 na tela, e tambem indica qual acao a tomar.
 Parametros :
 ntipo - indica qual a acao do formulario
 ctitulo - o titulo do formulario
 crod - o texto do rodape sobre o formulario
*/
procedure formEmprestimos(ntipo,ctitulo,crod) 

  teladefundo("±",white,lightblue) 
  rodape(crod," ",white,blue)   
  formulario(chr(180)+ctitulo+chr(195),4,2,18,76,white,blue,"±",lightgray,black) 

  vEmprestimos[1]:=replicate(" ",5) 
  AtrvEmprestimos(true) 
  AbrirArquivo(1) 
  AbrirArquivo(2) 
  AbrirArquivo(3) 
  if ntipo=1 
     RotformEmprestimos(1,0) 
     DesenhaBotao(20,45,black,lightgray,black,blue," Emprestar ",false) 
     DesenhaBotao(20,60,black,lightgray,black,blue," Fechar ",false) 
  endif 
  if ntipo=2 
     RotformEmprestimos(2,0) 
     DesenhaBotao(20,45,black,lightgray,black,blue," Devolver ",false) 
     DesenhaBotao(20,60,black,lightgray,black,blue," Fechar ",false) 
  endif 
  if ntipo=3 
     DesenhaBotao(20,60,black,lightgray,black,blue," Fechar ",false)
  endif

  LimpEmprestimos() 
  if ntipo=1 
     CformEmprestimos("1",1,0,0,crod,false)  /* Emprestar */
  elseif ntipo=2 
     CformEmprestimos("1",2,0,0,crod,false)  /* Devolver */
  elseif ntipo=3 
     CformEmprestimos("2",3,0,0,crod,true)   /* consultar todos */
  endif
return

/*-------------------------------------------*/

/*
 Nome : LimpEmprestimos()
 Descricao : procedimento limpa as iaveis do registro de Emprestimos.
*/
procedure LimpEmprestimos() 
     nEmpNinscUsuario:=0 
     nEmpNinscLivro:=0 
     cEmpDtEmprestimo:=RetDataAtual() 
     /*cEmpDtDevolucao:=RetDataAtual() */
     lEmpRemovido:=false 
return

/*-------------------------------------------*/

/*
 Nome : RotformEmprestimos
 Descricao : procedimento que escreve os rotulos do formulario de
 Emprestimos.
 Parametros :
 ntipo - indica qual a acao do formulario
 nl - indica um acrescimo na linha do rotulo
*/
procedure RotformEmprestimos(ntipo,nl) 

if (ntipo=1) .or. (ntipo=2)
  Etexto(5,6+nl,white,blue,"Numero de Inscricao do Usuario : ") 
  Etexto(38,6+nl,black,lightgray,vEmprestimos[1]) 
  Etexto(5,8+nl,white,blue,"Usuario : ") 
  Etexto(16,8+nl,black,lightgray,replicate(" ",30)) 
  Etexto(49,8+nl,white,blue,"Categoria : ") 
  Etexto(5,10+nl,white,blue,"Numero de Inscricao do Livro : ") 
  Etexto(36,10+nl,black,lightgray,vEmprestimos[2]) 
  Etexto(5,12+nl,white,blue,"Livro : ") 
  Etexto(13,12+nl,black,lightgray,replicate(" ",30)) 
  Etexto(46,12+nl,white,blue,"Estado : ") 
  Etexto(5,14+nl,white,blue,"Data do Emprestimo : ") 
  Etexto(27,14+nl,black,lightgray,vEmprestimos[3]) 
  Etexto(40,14+nl,white,blue,"Data de Devolucao : ") 
  Etexto(61,14+nl,black,lightgray,vEmprestimos[4]) 
endif 
if ntipo=2 
  Etexto(5,16+nl,white,blue,"Dias em Atraso : ") 
  Etexto(23,16+nl,black,lightgray,replicate(" ",4)) 
  Etexto(31,16+nl,white,blue,"Multa por dias em atraso : ") 
  Etexto(59,16+nl,black,lightgray,replicate(" ",7)) 
endif 
return
/*-------------------------------------------*/

/*
 Nome : CformEmprestimos
 Descricao : procedimento que realiza todo o controle de manuseio do
 formulario de Emprestimos.
 Parametros :
 ctipo - indica qual a acao do formulario
 ntipo2 - indica a acao original do formulario nao manipulado pela funcao
 npos - indica a ultima posicao da linha da lista de emprestimos
 ncol - indica a ultima posicao da coluna da lista de emprestimos
 crod - o texto do rodape sobre o formulario
 lfoco - se os objetos do formulario estao focados ou nao
*/
procedure CformEmprestimos(ctipo,ntipo2,npos,ncol,crod,lfoco) 
local sDiasAtraso
local sMulta
local nDiasAtraso
local nMulta
local nop

if ctipo="1" 
  cS:=""
  rodape(""," ",white,blue)
  Etexto(61,8,white,blue,"")
  Etexto(55,12,white,blue,"")
  Etexto(23,16,black,lightgray,"")
  Etexto(59,16,black,lightgray,"")
  cS:=Digita(cS,5,39,5,black,lightgray,"N")
  I:=Val(cS)
  nUsuNinsc:=I
  nEmpNinscUsuario:=I
  if (len(cS) > 0) .and. (cS<>replicate(" ",len(cS))) 
    if PesUsuarios("N","Ninsc",I,"",0)<>-1 
      Etexto(16,8,black,lightgray,cUsuNome)
      if cUsuCategoria="F" 
         Etexto(61,8,white,blue,"Funcionario")
      elseif cUsuCategoria="A" 
         Etexto(61,8,white,blue,"Aluno      ")
      elseif cUsuCategoria="P" 
         Etexto(61,8,white,blue,"Professor  ")
      endif
      cS:=""
      cS:=Digita(cS,5,37,9,black,lightgray,"N")
      I:=Val(cS)
      nLivNinsc:=I
      nEmpNinscLivro:=I
      if (len(cS) > 0) .and. (cS<>replicate(" ",len(cS))) 
        if PesLivros("N","Ninsc",I,"",0)<>-1 
           Etexto(13,12,black,lightgray,cLivTitulo)
           if cLivEstado="D" 
             Etexto(55,12,white,blue,"Disponivel")
           else
             Etexto(55,12,white,blue,"Emprestado")
           endif

           /* Emprestimo */

           if tipo2=1 
              if cLivEstado="D" 
                if cUsuSituacao < 4 
                   if cUsuCategoria="F" 
                     cEmpDtDevolucao:=SomaDias(RetDataAtual,7)
                   elseif cUsuCategoria="A" 
                     cEmpDtDevolucao:=SomaDias(RetDataAtual,14)
                   elseif cUsuCategoria="P" 
                     cEmpDtDevolucao:=SomaDias(RetDataAtual,30)
                   endif
                   cEmpDtEmprestimo:=RetDataAtual
                   nUsuSituacao++
                   cLivEstado:="E"
                   Etexto(27,14,black,lightgray,cEmpDtEmprestimo)
                   Etexto(61,14,black,lightgray,cEmpDtDevolucao)
                   CformEmprestimos("Emprestar",ntipo2,npos,ncol,crod,true)
                else
                   rodape("Usuario com 4 livros em sua posse, Impossivel "+;
                   "Efetuar Emprestimo !"," ",yellow,red)
                   CformEmprestimos("Fechar",ntipo2,npos,ncol,crod,true)
                endif
              else
                rodape("O livro ja esta emprestado, Impossivel "+;
                "Efetuar Emprestimo !"," ",yellow,red)
                CformEmprestimos("Fechar",ntipo2,npos,ncol,crod,true)
              endif
             /* Devolucao */
           elseif tipo2=2 
              if PesEmprestimos(nUsuNinsc,nLivNinsc)<>-1 
                 if cLivEstado="E" 
                   if ((nUsuSituacao >= 1) .and. (nUsuSituacao <= 4)) 
                      if ConverteData(cEmpDtDevolucao) < ConverteData(RetDataAtual) 
                         nDiasAtraso:=0
                         nMulta:=0.0
                         nDiasAtraso:=SubtraiDatas(cEmpDtDevolucao,RetDataAtual)
                         nMulta:=(0.5 * nDiasAtraso)
                      else
                         nDiasAtraso:=0
                         nMulta:=0.0
                      endif
                      sDiasAtraso:=alltrim(str(nDiasAtraso))
                      sMulta:=alltrim(str(nMulta))
                      Etexto(27,14,black,lightgray,cEmpDtEmprestimo)
                      Etexto(61,14,black,lightgray,cEmpDtDevolucao)
                      Etexto(23,16,black,lightgray,sDiasAtraso)
                      Etexto(59,16,black,lightgray,sMulta)
                      nUsuSituacao--
                      cLivEstado:="D"
                      CformEmprestimos("Devolver",ntipo2,npos,ncol,crod,true)
                   else
                     rodape("Usuario com 0 livros em sua posse, Impossivel "+;
                     "Efetuar Devolucao !"," ",yellow,red)
                     CformEmprestimos("Fechar",ntipo2,npos,ncol,crod,true)
                   endif
                 else
                   rodape("O livro ja esta disponivel, Impossivel "+;
                   "Efetuar Devolucao !"," ",yellow,red)
                   CformEmprestimos("Fechar",ntipo2,npos,ncol,crod,true)
                 endif
               else
                 rodape("Emprestimo inexistente, Impossivel "+;
                 "Efetuar Devolucao !"," ",yellow,red)
                 CformEmprestimos("Fechar",ntipo2,npos,ncol,crod,true)
               endif
           endif
             /* --- */
        else
          S:=alltrim(str(I))
          AtrvEmprestimos(true)
          RotformEmprestimos(ntipo2,0)
          rodape("Numero de Inscricao do Livro, nao encontrado !",;
          " ",yellow,red)
          CformEmprestimos("Fechar",ntipo2,npos,ncol,crod,true)
        endif
      else
        CformEmprestimos("Fechar",ntipo2,npos,ncol,crod,true)
      endif
    else
      S:=alltrim(str(I))
      AtrvEmprestimos(true)
      RotformEmprestimos(ntipo2,0)
      rodape("Numero de Inscricao do Usuario, nao encontrado !",;
      " ",yellow,red)
      CformEmprestimos("Fechar",ntipo2,npos,ncol,crod,true)
    endif
  else
    CformEmprestimos("Fechar",ntipo2,npos,ncol,crod,true)
  endif
elseif ctipo="2" 
   nListapos=npos
   nListacol=ncol
   if lista(3,6,5,13,70,nTamEmprestimos+2,113,white,blue,lfoco)=1 
        desenhalista(3,6,5,13,70,white,blue,npos,ncol,false) 
        CformEmprestimos("Fechar",ntipo2,npos,ncol,crod,true) 
   endif 
elseif ctipo="Emprestar" 
    nop:=Botao(20,45,black,lightgray,black,blue," Emprestar ",lfoco)
    do case
      case nop=1
          DesenhaBotao(20,45,black,lightgray,black,blue," Emprestar ",false) 
          CformEmprestimos("Fechar",ntipo2,npos,ncol,crod,true) 
      case nop=2
          if PesEmprestimos(nUsuNinsc,nLivNinsc)<>-1 
            lEmpRemovido:=false
            SalvarEmprestimos(2)
          else
            lEmpRemovido:=false
            nTamEmprestimos:=fseek(EmprestimosFile,0,FS_END)
            nTamEmprestimos:=int(nTamEmprestimos / TamEmp)
            fseek(EmprestimosFile,0,FS_SET)
            SalvarEmprestimos(1)
          endif
          DesenhaBotao(20,45,black,lightgray,black,blue," Emprestar ",false) 
          CformEmprestimos("Fechar",ntipo2,npos,ncol,crod,true) 
    endcase 
elseif ctipo="Devolver" 
    nop:=Botao(20,45,black,lightgray,black,blue," Devolver ",lfoco)
    do case
      case nop=1
          DesenhaBotao(20,45,black,lightgray,black,blue," Devolver ",false) 
          CformEmprestimos("Fechar",ntipo2,npos,ncol,crod,true) 
      case nop=2
          lEmpRemovido:=true 
          SalvarEmprestimos(2) 
          DesenhaBotao(20,45,black,lightgray,black,blue," Devolver ",false) 
          CformEmprestimos("Fechar",ntipo2,npos,ncol,crod,true) 
    endcase 
elseif ctipo = "Fechar" 
    nop:=Botao(20,60,black,lightgray,black,blue," Fechar ",lfoco)
    do case
      case nop=1
          DesenhaBotao(20,60,black,lightgray,black,blue," Fechar ",false) 
          if (ntipo2=1) .or. (ntipo2=2) 
            CformEmprestimos("1",ntipo2,npos,ncol,crod,true)
          elseif ntipo2=3 
            CformEmprestimos("2",ntipo2,npos,ncol,crod,true)
          endif
      case nop=2
         rodape(""," ",white,blue) 
         fclose(LivrosFile) 
         fclose(UsuariosFile) 
         fclose(EmprestimosFile) 
    endcase 
endif 

return

/*-------------------------------------------------------*/

/*
 Nome : AtrvEmprestimos
 Descricao : procedimento que atribui ou limpa o vetor de Emprestimos.
 Parametros :
 llimpar - indica se vai limpar ou atribuir os vetores
*/
procedure AtrvEmprestimos(llimpar) 

if llimpar=false 
  vEmprestimos[3]:=cEmpDtEmprestimo 
  vEmprestimos[4]:=cEmpDtDEvolucao 
else
  vEmprestimos[2]:=replicate(" ",5) 
  vEmprestimos[3]:=replicate(" ",10) 
  vEmprestimos[4]:=replicate(" ",10) 
endif

return

/*-------------------------------------------------------*/

/*
 Nome : SalvarEmprestimos
 Descricao : procedimento que salva os dados digitados no
 formulario de emprestimos.
 Parametros :
 ntipo - indica qual acao a sal
*/
procedure SalvarEmprestimos(ntipo) 

    fatribuir(1,false)
    fwrite(LivrosFile,@cLivros,TamLiv) 
    fatribuir(2,false)
    fwrite(UsuariosFile,@cUsuarios,TamUsu) 
    if ntipo=1 
        fseek(EmprestimosFile,nTamEmprestimos*TamEmp,FS_SET)
        fatribuir(3,false)
        fwrite(EmprestimosFile,@cEmprestimos,TamEmp) 
        AtrvEmprestimos(true) 
        RotformEmprestimos(1,0) 
    elseif ntipo=2 
        fatribuir(3,false)
        fwrite(EmprestimosFile,@cEmprestimos,TamEmp) 
        AtrvEmprestimos(true) 
        RotformEmprestimos(1,0) 
    endif 
return

/********************Modulo de Opcoes***********************/

/*
 Nome : formSair
 Descricao : procedimento que desenha o formulario de sair.
*/
procedure formSair()
  teladefundo("±",white,lightblue)
  rodape("Alterta !, Aviso de Saida do Sistema."," ",yellow,red)
  formulario(chr(180)+"Sair do Sistema"+chr(195),10,25,6,27,white,blue,"±",lightgray,black)
  Etexto(27,12,white,blue,"Deseja Sair do Sistema ?")
  DesenhaBotao(14,40,black,lightgray,black,blue," Nao ",false)
  CformSair(" Sim ",true)
return

/*-------------------------------------------*/

/*
 Nome : CformSair
 Descricao : procedimento que realiza todo o controle de manuseio do
 formulario de Saida.
 Parametros :
 ctipo - indica qual acao a executar
 lfoco - indica quais objeto terao foco
*/
procedure CformSair(ctipo,lfoco)
local nbp

if ctipo=" Sim " 
    nbp:=Botao(14,30,black,lightgray,black,blue," Sim ",lfoco)
    do case
      case nbp=1
          DesenhaBotao(14,30,black,lightgray,black,blue," Sim ",false)
          CformSair(" Nao ",true)
      case nbp=2
          setcolor(lightgray+"/"+black)
          cls
          formSplash()
          setcursor(SC_NORMAL)
          setcolor(lightgray+"/"+black)
          cls
          quit
    endcase
elseif ctipo=" Nao " 
    nbp:=Botao(14,40,black,lightgray,black,blue," Nao ",lfoco)
    do case 
      case nbp=1
          DesenhaBotao(14,40,black,lightgray,black,blue," Nao ",false)
          CformSair(" Sim ",true)
      case nbp=2
          rodape(""," ",white,blue)
    endcase
endif

return

/*-------------------------------------------*/

/*
 Nome : formSobre
 Descricao : procedimento que desenha o formulario de Sobre.
*/
procedure formSobre()
  teladefundo("±",white,lightblue)
  rodape("Informacoes sobre o sistema."," ",white,blue)
  formulario(chr(180)+"Sobre o Sistema"+chr(195),4,2,18,76,white,blue,"±",lightgray,black)
  LerArquivoSobre()
  desenhaBotao(20,63,black,lightgray,black,blue," Fechar ",false)
  CformSobre("Lista",0,0,true)
return

/*-----------------------------------------------------*/

/*
 Nome : LerArquivoSobre
 Descricao : procedimento que le o arquivo de sobre a atribui ao vetor
 de lista.
*/
procedure LerArquivoSobre()
local ncont
local ncont2
local clinha

 AbrirArquivo(4)
 clinha:=space(1)
 for ncont:=1 to 51
   vLista[ncont]:=space(1)
 next
 ncont:=1
 ncont2:=0

 do while true
  if nTamSobre > ncont2
     fread(SobreFile,@clinha,1)
     ncont2++
     if clinha=chr(13)  
        ncont++
        fread(SobreFile,@clinha,1)
     else
        vLista[ncont]:=vLista[ncont]+clinha
     endif
  else
     exit
  endif
 enddo
return

/*-----------------------------------------------------*/

/*
 Nome : CformSobre
 Descricao : procedimento que realiza todo o controle de manuseio do
 formulario de Sobre.
 Parametros :
 ctipo - indica qual acao a executar
 npos - indica a ultima posicao da linha da lista de sobre
 ncol - indica a ultima posicao da coluna da lista de sobre
 lfoco - indica quais objeto terao foco
*/
procedure CformSobre(ctipo,npos,ncol,lfoco)
local nop:=0

if ctipo="Fechar"
    nop:=Botao(20,63,black,lightgray,black,blue," Fechar ",lfoco)
    do case
      case nop=1
          DesenhaBotao(20,63,black,lightgray,black,blue," Fechar ",false)
          CformSobre("Lista",npos,ncol,true)
      case nop=2
          fclose(SobreFile)
          rodape(""," ",white,blue)
          teladefundo("±",white,lightblue)
    endcase
elseif ctipo="Lista"
    nListapos=npos
    nListacol=ncol
    if lista(4,6,5,13,70,43,70,white,blue,lfoco)=1
        desenhalista(4,6,5,13,70,white,blue,npos,ncol,false)
        CformSobre("Fechar",npos,ncol,true)
    endif
endif

return

/*-----------------------------------------------------*/

/*
 Nome : formSplash
 Descricao : procedimento que desenha a tela inicial do sistema.
*/
procedure formSplash()
  setcursor(SC_NONE)
  formulario("",6,10,12,58,white,blue,"±",lightgray,black)
  Etexto(13, 8,yellow,blue," ²²²²²²²     ²    ²²²²²²²     ²       ²    ²²²²²² ")
  Etexto(13, 9,yellow,blue,"²²²    ²²²   ²²  ²²²    ²²²   ²²      ²²  ²²²  ²²²")
  Etexto(13,10,yellow,blue,"²²²²²²²²²    ²²  ²²²²²²²²²    ²²      ²²  ²²    ²²")
  Etexto(13,11,yellow,blue,"²²²    ²²²   ²²  ²²²    ²²²   ²²²     ²²  ²²    ²²")
  Etexto(13,12,yellow,blue,"²²²²   ²²²   ²²  ²²²²   ²²²   ²²²²    ²²  ²²²  ²²²")
  Etexto(13,13,yellow,blue," ²²²²²²²²²   ²²   ²²²²²²²²²   ²²²²²²  ²²   ²²²²²² ")
  Etexto(12,15,yellow,blue,"Programa Desenvolvido por Henrique Figueiredo de Souza")
  Etexto(12,16,yellow,blue,"Todos os Direito Reservados - 1999  Versao 1.0")
  Etexto(12,17,yellow,blue,"Linguagem Usada Nesta Versao << CLIPPER >>")
  inkey(2)
return

