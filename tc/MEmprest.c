/* Modulo de Emprestimos e Devolucoes */

#include "biblio.h"

 /* variaveis gerais */

 char *vEmprestimos[6];  /* 10 */

/***************Modulo de Emprestimos e Devolucoes******************/

/*
 Nome : PesEmprestimos
 Descricao : funcao que pesquisa as informacoes contidas no arquivo de
 Emprestimos.
 Parametros :
 nCodUsuario - codigo do campo de numero de inscricao do usuario
 sCodLivro - codigo do campo de numero de inscricao do livro
*/
int PesEmprestimos(int nCodUsuario,int nCodLivro)
{
 int nPosicao,nRet;
 boolean bFlag;

fseek(EmprestimosFile,0,SEEK_SET);
nPosicao=0;
bFlag=false;
while(!feof(EmprestimosFile)) 
 {
   fread(&Emprestimos,sizeof(struct EmprestimosRec),1,EmprestimosFile);
   if ((Emprestimos.NinscUsuario==nCodUsuario) &&
      (Emprestimos.NinscLivro==nCodLivro))
     {
      nRet=nPosicao;
      fseek(EmprestimosFile,nPosicao*sizeof(struct EmprestimosRec),SEEK_SET);
      bFlag=true;
      break;
     }
   nPosicao++;
 }
 if ((feof(EmprestimosFile)) && (bFlag==false))
   {
    Emprestimos.NinscUsuario=nCodUsuario;
    Emprestimos.NinscLivro=nCodLivro;
    return(-1);
   }
return(nRet);
}

/*-----------------------------------------------------*/

/*
 Nome : formEmprestimos
 Descricao : procedimento que desenha o formulario de Emprestimos
 na tela, e tambem indica qual acao a tomar.
 Parametros :
 tipo - indica qual a acao do formulario
 titulo - o titulo do formulario
 rod - o texto do rodape sobre o formulario
*/
void formEmprestimos(int tipo,char *titulo,char *rod)
{
  teladefundo("±",white,lightblue);
  rodape(rod," ",white,blue);  
  formulario(somastr(3,"´",titulo,"Ã"),4,2,18,76,white,blue,'±',lightgray,black);

  vEmprestimos[1]=repete(" ",5);
  Atribuir_vEmprestimos(true);
  AbrirArquivo(1);
  AbrirArquivo(2);
  AbrirArquivo(3);
  if (tipo==1)
    {
     Rotulos_formEmprestimos(1,0);
     DesenhaBotao(20,45,black,white,black,blue," Emprestar ",false);
     DesenhaBotao(20,60,black,white,black,blue," Fechar ",false);
    }
  if (tipo==2)
    {
     Rotulos_formEmprestimos(2,0);
     DesenhaBotao(20,45,black,white,black,blue," Devolver ",false);
     DesenhaBotao(20,60,black,white,black,blue," Fechar ",false);
    }
  if (tipo==3)
     DesenhaBotao(20,60,black,white,black,blue," Fechar ",false);

  Limpar_Emprestimos();
  if (tipo==1)
     Controles_formEmprestimos("1",1,0,0,rod,false);  /* Emprestar */
  else if (tipo==2)
     Controles_formEmprestimos("1",2,0,0,rod,false);  /* Devolver */
  else if (tipo==3)
     Controles_formEmprestimos("2",3,0,0,rod,true);  /* consultar todos */
}

/*-------------------------------------------*/

/*
 Nome : Limpar_Emprestimos
 Descricao : procedimento limpa as variaveis do registro de Emprestimos.
*/
void Limpar_Emprestimos(void)
{
     Emprestimos.NinscUsuario=0;
     Emprestimos.NinscLivro=0;
     strcpy(Emprestimos.DtEmprestimo,RetDataAtual());
     Emprestimos.Removido=false;
}

/*-------------------------------------------*/

