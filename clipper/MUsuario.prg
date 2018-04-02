/******************Modulo de Usuarios**********************/

#include "Biblio.ch"

/*
 Nome : PesUsuarios
 Descricao : funcao que pesquisa as informacoes contidas no arquivo de
 usuarios.
 Parametros :
 ctipo - indica se e o valor e (N)umerico ou (S)tring
 ccampo - qual o campo a ser pesquisado
 nCod2 - codigo do campo se numerico
 sCod2 - codigo do campo se string
 nTamsCod - tamanho caracteres do campo de string
*/
function PesUsuarios(ctipo,ccampo,nCod2,sCod2,nTamsCod)
local nPosicao
local nCod
local sCod
local bFlag
local nRet

fseek(UsuariosFile,0,FS_SET) 
nPosicao:=0 
bFlag:=false 
nCod:=0 
sCod:="" 
do while (.Not.(nTamUsuarios=nPosicao)) 
   cUsuarios:=space(TamUsu)
   fread(UsuariosFile,@cUsuarios,TamUsu)
   fatribuir(2,true)

   if ctipo="N" 
       if ccampo="Ninsc" 
          nCod:=nUsuNinsc
       endif
       if (nCod=nCod2) 
          nRet:=nPosicao 
          fseek(UsuariosFile,nPosicao*TamUsu,FS_SET)
          bFlag:=true 
          exit 
       endif
   elseif ctipo="S" 
       if ccampo="Nome" 
          sCod:=cUsuNome
       elseif ccampo="Ident" 
          sCod:=cUsuIdent 
       endif

       if (substr(sCod,1,nTamsCod)=sCod2) 
          nRet:=nPosicao 
          fseek(UsuariosFile,nPosicao) 
          bFlag:=true 
          exit 
       endif 
   endif 
   nPosicao++
enddo 
 if (nTamUsuarios=nPosicao) .and. (bFlag=false)  
    return(-1)
 endif
return(nRet)

/*-----------------------------------------------------*/

/*
 Nome : PesBinaria
 Descricao : funcao que realiza uma pesquisa binaria
 por numero de inscricao do usuario.
 Parametros :
 nChave - numero de inscricao do usuario a pesquisar
*/
function PesBinaria(nChave)
local ninicio
local nfim
local nmeio
local lachou

 ninicio:=1 
 nfim:=nTamUsuarios+1 
 lachou:=false 
 do while ((.not.(lachou)) .and. (ninicio <= nfim)) 
   nmeio:=int((ninicio+nfim) / 2) 

   fseek(UsuariosFile,(nmeio-1)*TamUsu,FS_SET)
   cUsuarios:=space(TamUsu)
   fread(UsuariosFile,@cUsuarios,TamUsu)
   fatribuir(2,true)

   if (nchave=nUsuNinsc) 
      lachou:=true
   else
      if (nchave > nUsuNinsc) 
        ninicio:=nmeio+1
      else
        nfim:=nmeio-1
      endif
   endif 
 enddo 
 if lachou=true 
    return(nmeio-1)
 else
    return(-1)
 endif
return(1) 

/*-----------------------------------------------------*/

/*
 Nome : formUsuarios
 Descricao : procedimento que desenha o formulario de Usuarios na tela, e
 tambem indica qual acao a tomar.
 Parametros :
 ntipo - indica qual a acao do formulario
 ctitulo - o titulo do formulario
 crod - o texto do rodape sobre o formulario
*/
procedure formUsuarios(ntipo,ctitulo,crod) 

  teladefundo("±",white,lightblue) 
  rodape(crod," ",white,blue) 
  formulario(chr(180)+ctitulo+chr(195),4,2,18,76,white,blue,"±",lightgray,black) 

  vUsuarios[1]:=replicate(" ",5) 
  AtrvUsuarios(true) 
  AbrirArquivo(2) 
  if (ntipo=1) .or. (ntipo=2) 
     RotformUsuarios(0) 
     DesenhaBotao(20,48,black,lightgray,black,blue," Salvar ",false) 
     DesenhaBotao(20,63,black,lightgray,black,blue," Fechar ",false) 
  endif 
  if (ntipo=3) .or. (ntipo=4) .or. (ntipo=5) 
     DesenhaBotao(20,63,black,lightgray,black,blue," Fechar ",false) 
     RotformUsuarios(2) 
     Etexto(2,7,white,blue,chr(195)+replicate(chr(196),75)+chr(180)) 
  endif 
  if ntipo=6 
     DesenhaBotao(20,63,black,lightgray,black,blue," Fechar ",false)
  endif

  if ntipo=3 
     Etexto(5,6,white,blue,"Numero de Inscricao : ") 
     Etexto(27,6,black,lightgray,replicate(" ",5)) 
  endif 
  if ntipo=4 
     Etexto(5,6,white,blue,"Nome : ") 
     Etexto(12,6,black,lightgray,replicate(" ",30)) 
  endif 
  if ntipo=5 
     Etexto(5,6,white,blue,"Identidade : ") 
     Etexto(18,6,black,lightgray,replicate(" ",10)) 
  endif 

  LimpUsuarios() 
  if ntipo=1 
     CformUsuarios("2",1,0,0,crod,false)  /* cadastrar */
  elseif ntipo=2 
     CformUsuarios("1",2,0,0,crod,false)  /* alterar */
  elseif ntipo=3 
     CformUsuarios("3",3,0,0,crod,false) /* consultar por NInsc */
  elseif ntipo=4 
     CformUsuarios("4",4,0,0,crod,false) /* consultar por Nome */
  elseif ntipo=5 
     CformUsuarios("5",5,0,0,crod,false) /* consultar por Identidade */
  elseif ntipo=6 
     CformUsuarios("6",6,0,0,crod,true)  /* consultar todos */
  endif
