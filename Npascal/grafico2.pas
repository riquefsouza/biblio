{ Modulo de Graficos especificos }
unit grafico2;

interface

uses crt, rotinas1, grafico1, rotinas2;

var
 { variaveis de lista }

 nListapos, nListacol : integer;
 vsLista : array[0..50] of string;

{ Declaracao de funcoes de graficos especificos }

function fnLista(nnum,ntop,nesq,nalt,nlrg,ntlin,ntcol,
                 nfg,nbg,nrfg,nrbg:integer;bfco:boolean): integer;
function fsTiposLista(nnum,nlrg,npos,ncol:integer):string;
function fnCaixaLista(nnum,ntop,nesq,nalt,nlrg,nqtd,nopc,
                      nfg,nbg,nlfg,nlbg,nrfg,nrbg:integer;
                      bfco:boolean):integer;

{ Declaracao de Procedimentos de graficos especificos }

procedure pDesLista(nnum,ntop,nesq,nalt,nlrg,ntlin,ntcol,
                    nfg,nbg,nrfg,nrbg,npos,ncol:integer;bfco:boolean);
procedure pDesCaixaLista(nnum,ntop,nesq,nalt,nlrg,nqtd,npossel,npriop,nopc,
                         nfg,nbg,nlfg,nlbg,nrfg,nrbg:integer;bfco:boolean);
procedure pRetCaixaLista(nnum,nopc:integer);

implementation

{
 Nome : pDesLista
 Descricao : procedimento que desenha uma Lista rolavel na tela
 Parametros :
 nnum - indica o numero de qual arquivo a ser aberto
 ntop - posicao da linha inicial na tela
 nesq - posicao da coluna inicial na tela
 nalt - indica a altura da lista
 nlrg - indica a largura da lista
 ntlin - indica o numero total de linhas da lista
 ntcol - indica o numero total de colunas da lista
 nfg - cor do texto
 nbg - cor de fundo
 nrfg - cor do texto da barra de rolagem
 nrbg - cor de fundo da barra de rolagem
 npos - indica a ultima posicao da linha da lista na tela
 ncol - indica a ultima posicao da coluna da lista na tela
 bfco - indica se a lista esta focada ou nao
}
procedure pDesLista(nnum,ntop,nesq,nalt,nlrg,ntlin,ntcol,
                    nfg,nbg,nrfg,nrbg,npos,ncol:integer;bfco:boolean);
var
 ncont:integer;
 spos,scol:string;
 slista:string;
begin
if bfco=true then
  begin
   pETexto(ntop-1,nesq-1,chr(218),nfg,nbg);
   pETexto(ntop-1,nesq+nlrg+1,chr(191),nfg,nbg);
   pETexto(ntop+nalt,nesq-1,chr(192),nfg,nbg);
   pETexto(ntop+nalt,nesq+nlrg+1,chr(217),nfg,nbg);
   pBarraRolagem(1,2,ntop-1,nesq+nlrg+1,nalt+1,nlrg,nrfg,nrbg,
   ntlin-nalt+1,npos+1);
   pBarraRolagem(2,2,ntop+nalt,nesq-1,nalt,nlrg+2,nrfg,nrbg,
   ntcol-nlrg+1,ncol+1);
 end
else
 begin
   pETexto(ntop-1,nesq-1,' ',nfg,nbg);
   pETexto(ntop-1,nesq+nlrg+1,' ',nfg,nbg);
   pETexto(ntop+nalt,nesq-1,' ',nfg,nbg);
   pETexto(ntop+nalt,nesq+nlrg+1,' ',nfg,nbg);
 end;
pAbrirArquivo(nnum);
slista:=fsTiposLista(nnum,nlrg,npos+1,ncol+1);
pETexto(ntop,nesq,slista+fsRepete(' ',nlrg-length(slista)),nfg,nbg);
for ncont:=1 to nalt-2 do
 begin
  slista:=fsTiposLista(nnum,nlrg,npos+ncont+1,ncol+1);
  pETexto(ntop+ncont,nesq,slista+
  fsRepete(' ',nlrg-length(slista)),nfg,nbg);
 end;
