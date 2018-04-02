{ Modulo de Livros }
unit mlivros;

interface

uses  crt, rotinas1, grafico1, rotinas2, grafico2;

var
 { variaveis do modulo de livros }

 vsLivros : array[1..10] of string[30];

{ Declaracao de funcoes de MLivros }

function fnPesLivros(ctip:char;scampo:string;ncod:integer;scod:string;
                     ntamscod:integer):integer;
function fbVrfLivros:boolean;

{ Declaracao de Procedimentos de MLivros }

procedure pFrmLivros(ntip:integer;stit,srod:string);
procedure pLprLivros;
procedure pRotFrmLivros(nl:integer);
procedure pConFrmLivros(stip:string;ntip2,npos,ncol:integer;srod:string;
                        bfco:boolean);
procedure pAtrLivros(blimpar:boolean);
procedure pDigFrmLivros;
procedure pSlvLivros(ntip:integer);

implementation

{
 Nome : fnPesLivros
 Descricao : funcao que pesquisa as informacoes contidas no arquivo de
 livros
 Parametros :
 ctip - indica se e o valor e (N)umerico ou (S)tring
 campo - qual o campo a ser pesquisado
 nCod2 - codigo do campo se numerico
 sCod2 - codigo do campo se string
 nTamsCod - tamanho caracteres do campo de string
}
function fnPesLivros(ctip:char;scampo:string;ncod:integer;scod:string;
                     ntamscod:integer):integer;
var
 nposicao,ncod2:integer;
 scod2:string;
 bflag:boolean;
begin
seek(fLivros,0);
nposicao:=0;
bflag:=false;
ncod2:=0;
scod2:='';
while Not Eof(fLivros) do
 begin
   read(fLivros,Livros);
   if ctip='N' then
     begin
       if scampo='Ninsc' then
          ncod2:=Livros.nNinsc;

       if (ncod2=ncod) then
         begin
          fnPesLivros:=nposicao;
          seek(fLivros,nposicao);
          bflag:=true;
          exit;
         end
     end
   else if ctip='S' then
     begin
       if scampo='Titulo' then
          scod2:=Livros.sTitulo
       else if scampo='Area' then
          scod2:=Livros.sArea
       else if scampo='Autor' then
          scod2:=Livros.sAutor
       else if scampo='Pchave' then
          scod2:=Livros.sPchave;

       if (copy(scod2,1,ntamscod)=scod) then
         begin
          fnPesLivros:=nposicao;
          seek(fLivros,nposicao);
          bflag:=true;
          exit;
         end;
     end;
   nposicao:=nposicao+1;
 end;
 if (Eof(fLivros)) and (bflag=false) then
    fnPesLivros:=-1;
end;

{-----------------------------------------------------}

