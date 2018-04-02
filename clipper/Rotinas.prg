/* Modulo de Rotinas */

#include "Biblio.ch"

/*
 Nome : Center
 Descricao : Procedimento que centraliza um texto na tela.
 Parametros :
 ny - posicao de linha na tela
 cs - texto a ser centralizado
 cfg - cor do texto
 cbg - cod de fundo
*/
procedure center(ny,cs,cfg,cbg)
local nx:=0

 nx:=int(40-(len(cs) / 2))
 etexto(nx,ny,cfg,cbg,cs)
return

/*------------------------------------------*/

/*
 Nome : Beep
 Descricao : Procedimento que gera um beep.
 Parametros :
 nfreq - frequencia do beep.
 ntime - duracao do beep.
*/
procedure beep(nfreq,ntime)
 tone(nfreq,ntime)
return

/*-------------------------------------------*/

/*
 Nome : Etexto
 Descricao : procedimento que escreve o texto na tela com determinada cor.
 Parametros :
 nc - posicao de coluna do texto
 nl - posicao de linha do texto
 cfg - cor do texto
 cbg - cor de fundo
 ctexto - o texto a ser escrito
*/
procedure Etexto(nc,nl,cfg,cbg,ctexto)
 @ nl-1,nc-1 say ctexto color cfg+"/"+cbg
return

/*-------------------------------------------*/

/*
 Nome : Teladefundo
 Descricao : procedimento que desenha os caracteres do fundo da tela.
 Parametros :
 ctipo - o caracter a ser escrito no fundo
 cfg - cor do texto
 cbg - cor de fundo
*/
procedure TeladeFundo(ctipo,cfg,cbg)
local nl:=0
local nc:=0

for nl:=3 to 24 
  for nc:=1 to 80 
    etexto(nc,nl,cfg,cbg,ctipo)
  next
next
return

/*-------------------------------------------*/

/*
 Nome : cabecalho
 Descricao : procedimento que escreve o texto de cabecalho do sistema.
 Parametros :
 ctexto - o texto a ser escrito
 ctipo - o caracter de fundo.
 cfg - cor do texto
 cbg - cor de fundo
*/
procedure cabecalho(ctexto,ctipo,cfg,cbg)
local nc:=0

for nc:=1 to 80 
  Etexto(nc,1,cfg,cbg,ctipo)
next
center(1,ctexto,cfg,cbg)
return

/*-------------------------------------------*/

/*
 Nome : rodape
 Descricao : procedimento que escreve o texto no rodape da tela.
 Parametros :
 ctexto - o texto a ser escrito
 ctipo - o caracter de fundo.
 cfg - cor do texto
 cbg - cor de fundo
*/
procedure rodape(ctexto,ctipo,cfg,cbg)
local nc:=0

for nc:=1 to 80 
  Etexto(nc,25,cfg,cbg,ctipo)
next
center(25,ctexto,cfg,cbg)
return

/*-------------------------------------------*/

/*
 Nome : DatadoSistema
 Descricao : procedimento que escreve a data do sistema na tela.
 Parametros :
 nl - posicao da linha na tela
 nc - posicao da coluna na tela
 cfg - cor do texto
 cbg - cor de fundo
*/
procedure DatadoSistema(nl,nc,cfg,cbg)
local  dias:={"Domingo","Segunda","Terca",;
       "Quarta","Quinta","Sexta","Sabado"}
local cdw

  do case
     case cdow(Date())="Sunday"
          cdw:=dias[1]
     case cdow(Date())="Monday"
          cdw:=dias[2]
     case cdow(Date())="Tuesday"
          cdw:=dias[3]
     case cdow(Date())="Wednesday"
          cdw:=dias[4]
     case cdow(Date())="Thursday"
          cdw:=dias[5]
     case cdow(Date())="Friday"
          cdw:=dias[6]
     case cdow(Date())="Saturday"
          cdw:=dias[7]
  endcase

  Etexto(nc,nl,cfg,cbg, cdw+", "+dtoc(date()))
return

/*-------------------------------------------*/