slista:=fsTiposLista(nnum,nlrg,npos+nalt,ncol+1);
pETexto(ntop+nalt-1,nesq,slista+
fsRepete(' ',nlrg-length(slista)),nfg,nbg);

str(npos+1,spos);
pETexto(ntop+nalt+1,nesq,'Linha : '+
fsRepete('0',4-length(spos))+spos,nfg,nbg);
str(ncol+1,scol);
pETexto(ntop+nalt+1,nesq+14,'Coluna : '+
fsRepete('0',4-length(scol))+scol,nfg,nbg);

end;

{-------------------------------------------}

{
 Nome : fsTiposLista
 Descricao : funcao que indica quais arquivos serao usados com a lista,
 como tambem a formatacao do cabecalho desses arquivos na lista
 Parametros :
 nnum - indica o numero de qual arquivo a ser aberto
 nlrg - indica a largura do texto
 npos - indica a posicao do texto na lista
 ncol - indica a posicao da coluna do texto na lista
}
function fsTiposLista(nnum,nlrg,npos,ncol:integer):string;
var
 saux:string;
begin
if nnum=1 then
  begin
    if npos=1 then
      begin
        saux:='Numero de Inscricao ³ Titulo                         ³ ';
        saux:=saux+'Autor                          ³ ';
        saux:=saux+'Area                           ³ Palavra-Chave ³ ';
        saux:=saux+'Edicao ³ Ano de Publicacao ³ ';
        saux:=saux+'Editora                        ³ Volume ³ Estado Atual';
        fsTiposLista:=copy(saux,ncol,nlrg);
      end;
    if npos=2 then
      fsTiposLista:=fsRepete('-',nlrg);
    if npos > 2 then
     begin
      if nTamLivros > npos-3 then
       begin
        seek(fLivros,npos-3);
        read(fLivros,Livros);
        with Livros do
         begin
          str(nNinsc,sS);
          saux:=fsRepete(' ',19-length(sS))+sS+' ³ ';
          saux:=saux+sTitulo+fsRepete(' ',31-length(sTitulo))+'³ ';
          saux:=saux+sAutor+fsRepete(' ',31-length(sAutor))+'³ ';
          saux:=saux+sArea+fsRepete(' ',31-length(sArea))+'³ ';
          saux:=saux+sPchave+fsRepete(' ',14-length(sPchave))+'³ ';
          str(nEdicao,sS);
          saux:=saux+fsRepete(' ',6-length(sS))+sS+' ³ ';
          str(nAnoPubli,sS);
          saux:=saux+fsRepete(' ',17-length(sS))+sS+' ³ ';
          saux:=saux+sEditora+fsRepete(' ',31-length(sEditora))+'³ ';
          str(nVolume,sS);
          saux:=saux+fsRepete(' ',6-length(sS))+sS+' ³ ';
          if cEstado='D' then
             saux:=saux+'Disponivel'
          else
             saux:=saux+'Emprestado';
         end;
         fsTiposLista:=copy(saux,ncol,nlrg);
       end
      else
         fsTiposLista:='';
     end;
  end