{
 Nome : pFrmLivros
 Descricao : procedimento que desenha o formulario de livros na tela, e
 tambem indica qual acao a tomar.
 Parametros :
 ntip - indica qual a acao do formulario
 stit - o titulo do formulario
 srod - o texto do rodape sobre o formulario
}
procedure pFrmLivros(ntip:integer;stit,srod:string);
begin
  pTelaFundo(sCFundo,mnCor[5,1],mnCor[5,2]);
  pRodape(srod,' ',mnCor[6,1],mnCor[6,2]);
  pFrm(chr(180)+stit+chr(195),4,2,18,76,chr(177),mnCor[8,1],mnCor[8,2],
  lightgray,black);

  vsLivros[1]:=fsRepete(' ',5);
  pAtrLivros(true);
  pAbrirArquivo(1);
  if (ntip=1) or (ntip=2) then
    begin
     pRotFrmLivros(0);
     pDesBotao(20,45,' Salvar ',mnCor[9,1],mnCor[9,2],black,mnCor[8,2],false);
     pDesBotao(20,60,' Fechar ',mnCor[9,1],mnCor[9,2],black,mnCor[8,2],false);
    end;
  if (ntip=3) or (ntip=4) or (ntip=5) or (ntip=6) then
    begin
     pDesBotao(20,60,' Fechar ',mnCor[9,1],mnCor[9,2],black,mnCor[8,2],false);
     pRotFrmLivros(2);
     pETexto(7,2,chr(195)+fsRepete(chr(196),75)+chr(180),mnCor[8,1],mnCor[8,2]);
    end;
  if ntip=7 then
     pDesBotao(20,60,' Fechar ',mnCor[9,1],mnCor[9,2],black,mnCor[8,2],false);

  if ntip=3 then
    begin
     pETexto(6,5,'Titulo : ',mnCor[8,1],mnCor[8,2]);
     pETexto(6,14,fsRepete(' ',30),mnCor[11,1],mnCor[11,2]);
    end;
  if ntip=4 then
    begin
     pETexto(6,5,'Autor : ',mnCor[8,1],mnCor[8,2]);
     pETexto(6,13,fsRepete(' ',30),mnCor[11,1],mnCor[11,2]);
    end;
  if ntip=5 then
    begin
     pETexto(6,5,'Area : ',mnCor[8,1],mnCor[8,2]);
     pETexto(6,12,fsRepete(' ',30),mnCor[11,1],mnCor[11,2]);
    end;
  if ntip=6 then
    begin
     pETexto(6,5,'Palavra-Chave : ',mnCor[8,1],mnCor[8,2]);
     pETexto(6,21,fsRepete(' ',10),mnCor[11,1],mnCor[11,2]);
    end;

  pLprLivros;
  if ntip=1 then
     pConFrmLivros('2',1,0,0,srod,false)  { cadastrar }
  else if ntip=2 then
     pConFrmLivros('1',2,0,0,srod,false)  { alterar }
  else if ntip=3 then
     pConFrmLivros('3',3,0,0,srod,false) { consultar por titulo }
  else if ntip=4 then
     pConFrmLivros('4',4,0,0,srod,false) { consultar por Autor }
  else if ntip=5 then
     pConFrmLivros('5',5,0,0,srod,false) { consultar por Area }
  else if ntip=6 then
     pConFrmLivros('6',6,0,0,srod,false) { consultar por Palavra-chave }
  else if ntip=7 then
     pConFrmLivros('7',7,0,0,srod,true); { consultar todos }
end;

{-------------------------------------------}

{
 Nome : pLprLivros
 Descricao : procedimento limpa as variaveis do registro de livros.
}
procedure pLprLivros;
begin
   with Livros do
    begin
     nNinsc:=0;
     sTitulo:='';
     sAutor:='';
     sArea:='';
     sPchave:='';
     nEdicao:=0;
     nAnoPubli:=0;
     sEditora:='';
     nVolume:=0;
     cEstado:=' ';
    end;
end;

{-------------------------------------------}

{
 Nome : pRotFrmLivros
 Descricao : procedimento que escreve os rotulos do formulario de livros.
 Parametros :
 nl - indica um acrescimo na linha do rotulo
}
procedure pRotFrmLivros(nl:integer);
begin
  pETexto(6+nl,5,'Numero de Inscricao : ',mnCor[8,1],mnCor[8,2]);
  pETexto(6+nl,27,vslivros[1],mnCor[11,1],mnCor[11,2]);
  pETexto(6+nl,35,'Titulo : ',mnCor[8,1],mnCor[8,2]);
  pETexto(6+nl,44,vslivros[2],mnCor[11,1],mnCor[11,2]);
  pETexto(8+nl,5,'Autor : ',mnCor[8,1],mnCor[8,2]);
  pETexto(8+nl,13,vslivros[3],mnCor[11,1],mnCor[11,2]);
  pETexto(10+nl,5,'Area : ',mnCor[8,1],mnCor[8,2]);
  pETexto(10+nl,12,vslivros[4],mnCor[11,1],mnCor[11,2]);
  pETexto(12+nl,5,'Palavra-Chave : ',mnCor[8,1],mnCor[8,2]);
  pETexto(12+nl,21,vslivros[5],mnCor[11,1],mnCor[11,2]);
  pETexto(12+nl,35,'Edicao : ',mnCor[8,1],mnCor[8,2]);
  pETexto(12+nl,44,vslivros[6],mnCor[11,1],mnCor[11,2]);
  pETexto(14+nl,5,'Ano de Publicacao : ',mnCor[8,1],mnCor[8,2]);
  pETexto(14+nl,25,vslivros[7],mnCor[11,1],mnCor[11,2]);
  pETexto(14+nl,35,'Editora : ',mnCor[8,1],mnCor[8,2]);
  pETexto(14+nl,45,vslivros[8],mnCor[11,1],mnCor[11,2]);
  pETexto(16+nl,5,'Volume : ',mnCor[8,1],mnCor[8,2]);
  pETexto(16+nl,14,vslivros[9],mnCor[11,1],mnCor[11,2]);
  pETexto(16+nl,22,'Estado Atual : ',mnCor[8,1],mnCor[8,2]);
  pETexto(16+nl,37,vslivros[10],mnCor[11,1],mnCor[11,2]);
  pETexto(16+nl,40,'(D)isponivel ou (E)mprestado',mnCor[8,1],mnCor[8,2]);

