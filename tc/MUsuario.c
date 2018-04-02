/* Modulo de Usuarios */

#include "biblio.h"

 /* variaveis gerais */

 char *vUsuarios[12];  /* 30 */

/******************Modulo de Usuarios**********************/

/*
 Nome : PesUsuarios
 Descricao : funcao que pesquisa as informacoes contidas no arquivo de
 usuarios.
 Parametros :
 tipo - indica se e o valor e (N)umerico ou (S)tring
 campo - qual o campo a ser pesquisado
 nCod2 - codigo do campo se numerico
 sCod2 - codigo do campo se string
 nTamsCod - tamanho caracteres do campo de string
*/
int PesUsuarios(char tipo,char *campo,int nCod2,char *sCod2,
                int nTamsCod)
{
 int nPosicao,nCod,nRet;
 char *sCod;
 boolean bFlag;

sCod=(char*)malloc(50);
if (!sCod)
  exit(1);

fseek(UsuariosFile,0,SEEK_SET);
nPosicao=0;
bFlag=false;
nCod=0;
sCod[0]='\0';
while (!feof(UsuariosFile)) 
 {
   fread(&Usuarios,sizeof(struct UsuariosRec),1,UsuariosFile);
   if (tipo=='N')
     {
       if (strcmp(campo,"Ninsc")==0)
          nCod=Usuarios.Ninsc;

       if (nCod==nCod2) 
         {
          nRet=nPosicao;
          fseek(UsuariosFile,nPosicao*sizeof(struct UsuariosRec),SEEK_SET);
          bFlag=true;
          break;
         }
     }
   else if (tipo=='S')
     {
       if (strcmp(campo,"Nome")==0)
          sCod=Usuarios.Nome;
       else if (strcmp(campo,"Ident")==0)
          sCod=Usuarios.Ident;

       if (strcmp(copy(sCod,1,nTamsCod),sCod2)==0) 
         {
          nRet=nPosicao;
          fseek(UsuariosFile,nPosicao*sizeof(struct UsuariosRec),SEEK_SET);
          bFlag=true;
          break;
         }
     }
   nPosicao++;
 }
 if ((feof(UsuariosFile)) && (bFlag==false))
    return(-1);
 return(nRet);
}

/*-----------------------------------------------------*/

/*
 Nome : PesBinaria
 Descricao : funcao que realiza uma pesquisa binaria
 por numero de inscricao do usuario.
 Parametros :
 Chave - numero de inscricao do usuario a pesquisar
*/
int PesBinaria(int chave)
{
 int inicio,fim,meio;
 boolean achou;

 inicio=1;
 fim=nTamUsuarios+1;
 achou=false;
 while ((! achou) && (inicio <= fim)) 
  {
   meio=((inicio+fim) / 2);
   fseek(UsuariosFile,(meio-1)*sizeof(struct UsuariosRec),SEEK_SET);
   fread(&Usuarios,sizeof(struct UsuariosRec),1,UsuariosFile);
   if (chave==Usuarios.Ninsc)
      achou=true;
   else
    {
      if (chave > Usuarios.Ninsc) 
        inicio=meio+1;
      else
        fim=meio-1;
    }
  }
 if (achou==true)
    return(meio-1);
 else
    return(-1);
}

/*-----------------------------------------------------*/