/*
 Nome : Rotulos_formEmprestimos
 Descricao : procedimento que escreve os rotulos do formulario de
 Emprestimos.
 Parametros :
 tipo - indica qual a acao do formulario
 l - indica um acrescimo na linha do rotulo
*/
void Rotulos_formEmprestimos(int tipo,int l)
{
if ((tipo==1) || (tipo==2))
 {
  etexto(5,6+l,white,blue,"Numero de Inscricao do Usuario : ");
  etexto(38,6+l,black,lightgray,vEmprestimos[1]);
  etexto(5,8+l,white,blue,"Usuario : ");
  etexto(16,8+l,black,lightgray,repete(" ",30));
  etexto(49,8+l,white,blue,"Categoria : ");
  etexto(5,10+l,white,blue,"Numero de Inscricao do Livro : ");
  etexto(36,10+l,black,lightgray,vEmprestimos[2]);
  etexto(5,12+l,white,blue,"Livro : ");
  etexto(13,12+l,black,lightgray,repete(" ",30));
  etexto(46,12+l,white,blue,"Estado : ");
  etexto(5,14+l,white,blue,"Data do Emprestimo : ");
  etexto(27,14+l,black,lightgray,vEmprestimos[3]);
  etexto(40,14+l,white,blue,"Data de Devolucao : ");
  etexto(61,14+l,black,lightgray,vEmprestimos[4]);
 }
if (tipo==2)
 {
  etexto(5,16+l,white,blue,"Dias em Atraso : ");
  etexto(23,16+l,black,lightgray,repete(" ",4));
  etexto(31,16+l,white,blue,"Multa por dias em atraso : ");
  etexto(59,16+l,black,lightgray,repete(" ",7));
 }
}

/*-------------------------------------------*/