/*
 Nome : HoradoSistema
 Descricao : procedimento que escreve a Hora do sistema na tela.
 Parametros :
 nl - posicao da linha na tela
 nc - posicao da coluna na tela
 cfg - cor do texto
 cbg - cor de fundo
*/
procedure HoradoSistema(nl,nc,cfg,cbg)
  etexto(nc,nl,cfg,cbg,time())
return

/*-----------------------------------------------------*/

/*
 Nome : fAtribuir
 Descricao : procedimento atribui os dados tanto na string de buffer
 como tambem nas variaves do registro especifico
 Parametros :
 ntipo - indica o numero do registro
 ltipo - indica se vai atribuir ou nao
*/
procedure fAtribuir(nTipo,ltipo)
if nTipo=1
 if lTipo=true
   if len(cLivros) > 0
     nLivNinsc:=val(alltrim(substr(cLivros,1,5)))
     cLivTitulo:=alltrim(substr(cLivros,6,30))   
     cLivAutor:=alltrim(substr(cLivros,36,30))   
     cLivArea:=alltrim(substr(cLivros,66,30))    
     cLivPChave:=alltrim(substr(cLivros,96,10))  
     nLivEdicao:=val(alltrim(substr(cLivros,106,4)))  
     nLivAnoPubli:=val(alltrim(substr(cLivros,110,4)))
     cLivEditora:=alltrim(substr(cLivros,114,30))
     nLivVolume:=val(alltrim(substr(cLivros,144,4)))
     cLivEstado:=alltrim(substr(cLivros,148,1))      
   endif
 else
     cLivros:=alltrim(str(nLivNinsc))+replicate(" ",5-len(alltrim(str(nLivNinsc))))+;
     cLivTitulo+replicate(" ",30-len(cLivTitulo))+;
     cLivAutor+replicate(" ",30-len(cLivAutor))+;
     cLivArea+replicate(" ",30-len(cLivArea))+;
     cLivPChave+replicate(" ",10-len(cLivPChave))+;
     alltrim(str(nLivEdicao))+replicate(" ",4-len(alltrim(str(nLivEdicao))))+;
     alltrim(str(nLivAnoPubli))+replicate(" ",4-len(alltrim(str(nLivAnoPubli))))+;
     cLivEditora+replicate(" ",30-len(cLivEditora))+;
     alltrim(str(nLivVolume))+replicate(" ",4-len(alltrim(str(nLivVolume))))+;
     cLivEstado+chr(13)+chr(10)
 endif
elseif nTipo=2
 if lTipo=true
   if len(cUsuarios) > 0
     nUsuNinsc:=val(alltrim(substr(cUsuarios,1,5)))
     cUsuNome:=alltrim(substr(cUsuarios,6,30))  
     cUsuIdent:=alltrim(substr(cUsuarios,36,10)) 

     cEndLogra:=alltrim(substr(cUsuarios,46,30)) 
     nEndNumero:=val(alltrim(substr(cUsuarios,76,5))) 
     cEndCompl:=alltrim(substr(cUsuarios,81,10))
     cEndBairro:=alltrim(substr(cUsuarios,91,20))
     cEndCep:=alltrim(substr(cUsuarios,111,8))    

     cUsuTelefone:=alltrim(substr(cUsuarios,119,11))
     cUsuCategoria:=alltrim(substr(cUsuarios,130,1))
     nUsuSituacao:=val(alltrim(substr(cUsuarios,131,1)))        
   endif
 else
     cUsuarios:=alltrim(str(nUsuNinsc))+replicate(" ",5-len(alltrim(str(nUsuNinsc))))+;
     cUsuNome+replicate(" ",30-len(cUsuNome))+;
     cUsuIdent+replicate(" ",10-len(cUsuIdent))+;
     cEndLogra+replicate(" ",30-len(cEndLogra))+;
     alltrim(str(nEndNumero))+replicate(" ",5-len(alltrim(str(nEndNumero))))+;
     cEndCompl+replicate(" ",10-len(cEndCompl))+;
     cEndBairro+replicate(" ",20-len(cEndBairro))+;
     cEndCep+replicate(" ",8-len(cEndCep))+;
     cUsuTelefone+replicate(" ",11-len(cUsuTelefone))+;
     cUsuCategoria+replicate(" ",1-len(cUsuCategoria))+;
     alltrim(str(nUsuSituacao))+chr(13)+chr(10)
 endif