/*
 Nome : formUsuarios
 Descricao : procedimento que desenha o formulario de Usuarios na tela, e
 tambem indica qual acao a tomar.
 Parametros :
 tipo - indica qual a acao do formulario
 titulo - o titulo do formulario
 rod - o texto do rodape sobre o formulario
*/
void formUsuarios(int tipo,char *titulo,char *rod)
{
  teladefundo("±",white,lightblue);
  rodape(rod," ",white,blue);
  formulario(somastr(3,"´",titulo,"Ã"),4,2,18,76,white,blue,'±',lightgray,black);

  vUsuarios[1]=repete(" ",5);
  Atribuir_vUsuarios(true);
  AbrirArquivo(2);
  if ((tipo==1) || (tipo==2))
    {
     Rotulos_formUsuarios(0);
     DesenhaBotao(20,48,black,white,black,blue," Salvar ",false);
     DesenhaBotao(20,63,black,white,black,blue," Fechar ",false);
    }
  if ((tipo==3) || (tipo==4) || (tipo==5))
    {
     DesenhaBotao(20,63,black,white,black,blue," Fechar ",false);
     Rotulos_formUsuarios(2);
     postexto(2,7,white,blue);
     cprintf("%s%s%s","Ã",repete("Ä",75),"´");
    }
  if (tipo==6)
     DesenhaBotao(20,63,black,white,black,blue," Fechar ",false);

  if (tipo==3) 
    {
     etexto(5,6,white,blue,"Numero de Inscricao : ");
     etexto(27,6,black,lightgray,repete(" ",5));
    }
  if (tipo==4)
    {
     etexto(5,6,white,blue,"Nome : ");
     etexto(12,6,black,lightgray,repete(" ",30));
    }
  if (tipo==5)
    {
     etexto(5,6,white,blue,"Identidade : ");
     etexto(18,6,black,lightgray,repete(" ",10));
    }

  Limpar_Usuarios();
  if (tipo==1)
     Controles_formUsuarios("2",1,0,0,rod,false);  /* cadastrar */
  else if (tipo==2)
     Controles_formUsuarios("1",2,0,0,rod,false);  /* alterar */
  else if (tipo==3)
     Controles_formUsuarios("3",3,0,0,rod,false); /* consultar por NInsc */
  else if (tipo==4)
     Controles_formUsuarios("4",4,0,0,rod,false); /* consultar por Nome */
  else if (tipo==5)
     Controles_formUsuarios("5",5,0,0,rod,false); /* consultar por Identidade */
  else if (tipo==6)
     Controles_formUsuarios("6",6,0,0,rod,true); /* consultar todos */
}

/*-------------------------------------------*/

/*
 Nome : Limpar_Usuarios
 Descricao : procedimento limpa as variaveis do registro de usuarios.
*/
void Limpar_Usuarios(void)
{
     Usuarios.Ninsc=0;
     strcpy(Usuarios.Nome,"");
     strcpy(Usuarios.Ident,"0");
     strcpy(Usuarios.Endereco.Logra,"");
     Usuarios.Endereco.Numero=0;
     strcpy(Usuarios.Endereco.Compl,"");
     strcpy(Usuarios.Endereco.Bairro,"");
     strcpy(Usuarios.Endereco.Cep,"0");
     strcpy(Usuarios.Telefone,"0");
     Usuarios.Categoria=' ';
     Usuarios.Situacao=0;

}

/*-------------------------------------------*/

/*
 Nome : Rotulos_formUsuarios
 Descricao : procedimento que escreve os rotulos do formulario de Usuarios.
 Parametros :
 l - indica um acrescimo na linha do rotulo
*/
void Rotulos_formUsuarios(int l)
{
  etexto(5,6+l,white,blue,"Numero de Inscricao : ");
  etexto(27,6+l,black,lightgray,vUsuarios[1]);
  etexto(35,6+l,white,blue,"Nome : ");
  etexto(42,6+l,black,lightgray,vUsuarios[2]);
  etexto(5,8+l,white,blue,"Identidade : ");
  etexto(18,8+l,black,lightgray,vUsuarios[3]);
  postexto(2,10+l,white,blue);
  cprintf("%s%s%s","Ã",repete("Ä",75),"´");
  etexto(5,10+l,white,blue,"Endereco");
  etexto(5,12+l,white,blue,"Logradouro : ");
  etexto(18,12+l,black,lightgray,vUsuarios[4]);
  etexto(51,12+l,white,blue,"Numero : ");
  etexto(60,12+l,black,lightgray,vUsuarios[5]);
  etexto(5,14+l,white,blue,"Complemento : ");
  etexto(19,14+l,black,lightgray,vUsuarios[6]);
  etexto(32,14+l,white,blue,"Bairro : ");
  etexto(41,14+l,black,lightgray,vUsuarios[7]);
  etexto(63,14+l,white,blue,"Cep : ");
  etexto(69,14+l,black,lightgray,vUsuarios[8]);
  postexto(2,16+l,white,blue);
  cprintf("%s%s%s","Ã",repete("Ä",75),"´");
  etexto(31,8+l,white,blue,"Telefone : ");
  etexto(42,8+l,black,lightgray,vUsuarios[9]);
  etexto(5,17+l,white,blue,"Categoria : ");
  etexto(17,17+l,black,lightgray,vUsuarios[10]);
  etexto(20,17+l,white,blue,"(A)luno ou (P)rofessor ou (F)uncionario");
  etexto(5,19+l,white,blue,"Situacao : ");
  etexto(16,19+l,black,lightgray,vUsuarios[11]);

}