end;
{-------------------------------------------}

{
 Nome : pConFrmLivros
 Descricao : procedimento que realiza todo o controle de manuseio do
 formulario de livros.
 Parametros :
 stip - indica qual a acao do formulario
 ntip2 - indica a acao original do formulario nao manipulado pela funcao
 npos - indica a ultima posicao da linha da lista de livros
 ncol - indica a ultima posicao da coluna da lista de livros
 srod - o texto do rodape sobre o formulario
 bfco - se os objetos do formulario estao focados ou nao
}
procedure pConFrmLivros(stip:string;ntip2,npos,ncol:integer;srod:string;
                        bfco:boolean);
var
 ncode, ni : integer;
begin
if stip='1' then
   begin
      sS:=fsDigita(5,28,sS,5,5,'N',0,mnCor[11,1],mnCor[11,2]); { Ninsc }
      val(sS,ni,ncode);
      Livros.nNinsc:=ni;
      if (length(sS) > 0) and (sS<>fsRepete(' ',length(sS))) then
        begin
         pDesBotao(20,45,' Salvar ',mnCor[9,1],mnCor[9,2],black,
         mnCor[8,2],false);
         if fnPesLivros('N','Ninsc',ni,'',0)<>-1 then
           begin
                pAtrLivros(false);
                pRotFrmLivros(0);
                pRodape(srod,' ',mnCor[6,1],mnCor[6,2]);
                pConFrmLivros('2',ntip2,npos,ncol,srod,false);
           end
         else
           begin
            str(ni,sS);
            pAtrLivros(true);
            pRotFrmLivros(0);
            pRodape('Numero de Inscricao, nao encontrado !',' ',
            mnCor[7,1],mnCor[7,2]);
            pConFrmLivros('Fechar',ntip2,npos,ncol,srod,true);
           end;
        end
      else
        pConFrmLivros('Fechar',ntip2,npos,ncol,srod,true);
   end
else if stip='2' then
   begin
     with Livros do
      begin
        if ntip2=1 then
          begin
            ntamlivros:=FileSize(fLivros);
            if ntamlivros = 0 then
               nNinsc:=1
            else
               nNinsc:=nTamLivros + 1;
            ni:=nNinsc;
            str(nNinsc,sS);
            pETexto(6,27,sS,mnCor[11,1],mnCor[11,2]);
            sS:='';
          end
        else if ntip2=2 then
          begin
            pAbrirArquivo(1);
            if fnPesLivros('N','Ninsc',ni,'',0)=-1 then
              pRodape('Numero de Inscricao, nao encontrado !',' ',
              mnCor[7,1],mnCor[7,2]);
          end;
          pDigFrmLivros;
      end;
      pConFrmLivros('Salvar',ntip2,npos,ncol,srod,true);
   end
else if stip='3' then
    begin
      sS:='';
      sS:=fsDigita(5,15,sS,30,30,'T',0,mnCor[11,1],mnCor[11,2]);
      Livros.sTitulo:=sS;
      if (length(sS) > 0) and (sS<>fsRepete(' ',length(sS))) then
        begin
         if fnPesLivros('S','Titulo',0,sS,length(sS))<>-1 then
           begin
              pAtrLivros(false);
              pRotFrmLivros(2);
              pRodape(srod,' ',mnCor[6,1],mnCor[6,2]);
           end
         else
           begin
            pAtrLivros(true);
            pRotFrmLivros(2);
            pRodape('Titulo do Livro, nao encontrado !',' ',mnCor[7,1],
            mnCor[7,2]);
           end;
        end;
        pConFrmLivros('Fechar',ntip2,npos,ncol,srod,true);
    end
