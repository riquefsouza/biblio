/*
  MUsuario.h: interface para a classe MUsuario.
*/

#include "Graficos.h"
#include <iostream.h>
#include <stdio.h>

class MUsuario : public Graficos  
{
private:

  /* Registro de Enderecos */

  struct Enderecos {
     char Logra[30];     /* Logradouro */
     int Numero;         /* Numero do Endereco (5) */
     char Compl[10];     /* Complemento (10) */
     char Bairro[20];    /* Bairro do Endereco (20) */
     char Cep[8];        /* Cep do Endereco (8) */
  };

  /* Registro de Usuarios */

  struct UsuariosRec {
     int Ninsc;                 /* Numero de inscricao do Usuario (5) */
     char Nome[30];             /* Nome completo do Usuario (30) */
     char Ident[10];            /* Identidade do Usuario (10) */
     struct Enderecos Endereco; /* Endereco completo do Usuario (73) */
     char Telefone[11];         /* Telefone do Usuario (11) */
     char Categoria;      /* Categoria - (A)luno,(P)rofessor,(F)uncionario */
     int Situacao;        /* Situacao - Numero de Livros em sua posse (1) */
  };

public:
    void AbrirArquivo();
    struct UsuariosRec Usuarios;
    FILE *UsuariosFile;  
    int nTamUsuarios;
    MUsuario();
    virtual ~MUsuario();

};