else if nnum=2 then
  begin
    if npos=1 then
      begin
        saux:='Numero de Inscricao ³ Nome                           ³ ';
        saux:=saux+'Identidade ³ Logradouro                     ³ ';
        saux:=saux+'Numero ³ Complemento ³ ';
        saux:=saux+'Bairro               ³ Cep      ³ ';
        saux:=saux+'Telefone    ³ Categoria   ³ Situacao';
        fsTiposLista:=copy(saux,ncol,nlrg);
      end;
    if npos=2 then
      fsTiposLista:=fsRepete('-',nlrg);
    if npos > 2 then
     begin
      if nTamUsuarios > npos-3 then
       begin
        seek(fUsuarios,npos-3);
        read(fUsuarios,Usuarios);
        with Usuarios do
         begin
          str(nNinsc,sS);
          saux:=fsRepete(' ',19-length(sS))+sS+' ³ ';
          saux:=saux+sNome+fsRepete(' ',31-length(sNome))+'³ ';
          saux:=saux+fsRepete(' ',10-length(sIdent))+sIdent+' ³ ';
          saux:=saux+Endereco.sLogra+fsRepete(' ',31-length(Endereco.sLogra))+'³ ';
          str(Endereco.nNumero,sS);
          saux:=saux+fsRepete(' ',6-length(sS))+sS+' ³ ';
          saux:=saux+Endereco.sCompl+fsRepete(' ',12-length(Endereco.sCompl))+'³ ';
          saux:=saux+Endereco.sBairro+fsRepete(' ',21-length(Endereco.sBairro))+'³ ';
          saux:=saux+fsRepete(' ',8-length(Endereco.sCep))+Endereco.sCep+' ³';
          saux:=saux+fsRepete(' ',12-length(sTelefone))+sTelefone+' ³ ';
          if cCategoria='A' then
             saux:=saux+'Aluno'+fsRepete(' ',12-length('Aluno'))+'³ '
          else if cCategoria='P' then
             saux:=saux+'Professor'+fsRepete(' ',12-length('Professor'))+'³ '
          else if cCategoria='F' then
             saux:=saux+'Funcionario'+
             fsRepete(' ',12-length('Funcionario'))+'³ ';
          str(nSituacao,sS);
          saux:=saux+fsRepete(' ',8-length(sS))+sS;
         end;
         fsTiposLista:=copy(saux,ncol,nlrg);
       end
      else
         fsTiposLista:='';
     end;
  end
else if nnum=3 then
  begin
    if npos=1 then
      begin
        saux:='Numero de Inscricao do Usuario ³ ';
        saux:=saux+'Numero de Inscricao do Livro ³ ';
        saux:=saux+'Data do Emprestimo ³ Data da Devolucao ³ ';
        saux:=saux+'Removido';
        fsTiposLista:=copy(saux,ncol,nlrg);
      end;
    if npos=2 then
      fsTiposLista:=fsRepete('-',nlrg);
    if npos > 2 then
     begin
      if nTamEmprestimos > npos-3 then
       begin
        seek(fEmprestimos,npos-3);
        read(fEmprestimos,Emprestimos);
        with Emprestimos do
         begin
          sS:='';
          str(nNinscUsuario,sS);
          saux:=fsRepete(' ',30-length(sS))+sS+' ³ ';
          str(nNinscLivro,sS);
          saux:=saux+fsRepete(' ',28-length(sS))+sS+' ³ ';
          saux:=saux+sDtEmprestimo+fsRepete(' ',19-length(sDtEmprestimo))+'³ ';
          saux:=saux+sDtDevolucao+fsRepete(' ',18-length(sDtDevolucao))+'³ ';
          if bRemovido=true then
             saux:=saux+'Sim'
          else
             saux:=saux+'Nao';
         end;
         fsTiposLista:=copy(saux,ncol,nlrg);
       end
      else
         fsTiposLista:='';
     end;
  end
else if nnum=4 then
    fsTiposLista:=copy(vsLista[npos-1],ncol,length(vsLista[npos-1]));

end;

{-------------------------------------------}

{
 Nome : fnLista
 Descricao : funcao que executa a acao de rolamento da lista.
 Parametros :
 nnum - indica o numero de qual arquivo a ser aberto
 ntop - posicao da linha inicial na tela
 nesq - posicao da coluna inicial na tela
 nlrg - indica a largura da lista
 ntlin - indica o numero total de linhas da lista
 ntcol - indica o numero total de colunas da lista
 nfg - cor do texto
 nbg - cor de fundo
 nrfg - cor do texto da barra de rolagem
 nrbg - cor de fundo da barra de rolagem
 bfco - indica se a lista esta focada ou nao
}
function fnLista(nnum,ntop,nesq,nalt,nlrg,ntlin,ntcol,
               nfg,nbg,nrfg,nrbg:integer;bfco:boolean): integer;
