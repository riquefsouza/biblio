{ Modulo de Usuarios }
unit musuario;

interface

uses crt, rotinas1, grafico1, rotinas2, grafico2;

var
 { variaveis do modulo de Usuarios }

 vsUsuarios : array[1..11] of String[30];

{ Declaracao de funcoes de musuario }

function fnPesUsuarios(ctip:char;scampo:string;ncod:integer;scod:string;
                       ntamscod:integer):integer;
function fnPesBinaria(nchave:integer):integer; 
function fbVrfUsuarios:boolean;

{ Declaracao de Procedimentos de musuario }

procedure pFrmUsuarios(ntip:integer;stit,srod:string);
procedure pLprUsuarios; 
procedure pRotFrmUsuarios(nl:integer); 
procedure pConFrmUsuarios(stip:string;ntip2,npos,
          ncol:integer;srod:string;bfco:boolean); 
procedure pAtrUsuarios(blimpar:boolean); 
procedure pDigFrmUsuarios; 
procedure pSlvUsuarios(ntip:integer); 

implementation

{
 Nome : fnPesUsuarios
 Descricao : funcao que pesquisa as informacoes contidas no arquivo de
 usuarios.
 Parametros :
 ctip - indica se e o valor e (N)umerico ou (S)tring
 scampo - qual o campo a ser pesquisado
 ncod - codigo do campo se numerico
 scod - codigo do campo se string
 ntamscod - tamanho caracteres do campo de string
}
function fnPesUsuarios(ctip:char;scampo:string;ncod:integer;scod:string;
                       ntamscod:integer):integer;
var
 nposicao,ncod2:integer;
 scod2:string;
 bflag:boolean;
begin
seek(fUsuarios,0);
nposicao:=0;
bflag:=false;
ncod2:=0;
scod2:='';
while Not Eof(fUsuarios) do
 begin
   read(fUsuarios,Usuarios);
   if ctip='N' then
     begin
       if scampo='Ninsc' then
          ncod2:=Usuarios.nNinsc;

       if (ncod2=ncod) then
         begin
          fnPesUsuarios:=nposicao;
          seek(fUsuarios,nposicao);
          bflag:=true;
          exit;
         end
     end
   else if ctip='S' then
     begin
       if scampo='Nome' then
          scod2:=Usuarios.sNome
       else if scampo='Ident' then
          scod2:=Usuarios.sIdent;

       if (copy(scod2,1,ntamscod)=scod) then
         begin
          fnPesUsuarios:=nposicao;
          seek(fUsuarios,nposicao);
          bflag:=true;
          exit;
         end;
     end;
   nposicao:=nposicao+1;
 end;
 if (Eof(fUsuarios)) and (bflag=false) then
    fnPesUsuarios:=-1;
end;

{-----------------------------------------------------}

{
 Nome : fnPesBinaria
 Descricao : funcao que realiza uma pesquisa binaria
 por numero de inscricao do usuario.
 Parametros :
 nchave - numero de inscricao do usuario a pesquisar
}
function fnPesBinaria(nchave:integer):integer;
var
 ninicio,nfim,nmeio:integer;
 bachou:boolean;
begin
 ninicio:=1;
 nfim:=nTamUsuarios+1;
 bachou:=false;
 while ((not bachou) and (ninicio <= nfim)) do
  begin
   nmeio:=((ninicio+nfim) div 2);
   seek(fUsuarios,nmeio-1);
   read(fUsuarios,Usuarios);
   if (nchave=Usuarios.nNinsc) then
      bachou:=true
   else
    begin
      if (nchave > Usuarios.nNinsc) then
        ninicio:=nmeio+1
      else
        nfim:=nmeio-1;
    end;
  end;
 if bachou=true then
    fnPesBinaria:=nmeio-1
 else
    fnPesBinaria:=-1;
end;

{-----------------------------------------------------}