return

/*-------------------------------------------*/

/*
 Nome : LimpUsuarios
 Descricao : procedimento limpa as iaveis do registro de usuarios.
*/
procedure LimpUsuarios()
     nUsuNinsc:=0 
     cUsuNome:="" 
     cUsuIdent:="0" 
     cEndLogra:="" 
     nEndNumero:=0 
     cEndCompl:="" 
     cEndBairro:="" 
     cEndCep:="0" 
     cUsuTelefone:="0" 
     cUsuCategoria:="" 
     nUsuSituacao:=0 
return

/*-------------------------------------------*/

/*
 Nome : RotformUsuarios
 Descricao : procedimento que escreve os rotulos do formulario de Usuarios.
 Parametros :
 nl - indica um acrescimo na linha do rotulo
*/
procedure RotformUsuarios(nl) 
  Etexto(5,6+nl,white,blue,"Numero de Inscricao : ") 
  Etexto(27,6+nl,black,lightgray,vUsuarios[1]) 
  Etexto(35,6+nl,white,blue,"Nome : ") 
  Etexto(42,6+nl,black,lightgray,vUsuarios[2]) 
  Etexto(5,8+nl,white,blue,"Identidade : ") 
  Etexto(18,8+nl,black,lightgray,vUsuarios[3]) 
  Etexto(2,10+nl,white,blue,chr(195)+replicate("Ä",75)+chr(180)) 
  Etexto(5,10+nl,white,blue,"Endereco") 
  Etexto(5,12+nl,white,blue,"Logradouro : ") 
  Etexto(18,12+nl,black,lightgray,vUsuarios[4]) 
  Etexto(51,12+nl,white,blue,"Numero : ") 
  Etexto(60,12+nl,black,lightgray,vUsuarios[5]) 
  Etexto(5,14+nl,white,blue,"Complemento : ") 
  Etexto(19,14+nl,black,lightgray,vUsuarios[6]) 
  Etexto(32,14+nl,white,blue,"Bairro : ") 
  Etexto(41,14+nl,black,lightgray,vUsuarios[7]) 
  Etexto(63,14+nl,white,blue,"Cep : ") 
  Etexto(69,14+nl,black,lightgray,vUsuarios[8]) 
  Etexto(2,16+nl,white,blue,chr(195)+replicate("Ä",75)+chr(180)) 
  Etexto(31,8+nl,white,blue,"Telefone : ") 
  Etexto(42,8+nl,black,lightgray,vUsuarios[9]) 
  Etexto(5,17+nl,white,blue,"Categoria : ") 
  Etexto(17,17+nl,black,lightgray,vUsuarios[10]) 
  Etexto(20,17+nl,white,blue,"(A)luno ou (P)rofessor ou (F)uncionario") 
  Etexto(5,19+nl,white,blue,"Situacao : ") 
  Etexto(16,19+nl,black,lightgray,vUsuarios[11]) 
return
/*-------------------------------------------*/