else if stip='4' then
    begin
      sS:='';
      sS:=fsDigita(5,14,sS,30,30,'T',0,mnCor[11,1],mnCor[11,2]);
      Livros.sAutor:=sS;
      if (length(sS) > 0) and (sS<>fsRepete(' ',length(sS))) then
        begin
         if fnPesLivros('S','Autor',0,sS,length(sS))<>-1 then
           begin
              pAtrLivros(false);
              pRotFrmLivros(2);
              pRodape(srod,' ',mnCor[6,1],mnCor[6,2]);
           end
         else
           begin
            pAtrLivros(true);
            pRotFrmLivros(2);
            pRodape('Autor do Livro, nao encontrado !',' ',mnCor[7,1],mnCor[7,2]);
           end;
        end;
        pConFrmLivros('Fechar',ntip2,npos,ncol,srod,true);
    end
else if stip='5' then
    begin
      sS:='';
      sS:=fsDigita(5,13,sS,4,4,'T',0,mnCor[11,1],mnCor[11,2]);
      Livros.sArea:=sS;
      if (length(sS) > 0) and (sS<>fsRepete(' ',length(sS))) then
        begin
         if fnPesLivros('S','Area',0,sS,length(sS))<>-1 then
           begin
              pAtrLivros(false);
              pRotFrmLivros(2);
              pRodape(srod,' ',mnCor[6,1],mnCor[6,2]);
           end
         else
           begin
            pAtrLivros(true);
            pRotFrmLivros(2);
            pRodape('Area do Livro, nao encontrada !',' ',mnCor[7,1],mnCor[7,2]);
           end;
        end;
        pConFrmLivros('Fechar',ntip2,npos,ncol,srod,true);
    end
else if stip='6' then
    begin
      sS:='';
      sS:=fsDigita(5,22,sS,10,10,'T',0,mnCor[11,1],mnCor[11,2]);
      Livros.sPChave:=sS;
      if (length(sS) > 0) and (sS<>fsRepete(' ',length(sS))) then
        begin
         if fnPesLivros('S','Pchave',0,sS,length(sS))<>-1 then
           begin
              pAtrLivros(false);
              pRotFrmLivros(2);
              pRodape(srod,' ',mnCor[6,1],mnCor[6,2]);
           end
         else
           begin
            pAtrLivros(true);
            pRotFrmLivros(2);
            pRodape('Palavra-Chave do Livro, nao encontrado !',' ',
            mnCor[7,1],mnCor[7,2]);
           end;
        end;
        pConFrmLivros('Fechar',ntip2,npos,ncol,srod,true);
    end
else if stip='7' then
  begin
    nListapos:=npos;
    nListacol:=ncol;
    if fnLista(1,6,5,13,70,nTamLivros+2,220,mnCor[8,1],mnCor[8,2],
       mnCor[10,1],mnCor[10,2],bfco)=1 then
      begin
        pDesLista(1,6,5,13,70,nTamLivros+2,220,mnCor[8,1],mnCor[8,2],
        mnCor[10,1],mnCor[10,2],nListapos,nListacol,false);
        pConFrmLivros('Fechar',ntip2,npos,ncol,srod,true);
      end;
  end
else if stip='Salvar' then
  begin
    case fnBotao(20,45,' Salvar ',mnCor[9,1],mnCor[9,2],black,
         mnCor[8,2],bfco) of
      1:begin
          pDesBotao(20,45,' Salvar ',mnCor[9,1],mnCor[9,2],black,
          mnCor[8,2],false);
          pConFrmLivros('Fechar',ntip2,npos,ncol,srod,true);
        end;
      2:begin
          pSlvLivros(ntip2);
          pDesBotao(20,45,' Salvar ',mnCor[9,1],mnCor[9,2],black,
          mnCor[8,2],false);
          pConFrmLivros('Fechar',ntip2,npos,ncol,srod,true);
        end;
    end;
  end