elseif nTipo=3
 if lTipo=true
   if len(cEmprestimos) > 0
      nEmpNinscUsuario:=val(alltrim(substr(cEmprestimos,1,5)))
      nEmpNinscLivro:=val(alltrim(substr(cEmprestimos,6,5)))
      cEmpDtEmprestimo:=alltrim(substr(cEmprestimos,11,10))
      cEmpDtDevolucao:=alltrim(substr(cEmprestimos,21,10))
      if alltrim(substr(cEmprestimos,31,1))="T"
         lEmpRemovido:=true
      elseif alltrim(substr(cEmprestimos,31,1))="F"
         lEmpRemovido:=false
      endif
   endif
 else
    cEmprestimos:=alltrim(str(nEmpNinscUsuario))+;
    replicate(" ",5-len(str(nEmpNinscUsuario)))+;
    alltrim(str(nEmpNinscLivro))+replicate(" ",5-len(alltrim(str(nEmpNinscLivro))))+;
    cEmpDtEmprestimo+replicate(" ",10-len(cEmpDtEmprestimo))+;
    cEmpDtDevolucao+replicate(" ",10-len(cEmpDtDevolucao))
    if lEmpRemovido=true
       cEmprestimos:=cEmprestimos+"T"+chr(13)+chr(10)
    else
       cEmprestimos:=cEmprestimos+"F"+chr(13)+chr(10)
    endif
  endif
endif

return

/*-----------------------------------------------------*/

/*
 Nome : AbrirArquivo
 Descricao : procedimento que Abri o tipo de arquivo selecionado.
 Parametros :
 ntipo - indica o numero de qual arquivo a ser aberto
*/
procedure AbrirArquivo(nTipo)

  if nTipo=1
     if file("Livros.dat")=true
        if (LivrosFile:=fopen("Livros.dat",FO_READWRITE)) >= 0
           nTamLivros:=fseek(LivrosFile,0,FS_END)
           nTamLivros:=int(nTamLivros / TamLiv)
           fseek(LivrosFile,0,FS_SET)
        endif  
     else
        if (LivrosFile:=fcreate("Livros.dat",FC_NORMAL))>=0
           nTamLivros:=0
        endif
     endif
  endif
  if ntipo=2 
     if file("Usuarios.dat")=true
        if (UsuariosFile:=fopen("Usuarios.dat",FO_READWRITE)) >= 0
           nTamUsuarios:=fseek(UsuariosFile,0,FS_END)
           nTamUsuarios:=int(nTamUsuarios / TamUsu)
           fseek(UsuariosFile,0,FS_SET)
        endif  
     else
        if (UsuariosFile:=fcreate("Usuarios.dat",FC_NORMAL))>=0
           nTamUsuarios:=0
        endif
     endif
  endif
  if nTipo=3 
     if file("Empresti.dat")=true
        if (EmprestimosFile:=fopen("Empresti.dat",FO_READWRITE)) >= 0
           nTamEmprestimos:=fseek(EmprestimosFile,0,FS_END)
           nTamEmprestimos:=int(nTamEmprestimos / TamEmp)
           fseek(EmprestimosFile,0,FS_SET)
        endif  
     else
        if (EmprestimosFile:=fcreate("Empresti.dat",FC_NORMAL)) >=0
           nTamEmprestimos:=0
        endif
     endif
  endif
  if nTipo=4 
     if file("Sobre.dat")=true
        SobreFile:=fopen("Sobre.dat",FO_READ)
        nTamSobre:=fseek(SobreFile,0,FS_END)
        // nTamSobre:=nTamSobre / TamSobre
        fseek(SobreFile,0) 
     else
        SobreFile:=fcreate("Sobre.dat",FC_NORMAL)
        nTamSobre:=0
     endif
  endif

return

/*-----------------------------------------------------*/

/*
 Nome : RetDataAtual
 Descricao : funcao que retorna a data atual do sistema
*/
function RetDataAtual()
return(dtoc(date()))

/*--------------------------------------------------------*/

/*
 Nome : ConverteData
 Descricao : funcao que converte a data em string para numero.
 Parametros :
 cdt - data a ser convertida
*/
function ConverteData(cdt)
local sAux
local nAux

 sAux:=substr(cdt,7,4)+substr(cdt,4,2)+substr(cdt,1,2) 
 nAux:=Val(sAux) 