/*
 Nome : CformUsuarios
 Descricao : procedimento que realiza todo o controle de manuseio do
 formulario de Usuarios.
 Parametros :
 ctipo - indica qual a acao do formulario
 ntipo2 - indica a acao original do formulario nao manipulado pela funcao
 npos - indica a ultima posicao da linha da lista de usuarios
 ncol - indica a ultima posicao da coluna da lista de usuarios
 crod - o texto do rodape sobre o formulario
 lfoco - se os objetos do formulario estao focados ou nao
*/
procedure CformUsuarios(ctipo,ntipo2,npos,ncol,crod,lfoco) 
local nop

if ctipo="1" 
      cS:=Digita(cS,5,28,5,black,lightgray,"N")  /* N insc */
      I:=Val(cS) 
      nUsuNinsc:=I 
      if (len(cS) > 0) .and. (cS<>replicate(" ",len(cS)))       
         DesenhaBotao(20,48,black,lightgray,black,blue," Salvar ",false) 
         if PesUsuarios("N","Ninsc",I,"",0)<>-1 
                AtrvUsuarios(false) 
                RotformUsuarios(0) 
                rodape(crod," ",white,blue) 
                CformUsuarios("2",ntipo2,npos,ncol,crod,false) 
         else
            cS:=alltrim(str(I)) 
            AtrvUsuarios(true) 
            RotformUsuarios(0) 
            rodape("Numero de Inscricao, nao encontrado !"," ",yellow,red) 
            CformUsuarios("Fechar",ntipo2,npos,ncol,crod,true) 
         endif 
      else
        CformUsuarios("Fechar",ntipo2,npos,ncol,crod,true) 
      endif
elseif ctipo="2" 
        if ntipo2=1
            nTamUsuarios:=fseek(UsuariosFile,0,FS_END)
            nTamUsuarios:=int(nTamUsuarios / TamUsu)
            fseek(UsuariosFile,0,FS_SET)

            if nTamUsuarios = 0 
               nUsuNinsc:=1
            else
                nUsuNinsc:=nTamUsuarios + 1 
            endif 
            I:=nUsuNinsc 
            cS:=alltrim(str(nUsuNinsc)) 
            Etexto(27,6,black,lightgray,cS) 
            cS:="" 
        elseif ntipo2=2 
            AbrirArquivo(2) 
            if PesUsuarios("N","Ninsc",I,"",0)=-1 
              rodape("Numero de Inscricao, nao encontrado !"," ",yellow,red)
            endif
        endif 
          DformUsuarios() 
      
      CformUsuarios("Salvar",ntipo2,npos,ncol,crod,true) 

elseif ctipo="3" 

      cS:="" 
      cS:=Digita(cS,5,28,5,black,lightgray,"N")  /* N insc */
      I:=Val(cS)
      nUsuNinsc:=I 
      if (len(cS) > 0) .and. (cS<>replicate(" ",len(cS))) 
         if PesBinaria(I)<>-1 
            AtrvUsuarios(false) 
            RotformUsuarios(2) 
            rodape(crod," ",white,blue) 
         else
            AtrvUsuarios(true) 
            RotformUsuarios(2) 
            rodape("Numero de Inscricao, nao encontrado !"," ",yellow,red) 
         endif 
      endif 
        CformUsuarios("Fechar",ntipo2,npos,ncol,crod,true) 

elseif ctipo="4" 

      cS:="" 
      cS:=Digita(cS,30,13,5,black,lightgray,"T") 
      cUsuNome:=cS 
      if (len(cS) > 0) .and. (cS<>replicate(" ",len(cS))) 
         if PesUsuarios("S","Nome",0,cS,len(cS))<>-1 
              AtrvUsuarios(false) 
              RotformUsuarios(2) 
              rodape(crod," ",white,blue) 
         else
            AtrvUsuarios(true) 
            RotformUsuarios(2) 
            rodape("Nome do Usuario, nao encontrado !"," ",yellow,red) 
         endif 
      endif 
        CformUsuarios("Fechar",ntipo2,npos,ncol,crod,true) 

elseif ctipo="5" 

      cS:="" 
      cS:=Digita(cS,10,19,5,black,lightgray,"N") 
      cUsuIdent:=cS 
      if (len(cS) > 0) .and. (cS<>replicate(" ",len(cS))) 
         if PesUsuarios("N","Ident",0,cS,len(cS))<>-1 
              AtrvUsuarios(false) 
              RotformUsuarios(2) 
              rodape(crod," ",white,blue) 
         else
            AtrvUsuarios(true) 
            RotformUsuarios(2) 
            rodape("Identidade do Usuario, nao encontrada !"," ",yellow,red) 
         endif 
      endif 
        CformUsuarios("Fechar",ntipo2,npos,ncol,crod,true) 

