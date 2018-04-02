/*
  Nome : Sistema de Automacao de Biblioteca (Biblio)
  Autor : Henrique Figueiredo de Souza
  Linguagem : C
  Compilador : gcc
  Data de Realizacao : 4 de setembro de 1999
  Ultima Atualizacao : 15 de fevereiro de 2000
  Versao do Sistema : 1.0
  Nome do(s) Arquivo(s) e Como Compilar (nesta ordem) :
  1. Biblio.c --> "gcc biblio.c -o biblio.exe -lm"
                  
  Descricao :
  O Sistema e composto dos seguintes modulos:
  1.Modulo de Livros da Biblioteca
    Onde se realiza a manutencao dos livros da biblioteca
  2.Modulo de Usuarios da Bilioteca
    Onde se realiza a manutencao dos usuarios da biblioteca
  3.Modulo de Emprestimos e Devolucoes da Biblioteca
    Onde se efetua os emprestimos e devolucoes da biblioteca
  4.Modulo de Opcoes do sistema
    Onde e possivel ver sobre o sistema e sair dele
*/
/* programa Biblio */

#include <stdio.h>
#include <stdlib.h>
#include <stdarg.h>
#include <conio.h>
#include <string.h>
#include <time.h>
#include <dos.h>
#include <ctype.h>
#include <dir.h>
#include <math.h>

/* Declaracao de tipos */

  enum Keys { NullKey, F1, F2, F3, F4, F5, F6, F7, F8, F9, F10,
           CarriageReturn, Tab, ShiftTab, Bksp, UpArrow,
           DownArrow, RightArrow, LeftArrow, DeleteKey,
           InsertKey, HomeKey, Esc, EndKey, TextKey,
           NumberKey, SpaceKey, PgUp, PgDn, CtrlA, AltA,
           AltE, AltU, AltS, AltO };

  typedef int boolean;

  /* Registro de Enderecos */

  struct Enderecos {
     char Logra[30];     /* Logradouro */
     int Numero;         /* Numero do Endereco (5) */
     char Compl[10];     /* Complemento (10) */
     char Bairro[20];    /* Bairro do Endereco (20) */
     char Cep[8];        /* Cep do Endereco (8) */
  };

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

  /* Registro de Emprestimos */

  struct EmprestimosRec {
     int NinscUsuario;      /* Numero de inscricao do Usuario (5) */
     int NinscLivro;        /* Numero de inscricao do Livro (5) */
     char DtEmprestimo[10]; /* Data de Emprestimo do Livro (10) */
     char DtDevolucao[10];  /* Data de Devolucao do Livro (10) */
     boolean Removido;      /* Removido - Indica exclusao logica */
  };

/* Declaracao de variaveis globais */

 /* declaracao de constantes */

 const true=1;
 const false=0;

 const white = 15;
 const lightblue = 9;
 const blue = 1;
 const black = 0;
 const lightgray = 7;
 const red = 4;
 const yellow = 14;

 /* variaveis gerais */

 enum Keys sKey;
 // boolean fk;
 char ch;
 char *S;  
 int I;

 /* variaveis de menu */

 char *vMenu[10];  /* 30 */
 char *vSubMenu[10][10];  /* 35 */

 /* variaveis de lista */

 char *vLista[50];
 int Listapos;
 int Listacol;

 /* variaveis do modulo de livros */

 struct LivrosRec Livros;
 FILE *LivrosFile;  
 int nTamLivros;
 char *vLivros[11];  /* 30 */

 /* variaveis do modulo de Usuarios */

 struct UsuariosRec Usuarios;
 FILE *UsuariosFile;  
 int nTamUsuarios;
 char *vUsuarios[12];  /* 30 */

 /* variaveis do modulo de Emprestimos */

 struct EmprestimosRec Emprestimos;
 FILE *EmprestimosFile; 
 int nTamEmprestimos;
 char *vEmprestimos[6];  /* 10 */

 /* variaveis do modulo de Opcoes */

 FILE *SobreFile;

/* Declaracao de funcoes */

char *copy(char *string,int ini,int tam);
char *deletar(char *str,int ini,int tam);
char *inserir(char origem,char *alvo,int ini);
int posstr(char origem,char *alvo);
char *rtrimstr(char *str);
char *repete(char *st,int tam);
char *somastr(int num,...);
char *setstring(char *str,int fundo);
char *digita(char *str,int janelatam,int maxtam,int x,int y,
                  int fg,int bg,char ft,int fundo);
int SubMenu(int numero,int qtd,int maxtam,int topo,int esquerda,int ultpos,
            int lfg,int lbg,int fg,int bg);
int Botao(int topo,int esquerda,int fg,int bg,int sfg,int sbg,
          char *texto,boolean foco);
int Lista(int tipo,int topo,int esquerda,int altura,int largura,int tlinhas,
          int tcolunas,int fg,int bg,boolean foco);
char *TiposLista(int tipo,int largura,int pos,int col);

/* Modulo de Livros */

int PesLivros(char tipo,char *campo, int nCod2,char *sCod2,
              int nTamsCod);
boolean VerificaLivros(void);

/* Modulo de Usuarios */

int PesUsuarios(char tipo,char *campo,int nCod2,char *sCod2,
                int nTamsCod); 
int PesBinaria(int Chave);
boolean VerificaUsuarios(void);

/* Modulo de Emprestimos */

int PesEmprestimos(int nCodUsuario,int nCodLivro);
char *RetDataAtual(void); 
int ConverteData(char *dt); 
char *SomaDias(char *dt1,int qtddias); 
int SubtraiDatas(char *dt1,char *dt2); 

/* Declaracao de Procedimentos */

void escreverapido(int x,int y,char *str,int fg,int bg);
void center(int y,char *s,int fg,int bg);
void beep(int freq,int time);
void inkey(char cursorinicio,char cursorfim);
void xy(int x,int y);
void postexto(int c,int l,int fg,int bg);
void etexto(int c,int l,int fg,int bg,char *texto);
void teladefundo(char *tipo,int fg,int bg);
void cabecalho(char *texto,char *tipo,int fg,int bg);
void rodape(char *texto,char *tipo,int fg,int bg);
void datadosistema(int l,int c,int fg,int bg);
void horadosistema(int l,int c,int fg,int bg);
void formulario(char *titulo,int topo,int esquerda,
                     int altura,int largura,int fg,int bg,
                     char sombra,int sfg,int sbg);