else if stip = 'Fechar' then
  begin
    case fnBotao(20,60,' Fechar ',mnCor[9,1],mnCor[9,2],black,
         mnCor[8,2],bfco) of
      1:begin
          pDesBotao(20,60,' Fechar ',mnCor[9,1],mnCor[9,2],black,
          mnCor[8,2],false);
          if ntip2=1 then
            pConFrmLivros('2',ntip2,npos,ncol,srod,true)
          else if ntip2=2 then
            pConFrmLivros('1',ntip2,npos,ncol,srod,false)
          else if ntip2=3 then
            pConFrmLivros('3',ntip2,npos,ncol,srod,false)
          else if ntip2=4 then
            pConFrmLivros('4',ntip2,npos,ncol,srod,false)
          else if ntip2=5 then
            pConFrmLivros('5',ntip2,npos,ncol,srod,false)
          else if ntip2=6 then
            pConFrmLivros('6',ntip2,npos,ncol,srod,false)
          else if ntip2=7 then
            pConFrmLivros('7',ntip2,npos,ncol,srod,true);

        end;
      2:begin
         pRodape('',' ',mnCor[6,1],mnCor[6,2]);
         close(fLivros);
        end;
    end;
  end;

end;

{-------------------------------------------------------}

{
 Nome : pAtrLivros
 Descricao : procedimento que atribui ou limpa o vetor de livros.
 Parametros :
 blimpar - indica se vai limpar ou atribuir os vetores
}
procedure pAtrLivros(blimpar:boolean);
begin
if blimpar=false then
 begin
  with Livros do
    begin
      str(nNinsc,sS);
      vsLivros[1]:=sS;
      vsLivros[2]:=sTitulo;
      vsLivros[3]:=sAutor;
      vsLivros[4]:=sArea;
      vsLivros[5]:=sPchave;
      Str(nEdicao,sS);
      vsLivros[6]:=sS;
      Str(nAnoPubli,sS);
      vsLivros[7]:=sS;
      vsLivros[8]:=sEditora;
      Str(nVolume,sS);
      vsLivros[9]:=sS;
      vsLivros[10]:=cEstado;
    end;
 end
else
 begin
  vsLivros[2]:=fsRepete(' ',30);
  vsLivros[3]:=fsRepete(' ',30);
  vsLivros[4]:=fsRepete(' ',30);
  vsLivros[5]:=fsRepete(' ',10);
  vsLivros[6]:=fsRepete(' ',4);
  vsLivros[7]:=fsRepete(' ',4);
  vsLivros[8]:=fsRepete(' ',30);
  vsLivros[9]:=fsRepete(' ',4);
  vsLivros[10]:=fsRepete(' ',1);
 end;
end;

{-------------------------------------------------------}

{
 Nome : pDigFrmLivros
 Descricao : procedimento que realiza o cotrole de digitacao dos dados no
 formulario de livros.
}
procedure pDigFrmLivros;
var
 ni, ncode : integer;
begin
     with Livros do
      begin
        sS:=sTitulo;
        sS:=fsDigita(5,45,sS,30,30,'T',0,mnCor[11,1],mnCor[11,2]);
        sTitulo:=sS;
        sS:=sAutor;
        sS:=fsDigita(7,14,sS,30,30,'T',0,mnCor[11,1],mnCor[11,2]);
        sAutor:=sS;
        sS:=sArea;
        sS:=fsDigita(9,13,sS,30,30,'T',0,mnCor[11,1],mnCor[11,2]);
        sArea:=sS;
        sS:=sPChave;
        sS:=fsDigita(11,22,sS,10,10,'T',0,mnCor[11,1],mnCor[11,2]);
        sPchave:=sS;
        Str(nEdicao,sS);
        sS:=fsDigita(11,45,sS,4,4,'N',0,mnCor[11,1],mnCor[11,2]);
        val(sS,ni,ncode);
        nEdicao:=ni;
        Str(nAnoPubli,sS);
        sS:=fsDigita(13,26,sS,4,4,'N',0,mnCor[11,1],mnCor[11,2]);
        val(sS,ni,ncode);
        nAnoPubli:=ni;
        sS:=sEditora;
        sS:=fsDigita(13,46,sS,30,30,'T',0,mnCor[11,1],mnCor[11,2]);
        sEditora:=sS;
        str(nVolume,sS);
        sS:=fsDigita(15,15,sS,4,4,'N',0,mnCor[11,1],mnCor[11,2]);
        val(sS,ni,ncode);
        nVolume:=ni;
        sS:=cEstado;
        sS:=fsDigita(15,38,sS,1,1,'T',0,mnCor[11,1],mnCor[11,2]);
        cEstado:=sS[1];
        sS:='';
      end;
