/* Modulo de Graficos */

#include "biblio.h"

 /* variaveis de menu */

 char *vMenu[10];   /* 30 */
 char *vSubMenu[10][10];  /* 35 */

 /* variaveis de lista */

 char *vLista[50];
 int Listapos;
 int Listacol;

/*--------------------------------------------------*/

/*
 Nome : Digita
 Descricao : Procedimento que permite ter um maior controle da digitacao
 de um texto, tambem permitindo indicar um texto maior do que o permitido
 pelo espaco limite definido.
 Parametros :
 S - e o resultado da digitacao
 JanelaTam - indica o tamanho maximo de visualizacao do texto digitado
 maxtam - indica o tamanho maximo do texto a ser digitado
 X - posicao da coluna na tela
 Y - posicao da linha na tela
 fg - cor do texto
 bg - cor de fundo
 FT - indica o tipo de caracter a ser digitado se (N)umero ou (T)exto
 fundo - Indica o caracter de fundo, da janela de digitacao
*/
char *digita(char *str,int janelatam,int maxtam,int x,int y,
                  int fg,int bg,char ft,int fundo)
{
   int xx, i, j, p;
   boolean inserton;
   int compensacao;
   char *tempstr,*S1;

/*-------------------------------------------*/

_setcursortype(_NORMALCURSOR);
S1=(char*)malloc(100);
for(i=0;i<strlen(str);i++)
 S1[i]=str[i];
S1[i]='\0';

j=strlen(S1);
for(i=j;i<=(maxtam-j);i++)
   S1[i]=fundo;
/* S1[0]=maxtam; */
S1[i]='\0';

tempstr=copy(S1,1,janelatam);
escreverapido(x,y,tempstr,fg,bg);
/* S1=""; */
p=0; /* p=1; */
compensacao=1;
inserton=true;

do {
    xx=x+((p+1)-compensacao);
    if(((p+1)-compensacao) == janelatam)
       xx--;

xy(xx,y);

if (inserton)
   inkey('S', 'O');
else
   inkey('B', 'O');

if (ft=='N') 
  {
   if (sKey == TextKey)
     {
      beep(100,250);
      sKey=NullKey;
     }
   else if ( (ch=='-') && ((p>1) || (S1[1]=='-')) )
    {
     beep(100,250);
     sKey=NullKey;
    }
   else if (ch=='.') 
    {
     if ( !((posstr('.',S1)==0) || (posstr('.',S1)==p)) )
       {
        beep(100,250);
        sKey=NullKey;
       }
     else if (posstr('.',S1)==p)
       S1=deletar(S1,(p+1),1);
    }
  }

 switch(sKey)
  {
   case NumberKey: case SpaceKey:
   case TextKey:
     {
      if (strlen(S1) == maxtam) 
        {
         if (p == maxtam)
          {
           S1=deletar(S1,maxtam,1);
           S1[maxtam-1]=ch; 
           S1[maxtam]='\0';
           if (p == (janelatam+compensacao)) 
             compensacao++;
           tempstr=copy(S1,compensacao,janelatam);
           escreverapido(x,y,tempstr,fg,bg);
          }
         else
          {
           if (inserton) 
             {
              S1=deletar(S1,maxtam,1);
              S1=inserir(ch,S1,(p+1));
              if (p == (janelatam+compensacao))
                 compensacao++;
              if (p < maxtam)
                 p++;
              tempstr=copy(S1,compensacao,janelatam);
              escreverapido(x,y,tempstr,fg,bg);
             }
           else 
             {
              S1=deletar(S1,(p+1),1);
              S1=inserir(ch,S1,(p+1));
              if (p == (janelatam + compensacao))
                 compensacao++;
              if (p < maxtam)
                 p++;
              tempstr=copy(S1,compensacao,janelatam);
              escreverapido(x,y,tempstr,fg,bg);
             }
          }
        }
        else
          {
            if (inserton)
              {
               S1=inserir(ch,S1,(p+1));
              }
            else
              {
               S1=deletar(S1,(p+1),1);
               S1=inserir(ch,S1,(p+1));
              }
            if (p == (janelatam+compensacao))
               compensacao++;
            if (p < maxtam)
               p++;
            tempstr=copy(S1,compensacao,janelatam);
            escreverapido(x,y,tempstr,fg,bg);
          }
     }
     break;
   case Bksp:
     {
      if (p > 0) 
        {
         p--;
         S1=deletar(S1,(p+1),1);
         S1[maxtam-1]=fundo; 
         S1[maxtam]='\0';
         if (compensacao > 1)
           compensacao--;
         tempstr=copy(S1,compensacao,janelatam);
         escreverapido(x,y,tempstr,fg,bg);
         ch=' ';
        }
      else
        {
         beep(100,250);
         ch=' ';
         p=0;   
        }
     }
     break;
   case LeftArrow :
     {
      if (p > 0) 
        {
         p--;
         if ((p+1) < compensacao) 
           {
             compensacao--;
             tempstr=copy(S1,compensacao,janelatam);
             escreverapido(x,y,tempstr,fg,bg);
           }
        }
      else
        {
         S1=setstring(S1,fundo);
         break;
        }
     }
     break;
   case RightArrow :
     {
      if ( (S1[p] != fundo) && (p < maxtam) )
        {
         p++;
         if (p == (janelatam+compensacao))
           {
             compensacao++;
             tempstr=copy(S1,compensacao,janelatam);
             escreverapido(x,y,tempstr,fg,bg);
           }
        }
      else
        {
         S1=setstring(S1,fundo);
         break;
        }
     }
     break;
   case DeleteKey :
     {
      S1=deletar(S1,(p+1),1);
      S1[maxtam-1]=fundo; 
      S1[maxtam]='\0';
      if ( ((strlen(S1)+1)-compensacao) >= janelatam )
        {
          tempstr=copy(S1,compensacao,janelatam);
          escreverapido(x,y,tempstr,fg,bg);
        }
      else
        {
          tempstr=copy(S1,compensacao,janelatam);
          escreverapido(x,y,tempstr,fg,bg);
        }
     }
     break;
   case InsertKey :
      {
        if (inserton)
           inserton=false;
        else
           inserton=true;
      }
      break;
   case UpArrow: case DownArrow: case PgDn: case PgUp: case NullKey:
   case Esc: case F1: case F2: case F3: case F4: case F5: case F6:
   case F7: case F8: case F9: case F10: case ShiftTab: case HomeKey:
   case EndKey: case CtrlA: case AltA: case AltE: case AltU: case AltS:
   case AltO:
      beep(100,250);
      break;
   case CarriageReturn: case Tab:
      break;
  }

  if (sKey==Tab)
     break;

 } while (sKey!=CarriageReturn);
S1=setstring(S1,fundo);
S1=rtrimstr(S1);
_setcursortype(_NOCURSOR);
return(S1);
}

