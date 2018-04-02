/*
  MOpcoes.cpp: implementacao da classe MOpcoes
*/

#include "Graficos.h"
#include "MOpcoes.h"

MOpcoes::MOpcoes()
{

}

MOpcoes::~MOpcoes()
{

}

/*
 Nome : formSobre
 Descricao : procedimento que desenha o formulario de Sobre.
*/
void MOpcoes::formSobre()
{
 int cont;
 char linha[2];

 AbrirArquivo();

 cont=0;
 while (!feof(SobreFile)) 
 {
   fread(linha, 1, 1, SobreFile);
   cont++;
   if (cont==764)
   {
	 cout << endl;
	 cout << "Pressione para continuar..." << endl;
     getchar();
   }
   else if (linha[0]=='\n')
     cout << endl;
   else     
     cout << linha[0];
 }
 cout << endl;
 cout << "Pressione para continuar..." << endl;
 getchar();

}

/*
 Nome : AbrirArquivo
 Descricao : procedimento que Abri o tipo de arquivo selecionado.
*/
void MOpcoes::AbrirArquivo()
{
if ((SobreFile=fopen("Sobre.dat","rb+"))==NULL)
   cout << "O Arquivo de Sobre nao pode ser aberto" << endl;
  
}
