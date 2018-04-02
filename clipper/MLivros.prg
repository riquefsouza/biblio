/******************Modulo de Livros**********************/

#include "Biblio.ch"

/*
 Nome : PesLivros
 Descricao : funcao que pesquisa as informacoes contidas no arquivo de
 livros
 Parametros :
 ctipo - indica se e o valor e (N)umerico ou (S)tring
 ccampo - qual o campo a ser pesquisado
 nCod2 - codigo do campo se numerico
 sCod2 - codigo do campo se string
 nTamsCod - tamanho caracteres do campo de string
*/
function PesLivros(ctipo,ccampo,nCod2,sCod2,nTamsCod)
local nPosicao
local nCod
local sCod
local bFlag
local nRet

fseek(LivrosFile,0,FS_SET)
nPosicao:=0
bFlag:=false
nCod:=0
sCod:=""
do while (.Not.(nTamLivros=nPosicao)) 
   cLivros:=space(TamLiv)
   fread(LivrosFile,@cLivros,TamLiv)
   fatribuir(1,true)

   if ctipo="N" 
       if ccampo="Ninsc" 
          nCod:=nLivNinsc
       endif
       if (nCod=nCod2) 
          nRet:=nPosicao
          fseek(LivrosFile,nPosicao*TamLiv,FS_SET)
          bFlag:=true
          exit
       endif
   elseif ctipo="S" 
       if ccampo="Titulo" 
          sCod:=cLivtitulo
       elseif ccampo="Area" 
          sCod:=cLivArea
       elseif ccampo="Autor" 
          sCod:=cLivAutor
       elseif ccampo="Pchave" 
          sCod:=cLivPChave
       endif
       if (substr(sCod,1,nTamsCod)=sCod2) 
          nRet:=nPosicao
          fseek(LivrosFile,nPosicao*TamLiv,FS_SET)
          bFlag:=true
          exit
       endif
   endif
   nPosicao++
enddo
 if (nTamLivros=nPosicao) .and. (bFlag=false)  /* (Eof(LivrosFile)) */
    return(-1)
 endif
return(nRet)

/*-----------------------------------------------------*/

/*
 Nome : formLivros
 Descricao : procedimento que desenha o formulario de livros na tela, e
 tambem indica qual acao a tomar.
 Parametros :
 ntipo - indica qual a acao do formulario
 ctitulo - o titulo do formulario
 crod - o texto do rodape sobre o formulario
*/
procedure formLivros(ntipo,ctitulo,crod)

  teladefundo("±",white,lightblue)
  rodape(crod," ",white,blue) 
  formulario(chr(180)+ctitulo+chr(195),4,2,18,76,white,blue,"±",lightgray,black)

  vLivros[1]:=replicate(" ",5)
  AtrvLivros(true)
  AbrirArquivo(1)
  if ((ntipo=1) .or. (ntipo=2)) 
     RotformLivros(0)
     DesenhaBotao(20,45,black,lightgray,black,blue," Salvar ",false)
     DesenhaBotao(20,60,black,lightgray,black,blue," Fechar ",false)
  endif
  if ((ntipo=3) .or. (ntipo=4) .or. (ntipo=5) .or. (ntipo=6)) 
     DesenhaBotao(20,60,black,lightgray,black,blue," Fechar ",false)
     RotformLivros(2)
     Etexto(2,7,white,blue,chr(195)+replicate(chr(196),75)+chr(180))
  endif
  if ntipo=7 
     DesenhaBotao(20,60,black,lightgray,black,blue," Fechar ",false)
  endif
  if ntipo=3 
     Etexto(5,6,white,blue,"Titulo : ")
     Etexto(14,6,black,lightgray,replicate(" ",30))
  endif
  if ntipo=4 
     Etexto(5,6,white,blue,"Autor : ")
     Etexto(13,6,black,lightgray,replicate(" ",30))
  endif
  if ntipo=5 
     Etexto(5,6,white,blue,"Area : ")
     Etexto(12,6,black,lightgray,replicate(" ",30))
  endif
  if ntipo=6 
     Etexto(5,6,white,blue,"Palavra-Chave : ")
     Etexto(21,6,black,lightgray,replicate(" ",10))
  endif

  LimpLivros()
  if ntipo=1 
     CformLivros("2",1,0,0,crod,false)  /* cadastrar */
  elseif ntipo=2 
     CformLivros("1",2,0,0,crod,false)  /* alterar */
  elseif ntipo=3 
     CformLivros("3",3,0,0,crod,false) /* consultar por titulo */
  elseif ntipo=4 
     CformLivros("4",4,0,0,crod,false) /* consultar por Autor */
  elseif ntipo=5 
     CformLivros("5",5,0,0,crod,false) /* consultar por Area */
  elseif ntipo=6 
     CformLivros("6",6,0,0,crod,false) /* consultar por Palavra-chave */
  elseif ntipo=7 
     CformLivros("7",7,0,0,crod,true) /* consultar todos */
  endif

