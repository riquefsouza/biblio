/* Modulo de Livros */

#include "biblio.h"

 /* variaveis gerais */

 int I;
 char *vLivros[11];   /* 30 */

/******************Modulo de Livros**********************/

/*
 Nome : PesLivros
 Descricao : funcao que pesquisa as informacoes contidas no arquivo de
 livros
 Parametros :
 tipo - indica se e o valor e (N)umerico ou (S)tring
 campo - qual o campo a ser pesquisado
 nCod2 - codigo do campo se numerico
 sCod2 - codigo do campo se string
 nTamsCod - tamanho caracteres do campo de string
*/
int PesLivros(char tipo,char *campo,int nCod2,char *sCod2,
              int nTamsCod)
{
 int nPosicao,nCod,nRet;
 char *sCod;
 boolean bFlag;

sCod=(char*)malloc(50);
if (!sCod)
  exit(1);

fseek(LivrosFile,0,SEEK_SET);
nPosicao=0;
bFlag=false;
nCod=0;
sCod[0]='\0'; 
while (!feof(LivrosFile)) 
 {
   fread(&Livros,sizeof(struct LivrosRec),1,LivrosFile);
   if (tipo=='N')
     {
       if (strcmp(campo,"Ninsc")==0)
          nCod=Livros.Ninsc;

       if (nCod==nCod2) 
         {
          nRet=nPosicao;
          fseek(LivrosFile,nPosicao*sizeof(struct LivrosRec),SEEK_SET);
          bFlag=true;
          break;
         }
     }
   else if (tipo=='S')
     {
       if (strcmp(campo,"Titulo")==0)
          sCod=Livros.Titulo;
       else if (strcmp(campo,"Area")==0) 
          sCod=Livros.Area;
       else if (strcmp(campo,"Autor")==0)
          sCod=Livros.Autor;
       else if (strcmp(campo,"Pchave")==0)
          sCod=Livros.PChave;

       if (strcmp(copy(sCod,1,nTamsCod),sCod2)==0)
         {
          nRet=nPosicao;
          fseek(LivrosFile,nPosicao*sizeof(struct LivrosRec),SEEK_SET);
          bFlag=true;
          break;
         }
     }
   nPosicao++;
 }
 if ((feof(LivrosFile)) && (bFlag==false))
    return(-1);
 return(nRet);
}

/*-----------------------------------------------------*/

/*
 Nome : formLivros
 Descricao : procedimento que desenha o formulario de livros na tela, e
 tambem indica qual acao a tomar.
 Parametros :
 tipo - indica qual a acao do formulario
 titulo - o titulo do formulario
 rod - o texto do rodape sobre o formulario
*/
void formLivros(int tipo,char *titulo,char *rod)
{
  teladefundo("±",white,lightblue);
  rodape(rod," ",white,blue);  
  formulario(somastr(3,"´",titulo,"Ã"),4,2,18,76,white,blue,'±',lightgray,black);

  vLivros[1]=repete(" ",5);
  Atribuir_vLivros(true);
  AbrirArquivo(1);
  if ((tipo==1) || (tipo==2))
    {
     Rotulos_formLivros(0);
     DesenhaBotao(20,45,black,white,black,blue," Salvar ",false);
     DesenhaBotao(20,60,black,white,black,blue," Fechar ",false);
    }
  if ((tipo==3) || (tipo==4) || (tipo==5) || (tipo==6))
    {
     DesenhaBotao(20,60,black,white,black,blue," Fechar ",false);
     Rotulos_formLivros(2);
     postexto(2,7,white,blue);
     cprintf("%s%s%s","Ã",repete("Ä",75),"´");
    }
  if (tipo==7)
     DesenhaBotao(20,60,black,white,black,blue," Fechar ",false);

  if (tipo==3)
    {
     etexto(5,6,white,blue,"Titulo : ");
     etexto(14,6,black,lightgray,repete(" ",30));
    }
  if (tipo==4)
    {
     etexto(5,6,white,blue,"Autor : ");
     etexto(13,6,black,lightgray,repete(" ",30));
    }
  if (tipo==5) 
    {
     etexto(5,6,white,blue,"Area : ");
     etexto(12,6,black,lightgray,repete(" ",30));
    }
  if (tipo==6)
    {
     etexto(5,6,white,blue,"Palavra-Chave : ");
     etexto(21,6,black,lightgray,repete(" ",10));
    }

  Limpar_Livros();
  if (tipo==1)
     Controles_formLivros("2",1,0,0,rod,false);  /* cadastrar */
  else if (tipo==2)
     Controles_formLivros("1",2,0,0,rod,false);  /* alterar */
  else if (tipo==3)
     Controles_formLivros("3",3,0,0,rod,false); /* consultar por titulo */
  else if (tipo==4)
     Controles_formLivros("4",4,0,0,rod,false); /* consultar por Autor */
  else if (tipo==5)
     Controles_formLivros("5",5,0,0,rod,false); /* consultar por Area */
  else if (tipo==6)
     Controles_formLivros("6",6,0,0,rod,false); /* consultar por Palavra-chave */
  else if (tipo==7)
     Controles_formLivros("7",7,0,0,rod,true); /* consultar todos */
}