/*-------------------------------------------*/

/*
 Nome : formulario
 Descricao : procedimento que desenha um formulario na tela.
 Parametros :
 titulo - titulo do formulario
 topo - posicao da linha inicial na tela
 esquerda - posicao da coluna inicial na tela
 altura - a altura do formulario
 largura - a largura do formulario
 fg - cor do texto
 bg - cor de fundo
 sombra - o caracter que vai ser a sobra do formulario
 sfg - cor do texto da sombra
 sbg - cor de fundo da sombra
*/
void formulario(char *titulo,int topo,int esquerda,
                     int altura,int largura,int fg,int bg,
                     char sombra,int sfg,int sbg)
{
 int cont,cont2;

  etexto(esquerda,topo,fg,bg,"Ú");
  for(cont=1;cont<=(largura-1);cont++)
   {
     gotoxy(esquerda+cont,topo);
     cprintf("%s","Ä");
   }
  gotoxy(esquerda+2,topo);
  cprintf("%s",titulo);
  gotoxy(esquerda+largura,topo);
  cprintf("%s","¿");
  for(cont=1;cont<=(altura-1);cont++)
   {
    gotoxy(esquerda,topo+cont);
    cprintf("%s","³");
    for(cont2=1;cont2<=(largura-1);cont2++)
      {
        gotoxy(esquerda+cont2,topo+cont);
        cprintf("%s"," ");
      }
    gotoxy(esquerda+largura,topo+cont);
    cprintf("%s","³");
    postexto(esquerda+largura+1,topo+cont,sfg,sbg);
    cprintf("%c",sombra);
    textcolor(fg);
    textbackground(bg);
   }
  gotoxy(esquerda,topo+altura);
  cprintf("%s","À");
  for(cont=1;cont<=(largura-1);cont++)
   {
     etexto(esquerda+cont,topo+altura,fg,bg,"Ä");
     postexto(esquerda+cont+1,topo+altura+1,sfg,sbg);
     cprintf("%c",sombra);
   }
  etexto(esquerda+largura,topo+altura,fg,bg,"Ù");
  postexto(esquerda+largura+1,topo+altura,sfg,sbg);
  cprintf("%c",sombra);
  gotoxy(esquerda+largura+1,topo+altura+1);
  cprintf("%c",sombra);
}