void menu(int qtd,int topo,int fg,int bg,int lfg,int lbg,
          int pos2,int mfg,int mbg,int cont2);
void ControlaMenus(char tipo,int ultpos,boolean tf);
void DesenhaBotao(int topo,int esquerda,int fg,int bg,int sfg,int sbg,
                  char *texto,boolean foco);
void DesenhaLista(int tipo,int topo,int esquerda,int altura,int largura,
                  int fg,int bg,int pos,int col,boolean foco);
int tamArquivo(FILE *Arq,int tam);
void AbrirArquivo(int Tipo);
void formSplash(void);

/* Modulo de Livros */

void formLivros(int tipo,char *titulo,char *rod);
void Limpar_Livros(void);
void Rotulos_formLivros(int l);
void Controles_formLivros(char *tipo,int tipo2,int pos,int col,char *rod,
                          boolean foco);
void Atribuir_vLivros(boolean limpar);
void Digita_formLivros(void);
void SalvarLivros(int tipo);

/* Modulo de Usuarios */

void formUsuarios(int tipo,char *titulo,char *rod);
void Limpar_Usuarios(void); 
void Rotulos_formUsuarios(int l); 
void Controles_formUsuarios(char *tipo,int tipo2,int pos,
                            int col,char *rod,boolean foco);
void Atribuir_vUsuarios(boolean limpar); 
void Digita_formUsuarios(void); 
void SalvarUsuarios(int tipo);

/* Modulo de Emprestimos e Devolucoes */

void formEmprestimos(int tipo,char *titulo,char *rod);
void Limpar_Emprestimos(void); 
void Rotulos_formEmprestimos(int tipo,int l); 
void Controles_formEmprestimos(char *tipo,int tipo2,int pos,
     int col,char *rod,boolean foco); 
void Atribuir_vEmprestimos(boolean limpar); 
void SalvarEmprestimos(int tipo);

/* Modulo de Opcoes */

void formSair(void);
void Controles_formSair(char *tipo,boolean foco); 
void formSobre(void); 
void LerArquivoSobre(void); 
void Controles_formSobre(char *tipo,int pos,int col,boolean foco); 

/* Rotinas Fundamentais */

/*
 Nome : _setcursortype
 Descricao : Procedimento que muda o tipo de cursor
 Parametros :
 tipo - indica o tipo de cursor a ser mudado
*/
/*
void _setcursortype(int tipo)
{
 union REGS r;
if (tipo==0) /* _SOLIDCURSOR */
// {
/* asm mov ah,01h;
   asm mov ch,00h;
   asm mov cl,07h;
   asm int 10h; */
/*  r.h.ah=0x1;
  r.h.ch=0x0;
  r.h.cl=0x7;
  int86(0x10,&r,&r);
 }
else if (tipo==1) /* _NORMALCURSOR */
// {
/*  asm mov ah,01h;
  asm mov ch,06h;
  asm mov cl,07h;
  asm int 10h; */
/*  r.h.ah=0x1;
  r.h.ch=0x6;
  r.h.cl=0x7;
  int86(0x10,&r,&r);
 }
else if (tipo==2) /* _NOCURSOR  */
// {
/*  asm mov ah,01h;
  asm mov ch,20h;
  asm mov cl,20h;
  asm int 10h; */
/*  r.h.ah=0x1;
  r.h.ch=0x20;
  r.h.cl=0x20;
  int86(0x10,&r,&r);
 }
}
*/

/*------------------------------------------*/

/*
 Nome : escreverapido
 Descricao : Procedimento que permite ter um controle do posicionamento
 do cursor, sem piscadas ou erros de repeticao de visualizacao.
 Parametros :
 x - posicao de coluna na tela
 y - posicao de linha na tela
 S - o resultado do que foi digitado
 fg - cor do texto
 bg - cor de fundo
*/
void escreverapido(int x,int y,char *str,int fg,int bg)
{
 textcolor(fg);
 textbackground(bg);
 gotoxy(x-1,y+1);
 cprintf(str);
}

/*------------------------------------------*/

/*
 Nome : Center
 Descricao : Procedimento que centraliza um texto na tela.
 Parametros :
 y - posicao de linha na tela
 s - texto a ser centralizado
 fg - cor do texto
 bg - cod de fundo
*/
void center(int y,char *s,int fg,int bg)
{
int x;

 x=40-(strlen(s) / 2);
 etexto(x,y,fg,bg,s);
}

/*-------------------------------------------*/

/*
 Nome : Beep
 Descricao : Procedimento que gera um beep.
 Parametros :
 freq - frequencia do beep.
 time - duracao do beep.
*/
void beep(int freq,int time)
{
 sound(freq);
 delay(time);
 nosound();
}

/*-------------------------------------------*/

