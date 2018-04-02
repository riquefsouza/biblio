/* Modulo de Graficos */

#include "Biblio.ch"

/*
 Nome : Digita
 Descricao : Procedimento que permite ter um maior controle da digitacao
 de um texto, tambem permitindo indicar um texto maior do que o permitido
 pelo espaco limite definido.
 Parametros :
 ctexto - e o resultado da digitacao
 maxlen - indica o tamanho maximo do texto a ser digitado
 nx - posicao da coluna na tela
 ny - posicao da linha na tela
 cfg - cor do texto
 cbg - cor de fundo
 ctipo - indica o tipo de caracter a ser digitado se (N)umero ou (T)exto
*/
function Digita(ctexto,maxlen,nx,ny,cfg,cbg,ctipo)

 setcursor(SC_NORMAL)
 if valtype(ctexto)!="L" 
    if ctexto=""
       ctexto:=space(maxlen)
    else
       @ ny,nx-2 say ctexto color cfg+"/"+cbg
       ctexto:=ctexto+space(int(maxlen-len(ctexto)))
    endif
 else
    ctexto:=space(maxlen)
 endif
 if ctipo="T"
    @ ny,nx-2 get ctexto picture replicate("X",maxlen) color cfg+"/"+cbg
 elseif ctipo="N"
    @ ny,nx-2 get ctexto picture replicate("9",maxlen) color cfg+"/"+cbg
 endif
 read
 setcursor(SC_NONE)

return(alltrim(ctexto))

/*-------------------------------------------*/

/*
 Nome : formulario
 Descricao : procedimento que desenha um formulario na tela.
 Parametros :
 ctitulo - titulo do formulario
 ntopo - posicao da linha inicial na tela
 nesquerda - posicao da coluna inicial na tela
 naltura - a altura do formulario
 nlargura - a largura do formulario
 cfg - cor do texto
 cbg - cor de fundo
 csombra - o caracter que vai ser a sobra do formulario
 csfg - cor do texto da sombra
 csbg - cor de fundo da sombra
*/
procedure formulario(ctitulo,ntopo,nesquerda,;
                     naltura,nlargura,cfg,cbg,csombra,csfg,csbg)

  @ ntopo,nesquerda,ntopo+naltura,nesquerda+nlargura;
   box replicate(csombra,8) color csfg+"/"+csbg
  @ ntopo-1,nesquerda-1,naltura+ntopo-1,nlargura+nesquerda-1;
   box B_SINGLE+space(1) color cfg+"/"+cbg
  @ ntopo-1,nesquerda+1 say ctitulo color cfg+"/"+cbg 
return

/*-------------------------------------------*/

/*
 Nome : SubMenu
 Descricao : funcao que permite criar um controle de submenu, retornando
 a opcao selecionada.
 Parametros :
 nnumero - indica qual e o submenu
 nqtd - indica a quantidade de linhas do submenu
 nmaxtam - indica a largura maxima do submenu
 ntopo - posicao da linha inicial na tela
 nesquerda - posicao da coluna inicial na tela
 nultpos - indica a ultima opcao referenciada pelo usuario
 clfg - cor do texto selecionado
 clbg - cor de fundo selecionado
 cfg - cor do texto
 cbg - cor de fundo
*/
function SubMenu(nnumero,nqtd,nmaxtam,ntopo,nesquerda,nultpos,;
                 clfg,clbg,cfg,cbg)