/*-------------------------------------------*/

/*
 Nome : SubMenu
 Descricao : funcao que permite criar um controle de submenu, retornando
 a opcao selecionada.
 Parametros :
 numero - indica qual e o submenu
 qtd - indica a quantidade de linhas do submenu
 maxtam - indica a largura maxima do submenu
 topo - posicao da linha inicial na tela
 esquerda - posicao da coluna inicial na tela
 ultpos - indica a ultima opcao referenciada pelo usuario
 lfg - cor do texto selecionado
 lbg - cor de fundo selecionado
 fg - cor do texto
 bg - cor de fundo
*/
int SubMenu(int numero,int qtd,int maxtam,int topo,int esquerda,int ultpos,
            int lfg,int lbg,int fg,int bg)
{
 int cont,cont2;

 textcolor(fg);
 textbackground(bg);
 for(cont=0;cont<=(qtd-1);cont++)
  {
    gotoxy(esquerda,topo+cont);

    cprintf("%s%s",vSubMenu[numero][cont+1],
    repete(" ",maxtam-strlen(vSubMenu[numero][cont+1])) );
  }
 postexto(esquerda,topo+ultpos-1,lfg,lbg);
 cprintf("%s%s",vSubMenu[numero][ultpos],
 repete(" ",maxtam-strlen(vSubMenu[numero][ultpos])));

 cont=ultpos-2;
 cont2=ultpos-1;
 do {
   inkey('O','O');

   if (sKey==UpArrow)
     {
       cont--;
       cont2--;
       if (cont2==-1)
         {
          cont=-2;
          cont2=qtd-1;
         }

       postexto(esquerda,topo+cont+2,fg,bg);
       cprintf("%s%s",vSubMenu[numero][cont+3],
       repete(" ",maxtam-strlen(vSubMenu[numero][cont+3])));
       postexto(esquerda,topo+cont2,lfg,lbg);
       cprintf("%s%s",vSubMenu[numero][cont2+1],
       repete(" ",maxtam-strlen(vSubMenu[numero][cont2+1])));

       if (cont==-2)
          cont=qtd-2;

     }
   if (sKey==DownArrow)
     {
       cont++;
       cont2++;
       if (cont2==qtd)
          cont2=0;

       postexto(esquerda,topo+cont,fg,bg);
       cprintf("%s%s",vSubMenu[numero][cont+1],
       repete(" ",maxtam-strlen(vSubMenu[numero][cont+1])));
       postexto(esquerda,topo+cont2,lfg,lbg);
       cprintf("%s%s",vSubMenu[numero][cont2+1],
       repete(" ",maxtam-strlen(vSubMenu[numero][cont2+1])));

       if (cont==qtd-1)
          cont=-1;

     }

     if(sKey==LeftArrow || sKey==RightArrow)
        break;

 } while (sKey!=CarriageReturn);
 if (sKey==LeftArrow)
   return(1);
 else if (sKey==RightArrow)
   return(2);
 else if (sKey==CarriageReturn)
   return(cont2+3);

 return(0);
}