/*
 Nome : Inkey
 Descricao : Procedimento que identifica uma tecla do teclado.
 Parametros :
 cursorinicio - indica o estado do cursor inicial
 cursorfim - indica o estado do cursor final
*/
void inkey(char cursorinicio,char cursorfim)
{
boolean chavefuncional;
 switch(cursorinicio) {
   case 'B':_setcursortype(_SOLIDCURSOR); break;
   case 'S':_setcursortype(_NORMALCURSOR); break;
   case 'O':_setcursortype(_NOCURSOR); break;
 }

chavefuncional=false;
ch=getch();
if (ch==0)
 {
  chavefuncional=true;
  ch=getch();
 }

if (chavefuncional)
{
   switch(ch) {
    case 15: sKey = ShiftTab; break;
    case 18: sKey = AltE; break;    
    case 22: sKey = AltU; break;
    case 24: sKey = AltO; break;
    case 30: sKey = AltA; break;
    case 31: sKey = AltS; break;
    case 72: sKey = UpArrow; break;
    case 80: sKey = DownArrow; break;
    case 75: sKey = LeftArrow; break;
    case 77: sKey = RightArrow; break;
    case 73: sKey = PgUp; break;
    case 81: sKey = PgDn; break;
    case 71: sKey = HomeKey; break;
    case 79: sKey = EndKey; break;
    case 83: sKey = DeleteKey; break;
    case 82: sKey = InsertKey; break;
    case 59: sKey = F1; break;
    case 60: sKey = F2; break;
    case 61: sKey = F3; break;
    case 62: sKey = F4; break;
    case 63: sKey = F5; break;
    case 64: sKey = F6; break;
    case 65: sKey = F7; break;
    case 66: sKey = F8; break;
    case 67: sKey = F9; break;
    case 68: sKey = F10; break;
   }
}
else
{
   switch(ch) {
    case 1: sKey = CtrlA; break;           
    case 8: sKey = Bksp; break;
    case 9: sKey = Tab; break; 
    case 13: sKey = CarriageReturn; break; 
    case 27: sKey = Esc; break; 
    case 32: sKey = SpaceKey; break; 
    /* textkey */
    case 33: sKey = TextKey; break; 
    case 34: sKey = TextKey; break; 
    case 35: sKey = TextKey; break; 
    case 36: sKey = TextKey; break; 
    case 37: sKey = TextKey; break; 
    case 38: sKey = TextKey; break; 
    case 39: sKey = TextKey; break; 
    case 40: sKey = TextKey; break; 
    case 41: sKey = TextKey; break; 
    case 42: sKey = TextKey; break; 
    case 43: sKey = TextKey; break; 
    case 44: sKey = TextKey; break; 
    case 47: sKey = TextKey; break; 
    /* numberkey */
    case 45: sKey = NumberKey; break;
    case 46: sKey = NumberKey; break;
    case 48: sKey = NumberKey; break;
    case 49: sKey = NumberKey; break;
    case 50: sKey = NumberKey; break;
    case 51: sKey = NumberKey; break;
    case 52: sKey = NumberKey; break;
    case 53: sKey = NumberKey; break;
    case 54: sKey = NumberKey; break;
    case 55: sKey = NumberKey; break;
    case 56: sKey = NumberKey; break;
    case 57: sKey = NumberKey; break;
    /* textkey */
    case 58: sKey = TextKey; break;
    case 59: sKey = TextKey; break;
    case 60: sKey = TextKey; break;
    case 61: sKey = TextKey; break;
    case 62: sKey = TextKey; break;
    case 63: sKey = TextKey; break;
    case 64: sKey = TextKey; break;
    case 65: sKey = TextKey; break;
    case 66: sKey = TextKey; break;
    case 67: sKey = TextKey; break;
    case 68: sKey = TextKey; break;
    case 69: sKey = TextKey; break;
    case 70: sKey = TextKey; break;
    case 71: sKey = TextKey; break;
    case 72: sKey = TextKey; break;
    case 73: sKey = TextKey; break;
    case 74: sKey = TextKey; break;
    case 75: sKey = TextKey; break;
    case 76: sKey = TextKey; break;
    case 77: sKey = TextKey; break;
    case 78: sKey = TextKey; break;
    case 80: sKey = TextKey; break;
    case 81: sKey = TextKey; break;
    case 82: sKey = TextKey; break;
    case 83: sKey = TextKey; break;
    case 84: sKey = TextKey; break;
    case 85: sKey = TextKey; break;
    case 86: sKey = TextKey; break;
    case 87: sKey = TextKey; break;
    case 88: sKey = TextKey; break;
    case 89: sKey = TextKey; break;
    case 90: sKey = TextKey; break;
    case 91: sKey = TextKey; break;
    case 92: sKey = TextKey; break;
    case 93: sKey = TextKey; break;
    case 94: sKey = TextKey; break;
    case 95: sKey = TextKey; break;
    case 96: sKey = TextKey; break;
    case 97: sKey = TextKey; break;
    case 98: sKey = TextKey; break;
    case 99: sKey = TextKey; break;
    case 100: sKey = TextKey; break;
    case 101: sKey = TextKey; break;
    case 102: sKey = TextKey; break;
    case 103: sKey = TextKey; break;
    case 104: sKey = TextKey; break;
    case 105: sKey = TextKey; break;
    case 106: sKey = TextKey; break;
    case 107: sKey = TextKey; break;
    case 108: sKey = TextKey; break;
    case 109: sKey = TextKey; break;
    case 110: sKey = TextKey; break;
    case 111: sKey = TextKey; break;
    case 112: sKey = TextKey; break;
    case 113: sKey = TextKey; break;
    case 114: sKey = TextKey; break;
    case 115: sKey = TextKey; break;
    case 116: sKey = TextKey; break;
    case 117: sKey = TextKey; break;
    case 118: sKey = TextKey; break;
    case 119: sKey = TextKey; break;
    case 120: sKey = TextKey; break;
    case 121: sKey = TextKey; break;
    case 122: sKey = TextKey; break;
    case 123: sKey = TextKey; break;
    case 124: sKey = TextKey; break;
    case 125: sKey = TextKey; break;
    case 126: sKey = TextKey; break;
    case 127: sKey = TextKey; break;
   }
}

   switch(cursorfim) {
    case 'B':_setcursortype(_SOLIDCURSOR); break;
    case 'S':_setcursortype(_NORMALCURSOR); break;
    case 'O':_setcursortype(_NOCURSOR); break;
   }

}

/*--------------------------------------------------*/

/*
 Nome : deletar
 Descricao : funcao que deleta um pedaco da string
 Parametros :
 str - a string a ser cortada
 ini - a posicao inicial do corte
 tam - o tamanho do corte
*/
char *deletar(char *str,int ini,int tam)
{
char *st;
int ik,j;

if (ini>0 && tam>0 && tam<=strlen(str)) {
j=0;
st=(char*)malloc(100);
if (!st)
  exit(1);

for(ik=0;ik<(ini-1);ik++)
 {
   st[j] = str[ik];
   j++;
 }

for(ik=(ini+tam-1);ik<strlen(str);ik++)
{
   st[j] = str[ik];
   j++;
}
st[j]='\0';
return(st);
}
else
 return(str);
}

/*--------------------------------------------------*/

/*
 Nome : inserir
 Descricao : funcao que inclui um caracter numa string
 Parametros :
 origem - o caracter a ser incluido
 alvo - a string que vai receber o caracter
 ini - a posicao na string a inserir o caracter
*/
char *inserir(char origem,char *alvo,int ini)
{
int ig,j;
char *s1;

if(ini>0 && ini<=(strlen(alvo)+1)){
j=0;
s1=(char*)malloc(100);
if (!s1)
  exit(1);
for(ig=0;ig<(strlen(alvo)+1);ig++)
{
  if (ig==(ini-1)){
     s1[j]=origem;
     j++;
    }
  s1[j] = alvo[ig];
  j++;
}
s1[j]='\0';
return(s1);
}
else
 return(alvo);
}