/*-------------------------------------------*/

/*
 Nome : Limpar_Livros
 Descricao : procedimento limpa as variaveis do registro de livros.
*/
void Limpar_Livros(void)
{
     Livros.Ninsc=0;
     Livros.Titulo[0]='\0';
     Livros.Autor[0]='\0';
     Livros.Area[0]='\0';
     Livros.PChave[0]='\0';
     Livros.Edicao=0;
     Livros.AnoPubli=0;
     Livros.Editora[0]='\0';
     Livros.Volume=0;
     Livros.Estado=' ';
}

/*-------------------------------------------*/

/*
 Nome : Rotulos_formLivros
 Descricao : procedimento que escreve os rotulos do formulario de livros.
 Parametros :
 l - indica um acrescimo na linha do rotulo
*/
void Rotulos_formLivros(int l)
{
  etexto(5,6+l,white,blue,"Numero de Inscricao : ");
  etexto(27,6+l,black,lightgray,vLivros[1]);
  etexto(35,6+l,white,blue,"Titulo : ");
  etexto(44,6+l,black,lightgray,vLivros[2]);
  etexto(5,8+l,white,blue,"Autor : ");
  etexto(13,8+l,black,lightgray,vLivros[3]);
  etexto(5,10+l,white,blue,"Area : ");
  etexto(12,10+l,black,lightgray,vLivros[4]);
  etexto(5,12+l,white,blue,"Palavra-Chave : ");
  etexto(21,12+l,black,lightgray,vLivros[5]);
  etexto(35,12+l,white,blue,"Edicao : ");
  etexto(44,12+l,black,lightgray,vLivros[6]);
  etexto(5,14+l,white,blue,"Ano de Publicacao : ");
  etexto(25,14+l,black,lightgray,vLivros[7]);
  etexto(35,14+l,white,blue,"Editora : ");
  etexto(45,14+l,black,lightgray,vLivros[8]);
  etexto(5,16+l,white,blue,"Volume : ");
  etexto(14,16+l,black,lightgray,vLivros[9]);
  etexto(22,16+l,white,blue,"Estado Atual : ");
  etexto(37,16+l,black,lightgray,vLivros[10]);
  etexto(40,16+l,white,blue,"(D)isponivel ou (E)mprestado");

}

/*-------------------------------------------*/