/*-------------------------------------------*/

/*
 Nome : Controles_formUsuarios
 Descricao : procedimento que realiza todo o controle de manuseio do
 formulario de Usuarios.
 Parametros :
 tipo - indica qual a acao do formulario
 tipo2 - indica a acao original do formulario nao manipulado pela funcao
 pos - indica a ultima posicao da linha da lista de usuarios
 col - indica a ultima posicao da coluna da lista de usuarios
 rod - o texto do rodape sobre o formulario
 foco - se os objetos do formulario estao focados ou nao
*/
void Controles_formUsuarios(char *tipo,int tipo2,int pos,int col,
                            char *rod,boolean foco)
{
if (strcmp(tipo,"1")==0)
   {
      S=digita(S,5,5,28,5,black,lightgray,'N',32); /* N insc */
      I=atoi(S);
      Usuarios.Ninsc=I;
      if ((strlen(S) > 0) && (S!=repete(" ",strlen(S))))
        {
         DesenhaBotao(20,48,black,white,black,blue," Salvar ",false);
         if (PesUsuarios('N',"Ninsc",I,"",0)!=-1)
           {
                Atribuir_vUsuarios(false);
                Rotulos_formUsuarios(0);
                rodape(rod," ",white,blue);
                Controles_formUsuarios("2",tipo2,pos,col,rod,false);
           }
         else
           {
            itoa(I,S,10);
            Atribuir_vUsuarios(true);
            Rotulos_formUsuarios(0);
            rodape("Numero de Inscricao, nao encontrado !"," ",yellow,red);
            Controles_formUsuarios("Fechar",tipo2,pos,col,rod,true);
           }
        }
      else
        Controles_formUsuarios("Fechar",tipo2,pos,col,rod,true);
   }
else if (strcmp(tipo,"2")==0)
   {
        if (tipo2==1)
          {
            nTamUsuarios=tamArquivo(UsuariosFile,sizeof(struct UsuariosRec));
            if (nTamUsuarios == 0)
               Usuarios.Ninsc=1;
            else                
               Usuarios.Ninsc=nTamUsuarios + 1;
            I=Usuarios.Ninsc;
            itoa(Usuarios.Ninsc,S,10);
            etexto(27,6,black,lightgray,S);
            S[0]='\0';
          }
        else if (tipo2==2)
          {
            AbrirArquivo(2);
            if (PesUsuarios('N',"Ninsc",I,"",0)==-1)
              rodape("Numero de Inscricao, nao encontrado !"," ",yellow,red);
          }
          Digita_formUsuarios();
      
      Controles_formUsuarios("Salvar",tipo2,pos,col,rod,true);
   }
else if (strcmp(tipo,"3")==0)
    {
      S[0]='\0';
      S=digita(S,5,5,28,5,black,lightgray,'N',32); /* N insc */
      I=atoi(S);
      Usuarios.Ninsc=I;
      if ((strlen(S) > 0) && (S!=repete(" ",strlen(S)))) 
        {
         if (PesBinaria(I)!=-1)
           {
              Atribuir_vUsuarios(false);
              Rotulos_formUsuarios(2);
              rodape(rod," ",white,blue);
           }
         else
           {
            Atribuir_vUsuarios(true);
            Rotulos_formUsuarios(2);
            rodape("Numero de Inscricao, nao encontrado !"," ",yellow,red);
           }
        }
        Controles_formUsuarios("Fechar",tipo2,pos,col,rod,true);
    }
else if (strcmp(tipo,"4")==0)
    {
      S[0]='\0';
      S=digita(S,30,30,13,5,black,lightgray,'T',32);
      strcpy(Usuarios.Nome,S);
      if ((strlen(S) > 0) && (S!=repete(" ",strlen(S))))
        {
         if (PesUsuarios('S',"Nome",0,S,strlen(S))!=-1)
           {
              Atribuir_vUsuarios(false);
              Rotulos_formUsuarios(2);
              rodape(rod," ",white,blue);
           }
         else
           {
            Atribuir_vUsuarios(true);
            Rotulos_formUsuarios(2);
            rodape("Nome do Usuario, nao encontrado !"," ",yellow,red);
           }
        }
        Controles_formUsuarios("Fechar",tipo2,pos,col,rod,true);
    }
else if (strcmp(tipo,"5")==0)
    {
      S[0]='\0';
      S=digita(S,10,10,19,5,black,lightgray,'N',32);
      strcpy(Usuarios.Ident,S);
      if ((strlen(S) > 0) && (S!=repete(" ",strlen(S))))
        {
         if (PesUsuarios('N',"Ident",0,S,strlen(S))!=-1)
           {
              Atribuir_vUsuarios(false);
              Rotulos_formUsuarios(2);
              rodape(rod," ",white,blue);
           }
         else
           {
            Atribuir_vUsuarios(true);
            Rotulos_formUsuarios(2);
            rodape("Identidade do Usuario, nao encontrada !"," ",yellow,red);
           }
        }
        Controles_formUsuarios("Fechar",tipo2,pos,col,rod,true);
    }
else if (strcmp(tipo,"6")==0)
  {
    Listapos=pos;
    Listacol=col;
    if (Lista(2,6,5,13,70,nTamUsuarios+2,194,white,blue,foco)==1)
      {
        DesenhaLista(2,6,5,13,70,white,blue,pos,col,false);
        Controles_formUsuarios("Fechar",tipo2,pos,col,rod,true);
      }
  }
else if (strcmp(tipo,"Salvar")==0)
  {
    switch(Botao(20,48,black,white,black,blue," Salvar ",foco)){
      case 1:
          DesenhaBotao(20,48,black,white,black,blue," Salvar ",false);
          Controles_formUsuarios("Fechar",tipo2,pos,col,rod,true);
          break;
      case 2:
          SalvarUsuarios(tipo2);
          DesenhaBotao(20,48,black,white,black,blue," Salvar ",false);
          Controles_formUsuarios("Fechar",tipo2,pos,col,rod,true);
          break;
    }
  }
else if (strcmp(tipo,"Fechar")==0)
  {
    switch(Botao(20,63,black,white,black,blue," Fechar ",foco)){
      case 1:
          DesenhaBotao(20,63,black,white,black,blue," Fechar ",false);
          if (tipo2==1)
            Controles_formUsuarios("2",tipo2,pos,col,rod,true);
          else if (tipo2==2)
            Controles_formUsuarios("1",tipo2,pos,col,rod,false);
          else if (tipo2==3)
            Controles_formUsuarios("3",tipo2,pos,col,rod,false);
          else if (tipo2==4)
            Controles_formUsuarios("4",tipo2,pos,col,rod,false);
          else if (tipo2==5)
            Controles_formUsuarios("5",tipo2,pos,col,rod,false);
          else if (tipo2==6)
            Controles_formUsuarios("6",tipo2,pos,col,rod,true);
          break;
      case 2:
         rodape(""," ",white,blue);
         fclose(UsuariosFile);
         break;
    }
  }

}