/*--------------------------------------------------*/

/*
 Nome : posstr
 Descricao : funcao que retorna a posicao de um caracter numa string
 Parametros :
 origem - indica o caracter a ser encontrado na string
 alvo - indica a string que vai ser pesquisada
*/
int posstr(char origem,char *alvo)
{
int j;

for(j=0;j<strlen(alvo);j++)
 {
  if(origem==alvo[j])
    return(j+1);
 }
return(0);
}

/*--------------------------------------------------*/

/*
 Nome : xy
 Descricao : Procedimento que muda a posicao do cursor usado
 na funcao digita
 Parametros :
 x - indica a coluna
 y - indica a linha
*/
void xy(int x,int y)
{
  int xsmall;

  do {
   xsmall = x-80;
   if (xsmall > 0)
     {
       y++;
       x=xsmall;
     }
  } while(!(xsmall <= 0));
 gotoxy(x-1,y+1);
}

/*-------------------------------------------*/

/*
 Nome : setstring
 Descricao : funcao que retorna a string com um
 caracter a menos em relacao ao caracter do fundo
 Parametros :
 str - indica a string
 fundo - o caracter de fundo
*/
char *setstring(char *str,int fundo)
{
 int i;

i=strlen(str);
while(str[i-1] == fundo)
  i--;
//S1[0]=i;
_setcursortype(_NORMALCURSOR);
return(str);
}

/*--------------------------------------------------*/

/*
 Nome : Digita
 Descricao : funcao que permite ter um maior controle da digitacao
 de um texto, tambem permitindo indicar um texto maior do que o permitido
 pelo espaco limite definido.
 Parametros :
 S - e o resultado da digitacao
 janelatam - indica o tamanho maximo de visualizacao do texto digitado
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
S1[i]='\0';

tempstr=copy(S1,1,janelatam);
escreverapido(x,y,tempstr,fg,bg);
p=0;
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
         S1[maxtam-1]=fundo; //S1=S1+fundo;
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
      S1[maxtam-1]=fundo; //S1=S1+fundo;
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
   default: switch(sKey){
             case UpArrow:
             case DownArrow: case PgDn: case PgUp: case NullKey:
             case Esc: case F1: case F2: case F3: case F4:
             case F5: case F6: case  F7: case F8: case F9: case F10:
             beep(100,250);
             break;
           }

  }

  if (sKey==Tab)
     break;

 } while (sKey!=CarriageReturn);
S1=setstring(S1,fundo);
S1=rtrimstr(S1);
_setcursortype(_NOCURSOR);
return(S1);
}

/*-----------------------------------------------------------*/

/*
 Nome : rtrimstr
 Descricao : funcao que retorna a string sem espacos a direita
 Parametros :
 str - indica a string
*/
char *rtrimstr(char *str)
{
int j,i;
char *str1;

j=strlen(str);
str1=(char*)malloc(300);
if(!str1)
  exit(1);
str1=str;
for(i=j;i>=0;i--)
 {
  if(str1[i-1]!=' ')
   {
    str1[i]='\0';
    return(str1);
   }
 }
}

/*-----------------------------------------------------------*/

/*
 Nome : copy
 Descricao : funcao que retorna um pedaco de uma string
 Parametros :
 str - indica a string
 ini - indica a posicao inicial do pedaco
 tam - indica o tamanho do pedaco
*/
char *copy(char *string,int ini,int tam)
{
char *str1;
int i,j;
j=0;
str1=(char*)malloc(100);
if (!str1)
  exit(1);
ini--;
for(i=ini;i<(ini+tam);i++)
 {
   str1[j]=string[i];
   j++;
 }
str1[j]='\0';
return(str1);
}

/*-------------------------------------------*/

/*
 Nome : Repete
 Descricao : funcao que retorna um texto repetido n vezes.
 Parametros :
 St - indica o texto a ser repetido
 Tam - quantas vezes o texto se repetira
*/
char *repete(char *st,int tam)
{
 int cont,cont2;
 char *esp;

 tam=abs(tam);
 cont=0;
 cont2=0;
 esp=(char*)malloc(100);
 if (!esp)
   exit(1);
 while (cont < (tam*strlen(st)) )
  {
    if (cont2==strlen(st))
      cont2=0;
    esp[cont]=st[cont2];
    cont++;
    cont2++;
  }
  esp[cont]='\0';
  return(esp);
}

/*-------------------------------------------*/

/*
 Nome : somastr
 Descricao : funcao que soma determinado numero de strings 
 Parametros :
 num - indica o numero de strings
 ... - as strings a serem somadas
*/
char *somastr(int num,...)
{
 int ig,j,t;
 char *str,*soma;
 va_list argptr;

 va_start(argptr,num);
 str=(char*) malloc(500);
 if (!str)
    exit(1);
 soma=(char*) malloc(1000);
 if (!soma)
    exit(1);
 ig=0; j=0; t=0;
 for(;num;num--){
   str = va_arg(argptr,char*);
   for(ig=j;ig<j+strlen(str);ig++){
      soma[ig]=str[t];
      t++;
    }
   soma[ig]='\0';
   j=strlen(soma);
   t=0;
 }
 va_end(argptr);

 return(soma);
}

/*-------------------------------------------*/

/*
 Nome : Etexto
 Descricao : procedimento que escreve o texto na tela com determinada cor.
 Parametros :
 c - posicao de coluna do texto
 l - posicao de linha do texto
 fg - cor do texto
 bg - cor de fundo
 texto - o texto a ser escrito
*/
void etexto(int c,int l,int fg,int bg,char *texto)
{
 postexto(c,l,fg,bg);
 cprintf(texto);
}

/*-------------------------------------------*/

/*
 Nome : postexto
 Descricao : procedimento que posiciona o texto na tela com determinada cor
 Parametros :
 c - posicao de coluna do texto
 l - posicao de linha do texto
 fg - cor do texto
 bg - cor de fundo
*/
void postexto(int c,int l,int fg,int bg)
{
 textcolor(fg);
 textbackground(bg);
 gotoxy(c,l);
}

/*-------------------------------------------*/

/*
 Nome : Teladefundo
 Descricao : procedimento que desenha os caracteres do fundo da tela.
 Parametros :
 tipo - o caracter a ser escrito no fundo
 fg - cor do texto
 bg - cor de fundo
*/
void teladefundo(char *tipo,int fg,int bg)
{
int l,c;

for(l=3;l<=24;l++)
 {
  for(c=1;c<=80;c++)
  {
    etexto(c,l,fg,bg,tipo);
  }
 }
}