/*
 Nome : Controles_formLivros
 Descricao : procedimento que realiza todo o controle de manuseio do
 formulario de livros.
 Parametros :
 tipo - indica qual a acao do formulario
 tipo2 - indica a acao original do formulario nao manipulado pela funcao
 pos - indica a ultima posicao da linha da lista de livros
 col - indica a ultima posicao da coluna da lista de livros
 rod - o texto do rodape sobre o formulario
 foco - se os objetos do formulario estao focados ou nao
*/
void Controles_formLivros(char *tipo,int tipo2,int pos,int col,char *rod,
                          boolean foco)
{
if (strcmp(tipo,"1")==0)
   {
      S=digita(S,5,5,28,5,black,lightgray,'N',32); /* N insc */
      I=atoi(S);
      Livros.Ninsc=I;
      if ((strlen(S) > 0) && (S!=repete(" ",strlen(S))))
        {
         DesenhaBotao(20,45,black,white,black,blue," Salvar ",false);
         if (PesLivros('N',"Ninsc",I,"",0)!=-1)
           {
                Atribuir_vLivros(false);
                Rotulos_formLivros(0);
                rodape(rod," ",white,blue);
                Controles_formLivros("2",tipo2,pos,col,rod,false);
           }
         else
           {
            itoa(I,S,10);
            Atribuir_vLivros(true);
            Rotulos_formLivros(0);
            rodape("Numero de Inscricao, nao encontrado !"," ",yellow,red);
            Controles_formLivros("Fechar",tipo2,pos,col,rod,true);
           }
        }
      else
        Controles_formLivros("Fechar",tipo2,pos,col,rod,true);
   }
else if (strcmp(tipo,"2")==0)
   {
        if (tipo2==1)
          {
            nTamLivros=tamArquivo(LivrosFile,sizeof(struct LivrosRec));
            if (nTamLivros == 0)
               Livros.Ninsc=1;
            else
               Livros.Ninsc=nTamLivros + 1;
            I=Livros.Ninsc;
            itoa(Livros.Ninsc,S,10);
            etexto(27,6,black,lightgray,S);
            S[0]='\0';
          }
        else if (tipo2==2)
          {
            AbrirArquivo(1);
            if (PesLivros('N',"Ninsc",I,"",0)==-1)
              rodape("Numero de Inscricao, nao encontrado !"," ",yellow,red);
          }
          Digita_formLivros();
      
      Controles_formLivros("Salvar",tipo2,pos,col,rod,true);
   }
else if (strcmp(tipo,"3")==0)
    {
      S[0]='\0';
      S=digita(S,30,30,15,5,black,lightgray,'T',32);
      strcpy(Livros.Titulo,S);
      if ( (strlen(S) > 0) && (S!=repete(" ",strlen(S))) )
        {
         if (PesLivros('S',"Titulo",0,S,strlen(S))!=-1)
           {
              Atribuir_vLivros(false);
              Rotulos_formLivros(2);
              rodape(rod," ",white,blue);
           }
         else
           {
            Atribuir_vLivros(true);
            Rotulos_formLivros(2);
            rodape("Titulo do Livro, nao encontrado !"," ",yellow,red);
           }
        }
        Controles_formLivros("Fechar",tipo2,pos,col,rod,true);
    }
else if (strcmp(tipo,"4")==0)
    {
      S[0]='\0';
      S=digita(S,30,30,14,5,black,lightgray,'T',32);
      strcpy(Livros.Autor,S);
      if ((strlen(S) > 0) && (S!=repete(" ",strlen(S))))
        {
         if (PesLivros('S',"Autor",0,S,strlen(S))!=-1)
           {
              Atribuir_vLivros(false);
              Rotulos_formLivros(2);
              rodape(rod," ",white,blue);
           }
         else
           {
            Atribuir_vLivros(true);
            Rotulos_formLivros(2);
            rodape("Autor do Livro, nao encontrado !"," ",yellow,red);
           }
        }
        Controles_formLivros("Fechar",tipo2,pos,col,rod,true);
    }
else if (strcmp(tipo,"5")==0)
    {
      S[0]='\0';
      S=digita(S,4,4,13,5,black,lightgray,'T',32);
      strcpy(Livros.Area,S);
      if ((strlen(S) > 0) && (S!=repete(" ",strlen(S))))
        {
         if (PesLivros('S',"Area",0,S,strlen(S))!=-1)
           {
              Atribuir_vLivros(false);
              Rotulos_formLivros(2);
              rodape(rod," ",white,blue);
           }
         else
           {
            Atribuir_vLivros(true);
            Rotulos_formLivros(2);
            rodape("Area do Livro, nao encontrada !"," ",yellow,red);
           }
        }
        Controles_formLivros("Fechar",tipo2,pos,col,rod,true);
    }
else if (strcmp(tipo,"6")==0)
    {
      S[0]='\0';
      S=digita(S,10,10,22,5,black,lightgray,'T',32);
      strcpy(Livros.PChave,S);
      if ((strlen(S) > 0) && (S!=repete(" ",strlen(S))))
        {
         if (PesLivros('S',"Pchave",0,S,strlen(S))!=-1)
           {
              Atribuir_vLivros(false);
              Rotulos_formLivros(2);
              rodape(rod," ",white,blue);
           }
         else
           {
            Atribuir_vLivros(true);
            Rotulos_formLivros(2);
            rodape("Palavra-Chave do Livro, nao encontrado !"," ",yellow,red);
           }
        }
        Controles_formLivros("Fechar",tipo2,pos,col,rod,true);
    }
else if (strcmp(tipo,"7")==0)
  {
    Listapos=pos;
    Listacol=col;
    if (Lista(1,6,5,13,70,nTamLivros+2,220,white,blue,foco)==1)
      {
        DesenhaLista(1,6,5,13,70,white,blue,pos,col,false);
        Controles_formLivros("Fechar",tipo2,pos,col,rod,true);
      }
  }
else if (strcmp(tipo,"Salvar")==0)
  {
    switch(Botao(20,45,black,white,black,blue," Salvar ",foco)) {
      case 1:
          DesenhaBotao(20,45,black,white,black,blue," Salvar ",false);
          Controles_formLivros("Fechar",tipo2,pos,col,rod,true);
          break;
      case 2:
          SalvarLivros(tipo2);
          DesenhaBotao(20,45,black,white,black,blue," Salvar ",false);
          Controles_formLivros("Fechar",tipo2,pos,col,rod,true);
          break;
    }
  }
else if (strcmp(tipo,"Fechar")==0)
  {
    switch(Botao(20,60,black,white,black,blue," Fechar ",foco)) { 
      case 1:
          DesenhaBotao(20,60,black,white,black,blue," Fechar ",false);
          if (tipo2==1)
            Controles_formLivros("2",tipo2,pos,col,rod,true);
          else if (tipo2==2)
            Controles_formLivros("1",tipo2,pos,col,rod,false);
          else if (tipo2==3)
            Controles_formLivros("3",tipo2,pos,col,rod,false);
          else if (tipo2==4)
            Controles_formLivros("4",tipo2,pos,col,rod,false);
          else if (tipo2==5)
            Controles_formLivros("5",tipo2,pos,col,rod,false);
          else if (tipo2==6)
            Controles_formLivros("6",tipo2,pos,col,rod,false);
          else if (tipo2==7)
            Controles_formLivros("7",tipo2,pos,col,rod,true);
          break;
      case 2:
         rodape(""," ",white,blue);
         fclose(LivrosFile);
         break;
    }
  }

}