return

/*-------------------------------------------*/

/*
 Nome : LimpLivros
 Descricao : procedimento limpa as variaveis do registro de livros.
*/
procedure LimpLivros()
     nLivNinsc:=0
     cLivTitulo:=""
     cLivAutor:=""
     cLivArea:=""
     cLivPchave:=""
     nLivEdicao:=0
     nLivAnoPubli:=0
     cLivEditora:=""
     nLivVolume:=0
     cLivEstado:=""
return

/*-------------------------------------------*/

/*
 Nome : RotformLivros
 Descricao : procedimento que escreve os rotulos do formulario de livros.
 Parametros :
 nl - indica um acrescimo na linha do rotulo
*/
procedure RotformLivros(nl)

  Etexto(5,6+nl,white,blue,"Numero de Inscricao : ")
  Etexto(27,6+nl,black,lightgray,vlivros[1])
  Etexto(35,6+nl,white,blue,"Titulo : ")
  Etexto(44,6+nl,black,lightgray,vlivros[2])
  Etexto(5,8+nl,white,blue,"Autor : ")
  Etexto(13,8+nl,black,lightgray,vlivros[3])
  Etexto(5,10+nl,white,blue,"Area : ")
  Etexto(12,10+nl,black,lightgray,vlivros[4])
  Etexto(5,12+nl,white,blue,"Palavra-Chave : ")
  Etexto(21,12+nl,black,lightgray,vlivros[5])
  Etexto(35,12+nl,white,blue,"Edicao : ")
  Etexto(44,12+nl,black,lightgray,vlivros[6])
  Etexto(5,14+nl,white,blue,"Ano de Publicacao : ")
  Etexto(25,14+nl,black,lightgray,vlivros[7])
  Etexto(35,14+nl,white,blue,"Editora : ")
  Etexto(45,14+nl,black,lightgray,vlivros[8])
  Etexto(5,16+nl,white,blue,"Volume : ")
  Etexto(14,16+nl,black,lightgray,vlivros[9])
  Etexto(22,16+nl,white,blue,"Estado Atual : ")
  Etexto(37,16+nl,black,lightgray,vlivros[10])
  Etexto(40,16+nl,white,blue,"(D)isponivel ou (E)mprestado")

return

/*-------------------------------------------*/

/*
 Nome : CformLivros
 Descricao : procedimento que realiza todo o controle de manuseio do
 formulario de livros.
 Parametros :
 ctipo - indica qual a acao do formulario
 ntipo2 - indica a acao original do formulario nao manipulado pela funcao
 npos - indica a ultima posicao da linha da lista de livros
 ncol - indica a ultima posicao da coluna da lista de livros
 crod - o texto do rodape sobre o formulario
 lfoco - se os objetos do formulario estao focados ou nao
*/
procedure CformLivros(ctipo,ntipo2,npos,ncol,crod,lfoco)
local nop

if ctipo="1"

      cS:=Digita(cS,5,28,5,black,lightgray,"N")  /* N insc */          
      I:=Val(cS)
      nLivNinsc:=I
      if (len(cS) > 0) .and. (cS<>replicate(" ",len(cS))) 
         DesenhaBotao(20,45,black,lightgray,black,blue," Salvar ",false)
         if PesLivros("N","Ninsc",I,"",0)<>-1 
                AtrvLivros(false)
                RotformLivros(0)
                rodape(crod," ",white,blue)
                CformLivros("2",ntipo2,npos,ncol,crod,false)
         else
            cS:=alltrim(str(I))
            AtrvLivros(true) 
            RotformLivros(0) 
            rodape("Numero de Inscricao, nao encontrado !"," ",yellow,red) 
            CformLivros("Fechar",ntipo2,npos,ncol,crod,true) 
         endif
      else
        CformLivros("Fechar",ntipo2,npos,ncol,crod,true) 
      endif
