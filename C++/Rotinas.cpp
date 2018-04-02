/*
 Rotinas.cpp: implementacao da classe Rotinas
*/

#include "Rotinas.h"

Rotinas::Rotinas()
{
}

Rotinas::~Rotinas()
{
}

/*
Nome : cabecalho
Descricao : procedimento que escreve o texto de cabecalho do sistema.
Parametros :
texto - o texto do cabecalho
*/
void Rotinas::Cabecalho(char *texto)
{
char *tempo,*dia,*mes,*ano,*horas;
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
  horas=copy(tempo,12,8);
 

cout << "ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ";
cout << "ÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿" << endl; 
cout << "³ " << dia << "/" << mes << "/" << ano << "           "; 
cout << texto << "           " << horas <<" ³" << endl;
cout << "ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ";
cout << "ÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ" << endl;  

}

/*
 Nome : copy
 Descricao : funcao que retorna um pedaco de uma string
 Parametros :
 str - indica a string
 ini - indica a posicao inicial do pedaco
 tam - indica o tamanho do pedaco
*/
char* Rotinas::copy(char *string,int ini,int tam)
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

/*
 Nome : tamArquivo
 Descricao : funcao que retorna o tamanho de um arquivo
 Parametros :
 Arq - o nome do arquivo
 tam - tamanho do registro
*/
int Rotinas::tamArquivo(FILE *Arq,int tam)
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