/*-------------------------------------------*/

/*
 Nome : cabecalho
 Descricao : procedimento que escreve o texto de cabecalho do sistema.
 Parametros :
 texto - o texto a ser escrito
 tipo - o caracter de fundo.
 fg - cor do texto
 bg - cor de fundo
*/
void cabecalho(char *texto,char *tipo,int fg,int bg)
{
 int c;

for(c=1;c<=80;c++)
  etexto(c,1,fg,bg,tipo);

center(1,texto,fg,bg);
}

/*-------------------------------------------*/

/*
 Nome : rodape
 Descricao : procedimento que escreve o texto no rodape da tela.
 Parametros :
 texto - o texto a ser escrito
 tipo - o caracter de fundo.
 fg - cor do texto
 bg - cor de fundo
*/
void rodape(char *texto,char *tipo,int fg,int bg)
{
 int c;

for(c=1;c<=79;c++)
  etexto(c,25,fg,bg,tipo);

center(25,texto,fg,bg);
}

/*-------------------------------------------*/

/*
 Nome : DatadoSistema
 Descricao : procedimento que escreve a data do sistema na tela.
 Parametros :
 l - posicao da linha na tela
 c - posicao da coluna na tela
 fg - cor do texto
 bg - cor de fundo
*/
void datadosistema(int l,int c,int fg,int bg)
{
char *tempo,*dia,*mes,*ano,*dow;
time_t agora;

  time(&agora);
  tempo=asctime(localtime(&agora));
  dia=copy(tempo,9,2);
  mes=copy(tempo,5,3);
  if(strcmp(mes,"Jan")==0) mes= "01";
  else if (strcmp(mes,"Feb")==0) mes="02";
  else if (strcmp(mes,"Mar")==0) mes="03";
  else if (strcmp(mes,"Apr")==0) mes="04";
  else if (strcmp(mes,"May")==0) mes="05";
  else if (strcmp(mes,"Jun")==0) mes="06";
  else if (strcmp(mes,"Jul")==0) mes="07";
  else if (strcmp(mes,"Aug")==0) mes="08";
  else if (strcmp(mes,"Sep")==0) mes="09";
  else if (strcmp(mes,"Oct")==0) mes="10";
  else if (strcmp(mes,"Nov")==0) mes="11";
  else if (strcmp(mes,"Dez")==0) mes="12";
  ano=copy(tempo,21,4);
  dow=copy(tempo,1,3);
  if (strcmp(dow,"Mon")==0) dow="Segunda";
  else if (strcmp(dow,"Tue")==0) dow="Terca";
  else if (strcmp(dow,"Wed")==0) dow="Quarta";
  else if (strcmp(dow,"Thu")==0) dow="Quinta";
  else if (strcmp(dow,"Fri")==0) dow="Sexta";
  else if (strcmp(dow,"Sat")==0) dow="Sabado";
  else if (strcmp(dow,"Sun")==0) dow="Domingo";
  postexto(c,l,fg,bg);
  cprintf("%s, %s/%s/%s",dow,dia,mes,ano);
}

/*-------------------------------------------*/

/*
 Nome : HoradoSistema
 Descricao : procedimento que escreve a Hora do sistema na tela.
 Parametros :
 l - posicao da linha na tela
 c - posicao da coluna na tela
 fg - cor do texto
 bg - cor de fundo
*/
void horadosistema(int l,int c,int fg,int bg)
{
int hora,minuto,segundo;
struct time tempo;

  gettime(&tempo);
  hora=tempo.ti_hour;
  minuto=tempo.ti_min;
  segundo=tempo.ti_sec;
  postexto(c,l,fg,bg);
  cprintf("%1.2d:%1.2d:%1.2d",hora,minuto,segundo);
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

}
 
/*-------------------------------------------*/

