/********************Modulo de Opcoes***********************/

#include "Biblio.ch"

/*
 Nome : formSair
 Descricao : procedimento que desenha o formulario de sair.
*/
procedure formSair()
  teladefundo("±",white,lightblue)
  rodape("Alterta !, Aviso de Saida do Sistema."," ",yellow,red)
  formulario(chr(180)+"Sair do Sistema"+chr(195),10,25,6,27,white,blue,"±",lightgray,black)
  Etexto(27,12,white,blue,"Deseja Sair do Sistema ?")
  DesenhaBotao(14,40,black,lightgray,black,blue," Nao ",false)
  CformSair(" Sim ",true)
return

/*-------------------------------------------*/

/*
 Nome : CformSair
 Descricao : procedimento que realiza todo o controle de manuseio do
 formulario de Saida.
 Parametros :
 ctipo - indica qual acao a executar
 lfoco - indica quais objeto terao foco
*/
procedure CformSair(ctipo,lfoco)
local nbp

if ctipo=" Sim " 
    nbp:=Botao(14,30,black,lightgray,black,blue," Sim ",lfoco)
    do case
      case nbp=1
          DesenhaBotao(14,30,black,lightgray,black,blue," Sim ",false)
          CformSair(" Nao ",true)
      case nbp=2
          setcolor(lightgray+"/"+black)
          cls
          formSplash()
          setcursor(SC_NORMAL)
          setcolor(lightgray+"/"+black)
          cls
          quit
    endcase
elseif ctipo=" Nao " 
    nbp:=Botao(14,40,black,lightgray,black,blue," Nao ",lfoco)
    do case 
      case nbp=1
          DesenhaBotao(14,40,black,lightgray,black,blue," Nao ",false)
          CformSair(" Sim ",true)
      case nbp=2
          rodape(""," ",white,blue)
    endcase
endif

return

/*-------------------------------------------*/

/*
 Nome : formSobre
 Descricao : procedimento que desenha o formulario de Sobre.
*/
procedure formSobre()
  teladefundo("±",white,lightblue)
  rodape("Informacoes sobre o sistema."," ",white,blue)
  formulario(chr(180)+"Sobre o Sistema"+chr(195),4,2,18,76,white,blue,"±",lightgray,black)
  LerArquivoSobre()
  desenhaBotao(20,63,black,lightgray,black,blue," Fechar ",false)
  CformSobre("Lista",0,0,true)
return

/*-----------------------------------------------------*/

/*
 Nome : LerArquivoSobre
 Descricao : procedimento que le o arquivo de sobre a atribui ao vetor
 de lista.
*/
procedure LerArquivoSobre()
local ncont
local ncont2
local clinha

 AbrirArquivo(4)
 clinha:=space(1)
 for ncont:=1 to 51
   vLista[ncont]:=space(1)
 next
 ncont:=1
 ncont2:=0

 do while true
  if nTamSobre > ncont2
     fread(SobreFile,@clinha,1)
     ncont2++
     if clinha=chr(13)  
        ncont++
        fread(SobreFile,@clinha,1)
     else
        vLista[ncont]:=vLista[ncont]+clinha
     endif
  else
     exit
  endif
 enddo
return

/*-----------------------------------------------------*/

/*
 Nome : CformSobre
 Descricao : procedimento que realiza todo o controle de manuseio do
 formulario de Sobre.
 Parametros :
 ctipo - indica qual acao a executar
 npos - indica a ultima posicao da linha da lista de sobre
 ncol - indica a ultima posicao da coluna da lista de sobre
 lfoco - indica quais objeto terao foco
*/
procedure CformSobre(ctipo,npos,ncol,lfoco)
local nop:=0

if ctipo="Fechar"
    nop:=Botao(20,63,black,lightgray,black,blue," Fechar ",lfoco)
    do case
      case nop=1
          DesenhaBotao(20,63,black,lightgray,black,blue," Fechar ",false)
          CformSobre("Lista",npos,ncol,true)
      case nop=2
          fclose(SobreFile)
          rodape(""," ",white,blue)
          teladefundo("±",white,lightblue)
    endcase
elseif ctipo="Lista"
    nListapos=npos
    nListacol=ncol
    if lista(4,6,5,13,70,43,70,white,blue,lfoco)=1
        desenhalista(4,6,5,13,70,white,blue,npos,ncol,false)
        CformSobre("Fechar",npos,ncol,true)
    endif
endif

return