elseif ctipo="2" 
        if ntipo2=1
            nTamLivros:=fseek(LivrosFile,0,FS_END)
            nTamLivros:=int(nTamLivros / TamLiv)
            fseek(LivrosFile,0,FS_SET)
            
            if nTamLivros = 0 
               nLivNinsc:=1
            else                
                nLivNinsc:=nTamLivros + 1 
            endif 
            I:=nLivNinsc 
            cS:=alltrim(str(nLivNinsc)) 
            Etexto(27,6,black,lightgray,cS) 
            cS:="" 
        elseif ntipo2=2 
            AbrirArquivo(1) 
            if PesLivros("N","Ninsc",I,"",0)=-1 
              rodape("Numero de Inscricao, nao encontrado !"," ",yellow,red)
            endif
        endif 
          DformLivros() 
      
      CformLivros("Salvar",ntipo2,npos,ncol,crod,true) 

elseif ctipo="3" 

      cS:="" 
      cS:=Digita(cS,30,15,5,black,lightgray,"T") 
      cLivTitulo:=cS 
      if (len(cS) > 0) .and. (cS<>replicate(" ",len(cS))) 
         if PesLivros("S","Titulo",0,cS,len(cS))<>-1 
              AtrvLivros(false) 
              RotformLivros(2) 
              rodape(crod," ",white,blue) 
         else
            AtrvLivros(true) 
            RotformLivros(2) 
            rodape("Titulo do Livro, nao encontrado !"," ",yellow,red) 
         endif 
      endif 
        CformLivros("Fechar",ntipo2,npos,ncol,crod,true) 

elseif ctipo="4" 
    
      cS:="" 
      cS:=Digita(cS,30,14,5,black,lightgray,"T") 
      cLivAutor:=cS 
      if (len(cS) > 0) .and. (cS<>replicate(" ",len(cS))) 
         if PesLivros("S","Autor",0,cS,len(cS))<>-1 
              AtrvLivros(false) 
              RotformLivros(2) 
              rodape(rod," ",white,blue) 
         else
            AtrvLivros(true) 
            RotformLivros(2) 
            rodape("Autor do Livro, nao encontrado !"," ",yellow,red) 
         endif 
      endif 
        CformLivros("Fechar",ntipo2,npos,ncol,crod,true)     
elseif ctipo="5" 

      cS:="" 
      cS:=Digita(cS,4,13,5,black,lightgray,"T") 
      cLivArea:=cS 
      if (len(cS) > 0) .and. (cS<>replicate(" ",len(cS))) 
         if PesLivros("S","Area",0,cS,len(cS))<>-1 
              AtrvLivros(false) 
              RotformLivros(2) 
              rodape(rod," ",white,blue) 
         else
            AtrvLivros(true) 
            RotformLivros(2) 
            rodape("Area do Livro, nao encontrada !"," ",yellow,red) 
         endif 
      endif 
        CformLivros("Fechar",ntipo2,npos,ncol,crod,true) 

elseif ctipo="6" 

      cS:="" 
      cS:=Digita(cS,10,22,5,black,lightgray,"T") 
      cLivPChave:=cS 
      if (len(cS) > 0) .and. (cS<>replicate(" ",len(cS))) 
         if PesLivros("S","Pchave",0,cS,len(cS))<>-1 
              AtrvLivros(false) 
              RotformLivros(2) 
              rodape(rod," ",white,blue) 
         else
            AtrvLivros(true) 
            RotformLivros(2) 
            rodape("Palavra-Chave do Livro, nao encontrado !"," ",yellow,red) 
         endif 
      endif 
        CformLivros("Fechar",ntipo2,npos,ncol,crod,true) 

elseif ctipo="7" 
    nListacol=ncol
    nListapos=npos
    if lista(1,6,5,13,70,nTamLivros+2,220,white,blue,lfoco)=1 
        desenhalista(1,6,5,13,70,white,blue,npos,ncol,false) 
        CformLivros("Fechar",ntipo2,npos,ncol,crod,true) 
    endif 