/*-------------------------------------------*/

/*
 Nome : Menu
 Descricao : procedimento que escreve a linha de opcoes do menu.
 Parametros :
 qtd - indica a quantidade de opcoes no menu
 topo - posicao da linha inicial na tela
 fg - cor do texto
 bg - cor de fundo
 lfg - cor do texto do primeiro caracter de cada opcao do menu
 lbg - cor de fundo do primeiro caracter de cada opcao do menu
 pos2 - indica a ultima opcao de menu referenciada pelo usuario
 mfg - cor do texto do selecionado
 mbg - cor de fundo do selecionado
 cont2 - indica a ultima posicao da descricao da opcao de menu
 referenciada pelo usuario
*/
void menu(int qtd,int topo,int fg,int bg,int lfg,int lbg,int pos2,int mfg,int mbg,int cont2)
{
int cont,pos,entre;

   for(cont=1;cont<=80;cont++)
      etexto(cont,topo,fg,bg," ");

   pos=0;
   entre=0;
   for(cont=1;cont<=qtd;cont++)
    {
      etexto(pos+4+entre,topo,lfg,lbg,copy(vMenu[cont],1,1));
      etexto(pos+5+entre,topo,fg,bg,copy(vMenu[cont],2,strlen(vMenu[cont])));
      entre=entre+3;
      pos=pos+strlen(vMenu[cont]);
    }
   if (pos2 > 0)
     {
      postexto(pos2+2,topo,lfg,mbg);
      cprintf(" %s",copy(vMenu[cont2],1,1));
      postexto(pos2+4,topo,mfg,mbg);
      cprintf("%s ",copy(vMenu[cont2],2,strlen(vMenu[cont2])));
     }
}

/*-------------------------------------------*/

/*
 Nome : DesenhaBotao
 Descricao : procedimento que desenha um botao na tela
 Parametros :
 topo - posicao da linha inicial na tela
 esquerda - posicao da coluna inicial na tela
 fg - cor do texto
 bg - cor de fundo
 sfg - cor do texto da sombra
 sbg - cor de fundo da sombra
 texto - o texto a ser escrito no botao
 foco - indica se o botao esta focado ou nao
*/
void DesenhaBotao(int topo,int esquerda,int fg,int bg,int sfg,int sbg,
                  char *texto,boolean foco)
{
 int tam,cont;

tam=strlen(texto);
if (foco==false)
{
   postexto(esquerda,topo,fg,bg);
   cprintf(" %s ",texto);
}
if (foco==true)
{
  postexto(esquerda,topo,fg,bg);
  cprintf("%c%s%c",toascii(16),texto,toascii(17));
}
etexto(esquerda+tam+2,topo,sfg,sbg,"Ü");

for(cont=1;cont<=(tam+2);cont++)
  etexto(esquerda+cont,topo+1,sfg,sbg,"ß");

}

/*-------------------------------------------*/

/*
 Nome : Botao
 Descricao : funcao que realiza a acao de apertar o botao.
 Parametros :
 topo - posicao da linha inicial na tela
 esquerda - posicao da coluna inicial na tela
 fg - cor do texto
 bg - cor de fundo
 sfg - cor do texto da sombra
 sbg - cor de fundo da sombra
 texto - o texto a ser escrito no botao
 foco - indica se o botao esta focado ou nao
*/
int Botao(int topo,int esquerda,int fg,int bg,int sfg,int sbg,
          char *texto,boolean foco)
{
 int tam,cont;

tam=strlen(texto);
DesenhaBotao(topo,esquerda,fg,bg,sfg,sbg,texto,foco);

do {
inkey('O','O');

if (foco==true)
 {
  if (sKey==CarriageReturn)
    {
      postexto(esquerda+1,topo,fg,bg);
      cprintf("%c%s%c",toascii(16),texto,toascii(17));
      etexto(esquerda,topo,sfg,sbg," ");
      for(cont=1;cont<=(tam+2);cont++)
        etexto(esquerda+cont,topo+1,sfg,sbg," ");

      delay(500);
      return(2);
      /* break; */
    }
 }

} while (sKey!=Tab);
 if (sKey==Tab)
    return(1);
 return(0);
}

