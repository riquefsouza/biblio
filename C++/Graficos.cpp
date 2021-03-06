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
 cout << "旼컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴커" << endl;
 cout << "�  께께께�     �    께께께�     �       �    께께께      �" << endl;
 cout << "� 께�    께�   께  께�    께�   께      께  께�  께�     �" << endl;
 cout << "� 께께께께�    께  께께께께�    께      께  께    께     �" << endl;
 cout << "� 께�    께�   께  께�    께�   께�     께  께    께     �" << endl;
 cout << "� 께께   께�   께  께께   께�   께께    께  께�  께�     �" << endl;
 cout << "�  께께께께�   께   께께께께�   께께께  께   께께께      �" << endl;
 cout << "� Programa Desenvolvido por Henrique Figueiredo de Souza �" << endl;
 cout << "� Todos os Direitos Reservados - 1999   Versao 1.0       �" << endl;
 cout << "� Linguagem Usada Nesta Versao << C++ >>                 �" << endl;
 cout << "읕컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴켸" << endl;
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
  cout << "旼컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴�";
  cout << "컴컴컴컴컴컴컴컴컴컴컴�" << endl; 
  cout << "� (A)cervo  (U)suarios  (E)mprestimos e Devolucoes  ";
  cout << "(O)pcoes                 �" << endl;
  cout << "읕컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴�";
  cout << "컴컴컴컴컴컴컴컴컴컴컴�" << endl;  
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
   cout << "旼컴컴컴컴컴컴컴컴컴컴컴�" << endl;
   cout << "� 1. Cadastrar livros   �" << endl;
   cout << "� 2. Alterar livros     �" << endl;
   cout << "� 3. Consultar livros > �" << endl;
   cout << "� 4. Voltar ao menu     �" << endl;
   cout << "읕컴컴컴컴컴컴컴컴컴컴컴�" << endl;
 }
 else if(num==2) 
 {
   cout << "旼컴컴컴컴컴컴컴컴컴컴컴컴�" << endl;
   cout << "� 1. Cadastrar usuarios   �" << endl;
   cout << "� 2. Alterar usuarios     �" << endl;
   cout << "� 3. Consultar usuarios > �" << endl;
   cout << "� 4. Voltar ao menu       �" << endl;
   cout << "읕컴컴컴컴컴컴컴컴컴컴컴컴�" << endl;
 }
 else if(num==3) 
 {
   cout << "旼컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴�" << endl;
   cout << "� 1. Emprestar livros                   �" << endl;
   cout << "� 2. Devolver livros                    �" << endl;
   cout << "� 3. Consultar Emprestimos e Devolucoes �" << endl;
   cout << "� 4. Voltar ao menu                     �" << endl;
   cout << "읕컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴�" << endl;
 }
 else if(num==4) 
 {
   cout << "旼컴컴컴컴컴컴컴컴컴커" << endl;
   cout << "� 1. Sobre o sistema �" << endl;
   cout << "� 2. Sair do sistema �" << endl;
   cout << "� 3. Voltar ao menu  �" << endl;
   cout << "읕컴컴컴컴컴컴컴컴컴켸" << endl;
 }
 else if(num==5)
 {
   cout << "旼컴컴컴컴컴컴컴컴컴컴커" << endl;
   cout << "� 1. Todos os livros   �" << endl;
   cout << "� 2. Por Titulo        �" << endl;
   cout << "� 3. Por Autor         �" << endl;
   cout << "� 4. Por Area          �" << endl;
   cout << "� 5. Por Palavra-chave �" << endl;
   cout << "� 6. Voltar ao menu    �" << endl;
   cout << "읕컴컴컴컴컴컴컴컴컴컴켸" << endl;
 }
 else if(num==6)
 {
   cout << "旼컴컴컴컴컴컴컴컴컴컴컴컴컴커" << endl;
   cout << "� 1. Todos os Usuarios       �" << endl;
   cout << "� 2. Por Numero de Inscricao �" << endl;
   cout << "� 3. Por Nome                �" << endl;
   cout << "� 4. Por Identidade          �" << endl;
   cout << "� 5. Voltar ao menu          �" << endl;
   cout << "읕컴컴컴컴컴컴컴컴컴컴컴컴컴켸" << endl;
 }
   
 cout << "Escolha uma opcao > " << endl;

}