{
 Nome : pFrmUsuarios
 Descricao : procedimento que desenha o formulario de Usuarios na tela, e
 tambem indica qual acao a tomar.
 Parametros :
 ntip - indica qual a acao do formulario
 stit - o titulo do formulario
 srod - o texto do rodape sobre o formulario
}
procedure pFrmUsuarios(ntip:integer;stit,srod:string);
begin
  pTelaFundo(sCFundo,mnCor[5,1],mnCor[5,2]);
  pRodape(srod,' ',mnCor[6,1],mnCor[6,2]);
  pFrm(chr(180)+stit+chr(195),4,2,18,76,chr(177),mnCor[8,1],mnCor[8,2],
  lightgray,black);

  vsUsuarios[1]:=fsRepete(' ',5);
  pAtrUsuarios(true);
  pAbrirArquivo(2);
  if (ntip=1) or (ntip=2) then
    begin
     pRotFrmUsuarios(0);
     pDesBotao(20,48,' Salvar ',mnCor[9,1],mnCor[9,2],black,
     mnCor[8,2],false);
     pDesBotao(20,63,' Fechar ',mnCor[9,1],mnCor[9,2],black,
     mnCor[8,2],false);
    end;
  if (ntip=3) or (ntip=4) or (ntip=5) then
    begin
     pDesBotao(20,63,' Fechar ',mnCor[9,1],mnCor[9,2],black,mnCor[8,2],false);
     pRotFrmUsuarios(2);
     pETexto(7,2,chr(195)+fsRepete(chr(196),75)+chr(180),
     mnCor[8,1],mnCor[8,2]);
    end;
  if ntip=6 then
     pDesBotao(20,63,' Fechar ',mnCor[9,1],mnCor[9,2],black,mnCor[8,2],false);

  if ntip=3 then
    begin
     pETexto(6,5,'Numero de Inscricao : ',mnCor[8,1],mnCor[8,2]);
     pETexto(6,27,fsRepete(' ',5),mnCor[11,1],mnCor[11,2]);
    end;
  if ntip=4 then
    begin
     pETexto(6,5,'Nome : ',mnCor[8,1],mnCor[8,2]);
     pETexto(6,12,fsRepete(' ',30),mnCor[11,1],mnCor[11,2]);
    end;
  if ntip=5 then
    begin
     pETexto(6,5,'Identidade : ',mnCor[8,1],mnCor[8,2]);
     pETexto(6,18,fsRepete(' ',10),mnCor[11,1],mnCor[11,2]);
    end;

  pLprUsuarios;
  if ntip=1 then
     pConFrmUsuarios('2',1,0,0,srod,false)  { cadastrar }
  else if ntip=2 then
     pConFrmUsuarios('1',2,0,0,srod,false)  { alterar }
  else if ntip=3 then
     pConFrmUsuarios('3',3,0,0,srod,false) { consultar por NInsc }
  else if ntip=4 then
     pConFrmUsuarios('4',4,0,0,srod,false) { consultar por Nome }
  else if ntip=5 then
     pConFrmUsuarios('5',5,0,0,srod,false) { consultar por Identidade }
  else if ntip=6 then
     pConFrmUsuarios('6',6,0,0,srod,true); { consultar todos }
end;

{-------------------------------------------}

{
 Nome : pLprUsuarios
 Descricao : procedimento limpa as variaveis do registro de usuarios.
}
procedure pLprUsuarios;
begin
   with Usuarios do
    begin
     nNinsc:=0;
     sNome:='';
     sIdent:='0';
     Endereco.sLogra:='';
     Endereco.nNumero:=0;
     Endereco.sCompl:='';
     Endereco.sBairro:='';
     Endereco.sCep:='0';
     sTelefone:='0';
     cCategoria:=' ';
     nSituacao:=0;
    end;
end;

{-------------------------------------------}