/*-------------------------------------------*/

/*
 Nome : DesenhaLista
 Descricao : procedimento que desenha uma Lista rolavel na tela
 Parametros :
 tipo - indica o numero de qual arquivo a ser aberto
 topo - posicao da linha inicial na tela
 esquerda - posicao da coluna inicial na tela
 altura - indica a altura da lista
 largura - indica a largura da lista
 fg - cor do texto
 bg - cor de fundo
 pos - indica a ultima posicao da linha da lista na tela
 col - indica a ultima posicao da coluna da lista na tela
 foco - indica se a lista esta focada ou nao
*/
void DesenhaLista(int tipo,int topo,int esquerda,int altura,int largura,
                  int fg,int bg,int pos,int col,boolean foco)
{
 int cont; 
 char *sLista;

if (foco==true)

 {
   etexto(esquerda-1,topo-1,fg,bg,"Ú");
   etexto(esquerda+largura+1,topo-1,fg,bg,"¿");
   etexto(esquerda-1,topo+altura,fg,bg,"À");
   etexto(esquerda+largura+1,topo+altura,fg,bg,"Ù");
 }
else
 {
   etexto(esquerda-1,topo-1,fg,bg," ");
   etexto(esquerda+largura+1,topo-1,fg,bg," ");
   etexto(esquerda-1,topo+altura,fg,bg," ");
   etexto(esquerda+largura+1,topo+altura,fg,bg," ");
 }
AbrirArquivo(tipo);
sLista=TiposLista(tipo,largura,pos+1,col+1);
postexto(esquerda,topo,fg,bg);
cprintf("%s%s",sLista,repete(" ",largura-strlen(sLista)));
for(cont=1;cont<=(altura-2);cont++)
 {
  sLista=TiposLista(tipo,largura,pos+cont+1,col+1);
  postexto(esquerda,topo+cont,fg,bg);
  cprintf("%s%s",sLista,repete(" ",largura-strlen(sLista)));
 }
sLista=TiposLista(tipo,largura,pos+altura,col+1);
postexto(esquerda,topo+altura-1,fg,bg);
cprintf("%s%s",sLista,repete(" ",largura-strlen(sLista)));

postexto(esquerda,topo+altura+1,fg,bg);
cprintf("%s%4.4i","Linha : ",pos+1);

postexto(esquerda+14,topo+altura+1,fg,bg);
cprintf("%s%4.4i","Coluna : ",col+1);

}

/*-------------------------------------------*/