/*-------------------------------------------------------*/

/*
 Nome : Atribuir_vUsuarios
 Descricao : procedimento que atribui ou limpa o vetor de Usuarios.
 Parametros :
 limpar - indica se vai limpar ou atribuir os vetores
*/
void Atribuir_vUsuarios(boolean limpar)
{
if (limpar==false)
 {
      itoa(Usuarios.Ninsc,S,10);
      strcpy(vUsuarios[1],S);
      strcpy(vUsuarios[2],Usuarios.Nome);
      strcpy(vUsuarios[3],Usuarios.Ident);
      strcpy(vUsuarios[4],Usuarios.Endereco.Logra);
      itoa(Usuarios.Endereco.Numero,S,10);
      strcpy(vUsuarios[5],S);
      strcpy(vUsuarios[6],Usuarios.Endereco.Compl);
      strcpy(vUsuarios[7],Usuarios.Endereco.Bairro);
      strcpy(vUsuarios[8],Usuarios.Endereco.Cep);
      strcpy(vUsuarios[9],Usuarios.Telefone);
      vUsuarios[10][0]=Usuarios.Categoria;
      itoa(Usuarios.Situacao,S,10);
      strcpy(vUsuarios[11],S);
 }
else
 {
  vUsuarios[2]=repete(" ",30);
  vUsuarios[3]=repete(" ",10);
  vUsuarios[4]=repete(" ",30);
  vUsuarios[5]=repete(" ",5);
  vUsuarios[6]=repete(" ",10);
  vUsuarios[7]=repete(" ",20);
  vUsuarios[8]=repete(" ",8);
  vUsuarios[9]=repete(" ",11);
  vUsuarios[10]=repete(" ",1);
  vUsuarios[11]=repete(" ",1);
 }
}

