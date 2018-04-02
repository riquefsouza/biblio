/*
 MUsuario.cpp: implementacao da classe MUsuario
*/

#include "MUsuario.h"

MUsuario::MUsuario()
{

}

MUsuario::~MUsuario()
{

}

/*
 Nome : AbrirArquivo
 Descricao : procedimento que Abri o tipo de arquivo selecionado.
*/
void MUsuario::AbrirArquivo()
{
if ((UsuariosFile=fopen("Usuarios.dat","rb+"))==NULL)
  {
    cout << "O Arquivo de Usuarios nao pode ser aberto" << endl;
	cout << "Criando o arquivo de Usuarios" << endl;
    UsuariosFile=fopen("Usuarios.dat","wb+");
  }
  nTamUsuarios=tamArquivo(UsuariosFile,sizeof(struct UsuariosRec));
}
