/*
  Nome : Sistema de Automacao de Biblioteca (Biblio)
  Autor : Henrique Figueiredo de Souza
  Linguagem : C
  Compilador : Turbo C 
  Data de Realizacao : 4 de setembro de 1999
  Ultima Atualizacao : 15 de fevereiro de 2000
  Versao do Sistema : 1.0
  Nome do(s) Arquivo(s) e Como Compilar (nesta ordem) :
  0. biblio.prj --> "Arquivo de projeto"
  0. biblio.h   --> "Arquivo de cabecalho de declaracoes"
  1. Rotinas.c  --> "tcc -c rotinas.c"
  2. Graficos.c --> "tcc -c graficos.c"
  3. MLivros.c  --> "tcc -c mlivros.c"
  4. MUsuario.c --> "tcc -c musuario.c"
  5. MEmprest.c --> "tcc -c memprest.c"
  6. MOpcoes.c  --> "tcc -c mopcoes.c"
  7. biblio.c   --> "tcc -c biblio.c"
  8. tlink biblio.obj+rotinas.obj+graficos.obj+mlivros.obj+
     musuario.obj+memprest.obj+mopcoes.obj

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

#include "biblio.h"
 
/*-------------------------------------------*/

/*
 Nome : ControlaMenus
 Descricao : procedimento que faz todo o controle de manuseio dos submenus.
 Parametros :
 tipo - indica qual o submenu selecionado do menu
 ultpos - indica a ultima posicao da opcao de submenu selecionada
 tf - indica se vai redesenhar a tela de fundo
*/
void ControlaMenus(char tipo,int ultpos,boolean tf)
{

if (tf==true)
  teladefundo("±",white,lightblue);

if (tipo=='A')
  {
    menu(4,2,black,lightgray,red,lightgray,1,yellow,lightgray,1);
    rodape("Controle do Acervo da Biblioteca."," ",white,blue);
    formulario("",3,3,4,20,black,lightgray,'±',lightgray,black);
    switch(SubMenu(1,3,18,4,5,ultpos,yellow,lightgray,black,lightgray)){
      case 1: ControlaMenus('O',1,true); break;
      case 2: ControlaMenus('U',1,true); break;
      case 3: formLivros(1,"Cadastrar Livros",
        "Cadastro dos Livros do Acervo da Biblioteca."); break;
      case 4: formLivros(2,"Alterar Livros",
        "Altera os Livros do Acervo da Biblioteca."); break;
      case 5: ControlaMenus('5',1,false); break; 
    }
  }
else if (tipo=='U')
  {
    menu(4,2,black,lightgray,red,lightgray,10,yellow,lightgray,2);
    rodape("Controle de Usuarios da Biblioteca."," ",white,blue);
    formulario("",3,12,4,22,black,lightgray,'±',lightgray,black);
    switch(SubMenu(2,3,20,4,14,ultpos,yellow,lightgray,black,lightgray)){
      case 1: ControlaMenus('A',1,true); break; 
      case 2: ControlaMenus('E',1,true); break; 
      case 3: formUsuarios(1,"Cadastrar Usuarios",
        "Cadastro dos Usuarios da Biblioteca."); break;
      case 4: formUsuarios(2,"Alterar Usuarios",
        "Altera os Usuarios da Biblioteca."); break;
      case 5: ControlaMenus('6',1,false); break; 
    }
  }
else if (tipo=='E')
  {
    menu(4,2,black,lightgray,red,lightgray,21,yellow,lightgray,3);
    rodape("Controle de Emprestimos e Devolucoes da Biblioteca."," ",
    white,blue);
    formulario("",3,23,4,37,black,lightgray,'±',lightgray,black);
    switch(SubMenu(3,3,35,4,25,ultpos,yellow,lightgray,black,lightgray)){
      case 1: ControlaMenus('U',1,true); break;
      case 2: ControlaMenus('O',1,true); break;
      case 3: formEmprestimos(1,"Emprestar Livros",
        "Efetua os Emprestimos de Livros da Biblioteca."); break;
      case 4: formEmprestimos(2,"Devolver Livros",
        "Efetua a Devolucao dos Livros da Biblioteca."); break;
      case 5: formEmprestimos(3,"Consultar Emprestimos e Devolucoes",
        "Consulta os Emprestimos e Devolucoes dos Livros da Biblioteca.");
         break;
    }
  }
else if (tipo=='O')
  {
    menu(4,2,black,lightgray,red,lightgray,48,yellow,lightgray,4);
    rodape("Opcoes do Sistema de Biblioteca."," ",white,blue);
    formulario("",3,50,3,18,black,lightgray,'±',lightgray,black);
    switch(SubMenu(4,2,16,4,52,ultpos,yellow,lightgray,black,lightgray)){ 
      case 1: ControlaMenus('E',1,true); break;
      case 2: ControlaMenus('A',1,true); break;
      case 3: formSobre(); break;
      case 4: formSair(); break;
    }
  }
else if (tipo=='5')
  {
    formulario("",6,23,6,20,black,lightgray,'±',lightgray,black);
    switch(SubMenu(5,5,18,7,25,ultpos,yellow,lightgray,black,lightgray)){ 
      case 1: ControlaMenus('A',3,true); break;
      case 2: ControlaMenus('U',1,true); break;
      case 4: formLivros(3,"Consultar Livros por Titulo",
        "Consulta os Livros por Titulo do Acervo da Biblioteca."); break;
      case 5: formLivros(4,"Consultar Livros por Autor",
        "Consulta os Livros por Autor do Acervo da Biblioteca."); break;
      case 6: formLivros(5,"Consultar Livros por Area",
        "Consulta os Livros por Area do Acervo da Biblioteca."); break;
      case 7: formLivros(6,"Consultar Livros por Palavra-chave",
        "Consulta os Livros por Palavra-chave do Acervo da Biblioteca.");
         break;
      case 3: formLivros(7,"Consultar Todos os Livros",
        "Consulta Todos os Livros do Acervo da Biblioteca."); break;
    }
  }
else if (tipo=='6')
  {
    formulario("",6,34,5,26,black,lightgray,'±',lightgray,black);
    switch(SubMenu(6,4,24,7,36,ultpos,yellow,lightgray,black,lightgray)){ 
      case 1: ControlaMenus('U',3,true); break;
      case 2: ControlaMenus('E',1,true); break;
      case 4: formUsuarios(3,"Consultar Usuarios por Numero de Inscricao",
        "Consulta os Usuarios por Numero de Inscricao."); break;
      case 5: formUsuarios(4,"Consultar Usuarios por Nome",
        "Consulta os Usuarios por Nome."); break;
      case 6: formUsuarios(5,"Consultar Usuarios por Identidade",
        "Consulta os Usuarios por Numero de Identidade."); break;
      case 3: formUsuarios(6,"Consultar Todos os Usuarios",
        "Consulta Todos os Usuarios da Biblioteca."); break;

    }
  }

}