elseif ctipo="6" 
    nListapos:=npos
    nListacol:=ncol
    if lista(2,6,5,13,70,nTamUsuarios+2,194,white,blue,lfoco)=1 
        desenhalista(2,6,5,13,70,white,blue,npos,ncol,false) 
        CformUsuarios("Fechar",ntipo2,npos,ncol,crod,true) 
    endif 
elseif ctipo="Salvar" 
    nop:=Botao(20,48,black,lightgray,black,blue," Salvar ",lfoco)
    do case
      case nop=1
          DesenhaBotao(20,48,black,lightgray,black,blue," Salvar ",false) 
          CformUsuarios("Fechar",ntipo2,npos,ncol,crod,true) 
      case nop=2
          SalvarUsuarios(ntipo2) 
          DesenhaBotao(20,48,black,lightgray,black,blue," Salvar ",false) 
          CformUsuarios("Fechar",ntipo2,npos,ncol,crod,true) 
    endcase 

elseif ctipo = "Fechar" 
    nop:=Botao(20,63,black,lightgray,black,blue," Fechar ",lfoco)
    do case
      case nop=1
          DesenhaBotao(20,63,black,lightgray,black,blue," Fechar ",false) 
          if ntipo2=1 
            CformUsuarios("2",ntipo2,npos,ncol,crod,true)
          elseif ntipo2=2 
            CformUsuarios("1",ntipo2,npos,ncol,crod,false)
          elseif ntipo2=3 
            CformUsuarios("3",ntipo2,npos,ncol,crod,false)
          elseif ntipo2=4 
            CformUsuarios("4",ntipo2,npos,ncol,crod,false)
          elseif ntipo2=5 
            CformUsuarios("5",ntipo2,npos,ncol,crod,false)
          elseif ntipo2=6 
            CformUsuarios("6",ntipo2,npos,ncol,crod,true)
          endif
      case nop=2
         rodape(""," ",white,blue) 
         fclose(UsuariosFile) 
    endcase 
endif 

return

/*-------------------------------------------------------*/

/*
 Nome : AtrvUsuarios
 Descricao : procedimento que atribui ou limpa o vetor de Usuarios.
 Parametros :
 llimpar - indica se vai limpar ou atribuir os vetores
*/
procedure AtrvUsuarios(llimpar) 

if llimpar=false 
      cS:=alltrim(str(nUsuNinsc)) 
      vUsuarios[1]:=cS 
      vUsuarios[2]:=cUsuNome 
      vUsuarios[3]:=cUsuIdent 
      vUsuarios[4]:=cEndLogra 
      cS:=alltrim(str(nEndnumero)) 
      vUsuarios[5]:=cS 
      vUsuarios[6]:=cEndCompl 
      vUsuarios[7]:=cEndBairro 
      vUsuarios[8]:=cEndCep 
      vUsuarios[9]:=cUsuTelefone 
      vUsuarios[10]:=cUsuCategoria 
      cS:=alltrim(str(nUsuSituacao)) 
      vUsuarios[11]:=cS 
else
  vUsuarios[2]:=replicate(" ",30) 
  vUsuarios[3]:=replicate(" ",10) 
  vUsuarios[4]:=replicate(" ",30) 
  vUsuarios[5]:=replicate(" ",5) 
  vUsuarios[6]:=replicate(" ",10) 
  vUsuarios[7]:=replicate(" ",20) 
  vUsuarios[8]:=replicate(" ",8) 
  vUsuarios[9]:=replicate(" ",11) 
  vUsuarios[10]:=replicate(" ",1) 
  vUsuarios[11]:=replicate(" ",1) 
endif 
return

/*-------------------------------------------------------*/