/*-------------------------------------------------------*/

/*
 Nome : digita_formUsuarios
 Descricao : procedimento que realiza o cotrole de S=digitacao dos dados no
 formulario de usuarios.
*/
void Digita_formUsuarios(void)
{
        strcpy(S,Usuarios.Nome);
        strcpy(Usuarios.Nome,digita(S,30,30,43,5,black,lightgray,'T',32));
        strcpy(S,Usuarios.Ident);
        strcpy(Usuarios.Ident,digita(S,10,10,19,7,black,lightgray,'N',32));
        strcpy(S,Usuarios.Telefone);
        strcpy(Usuarios.Telefone,digita(S,11,11,43,7,black,lightgray,'N',32));
        strcpy(S,Usuarios.Endereco.Logra);
        strcpy(Usuarios.Endereco.Logra,digita(S,30,30,19,11,black,lightgray,'T',32));
        itoa(Usuarios.Endereco.Numero,S,10);
        strcpy(S,digita(S,5,5,61,11,black,lightgray,'N',32));
        I=atoi(S);
        Usuarios.Endereco.Numero=I;
        strcpy(S,Usuarios.Endereco.Compl);
        strcpy(Usuarios.Endereco.Compl,digita(S,10,10,20,13,black,lightgray,'T',32));
        strcpy(S,Usuarios.Endereco.Bairro);
        strcpy(Usuarios.Endereco.Bairro,digita(S,20,20,42,13,black,lightgray,'T',32));
        strcpy(S,Usuarios.Endereco.Cep);
        strcpy(Usuarios.Endereco.Cep,digita(S,8,8,70,13,black,lightgray,'N',32));
        S[0]=Usuarios.Categoria;
        strcpy(S,digita(S,1,1,18,16,black,lightgray,'T',32));
        Usuarios.Categoria=S[0];
        itoa(Usuarios.Situacao,S,10);
        strcpy(S,digita(S,1,1,17,18,black,lightgray,'N',32));
        I=atoi(S);
        Usuarios.Situacao=I;
        S[0]='\0';

}

/*-------------------------------------------------------*/