/*
 Nome : Controles_formEmprestimos
 Descricao : procedimento que realiza todo o controle de manuseio do
 formulario de Emprestimos.
 Parametros :
 tipo - indica qual a acao do formulario
 tipo2 - indica a acao original do formulario nao manipulado pela funcao
 pos - indica a ultima posicao da linha da lista de emprestimos
 col - indica a ultima posicao da coluna da lista de emprestimos
 rod - o texto do rodape sobre o formulario
 foco - se os objetos do formulario estao focados ou nao
*/
void Controles_formEmprestimos(char *tipo,int tipo2,int pos,int col,
                               char *rod,boolean foco)
{
 char *sDiasAtraso;
 int nDiasAtraso;
 float nMulta;

if (strcmp(tipo,"1")==0)
 {
  S[0]='\0';
  rodape(""," ",white,blue);
  etexto(61,8,white,blue,"");
  etexto(55,12,white,blue,"");
  etexto(23,16,black,lightgray,"");
  etexto(59,16,black,lightgray,"");
  S=digita(S,5,5,39,5,black,lightgray,'N',32);
  I=atoi(S);
  Usuarios.Ninsc=I;
  Emprestimos.NinscUsuario=I;
  if ((strlen(S) > 0) && (S!=repete(" ",strlen(S)))) 
   {
    if (PesUsuarios('N',"Ninsc",I,"",0)!=-1)
     {
      etexto(16,8,black,lightgray,Usuarios.Nome);
      if (Usuarios.Categoria=='F') 
         etexto(61,8,white,blue,"Funcionario");
      else if (Usuarios.Categoria=='A')
         etexto(61,8,white,blue,"Aluno      ");
      else if (Usuarios.Categoria=='P')
         etexto(61,8,white,blue,"Professor  ");

      S[0]='\0';
      S=digita(S,5,5,37,9,black,lightgray,'N',32);
      I=atoi(S);
      Livros.Ninsc=I;
      Emprestimos.NinscLivro=I;
      if ((strlen(S) > 0) && (S!=repete(" ",strlen(S)))) 
       {
        if (PesLivros('N',"Ninsc",I,"",0)!=-1) 
         {
           etexto(13,12,black,lightgray,Livros.Titulo);
	   if (Livros.Estado=='D')
             etexto(55,12,white,blue,"Disponivel");
           else
             etexto(55,12,white,blue,"Emprestado");

           /* Emprestimo */

           if (tipo2==1) 
             {
              if (Livros.Estado=='D')
               {
                if (Usuarios.Situacao < 4)
                  {
                   if (Usuarios.Categoria=='F')
                     strcpy(Emprestimos.DtDevolucao,SomaDias(RetDataAtual(),7));
                   else if (Usuarios.Categoria=='A')
                     strcpy(Emprestimos.DtDevolucao,SomaDias(RetDataAtual(),14));
                   else if (Usuarios.Categoria=='P')
                     strcpy(Emprestimos.DtDevolucao,SomaDias(RetDataAtual(),30));
                   strcpy(Emprestimos.DtEmprestimo,RetDataAtual());
                   Usuarios.Situacao=Usuarios.Situacao + 1;
                   Livros.Estado='E';
                   etexto(27,14,black,lightgray,Emprestimos.DtEmprestimo);
                   etexto(61,14,black,lightgray,Emprestimos.DtDevolucao);
                   Controles_formEmprestimos("Emprestar",tipo2,pos,col,rod,true);
                  }
                else
                  {
                   rodape("Usuario com 4 livros em sua posse, Impossivel Efetuar Emprestimo !"," ",yellow,red);
                   Controles_formEmprestimos("Fechar",tipo2,pos,col,rod,true);
                  }
               }
              else
               {
                rodape("O livro ja esta emprestado, Impossivel Efetuar Emprestimo !"," ",yellow,red);
                Controles_formEmprestimos("Fechar",tipo2,pos,col,rod,true);
               }
             }
             /* Devolucao */
           else if (tipo2==2) 
             {
              if (PesEmprestimos(Usuarios.Ninsc,Livros.Ninsc)!=-1)
                {
                 if (Livros.Estado=='E')
                  {
                   if ((Usuarios.Situacao >= 1) && (Usuarios.Situacao <= 4))
                     {
                      if (ConverteData(Emprestimos.DtDevolucao) <
                         ConverteData(RetDataAtual()))
                        {
                         nDiasAtraso=0;
                         nMulta=0.0;
                         nDiasAtraso=SubtraiDatas(Emprestimos.DtDevolucao,
                         RetDataAtual());
                         nMulta=(0.5 * nDiasAtraso);
                        }
                      else
                        {
                         nDiasAtraso=0;
                         nMulta=0.0;
                        }
                      sDiasAtraso=(char*)malloc(15);
                      if (!sDiasAtraso)
                         exit(1);
                      itoa(nDiasAtraso,sDiasAtraso,10);                      
                      etexto(27,14,black,lightgray,Emprestimos.DtEmprestimo);
                      etexto(61,14,black,lightgray,Emprestimos.DtDevolucao);
                      etexto(23,16,black,lightgray,sDiasAtraso);

                      postexto(59,16,black,lightgray);
                      cprintf("%3.2f",nMulta);

                      Usuarios.Situacao=Usuarios.Situacao - 1;
                      Livros.Estado='D';
                      Controles_formEmprestimos("Devolver",tipo2,pos,col,
                      rod,true);
                     }
                   else
                     {
                      rodape("Usuario com 0 livros em sua posse, Impossivel Efetuar Devolucao !"," ",yellow,red);
                      Controles_formEmprestimos("Fechar",tipo2,pos,col,rod,true);
                     }
                  }
                 else
                  {
                   rodape("O livro ja esta disponivel, Impossivel Efetuar Devolucao !"," ",yellow,red);
                   Controles_formEmprestimos("Fechar",tipo2,pos,col,rod,true);
                  }
                }
               else
                {
                 rodape("Emprestimo inexistente, Impossivel Efetuar Devolucao !"," ",yellow,red);
                 Controles_formEmprestimos("Fechar",tipo2,pos,col,rod,true);
                }
             }
             /* --- */
         }
        else
         {
          itoa(I,S,10);
          Atribuir_vEmprestimos(true);
          Rotulos_formEmprestimos(tipo2,0);
          rodape("Numero de Inscricao do Livro, nao encontrado !",
          " ",yellow,red);
          Controles_formEmprestimos("Fechar",tipo2,pos,col,rod,true);
         }
       }
      else
        Controles_formEmprestimos("Fechar",tipo2,pos,col,rod,true);
     }
    else
     {
      itoa(I,S,10);
      Atribuir_vEmprestimos(true);
      Rotulos_formEmprestimos(tipo2,0);
      rodape("Numero de Inscricao do Usuario, nao encontrado !",
      " ",yellow,red);
      Controles_formEmprestimos("Fechar",tipo2,pos,col,rod,true);
     }
   }
  else
    Controles_formEmprestimos("Fechar",tipo2,pos,col,rod,true);
 }
else if (strcmp(tipo,"2")==0)
  {
   Listapos=pos;
   Listacol=col;
   if (Lista(3,6,5,13,70,nTamEmprestimos+2,113,white,blue,foco)==1)
      {
        DesenhaLista(3,6,5,13,70,white,blue,pos,col,false);
        Controles_formEmprestimos("Fechar",tipo2,pos,col,rod,true);
      }
  }
else if (strcmp(tipo,"Emprestar")==0)
  {
    switch(Botao(20,45,black,white,black,blue," Emprestar ",foco)){ 
      case 1:
          DesenhaBotao(20,45,black,white,black,blue," Emprestar ",false);
          Controles_formEmprestimos("Fechar",tipo2,pos,col,rod,true);
          break;
      case 2:
          if (PesEmprestimos(Usuarios.Ninsc,Livros.Ninsc)!=-1)
           {
            Emprestimos.Removido=false;
            SalvarEmprestimos(2);
           }
          else
           {
            Emprestimos.Removido=false;
            nTamEmprestimos=tamArquivo(EmprestimosFile,sizeof(struct EmprestimosRec));
            SalvarEmprestimos(1);
           }
          DesenhaBotao(20,45,black,white,black,blue," Emprestar ",false);
          Controles_formEmprestimos("Fechar",tipo2,pos,col,rod,true);
          break;
    }
  }
else if (strcmp(tipo,"Devolver")==0)
  {
    switch(Botao(20,45,black,white,black,blue," Devolver ",foco)){ 
      case 1:
          DesenhaBotao(20,45,black,white,black,blue," Devolver ",false);
          Controles_formEmprestimos("Fechar",tipo2,pos,col,rod,true);
          break;
      case 2:
          Emprestimos.Removido=true;
          SalvarEmprestimos(2);
          DesenhaBotao(20,45,black,white,black,blue," Devolver ",false);
          Controles_formEmprestimos("Fechar",tipo2,pos,col,rod,true);
          break;
    }
  }
else if (strcmp(tipo,"Fechar")==0)
  {
    switch(Botao(20,60,black,white,black,blue," Fechar ",foco)){ 
      case 1:
          DesenhaBotao(20,60,black,white,black,blue," Fechar ",false);
          if ((tipo2==1) || (tipo2==2))
            Controles_formEmprestimos("1",tipo2,pos,col,rod,true);
          else if (tipo2==3)
            Controles_formEmprestimos("2",tipo2,pos,col,rod,true);
          break;
      case 2:
         rodape(""," ",white,blue);
         fclose(LivrosFile);
         fclose(UsuariosFile);
         fclose(EmprestimosFile);
         break;
    }
  }

}