return(nAux)

/*--------------------------------------------------------*/

/*
 Nome : SubtraiDatas
 Descricao : funcao que subtrai duas datas e retorna o numero de dias
 Parametros :
 cdt1 - data inicial
 cdt2 - data final
*/
function SubtraiDatas(cdt1,cdt2)
local ndia;local nmes;local nano;local ndia1;local nmes1;local nano1
local ndia2;local nmes2;local nano2;local ni;local nc;local ndias
local nudiames[12]

 ndias:=0 
 nudiames[1]:=31 
 nudiames[2]:=28 
 nudiames[3]:=31 
 nudiames[4]:=30 
 nudiames[5]:=31 
 nudiames[6]:=30 
 nudiames[7]:=31 
 nudiames[8]:=31 
 nudiames[9]:=30 
 nudiames[10]:=31 
 nudiames[11]:=30 
 nudiames[12]:=31 

 ni:=val(substr(cdt1,1,2)) 
 ndia1:=ni 
 ni:=val(substr(cdt1,4,2)) 
 nmes1:=ni 
 ni:=val(substr(cdt1,7,4)) 
 nano1:=ni 

 ni:=val(substr(cdt2,1,2)) 
 ndia2:=ni 
 ni:=val(substr(cdt2,4,2)) 
 nmes2:=ni 
 ni:=val(substr(cdt2,7,4)) 
 nano2:=ni 

 for nano:=nano1 to nano2 
    for nmes:=nmes1 to 12 
       /* ano bissexto */
       if (nano % 4)=0 
         nudiames[2]:=29
       endif
       /* data final */
       if (nano=nano2) .and. (nmes=nmes2) 
         nudiames[nmes2]:=ndia2
       endif
       for ndia:=ndia1 to nudiames[nmes] 
          ndias++
       next
       if (nano=nano2) .and. (nmes=nmes2) 
           return(ndias-1) 
           exit
       endif
       ndia1:=1
    next
    nmes1:=1 
 next

return(1)

/*--------------------------------------------------------*/

/*
 Nome : SomaDias
 Descricao : funcao que soma um determinado numero de dias a uma data.
 Parametros :
 cdt1 - a data a ser somada
 nqtddias - numero de dias a serem somados
*/
function SomaDias(cdt1,nqtddias)
local ndia;local nmes;local nano;local ndia1;local nmes1;local nano1
local ndia2;local nmes2;local nano2;local ni;local nc;local ndias
local nudiames[12]
local sAux;local sAux2

 ndias:=0 
 nudiames[1]:=31 
 nudiames[2]:=28 
 nudiames[3]:=31 
 nudiames[4]:=30 
 nudiames[5]:=31 
 nudiames[6]:=30 
 nudiames[7]:=31 
 nudiames[8]:=31 
 nudiames[9]:=30 
 nudiames[10]:=31 
 nudiames[11]:=30 
 nudiames[12]:=31 

 ni:=val(substr(cdt1,1,2)) 
 ndia1:=ni 
 ni:=val(substr(cdt1,4,2)) 
 nmes1:=ni 
 ni:=val(substr(cdt1,7,4)) 
 nano1:=ni 

 nano2:=nano1 + int(nqtddias / 365) 

 for nano:=nano1 to nano2 
    for nmes:=nmes1 to 12 
       /* ano bissexto */
       if (nano % 4)=0 
         nudiames[2]:=29
       endif
       for ndia:=ndia1 to nudiames[nmes] 
            ndias++
            if ndias=nqtddias+1 
                sAux:=alltrim(str(ndia)) 
                sAux2:=replicate("0",2-len(sAux))+sAux+"/" 
                sAux:=alltrim(str(nmes)) 
                sAux2:=sAux2+replicate("0",2-len(sAux))+sAux+"/" 
                sAux:=alltrim(str(nano)) 
                sAux2:=sAux2+replicate("0",4-len(sAux))+sAux 
                return(sAux2) 
                exit 
            endif 
       next
       ndia1:=1 
    next
    nmes1:=1 
 next 

return(1)