/*-------------------------------------------------------*/

/*
 Nome : Atribuir_vLivros
 Descricao : procedimento que atribui ou limpa o vetor de livros.
 Parametros :
 limpar - indica se vai limpar ou atribuir os vetores
*/
void Atribuir_vLivros(boolean limpar)
{
if (limpar==false)
 {
      itoa(Livros.Ninsc,S,10);
      strcpy(vLivros[1],S);
      strcpy(vLivros[2],Livros.Titulo);
      strcpy(vLivros[3],Livros.Autor);
      strcpy(vLivros[4],Livros.Area);
      strcpy(vLivros[5],Livros.PChave);
      itoa(Livros.Edicao,S,10);
      strcpy(vLivros[6],S);
      itoa(Livros.AnoPubli,S,10);
      strcpy(vLivros[7],S);
      strcpy(vLivros[8],Livros.Editora);
      itoa(Livros.Volume,S,10);
      strcpy(vLivros[9],S);
      vLivros[10][0]=Livros.Estado;
 }
else
 {
  vLivros[2]=repete(" ",30);
  vLivros[3]=repete(" ",30);
  vLivros[4]=repete(" ",30);
  vLivros[5]=repete(" ",10);
  vLivros[6]=repete(" ",4);
  vLivros[7]=repete(" ",4);
  vLivros[8]=repete(" ",30);
  vLivros[9]=repete(" ",4);
  vLivros[10]=repete(" ",1);
 }
}

/*-------------------------------------------------------*/

/*
 Nome : Digita_formLivros
 Descricao : procedimento que realiza o cotrole de digitacao dos dados no
 formulario de livros.
*/
void Digita_formLivros(void)
{
        strcpy(S,Livros.Titulo);
        strcpy(Livros.Titulo,digita(S,30,30,45,5,black,lightgray,'T',32));
        strcpy(S,Livros.Autor);
        strcpy(Livros.Autor,digita(S,30,30,14,7,black,lightgray,'T',32));
        strcpy(S,Livros.Area);
        strcpy(Livros.Area,digita(S,30,30,13,9,black,lightgray,'T',32));
        strcpy(S,Livros.PChave);
        strcpy(Livros.PChave,digita(S,10,10,22,11,black,lightgray,'T',32));
        itoa(Livros.Edicao,S,10);
        strcpy(S,digita(S,4,4,45,11,black,lightgray,'N',32));
        I=atoi(S);
        Livros.Edicao=I;
        itoa(Livros.AnoPubli,S,10);
        strcpy(S,digita(S,4,4,26,13,black,lightgray,'N',32));
        I=atoi(S);
        Livros.AnoPubli=I;
        strcpy(S,Livros.Editora);
        strcpy(Livros.Editora,digita(S,30,30,46,13,black,lightgray,'T',32));
        itoa(Livros.Volume,S,10);
        strcpy(S,digita(S,4,4,15,15,black,lightgray,'N',32));
        I=atoi(S);
        Livros.Volume=I;
        S[0]=Livros.Estado;
        strcpy(S,digita(S,1,1,38,15,black,lightgray,'T',32));
        Livros.Estado=S[0];
        S[0]='\0'; 

}