local ncont
local ncont2

 setcolor(cfg+"/"+cbg)
 for ncont:=0 to nqtd-1 
    @ ntopo+ncont-1,nesquerda-1 say vSubMenu[nnumero,ncont+1]+;
    replicate(" ",nmaxtam-len(vSubMenu[nnumero,ncont+1]))
 next
 Etexto(nesquerda,ntopo+nultpos-1,clfg,clbg,vSubMenu[nnumero,nultpos]+;
 replicate(" ",nmaxtam-len(vSubMenu[nnumero,nultpos])))

 ncont:=nultpos-2
 ncont2:=nultpos-1

 do while true
   nKey:=inkey()

   if nkey=K_UP
       ncont--
       ncont2--
       if ncont2=-1 
          ncont:=-2
          ncont2:=nqtd-1
       endif

       Etexto(nesquerda,ntopo+ncont+2,cfg,cbg,vSubMenu[nnumero,ncont+3]+;
       replicate(" ",nmaxtam-len(vSubMenu[nnumero,ncont+3])))
       Etexto(nesquerda,ntopo+ncont2,clfg,clbg,vSubMenu[nnumero,ncont2+1]+;
       replicate(" ",nmaxtam-len(vSubMenu[nnumero,ncont2+1])))

       if ncont=-2 
          ncont:=nqtd-2
       endif

   endif

   if nKey=K_DOWN
       ncont++
       ncont2++
       if ncont2=nqtd 
          ncont2:=0
       endif

       Etexto(nesquerda,ntopo+ncont,cfg,cbg,vSubMenu[nnumero,ncont+1]+;
       replicate(" ",nmaxtam-len(vSubMenu[nnumero,ncont+1])))
       Etexto(nesquerda,ntopo+ncont2,clfg,clbg,vSubMenu[nnumero,ncont2+1]+;
       replicate(" ",nmaxtam-len(vSubMenu[nnumero,ncont2+1])))

       if ncont=nqtd-1 
          ncont:=-1
       endif

   endif

   if nKey=K_LEFT
      return(1)
   elseif nKey=K_RIGHT
      return(2)
   elseif nKey=K_RETURN
      return(ncont2+3)
   endif

 enddo

return(true)

/*-------------------------------------------*/

/*
 Nome : Menu
 Descricao : procedimento que escreve a linha de opcoes do menu.
 Parametros :
 nqtd - indica a quantidade de opcoes no menu
 ntopo - posicao da linha inicial na tela
 cfg - cor do texto
 cbg - cor de fundo
 clfg - cor do texto do primeiro caracter de cada opcao do menu
 clbg - cor de fundo do primeiro caracter de cada opcao do menu
 npos2 - indica a ultima opcao de menu referenciada pelo usuario
 cmfg - cor do texto do selecionado
 cmbg - cor de fundo do selecionado
 ncont2 - indica a ultima posicao da descricao da opcao de menu
 referenciada pelo usuario
*/
procedure Menu(nqtd,ntopo,cfg,cbg,clfg,clbg,npos2,cmfg,cmbg,ncont2)
local ncont
local npos
local nentre

   for ncont:=1 to 80 
      Etexto(ncont,ntopo,cfg,cbg," ")
   next
   npos:=0
   nentre:=0
   for ncont:=1 to nqtd 
      Etexto(npos+4+nentre,ntopo,clfg,clbg,substr(vMenu[ncont],1,1))
      Etexto(npos+5+nentre,ntopo,cfg,cbg,substr(vMenu[ncont],2,len(vMenu[ncont])))
      nentre:=nentre+3
      npos:=npos+len(vMenu[ncont])
   next
   if npos2 > 0 
      Etexto(npos2+2,ntopo,clfg,cmbg," "+substr(vMenu[ncont2],1,1))
      Etexto(npos2+4,ntopo,cmfg,cmbg,substr(vMenu[ncont2],2,len(vMenu[ncont2]))+" ")
   endif
return

/*-------------------------------------------*/

/*
 Nome : DesenhaBotao
 Descricao : procedimento que desenha um botao na tela
 Parametros :
 ntopo - posicao da linha inicial na tela
 nesquerda - posicao da coluna inicial na tela
 cfg - cor do texto
 cbg - cor de fundo
 csfg - cor do texto da sombra
 csbg - cor de fundo da sombra
 ctexto - o texto a ser escrito no botao
 lfoco - indica se o botao esta focado ou nao
*/
procedure DesenhaBotao(ntopo,nesquerda,cfg,cbg,csfg,csbg,;
                       ctexto,lfoco)
local ntam:=0
local ncont:=0

ntam:=len(ctexto)
if lfoco=false 
   Etexto(nesquerda,ntopo,cfg,cbg," "+ctexto+" ")
endif
if lfoco=true 
  Etexto(nesquerda,ntopo,cfg,cbg,chr(16)+ctexto+chr(17))