/*
 Nome : VerificaUsuarios
 Descricao : funcao que verifica se os dados no formulario de usuarios
 foram S=digitados.
*/
boolean VerificaUsuarios(void)
{
  itoa(Usuarios.Ninsc,S,10);
  if ((strlen(S) == 0) && (S==repete(" ",strlen(S)))) 
    {
      rodape("Numero de Inscricao, nao cadastrado !"," ",yellow,red);
      return(false);
    }
  if ((strlen(Usuarios.Nome) == 0) &&
     (Usuarios.Nome==repete(" ",strlen(Usuarios.Nome))))
    {
      rodape("Nome do Usuario, nao cadastrado !"," ",yellow,red);
      return(false);
    }
  if ((strlen(Usuarios.Ident) == 0) && (Usuarios.Ident==repete(" ",strlen(Usuarios.Ident))))
    {
      rodape("Identidade, nao cadastrada !"," ",yellow,red);
      return(false);
    }
  if ((strlen(Usuarios.Endereco.Logra) == 0) &&
     (Usuarios.Endereco.Logra==repete(" ",strlen(Usuarios.Endereco.Logra))))
    {
      rodape("Logradouro, nao cadastrado !"," ",yellow,red);
      return(false);
    }
  itoa(Usuarios.Endereco.Numero,S,10);
  if ((strlen(S) == 0) && (S==repete(" ",strlen(S))))
    {
      rodape("Numero do Endereco, nao cadastrado !"," ",yellow,red);
      return(false);
    }
  if ((strlen(Usuarios.Endereco.Compl) == 0)
     && (Usuarios.Endereco.Compl==repete(" ",strlen(Usuarios.Endereco.Compl))))
    {
      rodape("Complemento do Endereco, nao cadastrado !"," ",yellow,red);
      return(false);
    }
  if ((strlen(Usuarios.Endereco.Bairro) == 0)
     && (Usuarios.Endereco.Bairro==repete(" ",strlen(Usuarios.Endereco.Bairro))))
    {
      rodape("Bairro, nao cadastrado !"," ",yellow,red);
      return(false);
    }
  if ((strlen(Usuarios.Endereco.Cep) == 0) &&
     (Usuarios.Endereco.Cep==repete(" ",strlen(Usuarios.Endereco.Cep))))
    {
      rodape("Cep, nao cadastrado !"," ",yellow,red);
      return(false);
    }
  if ((strlen(Usuarios.Telefone) == 0) &&
     (Usuarios.Telefone==repete(" ",strlen(Usuarios.Telefone))))
    {
      rodape("Telefone, nao cadastrado !"," ",yellow,red);
      return(false);
    }
  if ((Usuarios.Categoria == '\0') && (Usuarios.Categoria== ' '))
    {
      rodape("Categoria, nao cadastrada !"," ",yellow,red);
      return(false);
    }
 
 return(true);
}

/*---------------------------------------------------------------*/

/*
 Nome : SalvarUsuarios
 Descricao : procedimento que salva os dados S=digitados no
 formulario de usuarios.
 Parametros :
 tipo - indica qual acao a salvar
*/
void SalvarUsuarios(int tipo)
{
if (VerificaUsuarios()==true)
{
if ((Usuarios.Categoria=='A') || (Usuarios.Categoria=='P')
   || (Usuarios.Categoria=='F'))
  {
    if (tipo==1)
      {
        if(fseek(UsuariosFile,nTamUsuarios*sizeof(struct UsuariosRec),SEEK_SET)==0)
          fwrite(&Usuarios, sizeof(struct UsuariosRec), 1, UsuariosFile);
        Atribuir_vUsuarios(true);
        Rotulos_formUsuarios(0);
        Limpar_Usuarios();
      }
    else if (tipo==2)
       fwrite(&Usuarios, sizeof(struct UsuariosRec), 1, UsuariosFile);
  }
else
  rodape("Categoria, Cadastrada Incorretamente !"," ",yellow,red);
}

}