{
 Nome : pRotFrmUsuarios
 Descricao : procedimento que escreve os rotulos do formulario de Usuarios.
 Parametros :
 nl - indica um acrescimo na linha do rotulo
}
procedure pRotFrmUsuarios(nl:integer);
begin
  pETexto(6+nl,5,'Numero de Inscricao : ',mnCor[8,1],mnCor[8,2]);
  pETexto(6+nl,27,vsUsuarios[1],mnCor[11,1],mnCor[11,2]);
  pETexto(6+nl,35,'Nome : ',mnCor[8,1],mnCor[8,2]);
  pETexto(6+nl,42,vsUsuarios[2],mnCor[11,1],mnCor[11,2]);
  pETexto(8+nl,5,'Identidade : ',mnCor[8,1],mnCor[8,2]);
  pETexto(8+nl,18,vsUsuarios[3],mnCor[11,1],mnCor[11,2]);
  pETexto(10+nl,2,chr(195)+fsRepete(chr(196),75)+chr(180),
  mnCor[8,1],mnCor[8,2]);
  pETexto(10+nl,5,'Endereco',mnCor[8,1],mnCor[8,2]);
  pETexto(12+nl,5,'logradouro : ',mnCor[8,1],mnCor[8,2]);
  pETexto(12+nl,18,vsUsuarios[4],mnCor[11,1],mnCor[11,2]);
  pETexto(12+nl,51,'Numero : ',mnCor[8,1],mnCor[8,2]);
  pETexto(12+nl,60,vsUsuarios[5],mnCor[11,1],mnCor[11,2]);
  pETexto(14+nl,5,'Complemento : ',mnCor[8,1],mnCor[8,2]);
  pETexto(14+nl,19,vsUsuarios[6],mnCor[11,1],mnCor[11,2]);
  pETexto(14+nl,32,'Bairro : ',mnCor[8,1],mnCor[8,2]);
  pETexto(14+nl,41,vsUsuarios[7],mnCor[11,1],mnCor[11,2]);
  pETexto(14+nl,63,'Cep : ',mnCor[8,1],mnCor[8,2]);
  pETexto(14+nl,69,vsUsuarios[8],mnCor[11,1],mnCor[11,2]);
  pETexto(16+nl,2,chr(195)+fsRepete(chr(196),75)+chr(180),
  mnCor[8,1],mnCor[8,2]);
  pETexto(8+nl,31,'Telefone : ',mnCor[8,1],mnCor[8,2]);
  pETexto(8+nl,42,vsUsuarios[9],mnCor[11,1],mnCor[11,2]);
  pETexto(17+nl,5,'Categoria : ',mnCor[8,1],mnCor[8,2]);
  pETexto(17+nl,17,vsUsuarios[10],mnCor[11,1],mnCor[11,2]);
  pETexto(17+nl,20,'(A)luno ou (P)rofessor ou (F)uncionario',
  mnCor[8,1],mnCor[8,2]);
  pETexto(19+nl,5,'Situacao : ',mnCor[8,1],mnCor[8,2]);
  pETexto(19+nl,16,vsUsuarios[11],mnCor[11,1],mnCor[11,2]);

end;
{-------------------------------------------}

{
 Nome : pConFrmUsuarios
 Descricao : procedimento que realiza todo o controle de manuseio do
 formulario de Usuarios.
 Parametros :
 stip - indica qual a acao do formulario
 ntip2 - indica a acao original do formulario nao manipulado pela funcao
 npos - indica a ultima posicao da linha da lista de usuarios
 ncol - indica a ultima posicao da coluna da lista de usuarios
 srod - o texto do rodape sobre o formulario
 bfco - se os objetos do formulario estao focados ou nao
}
procedure pConFrmUsuarios(stip:string;ntip2,npos,ncol:integer;
                          srod:string;bfco:boolean);
var
 ni, ncode : integer;