endif
Etexto(nesquerda+ntam+2,ntopo,csfg,csbg,chr(220))
for ncont:=1 to ntam+2 
  Etexto(nesquerda+ncont,ntopo+1,csfg,csbg,chr(223))
next
return

/*-------------------------------------------*/

/*
 Nome : Botao
 Descricao : funcao que realiza a acao de apertar o botao.
 Parametros :
 ntopo - posicao da linha inicial na tela
 nesquerda - posicao da coluna inicial na tela
 cfg - cor do texto
 cbg - cor de fundo
 csfg - cor do texto da sombra
 csbg - cor de fundo da sombra
 ctexto - o texto a ser escrito no botao
 lfoco - indica se o botao esta focado ou nao
*/
function Botao(ntopo,nesquerda,cfg,cbg,csfg,csbg,;
               ctexto,lfoco)
local ntam:=0
local ncont:=0

ntam:=len(ctexto)
DesenhaBotao(ntopo,nesquerda,cfg,cbg,csfg,csbg,ctexto,lfoco)

do while true

nKey:=inkey()

if lfoco=true
  if nKey=K_RETURN
      Etexto(nesquerda+1,ntopo,cfg,cbg,chr(16)+ctexto+chr(17))
      Etexto(nesquerda,ntopo,csfg,csbg," ")
      for ncont:=1 to ntam+2 
        Etexto(nesquerda+ncont,ntopo+1,csfg,csbg," ")
      next
      inkey(1)
      return(2)
  endif
endif

if nKey=K_TAB
  return(1)
endif

enddo

return(true)

/*-------------------------------------------*/

/*
 Nome : DesenhaLista
 Descricao : procedimento que desenha uma Lista rolavel na tela
 Parametros :
 ntipo - indica o numero de qual arquivo a ser aberto
 ntopo - posicao da linha inicial na tela
 nesquerda - posicao da coluna inicial na tela
 naltura - indica a altura da lista
 nlargura - indica a largura da lista
 cfg - cor do texto
 cbg - cor de fundo
 npos - indica a ultima posicao da linha da lista na tela
 ncol - indica a ultima posicao da coluna da lista na tela
 lfoco - indica se a lista esta focada ou nao
*/
procedure DesenhaLista(ntipo,ntopo,nesquerda,naltura,nlargura,;
                       cfg,cbg,npos,ncol,lfoco)
local ncont:=0
local cposicao
local ccoluna
local csLista

if lfoco=true 
   Etexto(nesquerda-1,ntopo-1,cfg,cbg,"Ú")
   Etexto(nesquerda+nlargura+1,ntopo-1,cfg,cbg,"¿")
   Etexto(nesquerda-1,ntopo+naltura,cfg,cbg,"À")
   Etexto(nesquerda+nlargura+1,ntopo+naltura,cfg,cbg,"Ù")
else
   Etexto(nesquerda-1,ntopo-1,cfg,cbg," ")
   Etexto(nesquerda+nlargura+1,ntopo-1,cfg,cbg," ")
   Etexto(nesquerda-1,ntopo+naltura,cfg,cbg," ")
   Etexto(nesquerda+nlargura+1,ntopo+naltura,cfg,cbg," ")
endif
AbrirArquivo(ntipo)
csLista:=TiposLista(ntipo,nlargura,npos+1,ncol+1)
Etexto(nesquerda,ntopo,cfg,cbg,csLista+replicate(" ",nlargura-len(csLista)))
for ncont:=1 to naltura-2 
  csLista:=TiposLista(ntipo,nlargura,npos+ncont+1,ncol+1)
  Etexto(nesquerda,ntopo+ncont,cfg,cbg,csLista+;
  replicate(" ",nlargura-len(csLista)))
next
csLista:=TiposLista(ntipo,nlargura,npos+naltura,ncol+1)
Etexto(nesquerda,ntopo+naltura-1,cfg,cbg,csLista+;
Replicate(" ",nlargura-len(csLista)))

