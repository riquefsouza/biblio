/***************Modulo de Emprestimos e Devolucoes*******************/

#include "Biblio.ch"

/*
 Nome : PesEmprestimos
 Descricao : funcao que pesquisa as informacoes contidas no arquivo de
 Emprestimos.
 Parametros :
 nCodUsuario - codigo do campo de numero de inscricao do usuario
 nCodLivro - codigo do campo de numero de inscricao do livro
*/
function PesEmprestimos(nCodUsuario,nCodLivro)
local nPosicao
local bFlag
local nRet

fseek(EmprestimosFile,0,FS_SET) 
nPosicao:=0 
bFlag:=false 
do while (.Not.(nTamEmprestimos=nPosicao))
   cEmprestimos:=space(TamEmp)
   fread(EmprestimosFile,@cEmprestimos,TamEmp)
   fatribuir(3,true)

   if (nEmpNinscUsuario=nCodUsuario) .and. (nEmpNinscLivro=nCodLivro) 
      nRet:=nPosicao 
      fseek(EmprestimosFile,nPosicao*TamEmp,FS_SET)
      bFlag:=true 
      exit 
   endif 
   nPosicao++
enddo 
 if (nTamEmprestimos=nPosicao) .and. (bFlag=false)
    nEmpNinscUsuario:=nCodUsuario
    nEmpNinscLivro:=nCodLivro
    return(-1)
 endif
return(nRet)

/*-----------------------------------------------------*/

/*
 Nome : formEmprestimos
 Descricao : procedimento que desenha o formulario de Emprestimos
 na tela, e tambem indica qual acao a tomar.
 Parametros :
 ntipo - indica qual a acao do formulario
 ctitulo - o titulo do formulario
 crod - o texto do rodape sobre o formulario
*/
procedure formEmprestimos(ntipo,ctitulo,crod) 

  teladefundo("±",white,lightblue) 
  rodape(crod," ",white,blue)   
  formulario(chr(180)+ctitulo+chr(195),4,2,18,76,white,blue,"±",lightgray,black) 

  vEmprestimos[1]:=replicate(" ",5) 
  AtrvEmprestimos(true) 
  AbrirArquivo(1) 
  AbrirArquivo(2) 
  AbrirArquivo(3) 
  if ntipo=1 
     RotformEmprestimos(1,0) 
     DesenhaBotao(20,45,black,lightgray,black,blue," Emprestar ",false) 
     DesenhaBotao(20,60,black,lightgray,black,blue," Fechar ",false) 
  endif 
  if ntipo=2 
     RotformEmprestimos(2,0) 
     DesenhaBotao(20,45,black,lightgray,black,blue," Devolver ",false) 
     DesenhaBotao(20,60,black,lightgray,black,blue," Fechar ",false) 
  endif 
  if ntipo=3 
     DesenhaBotao(20,60,black,lightgray,black,blue," Fechar ",false)
  endif

  LimpEmprestimos() 
  if ntipo=1 
     CformEmprestimos("1",1,0,0,crod,false)  /* Emprestar */
  elseif ntipo=2 
     CformEmprestimos("1",2,0,0,crod,false)  /* Devolver */
  elseif ntipo=3 
     CformEmprestimos("2",3,0,0,crod,true)   /* consultar todos */
  endif
return

/*-------------------------------------------*/

/*
 Nome : LimpEmprestimos()
 Descricao : procedimento limpa as iaveis do registro de Emprestimos.
*/
procedure LimpEmprestimos() 
     nEmpNinscUsuario:=0 
     nEmpNinscLivro:=0 
     cEmpDtEmprestimo:=RetDataAtual() 
     /*cEmpDtDevolucao:=RetDataAtual() */
     lEmpRemovido:=false 
return

/*-------------------------------------------*/

/*
 Nome : RotformEmprestimos
 Descricao : procedimento que escreve os rotulos do formulario de
 Emprestimos.
 Parametros :
 ntipo - indica qual a acao do formulario
 nl - indica um acrescimo na linha do rotulo
*/
procedure RotformEmprestimos(ntipo,nl) 