/*
 Nome : ControlaMenus
 Descricao : procedimento que faz todo o controle de manuseio dos submenus.
 Parametros :
 tipo - indica qual o submenu selecionado do menu
 ultpos - indica a ultima posicao da opcao de submenu selecionada
 tf - indica se vai redesenhar a tela de fundo
*/
void ControlaMenus(char tipo,int ultpos,boolean tf)
{

if (tf==true)
  teladefundo("±",white,lightblue);

if (tipo=='A')
  {
    menu(4,2,black,lightgray,red,lightgray,1,yellow,lightgray,1);
    rodape("Controle do Acervo da Biblioteca."," ",white,blue);
    formulario("",3,3,4,20,black,lightgray,'±',lightgray,black);
    switch(SubMenu(1,3,18,4,5,ultpos,yellow,lightgray,black,lightgray)){
      case 1: ControlaMenus('O',1,true); break;
      case 2: ControlaMenus('U',1,true); break;
      case 3: formLivros(1,"Cadastrar Livros",
        "Cadastro dos Livros do Acervo da Biblioteca."); break;
      case 4: formLivros(2,"Alterar Livros",
        "Altera os Livros do Acervo da Biblioteca."); break;
      case 5: ControlaMenus('5',1,false); break; 
    }
  }
else if (tipo=='U')
  {
    menu(4,2,black,lightgray,red,lightgray,10,yellow,lightgray,2);
    rodape("Controle de Usuarios da Biblioteca."," ",white,blue);
    formulario("",3,12,4,22,black,lightgray,'±',lightgray,black);
    switch(SubMenu(2,3,20,4,14,ultpos,yellow,lightgray,black,lightgray)){
      case 1: ControlaMenus('A',1,true); break; 
      case 2: ControlaMenus('E',1,true); break; 
      case 3: formUsuarios(1,"Cadastrar Usuarios",
        "Cadastro dos Usuarios da Biblioteca."); break;
      case 4: formUsuarios(2,"Alterar Usuarios",
        "Altera os Usuarios da Biblioteca."); break;
      case 5: ControlaMenus('6',1,false); break; 
    }
  }
else if (tipo=='E')
  {
    menu(4,2,black,lightgray,red,lightgray,21,yellow,lightgray,3);
    rodape("Controle de Emprestimos e Devolucoes da Biblioteca."," ",
    white,blue);
    formulario("",3,23,4,37,black,lightgray,'±',lightgray,black);
    switch(SubMenu(3,3,35,4,25,ultpos,yellow,lightgray,black,lightgray)){
      case 1: ControlaMenus('U',1,true); break;
      case 2: ControlaMenus('O',1,true); break;
      case 3: formEmprestimos(1,"Emprestar Livros",
        "Efetua os Emprestimos de Livros da Biblioteca."); break;
      case 4: formEmprestimos(2,"Devolver Livros",
        "Efetua a Devolucao dos Livros da Biblioteca."); break;
      case 5: formEmprestimos(3,"Consultar Emprestimos e Devolucoes",
        "Consulta os Emprestimos e Devolucoes dos Livros da Biblioteca.");
         break;
    }
  }
else if (tipo=='O')
  {
    menu(4,2,black,lightgray,red,lightgray,48,yellow,lightgray,4);
    rodape("Opcoes do Sistema de Biblioteca."," ",white,blue);
    formulario("",3,50,3,18,black,lightgray,'±',lightgray,black);
    switch(SubMenu(4,2,16,4,52,ultpos,yellow,lightgray,black,lightgray)){ 
      case 1: ControlaMenus('E',1,true); break;
      case 2: ControlaMenus('A',1,true); break;
      case 3: formSobre(); break;
      case 4: formSair(); break;
    }
  }
else if (tipo=='5')
  {
    formulario("",6,23,6,20,black,lightgray,'±',lightgray,black);
    switch(SubMenu(5,5,18,7,25,ultpos,yellow,lightgray,black,lightgray)){ 
      case 1: ControlaMenus('A',3,true); break;
      case 2: ControlaMenus('U',1,true); break;
      case 4: formLivros(3,"Consultar Livros por Titulo",
        "Consulta os Livros por Titulo do Acervo da Biblioteca."); break;
      case 5: formLivros(4,"Consultar Livros por Autor",
        "Consulta os Livros por Autor do Acervo da Biblioteca."); break;
      case 6: formLivros(5,"Consultar Livros por Area",
        "Consulta os Livros por Area do Acervo da Biblioteca."); break;
      case 7: formLivros(6,"Consultar Livros por Palavra-chave",
        "Consulta os Livros por Palavra-chave do Acervo da Biblioteca.");
         break;
      case 3: formLivros(7,"Consultar Todos os Livros",
        "Consulta Todos os Livros do Acervo da Biblioteca."); break;
    }
  }
else if (tipo=='6')
  {
    formulario("",6,34,5,26,black,lightgray,'±',lightgray,black);
    switch(SubMenu(6,4,24,7,36,ultpos,yellow,lightgray,black,lightgray)){ 
      case 1: ControlaMenus('U',3,true); break;
      case 2: ControlaMenus('E',1,true); break;
      case 4: formUsuarios(3,"Consultar Usuarios por Numero de Inscricao",
        "Consulta os Usuarios por Numero de Inscricao."); break;
      case 5: formUsuarios(4,"Consultar Usuarios por Nome",
        "Consulta os Usuarios por Nome."); break;
      case 6: formUsuarios(5,"Consultar Usuarios por Identidade",
        "Consulta os Usuarios por Numero de Identidade."); break;
      case 3: formUsuarios(6,"Consultar Todos os Usuarios",
        "Consulta Todos os Usuarios da Biblioteca."); break;

    }
  }

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
void menu(int qtd,int topo,int fg,int bg,int lfg,int lbg,int pos2,
          int mfg,int mbg,int cont2)
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
      break;
    }
 }

} while (sKey!=Tab);
 if (sKey==Tab)
    return(1);

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
}

/*-----------------------------------------------------*/

/*
 Nome : tamArquivo
 Descricao : funcao que retorna o tamanho de um arquivo
 Parametros :
 Arq - o nome do arquivo
 tam - tamanho do registro
*/
int tamArquivo(FILE *Arq,int tam)
{
 int cont;
 char Local[200];

 cont=0;
 if(fseek(Arq,0,SEEK_SET)==0)
    while(!feof(Arq)){
       fread(Local, tam, 1, Arq);
       cont++;
      }
 if(fseek(Arq,0,SEEK_SET)==0)
    cont--;
 return(cont);
}

/*-----------------------------------------------------*/

/*
 Nome : AbrirArquivo
 Descricao : procedimento que Abri o tipo de arquivo selecionado.
 Parametros :
 tipo - indica o numero de qual arquivo a ser aberto
*/
void AbrirArquivo(int Tipo)
{
  struct ffblk f;

  if (Tipo==1)
   {
    if (findfirst("Livros.dat", &f, FA_ARCH)==0)
     {
      if ((LivrosFile=fopen("Livros.dat","rb+"))==NULL)
         rodape("O Arquivo de Livros nao pode ser aberto"," ",white,blue);
     }
    else
       LivrosFile=fopen("Livros.dat","wb+");
    nTamLivros=tamArquivo(LivrosFile,sizeof(struct LivrosRec));
   }
  if (Tipo==2)
   {
    if (findfirst("Usuarios.dat", &f, FA_ARCH)==0)
     {
      if ((UsuariosFile=fopen("Usuarios.dat","rb+"))==NULL)
        rodape("O Arquivo de Usuarios nao pode ser aberto"," ",white,blue);
     }
    else
       UsuariosFile=fopen("Usuarios.dat","wb+");
    nTamUsuarios=tamArquivo(UsuariosFile,sizeof(struct UsuariosRec));
   }
  if (Tipo==3)
   {
    if (findfirst("Empresti.dat", &f, FA_ARCH)==0)
     {
      if ((EmprestimosFile=fopen("Empresti.dat","rb+"))==NULL)
       rodape("O Arquivo de Emprestimos nao pode ser aberto"," ",white,blue);
     }
    else
      EmprestimosFile=fopen("Empresti.dat","wb+");
    nTamEmprestimos=tamArquivo(EmprestimosFile,sizeof(struct EmprestimosRec));
   }
  if (Tipo==4) 
   {
     if ((SobreFile=fopen("Sobre.dat","r"))==NULL)
       rodape("O Arquivo de Sobre nao pode ser aberto"," ",white,blue);
   }

}

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

 sCod=(char*)malloc(15);
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
else if (tipo == "Fechar")
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

 sCod=(char*)malloc(15);
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
     Controles_formUsuarios("2",1,0,0,rod,false); /* cadastrar */
  else if (tipo==2)
     Controles_formUsuarios("1",2,0,0,rod,false); /* alterar */
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
else if (tipo == "Fechar")
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
 foram digitados.
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