begin
if stip='1' then
   begin
      sS:=fsDigita(5,28,sS,5,5,'N',0,mnCor[11,1],mnCor[11,2]); { N insc }
      val(sS,ni,ncode);
      Usuarios.nNinsc:=ni;
      if (length(sS) > 0) and (sS<>fsRepete(' ',length(sS))) then
        begin
         pDesBotao(20,48,' Salvar ',mnCor[9,1],mnCor[9,2],black,
         mnCor[8,2],false);
         if fnPesUsuarios('N','Ninsc',ni,'',0)<>-1 then
           begin
                pAtrUsuarios(false);
                pRotFrmUsuarios(0);
                pRodape(srod,' ',mnCor[6,1],mnCor[6,2]);
                pConFrmUsuarios('2',ntip2,npos,ncol,srod,false);
           end
         else
           begin
            str(ni,sS);
            pAtrUsuarios(true);
            pRotFrmUsuarios(0);
            pRodape('Numero de Inscricao, nao encontrado !',' ',
            mnCor[7,1],mnCor[7,2]);
            pConFrmUsuarios('Fechar',ntip2,npos,ncol,srod,true);
           end;
        end
      else
        pConFrmUsuarios('Fechar',ntip2,npos,ncol,srod,true);
   end
else if stip='2' then
   begin
     with Usuarios do
      begin
        if ntip2=1 then
          begin
            nTamUsuarios:=FileSize(fUsuarios);
            if nTamUsuarios = 0 then
               nNinsc:=1
            else             
               nNinsc:=nTamUsuarios + 1;
            ni:=nNinsc;
            str(nNinsc,sS);
            pETexto(6,27,sS,mnCor[11,1],mnCor[11,2]);
            sS:='';
          end
        else if ntip2=2 then
          begin
            pAbrirArquivo(2);
            if fnPesUsuarios('N','Ninsc',ni,'',0)=-1 then
              pRodape('Numero de Inscricao, nao encontrado !',' ',
              mnCor[7,1],mnCor[7,2]);
          end;
          pDigFrmUsuarios;
      end;
      pConFrmUsuarios('Salvar',ntip2,npos,ncol,srod,true);
   end
else if stip='3' then
    begin
      sS:='';
      sS:=fsDigita(5,28,sS,5,5,'N',0,mnCor[11,1],mnCor[11,2]); { N insc }
      val(sS,ni,ncode);
      Usuarios.nNinsc:=ni;
      if (length(sS) > 0) and (sS<>fsRepete(' ',length(sS))) then
        begin
         if fnPesBinaria(ni)<>-1 then
           begin
              pAtrUsuarios(false);
              pRotFrmUsuarios(2);
              pRodape(srod,' ',mnCor[6,1],mnCor[6,2]);
           end
         else
           begin
            pAtrUsuarios(true);
            pRotFrmUsuarios(2);
            pRodape('Numero de Inscricao, nao encontrado !',' ',
            mnCor[7,1],mnCor[7,2]);
           end;
        end;
        pConFrmUsuarios('Fechar',ntip2,npos,ncol,srod,true);
    end
else if stip='4' then
    begin
      sS:='';
      sS:=fsDigita(5,13,sS,30,30,'T',0,mnCor[11,1],mnCor[11,2]);
      Usuarios.sNome:=sS;
      if (length(sS) > 0) and (sS<>fsRepete(' ',length(sS))) then
        begin
         if fnPesUsuarios('S','Nome',0,sS,length(sS))<>-1 then
           begin
              pAtrUsuarios(false);
              pRotFrmUsuarios(2);
              pRodape(srod,' ',mnCor[6,1],mnCor[6,2]);
           end
         else
           begin
            pAtrUsuarios(true);
            pRotFrmUsuarios(2);
            pRodape('Nome do Usuario, nao encontrado !',' ',
            mnCor[7,1],mnCor[7,2]);
           end;
        end;
        pConFrmUsuarios('Fechar',ntip2,npos,ncol,srod,true);
    end
