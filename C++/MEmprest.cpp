/*
  MEmprest.cpp: implementacao da classe MEmprest
*/

#include "MEmprest.h"

MEmprest::MEmprest()
{

}

MEmprest::~MEmprest()
{

}

/*
 Nome : AbrirArquivo
 Descricao : procedimento que Abri o tipo de arquivo selecionado.
*/
void MEmprest::AbrirArquivo()
{
if ((EmprestimosFile=fopen("Empresti.dat","rb+"))==NULL)
  {
    cout << "O Arquivo de Emprestimos nao pode ser aberto" << endl;
	cout << "Criando o arquivo de Emprestimos" << endl;
    EmprestimosFile=fopen("Empresti.dat","wb+");
  }
  nTamEmprestimos=tamArquivo(EmprestimosFile,sizeof(struct EmprestimosRec));
}