/***************Modulo de Emprestimos e Devolucoes******************/

/*
 Nome : RetDataAtual
 Descricao : funcao que retorna a data atual do sistema
*/
char *RetDataAtual(void)
{
char *tempo,*dia,*mes,*ano;
time_t agora;

  time(&agora);
  tempo=asctime(localtime(&agora));
  dia=copy(tempo,9,2);
  mes=copy(tempo,5,3);
  if(strcmp(mes,"Jan")==0) mes= "01";
  else if (strcmp(mes,"Feb")==0) mes="02";
  else if (strcmp(mes,"Mar")==0) mes="03";
  else if (strcmp(mes,"Apr")==0) mes="04";
  else if (strcmp(mes,"May")==0) mes="05";
  else if (strcmp(mes,"Jun")==0) mes="06";
  else if (strcmp(mes,"Jul")==0) mes="07";
  else if (strcmp(mes,"Aug")==0) mes="08";
  else if (strcmp(mes,"Sep")==0) mes="09";
  else if (strcmp(mes,"Oct")==0) mes="10";
  else if (strcmp(mes,"Nov")==0) mes="11";
  else if (strcmp(mes,"Dez")==0) mes="12";
  ano=copy(tempo,21,4);

  return(somastr(5,dia,"/",mes,"/",ano));
}

/*--------------------------------------------------------*/

/*
 Nome : ConverteData
 Descricao : funcao que converte a data em string para numero.
 Parametros :
 dt - data a ser convertida
*/
int ConverteData(char *dt)
{
  char *sAux;
  int nAux;

 sAux=somastr(3,copy(dt,7,4),copy(dt,4,2),copy(dt,1,2));
 nAux=atoi(sAux);
 return(nAux);
}

/*--------------------------------------------------------*/

/*
 Nome : SubtraiDatas
 Descricao : funcao que subtrai duas datas e retorna o numero de dias
 Parametros :
 dt1 - data inicial
 dt2 - data final
*/
int SubtraiDatas(char *dt1,char *dt2)
{
 int dia,mes,ano,dia1,mes1,ano1,dia2,mes2,ano2;
 int i,c,dias;
 int udiames[13];

 dias=0;
 udiames[1]=31;
 udiames[2]=28;
 udiames[3]=31;
 udiames[4]=30;
 udiames[5]=31;
 udiames[6]=30;
 udiames[7]=31;
 udiames[8]=31;
 udiames[9]=30;
 udiames[10]=31;
 udiames[11]=30;
 udiames[12]=31;

 i=atoi(copy(dt1,1,2));
 dia1=i;
 i=atoi(copy(dt1,4,2));
 mes1=i;
 i=atoi(copy(dt1,7,4));
 ano1=i;

 i=atoi(copy(dt2,1,2));
 dia2=i;
 i=atoi(copy(dt2,4,2));
 mes2=i;
 i=atoi(copy(dt2,7,4));
 ano2=i;

 for(ano=ano1;ano<=ano2;ano++)
  {
    for(mes=mes1;mes<=12;mes++)
     {
       /* ano bissexto */
       if (fmod(ano,4)==0)
         udiames[2]=29;
       /* data final */
       if ((ano==ano2) && (mes==mes2)) 
         udiames[mes2]=dia2;
       for(dia=dia1;dia<=udiames[mes];dia++)
          dias++;
       if ((ano==ano2) && (mes==mes2))
         {
           return(dias-1);
           break;
         }
       dia1=1;
     }
    mes1=1;
  }

}

/*--------------------------------------------------------*/

/*
 Nome : SomaDias
 Descricao : funcao que soma um determinado numero de dias a uma data.
 Parametros :
 dt1 - a data a ser somada
 qtddias - numero de dias a serem somados
*/
char *SomaDias(char *dt1,int qtddias)
{
 int dia,mes,ano,dia1,mes1,ano1,dia2,mes2,ano2;
 int i,c,dias;
 char *sAux,*sAux2;
 int udiames[13];

 sAux=(char*)malloc(100);
 if (!sAux)
   exit(1);

 sAux2=(char*)malloc(100);
 if (!sAux2)
   exit(1);
 
 dias=0;
 udiames[1]=31;
 udiames[2]=28;
 udiames[3]=31;
 udiames[4]=30;
 udiames[5]=31;
 udiames[6]=30;
 udiames[7]=31;
 udiames[8]=31;
 udiames[9]=30;
 udiames[10]=31;
 udiames[11]=30;
 udiames[12]=31;

 i=atoi(copy(dt1,1,2));
 dia1=i;
 i=atoi(copy(dt1,4,2));
 mes1=i;
 i=atoi(copy(dt1,7,4));
 ano1=i;

 ano2=ano1 + (qtddias / 365);

 for(ano=ano1;ano<=ano2;ano++)
  {
    for(mes=mes1;mes<=12;mes++)
     {
       /* ano bissexto */
       if (fmod(ano,4)==0)
         udiames[2]=29;
       for(dia=dia1;dia<=udiames[mes];dia++)
          {
            dias++;
            if (dias==qtddias+1)
              {
                itoa(dia,sAux,10);                
                strcpy(sAux2,somastr(3,repete("0",2-strlen(sAux)),sAux,"/"));
                itoa(mes,sAux,10);
                strcpy(sAux2,somastr(4,sAux2,repete("0",2-strlen(sAux)),sAux,"/"));
                itoa(ano,sAux,10);
                strcpy(sAux2,somastr(3,sAux2,repete("0",4-strlen(sAux)),sAux));
                return(sAux2);
                break;
              }
          }
       dia1=1;
     }
    mes1=1;
  }

}

/*--------------------------------------------------------*/

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
                      sDiasAtraso=(char*)malloc(100);
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
        write(EmprestimosFile,Emprestimos);
        Atribuir_vEmprestimos(true);
        Rotulos_formEmprestimos(1,0);
      }
}

/*******************Modulo de Opcoes**********************/

/*
 Nome : formSair
 Descricao : procedimento que desenha o formulario de sair.
*/
void formSair(void)
{
  teladefundo("±",white,lightblue);
  rodape("Alterta !, Aviso de Saida do Sistema."," ",yellow,red);
  formulario("´Sair do SistemaÃ",10,25,6,27,white,blue,'±',lightgray,black);
  etexto(27,12,white,blue,"Deseja Sair do Sistema ?");
  DesenhaBotao(14,40,black,white,black,blue," Nao ",false);
  Controles_formSair(" Sim ",true);
}