cposicao:=alltrim(str(npos+1))
Etexto(nesquerda,ntopo+naltura+1,cfg,cbg,"Linha : "+;
replicate("0",4-len(cposicao))+cposicao)
ccoluna:=alltrim(str(ncol+1))
Etexto(nesquerda+14,ntopo+naltura+1,cfg,cbg,"Coluna : "+;
replicate("0",4-len(ccoluna))+ccoluna)

return

/*-------------------------------------------*/

/*
 Nome : TiposLista
 Descricao : funcao que indica quais arquivos serao usados com a lista,
 como tambem a formatacao do cabecalho desses arquivos na lista
 Parametros :
 ntipo - indica o numero de qual arquivo a ser aberto
 nlargura - indica a largura do texto
 npos - indica a posicao do texto na lista
 ncol - indica a posicao da coluna do texto na lista
*/
function TiposLista(ntipo,nlargura,npos,ncol)
local sAux

if ntipo=1 
    if npos=1 
        sAux:="Numero de Inscricao ³ Titulo                         ³ "
        sAux:=sAux+"Autor                          ³ "
        sAux:=sAux+"Area                           ³ Palavra-Chave ³ "
        sAux:=sAux+"Edicao ³ Ano de Publicacao ³ "
        sAux:=sAux+"Editora                        ³ Volume ³ Estado Atual"
        return(substr(sAux,ncol,nlargura))
    endif
    if npos=2
      return(replicate("-",nlargura))
    endif
    if npos > 2 
      if nTamLivros > (npos-3) 
        fseek(LivrosFile,(npos-3)*TamLiv,FS_SET)
        cLivros:=space(TamLiv)
        fread(LivrosFile,@cLivros,TamLiv)
        fatribuir(1,true)

          cS:=alltrim(str(nLivNinsc))
          sAux:=replicate(" ",19-len(cS))+cS+" ³ "
          sAux:=sAux+cLivTitulo+replicate(" ",31-len(cLivTitulo))+"³ "
          sAux:=sAux+cLivAutor+replicate(" ",31-len(cLivAutor))+"³ "
          sAux:=sAux+cLivArea+replicate(" ",31-len(cLivArea))+"³ "
          sAux:=sAux+cLivPchave+replicate(" ",14-len(cLivPchave))+"³ "
          cS:=alltrim(Str(nLivEdicao))
          sAux:=sAux+replicate(" ",6-len(cS))+cS+" ³ "
          cS:=alltrim(Str(nLivAnoPubli))
          sAux:=sAux+replicate(" ",17-len(cS))+cS+" ³ "
          sAux:=sAux+cLivEditora+replicate(" ",31-len(cLivEditora))+"³ "
          cS:=alltrim(Str(nLivVolume))
          sAux:=sAux+replicate(" ",6-len(cS))+cS+" ³ "
          if cLivEstado="D" 
             sAux:=sAux+"Disponivel"
          else
             sAux:=sAux+"Emprestado"
          endif
         
         return(substr(sAux,ncol,nlargura))
      else
         return("")
      endif
    endif

