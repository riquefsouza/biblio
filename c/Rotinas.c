/* Modulo de Rotinas */

#include "biblio.h"

/* variaveis gerais */

 enum Keys sKey;
 char ch;
 char *S;  

 /* variaveis do modulo de livros */

 struct LivrosRec Livros;
 FILE *LivrosFile; 
 int nTamLivros;

 /* variaveis do modulo de Usuarios */

 struct UsuariosRec Usuarios;
 FILE *UsuariosFile; 
 int nTamUsuarios;

 /* variaveis do modulo de Emprestimos */

 struct EmprestimosRec Emprestimos;
 FILE *EmprestimosFile; 
 int nTamEmprestimos;

 /* variaveis do modulo de Opcoes */

 FILE *SobreFile;

/* Rotinas Fundamentais */

/*
 Nome : _setcursortype
 Descricao : Procedimento que muda o tipo de cursor
 Parametros :
 tipo - indica o tipo de cursor a ser mudado
*/
/*
void _setcursortype(enum modocursor tipo)
{
 union REGS r;
if (tipo==_SOLIDCURSOR)
{
  r.h.ah=0x1;
  r.h.ch=0x0;
  r.h.cl=0x7;
  int86(0x10,&r,&r);
 }
else if (tipo==_NORMALCURSOR)
{
  r.h.ah=0x1;
  r.h.ch=0x6;
  r.h.cl=0x7;
  int86(0x10,&r,&r);
 }
else if (tipo==_NOCURSOR)
{
  r.h.ah=0x1;
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
_setcursortype(_NORMALCURSOR);
return(str);
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
 return("");
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

/*-----------------------------------------------------*/

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
 int i,dias;
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
         }
       dia1=1;
     }
    mes1=1;
  }
  return(0);
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
 int dia,mes,ano,dia1,mes1,ano1,ano2;
 int i,dias;
 char *sAux,*sAux2;
 int udiames[13];

 sAux=(char*)malloc(15);
 if (!sAux)
   exit(1);

 sAux2=(char*)malloc(15);
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
              }
          }
       dia1=1;
     }
    mes1=1;
  }
 return("");
}
