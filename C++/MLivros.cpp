/*
  MLivros.cpp: implementacao da classe MLivros
*/

#include "MLivros.h"

MLivros::MLivros()
{

}

MLivros::~MLivros()
{

}

/*
 Nome : AbrirArquivo
 Descricao : procedimento que Abri o tipo de arquivo selecionado.
*/
void MLivros::AbrirArquivo()
{
  if ((LivrosFile=fopen("Livros.dat","rb+"))==NULL)
  {
    cout << "O Arquivo de Livros nao pode ser aberto" << endl;
	cout << "Criando o arquivo de Livros" << endl;
    LivrosFile=fopen("Livros.dat","wb+");
  }
  nTamLivros=tamArquivo(LivrosFile,sizeof(struct LivrosRec));
}

void MLivros::formLivros()
{
 int qLivros,cont;
 bool bOp;

 cout << "ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ";
 cout << "ÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿" << endl; 

 cout << "³ Cadastro de Livros                                  ";
 cout << "                       ³" << endl;
 cout << "ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ";
 cout << "ÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ" << endl;  
 cout << endl;

 AbrirArquivo();

 bOp=true;
 while(bOp)
 {
   cout << "Deseja cadastrar quantos livros (maximo de 99999) ? ";
   cin >> qLivros;
   if (qLivros < 1 || qLivros > 99999) 
     cout << "Erro --> Numero invalido digite de novo";
   else
     bOp=false;   
 } 
 
 nTamLivros=tamArquivo(LivrosFile,sizeof(struct LivrosRec));
 for(cont=1;cont<=qLivros;cont++)
 {
  nTamLivros++; 
  cout << "(" << cont << ") Numero de Inscricao do Livro : " << nTamLivros << endl;
  Digita_formLivros(cont);
 } 

}

void MLivros::Digita_formLivros(int cont)
{
 bool bOp;

  bOp=true;
  while(bOp)
  {
    cout << "(" << cont << ") Titulo do Livro (maximo de 30) : ";
    cin >> Livros.Titulo;
    if (strlen(Livros.Titulo)<=0 || strlen(Livros.Titulo)>30)
      cout << "Erro --> Tamanho do texto invalido digite de novo" << endl;
    else
      bOp=false;
  }

  bOp=true;
  while(bOp)
  {
    cout << "(" << cont << ") Autor do Livro (maximo de 30) : ";
    cin >> Livros.Autor;
    if (strlen(Livros.Autor)<=0 || strlen(Livros.Autor)>30)
      cout << "Erro --> Tamanho do texto invalido digite de novo" << endl;
    else
      bOp=false;       
  }
  
  bOp=true;
  while(bOp)
  {
    cout << "(" << cont << ") Area do Livro (maximo de 30) : ";
    cin >> Livros.Area;
    if (strlen(Livros.Area)<=0 || strlen(Livros.Area)>30)
      cout << "Erro --> Tamanho do texto invalido digite de novo" << endl;
    else
      bOp=false;
  }

  bOp=true;
  while(bOp)
  {
    cout << "(" << cont << ") Palavra Chave do Livro (maximo de 10) : ";
    cin >> Livros.PChave;
    if (strlen(Livros.PChave)<=0 || strlen(Livros.PChave)>10)
      cout << "Erro --> Tamanho do texto invalido digite de novo" << endl;
    else
      bOp=false;       
  }

  bOp=true;
  while(bOp)
  {
   cout << "(" << cont << ") Numero da Edicao do Livro (maximo de 4) : ";
   cin >> Livros.Edicao;
   if (Livros.Edicao<=0 || Livros.Edicao>4)
     cout << "Erro --> Tamanho do Numero invalido digite de novo" << endl;
   else
     bOp=false;       
  }

}