elseif ntipo=2 
    if npos=1 
        sAux:="Numero de Inscricao ³ Nome                           ³ "
        sAux:=sAux+"Identidade ³ Logradouro                     ³ "
        sAux:=sAux+"Numero ³ Complemento ³ "
        sAux:=sAux+"Bairro               ³ Cep      ³ "
        sAux:=sAux+"Telefone    ³ Categoria   ³ Situacao"
        return(substr(sAux,ncol,nlargura))
    endif
    if npos=2 
      return(replicate("-",nlargura))
    endif
    if npos > 2 
      if nTamUsuarios > (npos-3) 
        fseek(UsuariosFile,(npos-3)*TamUsu,FS_SET)
        cUsuarios:=space(TamUsu)
        fread(UsuariosFile,@cUsuarios,TamUsu)
        fatribuir(2,true)

          cS:=alltrim(str(nUsuNinsc))
          sAux:=replicate(" ",19-len(cS))+cS+" ³ "
          sAux:=sAux+cUsuNome+replicate(" ",31-len(cUsuNome))+"³ "
          sAux:=sAux+replicate(" ",10-len(cUsuIdent))+cUsuIdent+" ³ "
          sAux:=sAux+cEndlogra+replicate(" ",31-len(cEndlogra))+"³ "
          cS:=alltrim(str(nEndnumero))
          sAux:=sAux+replicate(" ",6-len(cS))+cS+" ³ "
          sAux:=sAux+cEndcompl+replicate(" ",12-len(cEndcompl))+"³ "
          sAux:=sAux+cEndBairro+replicate(" ",21-len(cEndBairro))+"³ "
          sAux:=sAux+replicate(" ",8-len(cEndCep))+cEndCep+" ³"
          sAux:=sAux+replicate(" ",12-len(cUsuTelefone))+cUsuTelefone+" ³ "
          if cUsuCategoria="A" 
             sAux:=sAux+"Aluno"+replicate(" ",12-len("Aluno"))+"³ "
          elseif cUsuCategoria="P" 
             sAux:=sAux+"Professor"+replicate(" ",12-len("Professor"))+"³ "
          elseif cUsuCategoria="F" 
             sAux:=sAux+"Funcionario"+;
             replicate(" ",12-len("Funcionario"))+"³ "
          endif
          cS:=alltrim(str(nUsuSituacao))
          sAux:=sAux+replicate(" ",8-len(cS))+cS

         return(substr(sAux,ncol,nlargura))
      else
         return("")
      endif
     endif
  
elseif ntipo=3 
    if npos=1 
        sAux:="Numero de Inscricao do Usuario ³ "
        sAux:=sAux+"Numero de Inscricao do Livro ³ "
        sAux:=sAux+"Data do Emprestimo ³ Data da Devolucao ³ "
        sAux:=sAux+"Removido"
        return(substr(sAux,ncol,nlargura))
    endif
    if npos=2 
      return(replicate("-",nlargura))
    endif
    if npos > 2 
      if nTamEmprestimos > (npos-3)        
        fseek(EmprestimosFile,(npos-3)*TamEmp,FS_SET)
        cEmprestimos:=space(TamEmp)
        fread(EmprestimosFile,@cEmprestimos,TamEmp)
        fatribuir(3,true)

          cS:=""
          cS:=alltrim(str(nEmpNinscUsuario))
          sAux:=replicate(" ",30-len(cS))+cS+" ³ "
          cS:=alltrim(str(nEmpNinscLivro))
          sAux:=sAux+replicate(" ",28-len(cS))+cS+" ³ "
          sAux:=sAux+cEmpDtEmprestimo+replicate(" ",19-len(cEmpDtEmprestimo))+"³ "
          sAux:=sAux+cEmpDtDevolucao+replicate(" ",18-len(cEmpDtDevolucao))+"³ "
          if lEmpRemovido=true 
             sAux:=sAux+"Sim"
          else
             sAux:=sAux+"Nao"
          endif
         return(substr(sAux,ncol,nlargura))

      else
         return("")
      endif
     endif
  
elseif ntipo=4 
    return(substr(vLista[npos],ncol,len(vLista[npos])))
endif

return("")

/*-------------------------------------------*/

/*
 Nome : Lista
 Descricao : funcao que executa a acao de rolamento da lista.
 Parametros :
 ntipo - indica o numero de qual arquivo a ser aberto
 ntopo - posicao da linha inicial na tela
 nesquerda - posicao da coluna inicial na tela
 nlargura - indica a largura da lista
 ntlinhas - indica o numero total de linhas da lista
 ntcolunas - indica o numero total de colunas da lista
 cfg - cor do texto
 cbg - cor de fundo
 nlistapos - indica a ultima posicao da linha da lista na tela
 nlitacol - indica a ultima posicao da coluna da lista na tela
 lfoco - indica se a lista esta focada ou nao
*/
function Lista(ntipo,ntopo,nesquerda,naltura,nlargura,ntlinhas,ntcolunas,;
               cfg,cbg,lfoco)
local ncont2:=0
local cposicao
local ccoluna
local csLista

DesenhaLista(ntipo,ntopo,nesquerda,naltura,nlargura,cfg,cbg,;
nListapos,nListacol,lfoco)

do while true