if (ntipo=1) .or. (ntipo=2)
  Etexto(5,6+nl,white,blue,"Numero de Inscricao do Usuario : ") 
  Etexto(38,6+nl,black,lightgray,vEmprestimos[1]) 
  Etexto(5,8+nl,white,blue,"Usuario : ") 
  Etexto(16,8+nl,black,lightgray,replicate(" ",30)) 
  Etexto(49,8+nl,white,blue,"Categoria : ") 
  Etexto(5,10+nl,white,blue,"Numero de Inscricao do Livro : ") 
  Etexto(36,10+nl,black,lightgray,vEmprestimos[2]) 
  Etexto(5,12+nl,white,blue,"Livro : ") 
  Etexto(13,12+nl,black,lightgray,replicate(" ",30)) 
  Etexto(46,12+nl,white,blue,"Estado : ") 
  Etexto(5,14+nl,white,blue,"Data do Emprestimo : ") 
  Etexto(27,14+nl,black,lightgray,vEmprestimos[3]) 
  Etexto(40,14+nl,white,blue,"Data de Devolucao : ") 
  Etexto(61,14+nl,black,lightgray,vEmprestimos[4]) 
endif 
if ntipo=2 
  Etexto(5,16+nl,white,blue,"Dias em Atraso : ") 
  Etexto(23,16+nl,black,lightgray,replicate(" ",4)) 
  Etexto(31,16+nl,white,blue,"Multa por dias em atraso : ") 
  Etexto(59,16+nl,black,lightgray,replicate(" ",7)) 
endif 
return
/*-------------------------------------------*/

/*
 Nome : CformEmprestimos
 Descricao : procedimento que realiza todo o controle de manuseio do
 formulario de Emprestimos.
 Parametros :
 ctipo - indica qual a acao do formulario
 ntipo2 - indica a acao original do formulario nao manipulado pela funcao
 npos - indica a ultima posicao da linha da lista de emprestimos
 ncol - indica a ultima posicao da coluna da lista de emprestimos
 crod - o texto do rodape sobre o formulario
 lfoco - se os objetos do formulario estao focados ou nao
*/
procedure CformEmprestimos(ctipo,ntipo2,npos,ncol,crod,lfoco) 
local sDiasAtraso
local sMulta
local nDiasAtraso
local nMulta
local nop