else if stip='5' then
    begin
      sS:='';
      sS:=fsDigita(5,19,sS,10,10,'N',0,mnCor[11,1],mnCor[11,2]);
      Usuarios.sIdent:=sS;
      if (length(sS) > 0) and (sS<>fsRepete(' ',length(sS))) then
        begin
         if fnPesUsuarios('N','Ident',0,sS,length(sS))<>-1 then
           begin
              pAtrUsuarios(false);
              pRotFrmUsuarios(2);
              pRodape(srod,' ',mnCor[6,1],mnCor[6,2]);
           end
         else
           begin
            pAtrUsuarios(true);
            pRotFrmUsuarios(2);
            pRodape('Identidade do Usuario, nao encontrada !',' ',
            mnCor[7,1],mnCor[7,2]);
           end;
        end;
        pConFrmUsuarios('Fechar',ntip2,npos,ncol,srod,true);
    end
else if stip='6' then
  begin
    nListapos:=npos;
    nListacol:=ncol;
    if fnLista(2,6,5,13,70,nTamUsuarios+2,194,
       mnCor[8,1],mnCor[8,2],mnCor[10,1],mnCor[10,2],bfco)=1 then
      begin
        pDesLista(2,6,5,13,70,nTamUsuarios+2,194,mnCor[8,1],mnCor[8,2],
        mnCor[10,1],mnCor[10,2],nListapos,nListacol,false);
        pConFrmUsuarios('Fechar',ntip2,npos,ncol,srod,true);
      end;
  end
else if stip='Salvar' then
  begin
    case fnBotao(20,48,' Salvar ',mnCor[9,1],mnCor[9,2],black,
         mnCor[8,2],bfco) of
      1:begin
          pDesBotao(20,48,' Salvar ',mnCor[9,1],mnCor[9,2],black,
          mnCor[8,2],false);
          pConFrmUsuarios('Fechar',ntip2,npos,ncol,srod,true);
        end;
      2:begin
          pSlvUsuarios(ntip2);
          pDesBotao(20,48,' Salvar ',mnCor[9,1],mnCor[9,2],black,
          mnCor[8,2],false);
          pConFrmUsuarios('Fechar',ntip2,npos,ncol,srod,true);
        end;
    end;
  end
else if stip = 'Fechar' then
  begin
    case fnBotao(20,63,' Fechar ',mnCor[9,1],mnCor[9,2],black,
         mnCor[8,2],bfco) of
      1:begin
          pDesBotao(20,63,' Fechar ',mnCor[9,1],mnCor[9,2],black,
          mnCor[8,2],false);
          if ntip2=1 then
            pConFrmUsuarios('2',ntip2,npos,ncol,srod,true)
          else if ntip2=2 then
            pConFrmUsuarios('1',ntip2,npos,ncol,srod,false)
          else if ntip2=3 then
            pConFrmUsuarios('3',ntip2,npos,ncol,srod,false)
          else if ntip2=4 then
            pConFrmUsuarios('4',ntip2,npos,ncol,srod,false)
          else if ntip2=5 then
            pConFrmUsuarios('5',ntip2,npos,ncol,srod,false)
          else if ntip2=6 then
            pConFrmUsuarios('6',ntip2,npos,ncol,srod,true);
        end;
      2:begin
         pRodape('',' ',mnCor[6,1],mnCor[6,2]);
         close(fUsuarios);
        end;
    end;
  end;

end;

{-------------------------------------------------------}

{
 Nome : pAtrUsuarios
 Descricao : procedimento que atribui ou limpa o vetor de Usuarios.
 Parametros :
 blimpar - indica se vai limpar ou atribuir os vetores
}
procedure pAtrUsuarios(blimpar:boolean);
begin
if blimpar=false then
 begin
  with Usuarios do
    begin
      str(nNinsc,sS);
      vsUsuarios[1]:=sS;
      vsUsuarios[2]:=sNome;
      vsUsuarios[3]:=sIdent;
      vsUsuarios[4]:=Endereco.sLogra;
      str(Endereco.nNumero,sS);
      vsUsuarios[5]:=sS;
      vsUsuarios[6]:=Endereco.sCompl;
      vsUsuarios[7]:=Endereco.sBairro;
      vsUsuarios[8]:=Endereco.sCep;
      vsUsuarios[9]:=sTelefone;
      vsUsuarios[10]:=cCategoria;
      str(nSituacao,sS);
      vsUsuarios[11]:=sS;
    end;
 end
