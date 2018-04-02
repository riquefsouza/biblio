/* Modulo de Opcoes */

#include "biblio.h"

/*******************Modulo de Opcoes**********************/

/*
 Nome : formSair
 Descricao : procedimento que desenha o formulario de sair.
*/
void formSair(void)
{
  teladefundo("±",white,lightblue);
  rodape("Alterta !, Aviso de Saida do Sistema."," ",yellow,red);
  formulario("¥Sair do Sistema√",10,25,6,27,white,blue,'±',lightgray,black);
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
  formulario("¥Sobre o Sistema√",4,2,18,76,white,blue,'±',lightgray,black);
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