/*-------------------------------------------*/

/* Bloco principal do programa */

int main(void)
{ 
  clrscr();
  teladefundo("±",white,lightblue);
  cabecalho("Sistema de Automacao de Biblioteca"," ",white,blue);
  rodape(""," ",white,blue);
  datadosistema(1,1,white,blue);
  horadosistema(1,73,white,blue);

  vMenu[1]="Acervo";
  vMenu[2]="Usuarios";
  vMenu[3]="Emprestimos e Devolucoes";
  vMenu[4]="Opcoes";

  vSubMenu[1][1]="Cadastrar livros";
  vSubMenu[1][2]="Alterar livros";
  vSubMenu[1][3]="Consultar livros >";

  vSubMenu[2][1]="Cadastrar usuarios";
  vSubMenu[2][2]="Alterar usuarios";
  vSubMenu[2][3]="Consultar usuarios >";

  vSubMenu[3][1]="Emprestar livros";
  vSubMenu[3][2]="Devolver livros";
  vSubMenu[3][3]="Consultar Emprestimos e Devolucoes";

  vSubMenu[4][1]="Sobre o sistema";
  vSubMenu[4][2]="Sair do sistema";

  vSubMenu[5][1]="Todos os livros";
  vSubMenu[5][2]="Por Titulo";
  vSubMenu[5][3]="Por Autor";
  vSubMenu[5][4]="Por Area";
  vSubMenu[5][5]="Por Palavra-chave";

  vSubMenu[6][1]="Todos os Usuarios";
  vSubMenu[6][2]="Por Numero de Inscricao";
  vSubMenu[6][3]="Por Nome";
  vSubMenu[6][4]="Por Identidade";

  menu(4,2,black,lightgray,red,lightgray,0,white,black,0);
  formSplash();

  S=(char*)malloc(300);
  if(!S) exit(1);

 do {
   teladefundo("±",white,lightblue);
   menu(4,2,black,lightgray,red,lightgray,0,white,black,0);

   inkey('O','O');

   if (sKey==AltA) ControlaMenus('A',1,true);
   if (sKey==AltU) ControlaMenus('U',1,true);
   if (sKey==AltE) ControlaMenus('E',1,true);
   if (sKey==AltO) ControlaMenus('O',1,true);

  } while(sKey != Esc);
  exit(0);
}