var
 ncont2:integer;
 spos,scol,slista:string;
begin

pDesLista(nnum,ntop,nesq,nalt,nlrg,ntlin,ntcol,nfg,nbg,nrfg,nrbg,
nListapos,nListacol,bfco);

Repeat

 nTecla:=fnTeclar;

  if nTecla=TUP then
    begin
     if nListapos > 0 then
       begin
         nListapos:=nListapos-1;
         for ncont2:=0 to nalt-1 do
            begin
              slista:=fsTiposLista(nnum,nlrg,nListapos+ncont2+1,nListacol+1);
              pETexto(ntop+ncont2,nesq,slista+
              fsRepete(' ',nlrg-length(slista)),nfg,nbg);
            end;
         pBarraRolagem(1,2,ntop-1,nesq+nlrg+1,nalt+1,nlrg,nrfg,nrbg,
         ntlin-nalt+1,nListapos+1);
         str(nListapos+1,spos);
         pETexto(ntop+nalt+1,nesq,'Linha : '+
         fsRepete('0',4-length(spos))+spos,nfg,nbg);
       end;
    end;

  if nTecla=TDOWN then
    begin
     if nListapos < (ntlin-nalt) then
       begin
         nListapos:=nListapos+1;
         for ncont2:=0 to nalt-1 do
            begin
              slista:=fsTiposLista(nnum,nlrg,nListapos+ncont2+1,nListacol+1);
              pETexto(ntop+ncont2,nesq,slista+
              fsRepete(' ',nlrg-length(slista)),nfg,nbg);
            end;
         pBarraRolagem(1,2,ntop-1,nesq+nlrg+1,nalt+1,nlrg,nrfg,nrbg,
         ntlin-nalt+1,nListapos+1);
         str(nListapos+1,spos);
         pETexto(ntop+nalt+1,nesq,'Linha : '+
         fsRepete('0',4-length(spos))+spos,nfg,nbg);
       end;
    end;

  if nTecla=TRIGHT then
    begin
     if nListacol < (ntcol-nlrg) then
       begin
         nListacol:=nListacol+1;
         for ncont2:=0 to nalt-1 do
            begin
              slista:=fsTiposLista(nnum,nlrg,nListapos+ncont2+1,nListacol+1);
              pETexto(ntop+ncont2,nesq,slista+
              fsRepete(' ',nlrg-length(slista)),nfg,nbg);
            end;
         pBarraRolagem(2,2,ntop+nalt,nesq-1,nalt,nlrg+2,nrfg,nrbg,
         ntcol-nlrg+1,nListacol+1);
         str(nListacol+1,scol);
         pETexto(ntop+nalt+1,nesq+14,'Coluna : '+
         fsRepete('0',4-length(scol))+scol,nfg,nbg);

       end;
    end;

  if nTecla=TLEFT then
    begin
     if nListacol > 0 then
       begin
         nListacol:=nListacol-1;
         for ncont2:=0 to nalt-1 do
            begin
              slista:=fsTiposLista(nnum,nlrg,nListapos+ncont2+1,nListacol+1);
              pETexto(ntop+ncont2,nesq,slista+
              fsRepete(' ',nlrg-length(slista)),nfg,nbg);
            end;
         pBarraRolagem(2,2,ntop+nalt,nesq-1,nalt,nlrg+2,nrfg,nrbg,
         ntcol-nlrg+1,nListacol+1);
         str(nListacol+1,scol);
         pETexto(ntop+nalt+1,nesq+14,'Coluna : '+
         fsRepete('0',4-length(scol))+scol,nfg,nbg);
       end;
    end;

until nTecla=TTAB;
if nTecla=TTAB then
  fnLista:=1;
end;

{-----------------------------------------------------}