/*
 Nome : TiposLista
 Descricao : funcao que indica quais arquivos serao usados com a lista,
 como tambem a formatacao do cabecalho desses arquivos na lista
 Parametros :
 tipo - indica o numero de qual arquivo a ser aberto
 largura - indica a largura do texto
 pos - indica a posicao do texto na lista
 col - indica a posicao da coluna do texto na lista
*/
char *TiposLista(int tipo,int largura,int pos,int col)
{
 char *sAux;

sAux=(char*)malloc(300);
if (!sAux) exit(1);

if (tipo==1)
  {
    if (pos==1)
      {
        sAux="Numero de Inscricao ³ Titulo                         ³ ";
        sAux=somastr(2,sAux,"Autor                          ³ ");
        sAux=somastr(2,sAux,"Area                           ³ Palavra-Chave ³ ");
        sAux=somastr(2,sAux,"Edicao ³ Ano de Publicacao ³ ");
        sAux=somastr(2,sAux,"Editora                        ³ Volume ³ Estado Atual");
        return(copy(sAux,col,largura));
      }
    if (pos==2)
      return(repete("-",largura));
    if (pos > 2) 
     {
      if (nTamLivros > pos-3)
       {
        if(fseek(LivrosFile,(pos-3)*sizeof(struct LivrosRec),SEEK_SET)==0)
          fread(&Livros,sizeof(struct LivrosRec),1,LivrosFile);

          itoa(Livros.Ninsc,S,10);
          sAux=somastr(3,repete(" ",19-strlen(S)),S," ³ ");
          sAux=somastr(4,sAux,Livros.Titulo,repete(" ",31-strlen(Livros.Titulo)),"³ ");
          sAux=somastr(4,sAux,Livros.Autor,repete(" ",31-strlen(Livros.Autor)),"³ ");
          sAux=somastr(4,sAux,Livros.Area,repete(" ",31-strlen(Livros.Area)),"³ ");
          sAux=somastr(4,sAux,Livros.PChave,repete(" ",14-strlen(Livros.PChave)),"³ ");
          itoa(Livros.Edicao,S,10);
          sAux=somastr(4,sAux,repete(" ",6-strlen(S)),S," ³ ");
          itoa(Livros.AnoPubli,S,10);
          sAux=somastr(4,sAux,repete(" ",17-strlen(S)),S," ³ ");
          sAux=somastr(4,sAux,Livros.Editora,repete(" ",31-strlen(Livros.Editora)),"³ ");
          itoa(Livros.Volume,S,10);
          sAux=somastr(4,sAux,repete(" ",6-strlen(S)),S," ³ ");
          if (Livros.Estado=='D')
             sAux=somastr(2,sAux,"Disponivel");
          else
             sAux=somastr(2,sAux,"Emprestado");
         
         return(copy(sAux,col,largura));
       }
      else
         return("");
     }
  }
else if (tipo==2)
  {
    if (pos==1)
      {
        sAux="Numero de Inscricao ³ Nome                           ³ ";
        sAux=somastr(2,sAux,"Identidade ³ Logradouro                     ³ ");
        sAux=somastr(2,sAux,"Numero ³ Complemento ³ ");
        sAux=somastr(2,sAux,"Bairro               ³ Cep      ³ ");
        sAux=somastr(2,sAux,"Telefone    ³ Categoria   ³ Situacao");
        return(copy(sAux,col,largura));
      }
    if (pos==2)
      return(repete("-",largura));
    if (pos > 2) 
     {
      if (nTamUsuarios > pos-3) 
       {
        if(fseek(UsuariosFile,(pos-3)*sizeof(struct UsuariosRec),SEEK_SET)==0)
          fread(&Usuarios,sizeof(struct UsuariosRec),1,UsuariosFile);

          itoa(Usuarios.Ninsc,S,10);
          sAux=somastr(3,repete(" ",19-strlen(S)),S," ³ ");
          sAux=somastr(4,sAux,Usuarios.Nome,repete(" ",31-strlen(Usuarios.Nome)),"³ ");
          sAux=somastr(4,sAux,repete(" ",10-strlen(Usuarios.Ident)),Usuarios.Ident," ³ ");
          sAux=somastr(4,sAux,Usuarios.Endereco.Logra,repete(" ",31-strlen(Usuarios.Endereco.Logra)),"³ ");
          itoa(Usuarios.Endereco.Numero,S,10);
          sAux=somastr(4,sAux,repete(" ",6-strlen(S)),S," ³ ");
          sAux=somastr(4,sAux,Usuarios.Endereco.Compl,repete(" ",12-strlen(Usuarios.Endereco.Compl)),"³ ");
          sAux=somastr(4,sAux,Usuarios.Endereco.Bairro,repete(" ",21-strlen(Usuarios.Endereco.Bairro)),"³ ");
          sAux=somastr(4,sAux,repete(" ",8-strlen(Usuarios.Endereco.Cep)),Usuarios.Endereco.Cep," ³");
          sAux=somastr(4,sAux,repete(" ",12-strlen(Usuarios.Telefone)),Usuarios.Telefone," ³ ");
          if (Usuarios.Categoria=='A')
             sAux=somastr(4,sAux,"Aluno",repete(" ",12-strlen("Aluno")),"³ ");
          else if (Usuarios.Categoria=='P')
             sAux=somastr(4,sAux,"Professor",repete(" ",12-strlen("Professor")),"³ ");
          else if (Usuarios.Categoria=='F')
             sAux=somastr(4,sAux,"Funcionario",
             repete(" ",12-strlen("Funcionario")),"³ ");
          itoa(Usuarios.Situacao,S,10);
          sAux=somastr(3,sAux,repete(" ",8-strlen(S)),S);
         
         return(copy(sAux,col,largura));
       }
      else
         return("");
     }
  }
else if (tipo==3)
  {
    if (pos==1)
      {
        sAux="Numero de Inscricao do Usuario ³ ";
        sAux=somastr(2,sAux,"Numero de Inscricao do Livro ³ ");
        sAux=somastr(2,sAux,"Data do Emprestimo ³ Data da Devolucao ³ ");
        sAux=somastr(2,sAux,"Removido");
        return(copy(sAux,col,largura));
      }
    if (pos==2)
      return(repete("-",largura));
    if (pos > 2)
     {
      if (nTamEmprestimos > pos-3) 
       {
        if(fseek(EmprestimosFile,(pos-3)*sizeof(struct EmprestimosRec),SEEK_SET)==0)
          fread(&Emprestimos,sizeof(struct EmprestimosRec),1,EmprestimosFile);

          S[0]='\0';
          itoa(Emprestimos.NinscUsuario,S,10);
          sAux=somastr(3,repete(" ",30-strlen(S)),S," ³ ");
          itoa(Emprestimos.NinscLivro,S,10);
          sAux=somastr(4,sAux,repete(" ",28-strlen(S)),S," ³ ");
          sAux=somastr(4,sAux,Emprestimos.DtEmprestimo,
          repete(" ",19-strlen(Emprestimos.DtEmprestimo)),"³ ");
          sAux=somastr(4,sAux,Emprestimos.DtDevolucao,
          repete(" ",18-strlen(Emprestimos.DtDevolucao)),"³ ");
          if (Emprestimos.Removido==true)
             sAux=somastr(2,sAux,"Sim");
          else
             sAux=somastr(2,sAux,"Nao");
         
         return(copy(sAux,col,largura));
       }
      else
         return("");
     }
  }
else if (tipo==4){
     sAux=copy(vLista[pos-1],col,strlen(vLista[pos-1]));
     return(sAux);
   }
 return("");
}