/*-------------------------------------------*/

/*
 Nome : Controles_formSair
 Descricao : procedimento que realiza todo o controle de manuseio do
 formulario de Saida.
 Parametros :
 tipo - indica qual acao a executar
 foco - indica quais objeto terao foco
*/
void Controles_formSair(char *tipo,boolean foco)
{

if (strcmp(tipo," Sim ")==0)
  {
    switch(Botao(14,30,black,white,black,blue," Sim ",foco)) {
      case 1:
          DesenhaBotao(14,30,black,white,black,blue," Sim ",false);
          Controles_formSair(" Nao ",true);
          break;
      case 2:
          textcolor(lightgray);
          textbackground(black);
          clrscr();
          formSplash();
          _setcursortype(_NORMALCURSOR);
          textcolor(lightgray);
          textbackground(black);
          clrscr();
          exit(1);
          break;
    }
  }
else if (strcmp(tipo," Nao ")==0)
  {
    switch(Botao(14,40,black,white,black,blue," Nao ",foco)) {
      case 1:
          DesenhaBotao(14,40,black,white,black,blue," Nao ",false);
          Controles_formSair(" Sim ",true);
          break;
      case 2:
          rodape(""," ",white,blue);
          break;
    }
  }

}

/*-------------------------------------------*/

/*
 Nome : formSobre
 Descricao : procedimento que desenha o formulario de Sobre.
*/
void formSobre(void)
{
  teladefundo("±",white,lightblue);
  rodape("Informacoes sobre o sistema."," ",white,blue);
  formulario("´Sobre o SistemaÃ",4,2,18,76,white,blue,'±',lightgray,black);
  LerArquivoSobre();
  DesenhaBotao(20,63,black,white,black,blue," Fechar ",false);
  Controles_formSobre("Lista",0,0,true);
}

/*-----------------------------------------------------*/

/*
 Nome : LerArquivoSobre
 Descricao : procedimento que le o arquivo de sobre a atribui ao vetor
 de lista.
*/
void LerArquivoSobre(void)
{
 int cont;
 char linha[2];

 AbrirArquivo(4);

 for(cont=0;cont<50;cont++)
  vLista[cont][0]='\0';

 cont=0;
 while (!feof(SobreFile)) {
      fread(linha, 1, 1, SobreFile);
      if (linha[0]=='\n')
         cont++;
      else
         vLista[cont]=somastr(2,vLista[cont],linha);
  }

}

/*-----------------------------------------------------*/

/*
 Nome : Controles_formSobre
 Descricao : procedimento que realiza todo o controle de manuseio do
 formulario de Sobre.
 Parametros :
 tipo - indica qual acao a executar
 pos - indica a ultima posicao da linha da lista de sobre
 col - indica a ultima posicao da coluna da lista de sobre
 foco - indica quais objeto terao foco
*/
void Controles_formSobre(char *tipo,int pos,int col,boolean foco)
{

if (strcmp(tipo,"Fechar")==0)
  {
    switch(Botao(20,63,black,white,black,blue," Fechar ",foco)) {
      case 1:
          DesenhaBotao(20,63,black,white,black,blue," Fechar ",false);
          Controles_formSobre("Lista",pos,col,true);
          break;
      case 2:
          fclose(SobreFile);
          rodape(""," ",white,blue);
          teladefundo("±",white,lightblue);
          break;
    }
  }
else if (strcmp(tipo,"Lista")==0)
  {
    Listapos=pos;
    Listacol=col;
    if (Lista(4,6,5,13,70,43,70,white,blue,foco)==1)
      {
        DesenhaLista(4,6,5,13,70,white,blue,pos,col,false);
        Controles_formSobre("Fechar",pos,col,true);
      }
  }

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
  etexto(12,17,yellow,blue,"Linguagem Usada Nesta Versao << C >>");
  delay(2000);
}

/*-------------------------------------------*/

/* Bloco principal do programa */

int main(void)
{ 
  clrscr();
  teladefundo("±",white,lightblue);
  cabecalho("Sistema de Automacao de Biblioteca"," ",white,blue);
  rodape(""," ",white,blue);
  datadosistema(1,1,white,blue);
  horadosistema(1,73,white,blue);

  vMenu[1]="Acervo";
  vMenu[2]="Usuarios";
  vMenu[3]="Emprestimos e Devolucoes";
  vMenu[4]="Opcoes";

  vSubMenu[1][1]="Cadastrar livros";
  vSubMenu[1][2]="Alterar livros";
  vSubMenu[1][3]="Consultar livros >";

  vSubMenu[2][1]="Cadastrar usuarios";
  vSubMenu[2][2]="Alterar usuarios";
  vSubMenu[2][3]="Consultar usuarios >";

  vSubMenu[3][1]="Emprestar livros";
  vSubMenu[3][2]="Devolver livros";
  vSubMenu[3][3]="Consultar Emprestimos e Devolucoes";

  vSubMenu[4][1]="Sobre o sistema";
  vSubMenu[4][2]="Sair do sistema";

  vSubMenu[5][1]="Todos os livros";
  vSubMenu[5][2]="Por Titulo";
  vSubMenu[5][3]="Por Autor";
  vSubMenu[5][4]="Por Area";
  vSubMenu[5][5]="Por Palavra-chave";

  vSubMenu[6][1]="Todos os Usuarios";
  vSubMenu[6][2]="Por Numero de Inscricao";
  vSubMenu[6][3]="Por Nome";
  vSubMenu[6][4]="Por Identidade";

  menu(4,2,black,lightgray,red,lightgray,0,white,black,0);
  formSplash();

  S=(char*)malloc(300);
  if(!S)
    exit(1);

 do {
   teladefundo("±",white,lightblue);
   menu(4,2,black,lightgray,red,lightgray,0,white,black,0);

   inkey('O','O');

   if (sKey==AltA) ControlaMenus('A',1,true);
   if (sKey==AltU) ControlaMenus('U',1,true);
   if (sKey==AltE) ControlaMenus('E',1,true);
   if (sKey==AltO) ControlaMenus('O',1,true);

  } while(sKey != Esc);

  exit(0);
}