else
 begin
  vsUsuarios[2]:=fsRepete(' ',30);
  vsUsuarios[3]:=fsRepete(' ',10);
  vsUsuarios[4]:=fsRepete(' ',30);
  vsUsuarios[5]:=fsRepete(' ',5);
  vsUsuarios[6]:=fsRepete(' ',10);
  vsUsuarios[7]:=fsRepete(' ',20);
  vsUsuarios[8]:=fsRepete(' ',8);
  vsUsuarios[9]:=fsRepete(' ',11);
  vsUsuarios[10]:=fsRepete(' ',1);
  vsUsuarios[11]:=fsRepete(' ',1);
 end;
end;

{-------------------------------------------------------}

{
 Nome : pDigFrmUsuarios
 Descricao : procedimento que realiza o cotrole de digitacao dos dados no
 formulario de usuarios.
}
procedure pDigFrmUsuarios;
var
 ni, ncode : integer;
begin
     with Usuarios do
      begin
        sS:=sNome;
        sS:=fsDigita(5,43,sS,30,30,'T',0,mnCor[11,1],mnCor[11,2]);
        sNome:=sS;
        sS:=sIdent;
        sS:=fsDigita(7,19,sS,10,10,'N',0,mnCor[11,1],mnCor[11,2]);
        sIdent:=sS;
        sS:=sTelefone;
        sS:=fsDigita(7,43,sS,11,11,'N',0,mnCor[11,1],mnCor[11,2]);
        sTelefone:=sS;
        sS:=Endereco.sLogra;
        sS:=fsDigita(11,19,sS,30,30,'T',0,mnCor[11,1],mnCor[11,2]);
        Endereco.sLogra:=sS;
        Str(Endereco.nNumero,sS);
        sS:=fsDigita(11,61,sS,5,5,'N',0,mnCor[11,1],mnCor[11,2]);
        val(sS,ni,ncode);
        Endereco.nNumero:=ni;
        sS:=Endereco.sCompl;
        sS:=fsDigita(13,20,sS,10,10,'T',0,mnCor[11,1],mnCor[11,2]);
        Endereco.sCompl:=sS;
        sS:=Endereco.sBairro;
        sS:=fsDigita(13,42,sS,20,20,'T',0,mnCor[11,1],mnCor[11,2]);
        Endereco.sBairro:=sS;
        sS:=Endereco.sCep;
        sS:=fsDigita(13,70,sS,8,8,'N',0,mnCor[11,1],mnCor[11,2]);
        Endereco.sCep:=sS;
        sS:=cCategoria;
        sS:=fsDigita(16,18,sS,1,1,'T',0,mnCor[11,1],mnCor[11,2]);
        cCategoria:=sS[1];
        str(nSituacao,sS);
        sS:=fsDigita(18,17,sS,1,1,'N',0,mnCor[11,1],mnCor[11,2]);
        val(sS,ni,ncode);
        nSituacao:=ni;
        sS:='';
      end;
end;

{-------------------------------------------------------}