nKey:=inkey()

  if nKey=K_UP 
     if nListapos > 0 
         nListapos--
         for ncont2:=0 to naltura-1 
              csLista:=TiposLista(ntipo,nlargura,nListapos+ncont2+1,nlistacol+1)
              Etexto(nesquerda,ntopo+ncont2,cfg,cbg,csLista+;
              replicate(" ",nlargura-len(csLista)))
         next
         cposicao:=alltrim(str(nlistapos+1))
         Etexto(nesquerda,ntopo+naltura+1,cfg,cbg,"Linha : "+;
         replicate("0",4-len(cposicao))+cposicao)
     endif
  endif

  if nKey=K_DOWN
     if nListapos < (ntlinhas-naltura) 
         nListapos++
         for ncont2:=0 to naltura-1 
             csLista:=TiposLista(ntipo,nlargura,nListapos+ncont2+1,nlistacol+1)
             Etexto(nesquerda,ntopo+ncont2,cfg,cbg,csLista+;
             replicate(" ",nlargura-len(csLista)))
         next
         cposicao:=alltrim(str(nlistapos+1))
         Etexto(nesquerda,ntopo+naltura+1,cfg,cbg,"Linha : "+;
         replicate("0",4-len(cposicao))+alltrim(cposicao))
     endif
  endif

  if nKey=K_RIGHT
     if nListacol < (ntcolunas-nlargura) 
         nlistacol++
         for ncont2:=0 to naltura-1 
            csLista:=TiposLista(ntipo,nlargura,nListapos+ncont2+1,nListacol+1)
            Etexto(nesquerda,ntopo+ncont2,cfg,cbg,csLista+;
            replicate(" ",nlargura-len(csLista)))
         next
         ccoluna:=alltrim(str(nlistacol+1))
         Etexto(nesquerda+14,ntopo+naltura+1,cfg,cbg,"Coluna : "+;
         replicate("0",4-len(ccoluna))+ccoluna)
     endif
  endif

  if nKey=K_LEFT
     if nListacol > 0 
         nlistacol--
         for ncont2:=0 to naltura-1 
            csLista:=TiposLista(ntipo,nlargura,nListapos+ncont2+1,nListacol+1)
            Etexto(nesquerda,ntopo+ncont2,cfg,cbg,csLista+;
            replicate(" ",nlargura-len(csLista)))
         next
         ccoluna:=alltrim(str(nlistacol+1))
         Etexto(nesquerda+14,ntopo+naltura+1,cfg,cbg,"Coluna : "+;
         replicate("0",4-len(ccoluna))+ccoluna)
     endif
  endif

   if nKey=K_TAB
      return(1)
   endif
enddo 

return(true)

/*-----------------------------------------------------*/

/*
 Nome : formSplash
 Descricao : procedimento que desenha a tela inicial do sistema.
*/
procedure formSplash()
  setcursor(SC_NONE)
  formulario("",6,10,12,58,white,blue,"±",lightgray,black)
  Etexto(13, 8,yellow,blue," ²²²²²²²     ²    ²²²²²²²     ²       ²    ²²²²²² ")
  Etexto(13, 9,yellow,blue,"²²²    ²²²   ²²  ²²²    ²²²   ²²      ²²  ²²²  ²²²")
  Etexto(13,10,yellow,blue,"²²²²²²²²²    ²²  ²²²²²²²²²    ²²      ²²  ²²    ²²")
  Etexto(13,11,yellow,blue,"²²²    ²²²   ²²  ²²²    ²²²   ²²²     ²²  ²²    ²²")
  Etexto(13,12,yellow,blue,"²²²²   ²²²   ²²  ²²²²   ²²²   ²²²²    ²²  ²²²  ²²²")
  Etexto(13,13,yellow,blue," ²²²²²²²²²   ²²   ²²²²²²²²²   ²²²²²²  ²²   ²²²²²² ")
  Etexto(12,15,yellow,blue,"Programa Desenvolvido por Henrique Figueiredo de Souza")
  Etexto(12,16,yellow,blue,"Todos os Direito Reservados - 1999  Versao 1.0")
  Etexto(12,17,yellow,blue,"Linguagem Usada Nesta Versao << CLIPPER >>")
  inkey(2)
return