/*-------------------------------------------*/

/*
 Nome : Lista
 Descricao : funcao que executa a acao de rolamento da lista.
 Parametros :
 tipo - indica o numero de qual arquivo a ser aberto
 topo - posicao da linha inicial na tela
 esquerda - posicao da coluna inicial na tela
 largura - indica a largura da lista
 tlinhas - indica o numero total de linhas da lista
 tcolunas - indica o numero total de colunas da lista
 fg - cor do texto
 bg - cor de fundo
 listapos - indica a ultima posicao da linha da lista na tela
 litacol - indica a ultima posicao da coluna da lista na tela
 foco - indica se a lista esta focada ou nao
*/
int Lista(int tipo,int topo,int esquerda,int altura,int largura,int tlinhas,
          int tcolunas,int fg,int bg,boolean foco)
{
 int cont2;
 char *sLista;

DesenhaLista(tipo,topo,esquerda,altura,largura,fg,bg,Listapos,Listacol,foco);

sLista=(char*)malloc(300);
if (!sLista) exit(1);

do {

inkey('O','O');

  if (sKey==UpArrow)
    {
     if (Listapos > 0)
       {
         Listapos--;
         for(cont2=0;cont2<=(altura-1);cont2++)
            {
              sLista=TiposLista(tipo,largura,Listapos+cont2+1,Listacol+1);
              postexto(esquerda,(topo+cont2),fg,bg);
              cprintf("%s%s",sLista,repete(" ",largura-strlen(sLista)));
            }
         postexto(esquerda,(topo+altura+1),fg,bg);
         cprintf("%s%4.4i","Linha : ",Listapos+1);
       }
    }

  if (sKey==DownArrow)
    {
     if (Listapos < (tlinhas-altura)) 
       {
         Listapos++;
         for(cont2=0;cont2<=(altura-1);cont2++)
            {
              sLista=TiposLista(tipo,largura,Listapos+cont2+1,Listacol+1);
              postexto(esquerda,(topo+cont2),fg,bg);
              cprintf("%s%s",sLista,repete(" ",largura-strlen(sLista)));
            }
         postexto(esquerda,(topo+altura+1),fg,bg);
         cprintf("%s%4.4i","Linha : ",Listapos+1);
       }
    }

  if (sKey==RightArrow)
    {
     if (Listacol < (tcolunas-largura))
       {
         Listacol++;
         for(cont2=0;cont2<=(altura-1);cont2++)
            {
              sLista=TiposLista(tipo,largura,Listapos+cont2+1,Listacol+1);
              postexto(esquerda,topo+cont2,fg,bg);
              cprintf("%s%s",sLista,repete(" ",largura-strlen(sLista)));
            }
         postexto((esquerda+14),(topo+altura+1),fg,bg);
         cprintf("%s%4.4i","Coluna : ",Listacol+1);

       }
    }

  if (sKey==LeftArrow)
    {
     if (Listacol > 0)
       {
         Listacol--;
         for(cont2=0;cont2<=(altura-1);cont2++)
            {
              sLista=TiposLista(tipo,largura,Listapos+cont2+1,Listacol+1);
              postexto(esquerda,(topo+cont2),fg,bg);
              cprintf("%s%s",sLista,repete(" ",largura-strlen(sLista)));
            }
         postexto((esquerda+14),(topo+altura+1),fg,bg);
         cprintf("%s%4.4i","Coluna : ",Listacol+1);
       }
    }

} while (sKey!=Tab);
if (sKey==Tab)
  return(1);

 return(0);
}