/*-------------------------------------------------------*/

/*
 Nome : Atribuir_vEmprestimos
 Descricao : procedimento que atribui ou limpa o vetor de Emprestimos.
 Parametros :
 limpar - indica se vai limpar ou atribuir os vetores
*/
void Atribuir_vEmprestimos(boolean limpar)
{
if (limpar==false)
 {
      strcpy(vEmprestimos[3],Emprestimos.DtEmprestimo);
      strcpy(vEmprestimos[4],Emprestimos.DtDevolucao);
 }
else
 {
  vEmprestimos[2]=repete(" ",5);
  vEmprestimos[3]=repete(" ",10);
  vEmprestimos[4]=repete(" ",10);
 }
}

/*-------------------------------------------------------*/

/*
 Nome : SalvarEmprestimos
 Descricao : procedimento que salva os dados S=digitados no
 formulario de emprestimos.
 Parametros :
 tipo - indica qual acao a salvar
*/
void SalvarEmprestimos(int tipo)
{
    fwrite(&Livros, sizeof(struct LivrosRec), 1, LivrosFile);
    fwrite(&Usuarios, sizeof(struct UsuariosRec), 1, UsuariosFile);
    if (tipo==1)
      {
        if(fseek(EmprestimosFile,nTamEmprestimos*sizeof(struct EmprestimosRec),SEEK_SET)==0)
           fwrite(&Emprestimos, sizeof(struct EmprestimosRec), 1, EmprestimosFile);
        Atribuir_vEmprestimos(true);
        Rotulos_formEmprestimos(1,0);
      }
    else if (tipo==2)
      {
        fwrite(&Emprestimos, sizeof(struct EmprestimosRec), 1, EmprestimosFile);
        Atribuir_vEmprestimos(true);
        Rotulos_formEmprestimos(1,0);
      }
}
