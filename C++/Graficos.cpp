/*
  Graficos.cpp: implementacao da classe Graficos
*/

#include "Graficos.h"

Graficos::Graficos()
{

}

Graficos::~Graficos()
{

}

/*
 Nome : formSplash
 Descricao : procedimento que desenha a tela inicial do sistema.
*/
void Graficos::formSplash()
{
 cout << "ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿" << endl;
 cout << "³  ²²²²²²²     ²    ²²²²²²²     ²       ²    ²²²²²²      ³" << endl;
 cout << "³ ²²²    ²²²   ²²  ²²²    ²²²   ²²      ²²  ²²²  ²²²     ³" << endl;
 cout << "³ ²²²²²²²²²    ²²  ²²²²²²²²²    ²²      ²²  ²²    ²²     ³" << endl;
 cout << "³ ²²²    ²²²   ²²  ²²²    ²²²   ²²²     ²²  ²²    ²²     ³" << endl;
 cout << "³ ²²²²   ²²²   ²²  ²²²²   ²²²   ²²²²    ²²  ²²²  ²²²     ³" << endl;
 cout << "³  ²²²²²²²²²   ²²   ²²²²²²²²²   ²²²²²²  ²²   ²²²²²²      ³" << endl;
 cout << "³ Programa Desenvolvido por Henrique Figueiredo de Souza ³" << endl;
 cout << "³ Todos os Direitos Reservados - 1999   Versao 1.0       ³" << endl;
 cout << "³ Linguagem Usada Nesta Versao << C++ >>                 ³" << endl;
 cout << "ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ" << endl;
 for(int cont=1;cont<=12;cont++)
	 cout << endl;
 cout << "pressione para continuar..." << endl;
 getchar();
}

/*
 Nome : Menu
 Descricao : procedimento que escreve a linha de opcoes do menu.
*/
void Graficos::Menu()
{
  cout << "ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ";
  cout << "ÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿" << endl; 
  cout << "³ (A)cervo  (U)suarios  (E)mprestimos e Devolucoes  ";
  cout << "(O)pcoes                 ³" << endl;
  cout << "ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ";
  cout << "ÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ" << endl;  
  cout << "Escolha uma opcao > ";
}

/*
 Nome : SubMenu
 Descricao : procedimento que escreve as linhas de opcoes do submenu
 Parametros :
 num - indica o numero do submenu
*/
void Graficos::SubMenu(int num)
{
 if (num==1)
 {
   cout << "ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿" << endl;
   cout << "³ 1. Cadastrar livros   ³" << endl;
   cout << "³ 2. Alterar livros     ³" << endl;
   cout << "³ 3. Consultar livros > ³" << endl;
   cout << "³ 4. Voltar ao menu     ³" << endl;
   cout << "ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ" << endl;
 }
 else if(num==2) 
 {
   cout << "ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿" << endl;
   cout << "³ 1. Cadastrar usuarios   ³" << endl;
   cout << "³ 2. Alterar usuarios     ³" << endl;
   cout << "³ 3. Consultar usuarios > ³" << endl;
   cout << "³ 4. Voltar ao menu       ³" << endl;
   cout << "ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ" << endl;
 }
 else if(num==3) 
 {
   cout << "ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿" << endl;
   cout << "³ 1. Emprestar livros                   ³" << endl;
   cout << "³ 2. Devolver livros                    ³" << endl;
   cout << "³ 3. Consultar Emprestimos e Devolucoes ³" << endl;
   cout << "³ 4. Voltar ao menu                     ³" << endl;
   cout << "ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ" << endl;
 }
 else if(num==4) 
 {
   cout << "ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿" << endl;
   cout << "³ 1. Sobre o sistema ³" << endl;
   cout << "³ 2. Sair do sistema ³" << endl;
   cout << "³ 3. Voltar ao menu  ³" << endl;
   cout << "ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ" << endl;
 }
 else if(num==5)
 {
   cout << "ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿" << endl;
   cout << "³ 1. Todos os livros   ³" << endl;
   cout << "³ 2. Por Titulo        ³" << endl;
   cout << "³ 3. Por Autor         ³" << endl;
   cout << "³ 4. Por Area          ³" << endl;
   cout << "³ 5. Por Palavra-chave ³" << endl;
   cout << "³ 6. Voltar ao menu    ³" << endl;
   cout << "ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ" << endl;
 }
 else if(num==6)
 {
   cout << "ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿" << endl;
   cout << "³ 1. Todos os Usuarios       ³" << endl;
   cout << "³ 2. Por Numero de Inscricao ³" << endl;
   cout << "³ 3. Por Nome                ³" << endl;
   cout << "³ 4. Por Identidade          ³" << endl;
   cout << "³ 5. Voltar ao menu          ³" << endl;
   cout << "ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ" << endl;
 }
   
 cout << "Escolha uma opcao > " << endl;

}