{
 Nome : pDesCaixaLista
 Descricao : procedimento que desenha uma caixa de listagem rolavel na tela
 Parametros :
 nnum - indica o numero de qual e a caixa de lista
 ntop - posicao da linha inicial na tela
 nesq - posicao da coluna inicial na tela
 nalt - indica a altura da lista
 nlrg - indica a largura da lista
 nqtd - indica a quantidade de itens
 npossel - posicao do selecionado
 npriop - valor da primeira opcao na primeira linha
 nopc - opcao selecionada
 nfg - cor do texto
 nbg - cor de fundo
 nlfg - cor do texto do selecionado
 nlbg - cor de fundo do selecionado
 nrfg - cor do texto da barra de rolagem
 nrbg - cor de fundo da barra de rolagem
 bfco - indica se a lista esta focada ou nao
}
procedure pDesCaixaLista(nnum,ntop,nesq,nalt,nlrg,nqtd,npossel,npriop,nopc,
                         nfg,nbg,nlfg,nlbg,nrfg,nrbg:integer;bfco:boolean); 
var
 ncont:integer;
begin

if bfco=false then
 begin
  if nopc < nalt then
   npossel:=ntop+nopc
  else
   npossel:=ntop+nalt-1;
 end;

pETexto(ntop,nesq,chr(218),nfg,nbg);
for ncont:=1 to nlrg-1 do
 pETexto(ntop,nesq+ncont,chr(196),nfg,nbg);
pETexto(ntop,nesq+nlrg,chr(191),nfg,nbg);

pETexto(ntop+nalt,nesq,chr(192),nfg,nbg);
for ncont:=1 to nlrg-1 do
 pETexto(ntop+nalt,nesq+ncont,chr(196),nfg,nbg);
pETexto(ntop+nalt,nesq+nlrg,chr(217),nfg,nbg);

pBarraRolagem(1,2,ntop,nesq+nlrg,nalt,nlrg,nrfg,nrbg,nqtd,nopc);

for ncont:=1 to nalt-1 do
begin
 pETexto(ntop+ncont,nesq,chr(179),nfg,nbg);

 pETexto(ntop+ncont,nesq+1,' ',nfg,nbg);
 pETexto(ntop+ncont,nesq+nlrg-1,' ',nfg,nbg);

 if (ncont+ntop)=npossel then
  begin
   pETexto(ntop+ncont,nesq+2,
   msCaixaLista[nnum,nopc]+fsRepete(' ',nlrg-length(msCaixaLista[nnum,nopc])-3)
   ,nlfg,nlbg);
   if bfco=true then
    begin
     pETexto(ntop+ncont,nesq+1,'[',nlfg,nlbg);
     pETexto(ntop+ncont,nesq+nlrg-1,']',nlfg,nlbg);
    end;
  end
 else
   pETexto(ntop+ncont,nesq+2,
   msCaixaLista[nnum,npriop+ncont-1]+
   fsRepete(' ',nlrg-length(msCaixaLista[nnum,npriop+ncont-1])-3),nfg,nbg);
end;

end;

{-------------------------------------------}

{
 Nome : fnCaixaLista
 Descricao : funcao que realiza a acao de escolher
 uma opcao na caixa de listagem.
 Parametros :
 nnum - indica o numero de qual e a caixa de lista
 ntop - posicao da linha inicial na tela
 nesq - posicao da coluna inicial na tela
 nalt - indica a altura da lista
 nlrg - indica a largura da lista
 nqtd - indica a quantidade de itens
 nop - opcao selecionada
 nfg - cor do texto
 nbg - cor de fundo
 nlfg - cor do texto do selecionado
 nlbg - cor de fundo do selecionado
 nrfg - cor do texto da barra de rolagem
 nrbg - cor de fundo da barra de rolagem
 bfco - indica se a lista esta focada ou nao
}
function fnCaixaLista(nnum,ntop,nesq,nalt,nlrg,nqtd,nopc,
                  nfg,nbg,nlfg,nlbg,nrfg,nrbg:integer;bfco:boolean):integer; 
