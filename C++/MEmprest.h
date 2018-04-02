/*
  MEmprest.h: interface para a classe MEmprest.
*/

#include "Graficos.h"
#include <iostream.h>
#include <stdio.h>

class MEmprest : public Graficos  
{
private:

  /* Registro de Emprestimos */

  struct EmprestimosRec {
     int NinscUsuario;      /* Numero de inscricao do Usuario (5) */
     int NinscLivro;        /* Numero de inscricao do Livro (5) */
     char DtEmprestimo[10]; /* Data de Emprestimo do Livro (10) */
     char DtDevolucao[10];  /* Data de Devolucao do Livro (10) */
     bool Removido;      /* Removido - Indica exclusao logica */
  };

public:
    void AbrirArquivo();
    struct EmprestimosRec Emprestimos;
    FILE *EmprestimosFile; 
    int nTamEmprestimos;
    MEmprest();
    virtual ~MEmprest();

};