elseif ctipo="Salvar" 
    nop:=Botao(20,45,black,lightgray,black,blue," Salvar ",lfoco)
    do case 
      case nop=1
          DesenhaBotao(20,45,black,lightgray,black,blue," Salvar ",false) 
          CformLivros("Fechar",ntipo2,npos,ncol,crod,true) 
      case nop=2
          SalvarLivros(ntipo2) 
          DesenhaBotao(20,45,black,lightgray,black,blue," Salvar ",false) 
          CformLivros("Fechar",ntipo2,npos,ncol,crod,true) 
    endcase 
elseif ctipo = "Fechar" 
    nop:=Botao(20,60,black,lightgray,black,blue," Fechar ",lfoco)
    do case  
      case nop=1
          DesenhaBotao(20,60,black,lightgray,black,blue," Fechar ",false) 
          if ntipo2=1 
            CformLivros("2",ntipo2,npos,ncol,crod,true)
          elseif ntipo2=2 
            CformLivros("1",ntipo2,npos,ncol,crod,false)
          elseif ntipo2=3 
            CformLivros("3",ntipo2,npos,ncol,crod,false)
          elseif ntipo2=4 
            CformLivros("4",ntipo2,npos,ncol,crod,false)
          elseif ntipo2=5 
            CformLivros("5",ntipo2,npos,ncol,crod,false)
          elseif ntipo2=6 
            CformLivros("6",ntipo2,npos,ncol,crod,false)
          elseif ntipo2=7 
            CformLivros("7",ntipo2,npos,ncol,crod,true)
          endif 
      case nop=2
         rodape(""," ",white,blue) 
         fclose(LivrosFile) 
    endcase 
endif 

return

/*-------------------------------------------------------*/

/*
 Nome : AtrvLivros
 Descricao : procedimento que atribui ou limpa o vetor de livros.
 Parametros :
 llimpar - indica se vai limpar ou atribuir os vetores
*/
procedure AtrvLivros(llimpar) 

if llimpar=false 
      cS:=alltrim(str(nLivNinsc)) 
      vLivros[1]:=cS 
      vLivros[2]:=cLivTitulo 
      vLivros[3]:=cLivAutor 
      vLivros[4]:=cLivArea 
      vLivros[5]:=cLivPchave 
      cS:=alltrim(Str(nLivEdicao)) 
      vLivros[6]:=cS 
      cS:=alltrim(Str(nLivAnoPubli)) 
      vLivros[7]:=cS 
      vLivros[8]:=cLivEditora 
      cS:=alltrim(Str(nLivVolume)) 
      vLivros[9]:=cS 
      vLivros[10]:=cLivEstado 
else
  vLivros[2]:=replicate(" ",30) 
  vLivros[3]:=replicate(" ",30) 
  vLivros[4]:=replicate(" ",30) 
  vLivros[5]:=replicate(" ",10) 
  vLivros[6]:=replicate(" ",4) 
  vLivros[7]:=replicate(" ",4) 
  vLivros[8]:=replicate(" ",30) 
  vLivros[9]:=replicate(" ",4) 
  vLivros[10]:=replicate(" ",1) 
endif 
return

/*-------------------------------------------------------*/

/*
 Nome : DformLivros
 Descricao : procedimento que realiza o cotrole de digitacao dos dados no
 formulario de livros.
*/
procedure DformLivros() 
        cS:=cLivTitulo 
        cS:=Digita(cS,30,45,5,black,lightgray,"T")           
        cLivTitulo:=cS 
        cS:=cLivAutor 
        cS:=Digita(cS,30,14,7,black,lightgray,"T")
        cLivAutor:=cS 
        cS:=cLivArea 
        cS:=Digita(cS,30,13,9,black,lightgray,"T") 
        cLivArea:=cS 
        cS:=cLivPChave 
        cS:=Digita(cS,10,22,11,black,lightgray,"T") 
        cLivPchave:=cS 
        cS:=alltrim(Str(nLivEdicao)) 
        cS:=Digita(cS,4,45,11,black,lightgray,"N") 
        I:=Val(cS) 
        nLivEdicao:=I 
        cS:=alltrim(Str(nLivAnoPubli)) 
        cS:=Digita(cS,4,26,13,black,lightgray,"N") 
        I:=Val(cS) 
        nLivAnoPubli:=I 
        cS:=cLivEditora 
        cS:=Digita(cS,30,46,13,black,lightgray,"T") 
        cLivEditora:=cS 
        cS:=alltrim(str(nLivVolume)) 
        cS:=Digita(cS,4,15,15,black,lightgray,"N") 
        I:=Val(cS) 
        nLivVolume:=I 
        cS:=cLivEstado 
        cS:=Digita(cS,1,38,15,black,lightgray,"T") 
        cLivEstado:=cS
        cS:=""
      