if ctipo="1" 
  cS:=""
  rodape(""," ",white,blue)
  Etexto(61,8,white,blue,"")
  Etexto(55,12,white,blue,"")
  Etexto(23,16,black,lightgray,"")
  Etexto(59,16,black,lightgray,"")
  cS:=Digita(cS,5,39,5,black,lightgray,"N")
  I:=Val(cS)
  nUsuNinsc:=I
  nEmpNinscUsuario:=I
  if (len(cS) > 0) .and. (cS<>replicate(" ",len(cS))) 
    if PesUsuarios("N","Ninsc",I,"",0)<>-1 
      Etexto(16,8,black,lightgray,cUsuNome)
      if cUsuCategoria="F" 
         Etexto(61,8,white,blue,"Funcionario")
      elseif cUsuCategoria="A" 
         Etexto(61,8,white,blue,"Aluno      ")
      elseif cUsuCategoria="P" 
         Etexto(61,8,white,blue,"Professor  ")
      endif
      cS:=""
      cS:=Digita(cS,5,37,9,black,lightgray,"N")
      I:=Val(cS)
      nLivNinsc:=I
      nEmpNinscLivro:=I
      if (len(cS) > 0) .and. (cS<>replicate(" ",len(cS))) 
        if PesLivros("N","Ninsc",I,"",0)<>-1 
           Etexto(13,12,black,lightgray,cLivTitulo)
           if cLivEstado="D" 
             Etexto(55,12,white,blue,"Disponivel")
           else
             Etexto(55,12,white,blue,"Emprestado")
           endif

           /* Emprestimo */

           if tipo2=1 
              if cLivEstado="D" 
                if cUsuSituacao < 4 
                   if cUsuCategoria="F" 
                     cEmpDtDevolucao:=SomaDias(RetDataAtual,7)
                   elseif cUsuCategoria="A" 
                     cEmpDtDevolucao:=SomaDias(RetDataAtual,14)
                   elseif cUsuCategoria="P" 
                     cEmpDtDevolucao:=SomaDias(RetDataAtual,30)
                   endif
                   cEmpDtEmprestimo:=RetDataAtual
                   nUsuSituacao++
                   cLivEstado:="E"
                   Etexto(27,14,black,lightgray,cEmpDtEmprestimo)
                   Etexto(61,14,black,lightgray,cEmpDtDevolucao)
                   CformEmprestimos("Emprestar",ntipo2,npos,ncol,crod,true)
                else
                   rodape("Usuario com 4 livros em sua posse, Impossivel "+;
                   "Efetuar Emprestimo !"," ",yellow,red)
                   CformEmprestimos("Fechar",ntipo2,npos,ncol,crod,true)
                endif
              else
                rodape("O livro ja esta emprestado, Impossivel "+;
                "Efetuar Emprestimo !"," ",yellow,red)
                CformEmprestimos("Fechar",ntipo2,npos,ncol,crod,true)
              endif
             /* Devolucao */
           elseif tipo2=2 
              if PesEmprestimos(nUsuNinsc,nLivNinsc)<>-1 
                 if cLivEstado="E" 
                   if ((nUsuSituacao >= 1) .and. (nUsuSituacao <= 4)) 
                      if ConverteData(cEmpDtDevolucao) < ConverteData(RetDataAtual) 
                         nDiasAtraso:=0
                         nMulta:=0.0
                         nDiasAtraso:=SubtraiDatas(cEmpDtDevolucao,RetDataAtual)
                         nMulta:=(0.5 * nDiasAtraso)
                      else
                         nDiasAtraso:=0
                         nMulta:=0.0
                      endif
                      sDiasAtraso:=alltrim(str(nDiasAtraso))
                      sMulta:=alltrim(str(nMulta))
                      Etexto(27,14,black,lightgray,cEmpDtEmprestimo)
                      Etexto(61,14,black,lightgray,cEmpDtDevolucao)
                      Etexto(23,16,black,lightgray,sDiasAtraso)
                      Etexto(59,16,black,lightgray,sMulta)
                      nUsuSituacao--
                      cLivEstado:="D"
                      CformEmprestimos("Devolver",ntipo2,npos,ncol,crod,true)
                   else
                     rodape("Usuario com 0 livros em sua posse, Impossivel "+;
                     "Efetuar Devolucao !"," ",yellow,red)
                     CformEmprestimos("Fechar",ntipo2,npos,ncol,crod,true)
                   endif
                 else
                   rodape("O livro ja esta disponivel, Impossivel "+;
                   "Efetuar Devolucao !"," ",yellow,red)
                   CformEmprestimos("Fechar",ntipo2,npos,ncol,crod,true)
                 endif
               else
                 rodape("Emprestimo inexistente, Impossivel "+;
                 "Efetuar Devolucao !"," ",yellow,red)
                 CformEmprestimos("Fechar",ntipo2,npos,ncol,crod,true)
               endif
           endif
             /* --- */
        else
          S:=alltrim(str(I))
          AtrvEmprestimos(true)
          RotformEmprestimos(ntipo2,0)
          rodape("Numero de Inscricao do Livro, nao encontrado !",;
          " ",yellow,red)
          CformEmprestimos("Fechar",ntipo2,npos,ncol,crod,true)
        endif
      else
        CformEmprestimos("Fechar",ntipo2,npos,ncol,crod,true)
      endif
    else
      S:=alltrim(str(I))
      AtrvEmprestimos(true)
      RotformEmprestimos(ntipo2,0)
      rodape("Numero de Inscricao do Usuario, nao encontrado !",;
      " ",yellow,red)
      CformEmprestimos("Fechar",ntipo2,npos,ncol,crod,true)
    endif
  else
    CformEmprestimos("Fechar",ntipo2,npos,ncol,crod,true)
  endif
elseif ctipo="2" 
   nListapos=npos
   nListacol=ncol
   if lista(3,6,5,13,70,nTamEmprestimos+2,113,white,blue,lfoco)=1 
        desenhalista(3,6,5,13,70,white,blue,npos,ncol,false) 
        CformEmprestimos("Fechar",ntipo2,npos,ncol,crod,true) 
   endif 