/*-------------------------------------------*/

/*
 Nome : formSplash
 Descricao : procedimento que desenha a tela inicial do sistema.
*/
void formSplash(void)
{
  _setcursortype(_NOCURSOR);
  formulario("",6,10,12,58,white,blue,'±',lightgray,black);
  etexto(13, 8,yellow,blue," ²²²²²²²     ²    ²²²²²²²     ²       ²    ²²²²²² ");
  etexto(13, 9,yellow,blue,"²²²    ²²²   ²²  ²²²    ²²²   ²²      ²²  ²²²  ²²²");
  etexto(13,10,yellow,blue,"²²²²²²²²²    ²²  ²²²²²²²²²    ²²      ²²  ²²    ²²");
  etexto(13,11,yellow,blue,"²²²    ²²²   ²²  ²²²    ²²²   ²²²     ²²  ²²    ²²");
  etexto(13,12,yellow,blue,"²²²²   ²²²   ²²  ²²²²   ²²²   ²²²²    ²²  ²²²  ²²²");
  etexto(13,13,yellow,blue," ²²²²²²²²²   ²²   ²²²²²²²²²   ²²²²²²  ²²   ²²²²²² ");
  etexto(12,15,yellow,blue,"Programa Desenvolvido por Henrique Figueiredo de Souza");
  etexto(12,16,yellow,blue,"Todos os Direito Reservados - 1999  Versao 1.0");
  etexto(12,17,yellow,blue,"Linguagem Usada Nesta Versao << TURBO C >>");
  delay(2000);
}