/*-------------------------------------------------------*/

/*
 Nome : VerificaLivros
 Descricao : funcao que verifica se os dados no formulario de livros
 foram digitados.
*/
boolean VerificaLivros(void)
{
  itoa(Livros.Ninsc,S,10);
  if ((strlen(S) == 0) && (S==repete(" ",strlen(S))))
    {
      rodape("Numero de Inscricao, nao cadastrado !"," ",yellow,red);
      return(false);
    }
  if ((strlen(Livros.Titulo) == 0) &&
  (Livros.Titulo==repete(" ",strlen(Livros.Titulo))))
    {
      rodape("Titulo, nao cadastrado !"," ",yellow,red);
      return(false);
    }
  if ((strlen(Livros.Autor) == 0) &&
  (Livros.Autor==repete(" ",strlen(Livros.Autor))))
    {
      rodape("Autor, nao cadastrado !"," ",yellow,red);
      return(false);
    }
  if ((strlen(Livros.Area) == 0) &&
  (Livros.Area==repete(" ",strlen(Livros.Area))))
    {
      rodape("Area, nao cadastrada !"," ",yellow,red);
      return(false);
    }
  if ((strlen(Livros.PChave) == 0) &&
  (Livros.PChave==repete(" ",strlen(Livros.PChave))))
    {
      rodape("Palavra-Chave, nao cadastrada !"," ",yellow,red);
      return(false);
    }
  itoa(Livros.Edicao,S,10);
  if ((strlen(S) == 0) && (S==repete(" ",strlen(S))))
    {
      rodape("Edicao, nao cadastrada !"," ",yellow,red);
      return(false);
    }
  itoa(Livros.AnoPubli,S,10);
  if ((strlen(S) == 0) && (Livros.Titulo==repete(" ",strlen(Livros.Titulo))))
    {
      rodape("Ano de Publicacao, nao cadastrado !"," ",yellow,red);
      return(false);
    }
  if ((strlen(Livros.Editora) == 0) &&
  (Livros.Editora==repete(" ",strlen(Livros.Editora))))
    {
      rodape("Editora, nao cadastrada !"," ",yellow,red);
      return(false);
    }
  itoa(Livros.Volume,S,10);
  if ((strlen(S) == 0) && (S==repete(" ",strlen(S))))
    {
      rodape("Volume, nao cadastrado !"," ",yellow,red);
      return(false);
    }
  if ((Livros.Estado == '\0') && (Livros.Estado==' '))
    {
      rodape("Estado, nao cadastrado !"," ",yellow,red);
      return(false);
    }

 return(true);
}

/*---------------------------------------------------------------*/

/*
 Nome : SalvarLivros
 Descricao : procedimento que salva os dados digitados no
 formulario de livros.
 Parametros :
 tipo - indica qual acao a salvar
*/
void SalvarLivros(int tipo)
{
if (VerificaLivros()==true)
{
if ((Livros.Estado=='D') || (Livros.Estado=='E'))
  {
    if (tipo==1)
      {
        if(fseek(LivrosFile,nTamLivros*sizeof(struct LivrosRec),SEEK_SET)==0)
          fwrite(&Livros, sizeof(struct LivrosRec), 1, LivrosFile);
        Atribuir_vLivros(true);
        Rotulos_formLivros(0);
        Limpar_Livros();

      }
    else if (tipo==2)
       fwrite(&Livros, sizeof(struct LivrosRec), 1, LivrosFile);
  }
else
  rodape("Estado Atual, Cadastrado Incorretamente !"," ",yellow,red);
}

}