elseif ctipo="Emprestar" 
    nop:=Botao(20,45,black,lightgray,black,blue," Emprestar ",lfoco)
    do case
      case nop=1
          DesenhaBotao(20,45,black,lightgray,black,blue," Emprestar ",false) 
          CformEmprestimos("Fechar",ntipo2,npos,ncol,crod,true) 
      case nop=2
          if PesEmprestimos(nUsuNinsc,nLivNinsc)<>-1 
            lEmpRemovido:=false
            SalvarEmprestimos(2)
          else
            lEmpRemovido:=false
            nTamEmprestimos:=fseek(EmprestimosFile,0,FS_END)
            nTamEmprestimos:=int(nTamEmprestimos / TamEmp)
            fseek(EmprestimosFile,0,FS_SET)
            SalvarEmprestimos(1)
          endif
          DesenhaBotao(20,45,black,lightgray,black,blue," Emprestar ",false) 
          CformEmprestimos("Fechar",ntipo2,npos,ncol,crod,true) 
    endcase 
elseif ctipo="Devolver" 
    nop:=Botao(20,45,black,lightgray,black,blue," Devolver ",lfoco)
    do case
      case nop=1
          DesenhaBotao(20,45,black,lightgray,black,blue," Devolver ",false) 
          CformEmprestimos("Fechar",ntipo2,npos,ncol,crod,true) 
      case nop=2
          lEmpRemovido:=true 
          SalvarEmprestimos(2) 
          DesenhaBotao(20,45,black,lightgray,black,blue," Devolver ",false) 
          CformEmprestimos("Fechar",ntipo2,npos,ncol,crod,true) 
    endcase 
elseif ctipo = "Fechar" 
    nop:=Botao(20,60,black,lightgray,black,blue," Fechar ",lfoco)
    do case
      case nop=1
          DesenhaBotao(20,60,black,lightgray,black,blue," Fechar ",false) 
          if (ntipo2=1) .or. (ntipo2=2) 
            CformEmprestimos("1",ntipo2,npos,ncol,crod,true)
          elseif ntipo2=3 
            CformEmprestimos("2",ntipo2,npos,ncol,crod,true)
          endif
      case nop=2
         rodape(""," ",white,blue) 
         fclose(LivrosFile) 
         fclose(UsuariosFile) 
         fclose(EmprestimosFile) 
    endcase 
endif 

return

/*-------------------------------------------------------*/

/*
 Nome : AtrvEmprestimos
 Descricao : procedimento que atribui ou limpa o vetor de Emprestimos.
 Parametros :
 llimpar - indica se vai limpar ou atribuir os vetores
*/
procedure AtrvEmprestimos(llimpar) 

if llimpar=false 
  vEmprestimos[3]:=cEmpDtEmprestimo 
  vEmprestimos[4]:=cEmpDtDEvolucao 
else
  vEmprestimos[2]:=replicate(" ",5) 
  vEmprestimos[3]:=replicate(" ",10) 
  vEmprestimos[4]:=replicate(" ",10) 
endif

return

/*-------------------------------------------------------*/

/*
 Nome : SalvarEmprestimos
 Descricao : procedimento que salva os dados digitados no
 formulario de emprestimos.
 Parametros :
 ntipo - indica qual acao a sal
*/
procedure SalvarEmprestimos(ntipo) 

    fatribuir(1,false)
    fwrite(LivrosFile,@cLivros,TamLiv) 
    fatribuir(2,false)
    fwrite(UsuariosFile,@cUsuarios,TamUsu) 
    if ntipo=1 
        fseek(EmprestimosFile,nTamEmprestimos*TamEmp,FS_SET)
        fatribuir(3,false)
        fwrite(EmprestimosFile,@cEmprestimos,TamEmp) 
        AtrvEmprestimos(true) 
        RotformEmprestimos(1,0) 
    elseif ntipo=2 
        fatribuir(3,false)
        fwrite(EmprestimosFile,@cEmprestimos,TamEmp) 
        AtrvEmprestimos(true) 
        RotformEmprestimos(1,0) 
    endif 
return
