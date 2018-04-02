/*
  Nome : Sistema de Automacao de Biblioteca (Biblio)
  Autor : Henrique Figueiredo de Souza
  Linguagem : C++
  Compilador : gcc 
  Data de Realizacao : 4 de setembro de 1999
  Ultima Atualizacao : 15 de fevereiro de 2000
  Versao do Sistema : 1.0
  Nome do(s) Arquivo(s) e Como Compilar (nesta ordem) :
  0. biblio.h   --> ""
  1. Rotinas.cpp  --> ""
  2. Graficos.cpp --> ""
  3. MLivros.cpp  --> ""
  4. MUsuario.cpp --> ""
  5. MEmprest.cpp --> ""
  6. MOpcoes.cpp  --> ""
  7. biblio.cpp   --> ""
 
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
/* Implementacao da classe Biblio */

#include "Biblio.h"
//#include "Graficos.h"
#include "MLivros.h"
//#include "MUsuario.h"
//#include "MEmprest.h"
#include "MOpcoes.h"

Biblio::Biblio()
{
}

Biblio::~Biblio()
{

}

/*
 bloco principal do programa
*/

int main(void)
{
bool bOp;
char opMenu;
Graficos vGraficos;

	
 vGraficos.formSplash();
 vGraficos.Cabecalho("Sistema de Automacao de Biblioteca");
 bOp=true;

 while(bOp)
 {
   vGraficos.Menu();
   cin >> opMenu;
   if (opMenu=='A' || opMenu=='a')
     ControlaMenus(1);
   else if (opMenu=='U' || opMenu=='u')
     ControlaMenus(2);
   else if (opMenu=='E' || opMenu=='e')
     ControlaMenus(3);
   else if (opMenu=='O' || opMenu=='o')
     ControlaMenus(4);
   else
     cout << "Erro --> Opcao invalida digite de novo" << endl;   
 }
 return(0);
}

/*
 Nome : ControlaMenus
 Descricao : procedimento que escreve as linhas de opcoes do submenu
 Parametros :
 num - indica o numero do submenu
*/
void ControlaMenus(int num)
{
int opSubMenu;
bool bSOp;
Graficos vGraficos;
MLivros vMLivros;
MOpcoes vMOpcoes;

 bSOp=true;
 if(num==1)
 {
   while(bSOp)
   {
     vGraficos.SubMenu(1);
     cin >> opSubMenu;
	 switch(opSubMenu)
	 {
      case 1: vMLivros.formLivros(); break;
      case 2: bSOp=false; break;
      case 3:
	  {
            while(bSOp)
            {
            vGraficos.SubMenu(5);
            cin >> opSubMenu;
            switch(opSubMenu)
			{
			 case 1: bSOp=false; break;
			 case 2: bSOp=false; break;
             case 3: bSOp=false; break;
             case 4: bSOp=false; break;
			 case 5: bSOp=false; break;
			 case 6: bSOp=false; break;
             default:
              cout << "Erro --> Opcao invalida digite de novo" << endl; 
			  break;
            }
          }
	  }
	  case 4: bSOp=false; break;
	  default: cout << "Erro --> Opcao invalida digite de novo" << endl;
               break;  
	 }    
   }
 }
 else if (num==2)
 {
   while(bSOp)
   {
     vGraficos.SubMenu(2);
     cin >> opSubMenu;
     switch(opSubMenu)
	 {
	  case 1: bSOp=false; break;
	  case 2: bSOp=false; break;
	  case 3:
	  {
            while(bSOp)
            {
            vGraficos.SubMenu(6);
            cin >> opSubMenu;
            switch(opSubMenu)
			{
	          case 1: bSOp=false; break;
              case 2: bSOp=false; break;
			  case 3: bSOp=false; break;
			  case 4: bSOp=false; break;
			  case 5: bSOp=false; break;
			  default:
                cout << "Erro --> Opcao invalida digite de novo" << endl;
				break;
			} 
            }
	  }
	  case 4: bSOp=false; break;
	  default: cout << "Erro --> Opcao invalida digite de novo" << endl;
		       break;
	 }
   }
 }
 else if (num==3)
 {
   while(bSOp)
   {
     vGraficos.SubMenu(3);
     cin >> opSubMenu;
     switch(opSubMenu)
	 {
	   case 1: bSOp=false; break;
	   case 2: bSOp=false; break;
	   case 3: bSOp=false; break;
	   case 4: bSOp=false; break;
	   default: cout << "Erro --> Opcao invalida digite de novo" << endl;
                break;  
	 }
   }
 }
 else if (num==4)
 {
   while(bSOp)
   {
     vGraficos.SubMenu(4);
     cin >> opSubMenu;
     switch(opSubMenu)
	 {
	   case 1: vMOpcoes.formSobre(); bSOp=false; break;
	   case 2: exit(0); break;
	   case 3: bSOp=false; break;
	   default: cout << "Erro --> Opcao invalida digite de novo" << endl;
	 }
   }
 }
}
