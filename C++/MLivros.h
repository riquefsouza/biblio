/*
  MLivros.h: interface para a classe MLivros.
*/

#include "Graficos.h"
#include <iostream.h>
#include <stdio.h>

class MLivros : public Graficos  
{
private:
 
  /* Registro de Livros */

  struct LivrosRec {
     int Ninsc;          /* Numero de Inscricao do Livro (5) */
     char Titulo[30];    /* Titulo do Livro (30) */
     char Autor[30];     /* Autor do Livro (30) */
     char Area[30];      /* Area de atuacao do Livro (30) */
     char PChave[10];    /* Palavra-Chave para pesquisar o Livro (10) */
     int Edicao;         /* Edicao do Livro (4) */
     int AnoPubli;       /* Ano de Publicacao do Livro (4) */
     char Editora[30];   /* Editora do Livro (30) */
     int Volume;         /* Volume do Livro (4) */
     char Estado;        /* Estado Atual - (D)isponivel ou (E)mprestado */
  };

public:
	void Digita_formLivros(int cont);
	void formLivros();
	void AbrirArquivo();
	struct LivrosRec Livros;
    FILE *LivrosFile;  
    int nTamLivros;
	MLivros();
	virtual ~MLivros();

};