end;

{-------------------------------------------------------}

{
 Nome : fbVrfLivros
 Descricao : funcao que verifica se os dados no formulario de livros
 foram digitados.
}
function fbVrfLivros:boolean;
begin
with Livros do
 begin
  str(nNinsc,sS);
  if (length(sS) = 0) and (sS=fsRepete(' ',length(sS))) then
    begin
      pRodape('Numero de Inscricao, nao cadastrado !',' ',mnCor[7,1],
      mnCor[7,2]);
      fbVrfLivros:=false;
      exit
    end;
  if (length(sTitulo) = 0) and (sTitulo=fsRepete(' ',length(sTitulo))) then
    begin
      pRodape('Titulo, nao cadastrado !',' ',mnCor[7,1],mnCor[7,2]);
      fbVrfLivros:=false;
      exit
    end;
  if (length(sAutor) = 0) and (sAutor=fsRepete(' ',length(sAutor))) then
    begin
      pRodape('Autor, nao cadastrado !',' ',mnCor[7,1],mnCor[7,2]);
      fbVrfLivros:=false;
      exit
    end;
  if (length(sArea) = 0) and (sArea=fsRepete(' ',length(sArea))) then
    begin
      pRodape('Area, nao cadastrada !',' ',mnCor[7,1],mnCor[7,2]);
      fbVrfLivros:=false;
      exit
    end;
  if (length(sPchave) = 0) and (sPchave=fsRepete(' ',length(sPchave))) then
    begin
      pRodape('Palavra-Chave, nao cadastrada !',' ',mnCor[7,1],mnCor[7,2]);
      fbVrfLivros:=false;
      exit
    end;
  str(nEdicao,sS);
  if (length(sS) = 0) and (sS=fsRepete(' ',length(sS))) then
    begin
      pRodape('Edicao, nao cadastrada !',' ',mnCor[7,1],mnCor[7,2]);
      fbVrfLivros:=false;
      exit
    end;
  str(nAnoPubli,sS);
  if (length(sS) = 0) and (sS=fsRepete(' ',length(sS))) then
    begin
      pRodape('Ano de Publicacao, nao cadastrado !',' ',
      mnCor[7,1],mnCor[7,2]);
      fbVrfLivros:=false;
      exit
    end;
  if (length(sEditora) = 0) and (sEditora=fsRepete(' ',length(sEditora))) then
    begin
      pRodape('Editora, nao cadastrada !',' ',mnCor[7,1],mnCor[7,2]);
      fbVrfLivros:=false;
      exit
    end;
  str(nVolume,sS);
  if (length(sS) = 0) and (sS=fsRepete(' ',length(sS))) then
    begin
      pRodape('Volume, nao cadastrado !',' ',mnCor[7,1],mnCor[7,2]);
      fbVrfLivros:=false;
      exit
    end;
  if (length(cEstado) = 0) and (cEstado=fsRepete(' ',length(cEstado))) then
    begin
      pRodape('Estado, nao cadastrado !',' ',mnCor[7,1],mnCor[7,2]);
      fbVrfLivros:=false;
      exit
    end;

 end;
 fbVrfLivros:=true;
end;

{---------------------------------------------------------------}

{
 Nome : pSlvLivros
 Descricao : procedimento que salva os dados digitados no
 formulario de livros.
 Parametros :
 ntip - indica qual acao a salvar
}
procedure pSlvLivros(ntip:integer);
begin
if fbVrfLivros=true then
begin
if (Livros.cEstado='D') or (Livros.cEstado='E') then
  begin
    if ntip=1 then
      begin
        seek(fLivros,nTamLivros);
        write(fLivros,Livros);
        pAtrLivros(true);
        pRotFrmLivros(0);
        pLprLivros;
      end
    else if ntip=2 then
       write(fLivros,Livros);
  end
else
  pRodape('Estado Atual, Cadastrado Incorretamente !',' ',
  mnCor[7,1],mnCor[7,2]);
end;

end;

end.