{
 Nome : fbVrfUsuarios
 Descricao : funcao que verifica se os dados no formulario de usuarios
 foram digitados.
}
function fbVrfUsuarios:boolean;
begin
with Usuarios do
 begin
  str(nNinsc,sS);
  if (length(sS) = 0) and (sS=fsRepete(' ',length(sS))) then
    begin
      pRodape('Numero de Inscricao, nao cadastrado !',' ',
      mnCor[7,1],mnCor[7,2]);
      fbVrfUsuarios:=false;
      exit
    end;
  if (length(sNome) = 0) and (sNome=fsRepete(' ',length(sNome))) then
    begin
      pRodape('Nome do Usuario, nao cadastrado !',' ',mnCor[7,1],mnCor[7,2]);
      fbVrfUsuarios:=false;
      exit
    end;
  if (length(sIdent) = 0) and (sIdent=fsRepete(' ',length(sIdent))) then
    begin
      pRodape('Identidade, nao cadastrada !',' ',mnCor[7,1],mnCor[7,2]);
      fbVrfUsuarios:=false;
      exit
    end;
  if (length(Endereco.sLogra) = 0) and
     (Endereco.sLogra=fsRepete(' ',length(Endereco.sLogra))) then
    begin
      pRodape('Logradouro, nao cadastrado !',' ',mnCor[7,1],mnCor[7,2]);
      fbVrfUsuarios:=false;
      exit
    end;
  str(Endereco.nNumero,sS);
  if (length(sS) = 0) and (sS=fsRepete(' ',length(sS))) then
    begin
      pRodape('Numero do Endereco, nao cadastrado !',' ',
      mnCor[7,1],mnCor[7,2]);
      fbVrfUsuarios:=false;
      exit
    end;
  if (length(Endereco.sCompl) = 0)
     and (Endereco.sCompl=fsRepete(' ',length(Endereco.sCompl))) then
    begin
      pRodape('Complemento do Endereco, nao cadastrado !',' ',
      mnCor[7,1],mnCor[7,2]);
      fbVrfUsuarios:=false;
      exit
    end;
  if (length(Endereco.sBairro) = 0)
     and (Endereco.sBairro=fsRepete(' ',length(Endereco.sBairro))) then
    begin
      pRodape('Bairro, nao cadastrado !',' ',mnCor[7,1],mnCor[7,2]);
      fbVrfUsuarios:=false;
      exit
    end;
  if (length(Endereco.sCep) = 0) and
     (Endereco.sCep=fsRepete(' ',length(Endereco.sCep))) then
    begin
      pRodape('Cep, nao cadastrado !',' ',mnCor[7,1],mnCor[7,2]);
      fbVrfUsuarios:=false;
      exit
    end;
  if (length(sTelefone) = 0) and
     (sTelefone=fsRepete(' ',length(sTelefone))) then
    begin
      pRodape('Telefone, nao cadastrado !',' ',mnCor[7,1],mnCor[7,2]);
      fbVrfUsuarios:=false;
      exit
    end;
  if (length(cCategoria) = 0) and
     (cCategoria=fsRepete(' ',length(cCategoria))) then
    begin
      pRodape('Categoria, nao cadastrada !',' ',mnCor[7,1],mnCor[7,2]);
      fbVrfUsuarios:=false;
      exit
    end;

 end;
 fbVrfUsuarios:=true;
end;

{---------------------------------------------------------------}

{
 Nome : pSlvUsuarios
 Descricao : procedimento que salva os dados digitados no
 formulario de usuarios.
 Parametros :
 ntip - indica qual acao a salvar
}
procedure pSlvUsuarios(ntip:integer);
begin
if fbVrfUsuarios=true then
begin
if (Usuarios.cCategoria='A') or (Usuarios.cCategoria='P')
   or (Usuarios.cCategoria='F') then
  begin
    if ntip=1 then
      begin
        seek(fUsuarios,nTamUsuarios);
        write(fUsuarios,Usuarios);
        pAtrUsuarios(true);
        pRotFrmUsuarios(0);
        pLprUsuarios;
      end
    else if ntip=2 then
       write(fUsuarios,Usuarios);
  end
else
  pRodape('Categoria, Cadastrada Incorretamente !',' ',mnCor[7,1],mnCor[7,2]);
end;

end;

end.