var
  nret,npriop,npossel: integer;
begin
if nopc >= nalt then
 npriop:=(nopc-(nalt-1))+1
else
 npriop:=1;

if nopc < nalt then
 npossel:=ntop+nopc
else
 npossel:=ntop+nalt-1;

pDesCaixaLista(nnum,ntop,nesq,nalt,nlrg,nqtd,npossel,npriop,nopc,
               nfg,nbg,nlfg,nlbg,nrfg,nrbg,bfco);
nret:=nopc;
pRetCaixaLista(nnum,nopc);
Repeat

nTecla:=fnTeclar;

if bfco=true then
 begin
  if nTecla=TUP then
    begin
     if nopc>1 then
      begin
       nopc:=nopc-1;
       if npossel = (ntop+1) then
         npriop:=npriop-1;
       if (ntop+1) < npossel then
         npossel:=npossel-1;
       pDesCaixaLista(nnum,ntop,nesq,nalt,nlrg,nqtd,npossel,npriop,nopc,
                      nfg,nbg,nlfg,nlbg,nrfg,nrbg,true);
       pRetCaixaLista(nnum,nopc);
       nret:=nopc;
      end;
    end;
  if nTecla=TDOWN then
    begin
     if nopc<nqtd then
      begin
       nopc:=nopc+1;
       if npossel = (ntop+nalt-1) then
         npriop:=npriop+1;
       if (ntop+nalt-1) > npossel then
         npossel:=npossel+1;
       pDesCaixaLista(nnum,ntop,nesq,nalt,nlrg,nqtd,npossel,npriop,nopc,
                      nfg,nbg,nlfg,nlbg,nrfg,nrbg,true);
       pRetCaixaLista(nnum,nopc);
       nret:=nopc;
      end;
    end;
 end;

until nTecla=TTAB;
pDesCaixaLista(nnum,ntop,nesq,nalt,nlrg,nqtd,npossel,npriop,nopc,
               nfg,nbg,nlfg,nlbg,nrfg,nrbg,false);
fnCaixaLista:=nret;
end;

{-------------------------------------------}

{
 Nome : pRetCaixaLista
 Descricao : procedimento que retorna a opcao de uma caixa de listagem.
 Parametros :
 nnum - indica o numero de qual e a caixa de lista
 nopc - opcao selecionada
}
procedure pRetCaixaLista(nnum,nopc:integer);
var
 nfg,nbg,npriop,npossel:integer;
begin
 case nnum of
  1:begin

     if mnCor[nopc,1] >= 8 then
       npriop:=(mnCor[nopc,1]-(8-1))+1
     else
       npriop:=1;

     if mnCor[nopc,2] < 8 then
       npossel:=fnCenTop(17)+3+mnCor[nopc,2]
     else
       npossel:=fnCenTop(17)+3+8-1;

     pDesCaixaLista(2,fnCenTop(17)+3,fnCenEsq(70)+31,8,17,
     16,npossel,npriop,mnCor[nopc,1]+1,
     white,blue,blue,white,white,black,false);

     pDesCaixaLista(3,fnCenTop(17)+3,fnCenEsq(70)+51,8,17,
     16,npossel,npriop,mnCor[nopc,2]+1,
     white,blue,blue,white,white,black,false);

     pETexto(fnCenTop(17)+13,fnCenEsq(70)+20,' Escolha as cores para o item ',
     mnCor[nopc,1],mnCor[nopc,2]);
    end;
  2:begin
      nfg:=nopc-1;
      nbg:=15;
      pETexto(fnCenTop(17)+13,fnCenEsq(70)+20,
      ' Escolha as cores para o item ',nfg,nbg);
    end;
  3:begin
      nfg:=15;
      nbg:=nopc-1;
      pETexto(fnCenTop(17)+13,fnCenEsq(70)+20,
      ' Escolha as cores para o item ',nfg,nbg);
    end;
 end;
end;

end.