return

/*-------------------------------------------------------*/

/*
 Nome : VerificaLivros
 Descricao : funcao que verifica se os dados no formulario de livros
 foram digitados.
*/
function VerificaLivros()
  cS:=alltrim(str(nLivNinsc)) 
  if (len(cS) = 0) .and. (cS=replicate(" ",len(cS)))   
      rodape("Numero de Inscricao, nao cadastrado !"," ",yellow,red) 
      return(false)    
  endif 
  if (len(cLivTitulo) = 0) .and. (cLivTitulo=replicate(" ",len(cLivTitulo))) 
      rodape("Titulo, nao cadastrado !"," ",yellow,red) 
      return(false)   
  endif 
  if (len(cLivAutor) = 0) .and. (cLivAutor=replicate(" ",len(cLivAutor)))     
      rodape("Autor, nao cadastrado !"," ",yellow,red) 
      return(false)      
  endif 
  if (len(cLivArea) = 0) .and. (cLivArea=replicate(" ",len(cLivArea)))     
      rodape("Area, nao cadastrada !"," ",yellow,red) 
      return(false)      
  endif 
  if (len(cLivPchave) = 0) .and. (cLivPchave=replicate(" ",len(cLivPchave)))     
      rodape("Palavra-Chave, nao cadastrada !"," ",yellow,red) 
      return(false)      
  endif 
  cS:=alltrim(str(nLivEdicao)) 
  if (len(cS) = 0) .and. (cS=replicate(" ",len(cS)))     
      rodape("Edicao, nao cadastrada !"," ",yellow,red) 
      return(false)      
  endif 
  cS:=alltrim(str(nLivAnoPubli)) 
  if (len(cS) = 0) .and. (cS=replicate(" ",len(cS)))     
      rodape("Ano de Publicacao, nao cadastrado !"," ",yellow,red) 
      return(false)      
  endif 
  if (len(cLivEditora) = 0) .and. (cLivEditora=replicate(" ",len(cLivEditora)))     
      rodape("Editora, nao cadastrada !"," ",yellow,red) 
      return(false)      
  endif 
  cS:=alltrim(str(nLivVolume)) 
  if (len(cS) = 0) .and. (cS=replicate(" ",len(cS)))     
      rodape("Volume, nao cadastrado !"," ",yellow,red) 
      return(false)      
  endif 
  if (len(cLivEstado) = 0) .and. (cLivEstado=replicate(" ",len(cLivEstado)))     
      rodape("Estado, nao cadastrado !"," ",yellow,red) 
      return(false)      
  endif 

return(true) 

/*---------------------------------------------------------------*/

/*
 Nome : SalvarLivros
 Descricao : procedimento que salva os dados digitados no
 formulario de livros.
 Parametros :
 ntipo - indica qual acao a salvar
*/
procedure SalvarLivros(ntipo) 

if VerificaLivros()=true 
 if (cLivEstado="D") .or. (cLivEstado="E") 
    if ntipo=1 
        fseek(LivrosFile,nTamLivros*TamLiv,FS_SET)
        fatribuir(1,false)
        fwrite(LivrosFile,@cLivros,TamLiv) 
        AtrvLivros(true) 
        RotformLivros(0) 
        LimpLivros() 
    elseif ntipo=2
       fatribuir(1,false)
       fwrite(LivrosFile,@cLivros,TamLiv) 
    endif
 else
  rodape("Estado Atual, Cadastrado Incorretamente !"," ",yellow,red)
 endif
endif 

return