/*
 Nome : DformUsuarios
 Descricao : procedimento que realiza o cotrole de digitacao dos dados no
 formulario de usuarios.
*/
procedure DformUsuarios()
        cS:=cUsuNome 
        cS:=Digita(cS,30,43,5,black,lightgray,"T") 
        cUsuNome:=cS 
        cS:=cUsuIdent 
        cS:=Digita(cS,10,19,7,black,lightgray,"N") 
        cUsuIdent:=cS 
        cS:=cUsuTelefone 
        cS:=Digita(cS,11,43,7,black,lightgray,"N") 
        cUsuTelefone:=cS 
        cS:=cEndLogra 
        cS:=Digita(cS,30,19,11,black,lightgray,"T") 
        cEndLogra:=cS 
        cS:=alltrim(Str(nEndnumero)) 
        cS:=Digita(cS,5,61,11,black,lightgray,"N") 
        I:=Val(cS)
        nEndnumero:=I 
        cS:=cEndcompl 
        cS:=Digita(cS,10,20,13,black,lightgray,"T") 
        cEndcompl:=cS 
        cS:=cEndBairro 
        cS:=Digita(cS,20,42,13,black,lightgray,"T") 
        cEndBairro:=cS 
        cS:=cEndCep 
        cS:=Digita(cS,8,70,13,black,lightgray,"N") 
        cEndCep:=cS 
        cS:=cUsuCategoria 
        cS:=Digita(cS,1,18,16,black,lightgray,"T") 
        cUsuCategoria:=cS 
        cS:=alltrim(str(nUsuSituacao)) 
        cS:=Digita(cS,1,17,18,black,lightgray,"N") 
        I:=Val(cS)
        nUsuSituacao:=I 
        cS:="" 
return

/*-------------------------------------------------------*/

/*
 Nome : VerificaUsuarios
 Descricao : funcao que verifica se os dados no formulario de usuarios
 foram digitados.
*/
function VerificaUsuarios()

  cS:=alltrim(str(nUsuNinsc)) 
  if (len(cS) = 0) .and. (cS=replicate(" ",len(cS))) 
      rodape("Numero de Inscricao, nao cadastrado !"," ",yellow,red) 
      return(false) 
  endif 
  if (len(cUsuNome) = 0) .and. (cUsuNome=replicate(" ",len(cUsuNome)))  
      rodape("Nome do Usuario, nao cadastrado !"," ",yellow,red) 
      return(false)      
  endif 
  if (len(cUsuIdent) = 0) .and. (cUsuIdent=replicate(" ",len(cUsuIdent)))     
      rodape("Identidade, nao cadastrada !"," ",yellow,red) 
      return(false)      
  endif 
  if (len(cEndlogra) = 0) .and. (cEndlogra=replicate(" ",len(cEndlogra)))     
      rodape("Logradouro, nao cadastrado !"," ",yellow,red) 
      return(false)      
  endif 
  cS:=alltrim(str(nEndnumero))
  if (len(cS) = 0) .and. (cS=replicate(" ",len(cS)))     
      rodape("Numero do Endereco, nao cadastrado !"," ",yellow,red) 
      return(false)      
  endif 
  if (len(cEndcompl) = 0) .and. (cEndcompl=replicate(" ",len(cEndcompl)))     
      rodape("Complemento do Endereco, nao cadastrado !"," ",yellow,red) 
      return(false)      
  endif 
  if (len(cEndBairro) = 0) .and. (cEndBairro=replicate(" ",len(cEndBairro)))     
      rodape("Bairro, nao cadastrado !"," ",yellow,red) 
      return(false)      
  endif 
  if (len(cEndCep) = 0) .and. (cEndCep=replicate(" ",len(cEndCep)))     
      rodape("Cep, nao cadastrado !"," ",yellow,red) 
      return(false)      
  endif 
  if (len(cUsuTelefone) = 0) .and. (cUsuTelefone=replicate(" ",len(cUsuTelefone)))     
      rodape("Telefone, nao cadastrado !"," ",yellow,red) 
      return(false)      
  endif 
  if (len(cUsuCategoria) = 0) .and.;
     (cUsuCategoria=replicate(" ",len(cUsuCategoria)))     
      rodape("Categoria, nao cadastrada !"," ",yellow,red) 
      return(false)      
  endif 

return(true) 

/*---------------------------------------------------------------*/

/*
 Nome : SalvarUsuarios
 Descricao : procedimento que salva os dados digitados no
 formulario de usuarios.
 Parametros :
 ntipo - indica qual acao a sal
*/
procedure SalvarUsuarios(ntipo) 

if VerificaUsuarios()=true 
 if (cUsuCategoria="A") .or. (cUsuCategoria="P") .or. (cUsuCategoria="F") 
    if ntipo=1 
        fseek(UsuariosFile,nTamUsuarios*TamUsu,FS_SET)
        fatribuir(2,false)
        fwrite(UsuariosFile,@cUsuarios,TamUsu) 

        AtrvUsuarios(true) 
        RotformUsuarios(0) 
        LimpUsuarios()
    elseif ntipo=2 
        fatribuir(2,false)
        fwrite(UsuariosFile,@cUsuarios,TamUsu) 
    endif
 else
  rodape("Categoria, Cadastrada Incorretamente !"," ",yellow,red)
 endif
endif 

return
