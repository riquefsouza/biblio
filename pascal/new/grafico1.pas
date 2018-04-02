{ Modulo de Graficos gerais }
unit grafico1;

interface

uses crt, rotinas1, mmouse;

var

 { variaveis gerais }

 sS:string;

 { variaveis de menu }

 vsMenu : array[1..10] of string[30];
 msSubMenu : array[1..10,1..15] of string[35];

 { variaveis de OpcaoBotao }

 vsOpcaoBotao : array[1..10] of String[30];

{ Declaracao de funcoes de graficos }

function fsDigita(ntop,nesq:integer;stxt:string;njanelatam,nmaxtam:integer;
                  cft:char;nfundo,nfg,nbg:integer):string;
function fnSubMenu(nnum,ntop,nesq,nqtd,nmaxtam,nultpos,nlfg,nlbg,
                   nfg,nbg:integer):integer;
function fnBotao(ntop,nesq:integer;stxt:string;nfg,nbg,nsfg,nsbg:integer;
                 bfco:boolean):integer;
function fnOpcaoBotao(ntop,nesq,nqtd,nmaxtam,nopc,nfg,nbg:integer;
                      bfco:boolean):integer;

{ Declaracao de Procedimentos de graficos }

procedure pFrm(stit:string;ntop,nesq,nalt,nlrg:integer;
               csombra:char;nfg,nbg,nsfg,nsbg:integer);
procedure pMenu(ntop,nqtd,nfg,nbg,nlfg,nlbg,npos,nmfg,nmbg,ncont:integer);
procedure pDesBotao(ntop,nesq:integer;stxt:string;
                    nfg,nbg,nsfg,nsbg:integer;bfco:boolean);
procedure pBarraRolagem(nnum,nnum2,ntop,nesq,nalt,nlrg,
                        nrfg,nrbg,nqtd,nopc:integer);
procedure pDesOpcaoBotao(ntop,nesq,nqtd,nmaxtam,nopc,nfg,nbg:integer;
                         bfco:boolean);
procedure pMiniBotao(ntop,nesq:integer;stxt:string;
                     nfg,nbg,nsfg,nsbg:integer;bfco:boolean);
procedure pDesCalendario(ntop,nesq,ndia,nmes,nano,nfg,nbg:integer);
procedure pCalendario(nnum,ntop,nesq,ndia,nmes,nano,nhor,nmin,nseg,
                      nfg,nbg,ndfg,ndbg,nsfg,nsbg:integer;bfco:boolean);
procedure pDesTabAscii(ntop,nesq,nfg,nbg,nsfg,nsbg:integer;bfco:boolean);
procedure pTabAscii(ntop,nesq,nfg,nbg,nsfg,nsbg:integer;bfco:boolean);
procedure pDesCalculadora(ntop,nesq,nfg,nbg,ndfg,ndbg,nsfg,nsbg:integer);
procedure pCalculadora(ntop,nesq,nfg,nbg,ndfg,ndbg,nsfg,nsbg:integer;
                       bfco:boolean);
procedure pDesQuebraCabeca(ntop,nesq,nfg,nbg,nsfg,nsbg:integer;bfco:boolean);
procedure pQuebraCabeca(ntop,nesq,nfg,nbg,nsfg,nsbg:integer;bfco:boolean);

implementation

{
 Nome : fsDigita
 Descricao : Procedimento que permite ter um maior controle da digitacao
 de um texto, tambem permitindo indicar um texto maior do que o permitido
 pelo espaco limite definido.
 Parametros :
 ntop - posicao da linha na tela
 nesq - posicao da coluna na tela
 stxt - e o texto de entrada
 njanelatam - indica o tamanho maximo de visualizacao do texto digitado
 nmaxtam - indica o tamanho maximo do texto a ser digitado
 cft - indica o tipo de caracter a ser digitado se (N)umero ou (T)exto
 nfundo - Indica o caracter de fundo, da janela de digitacao
 nfg - cor do texto
 nbg - cor de fundo
}
function fsDigita(ntop,nesq:integer;stxt:string;njanelatam,nmaxtam:integer;
                  cft:char;nfundo,nfg,nbg:integer):string; 
var
   nxx, ni, nj, np : integer;
   binserton : boolean;
   ncompensacao : integer;
   stempstr : string;

{-------------------------------------------}

procedure pXY(nx,ny : integer);
var
  nxpequeno : integer;
begin
  repeat
   nxpequeno := nx-80;
   if nxpequeno > 0 then
     begin
       ny:=ny+1;
       nx:=nxpequeno;
     end;
  until nxpequeno <= 0;
 gotoxy(nx-1,ny+1);
end;

{-------------------------------------------}

procedure pSetaString;
var
 ni : integer;
begin
ni:=length(stxt);
while stxt[ni] = char(nfundo) do
  ni:=ni-1;
stxt[0]:=char(ni);
{pSetaCursor(normal);}
end;

{-------------------------------------------}

begin
nj:=length(stxt)+1;
for ni:=nj to nmaxtam do
   stxt[ni]:=char(nfundo);
stxt[0]:=char(nmaxtam);

stempstr:=copy(stxt,1,njanelatam);
pETexto(ntop+1,nesq-1,stempstr,nfg,nbg);
np:=1;
ncompensacao:=1;
binserton:=true;

pSetaCursor(normal);

repeat
    nxx:=nesq+(np-ncompensacao);
    if (np-ncompensacao) = njanelatam then
       nxx:=nxx-1;

pXY(nxx,ntop);

if binserton then
  pSetaCursor(normal)
else
  pSetaCursor(solido);

 if keypressed=true then
   nTecla:=fnTeclar
 else
  begin
   nTecla:=TNULL;
   pLerMouse;
  end;

{pSetaCursor(nenhum);}


if (cft='N') then
  begin
   if (nTecla = TTEXTO) then
     begin
      pBeep(100,250);
      nTecla:=TNULL;
     end
   else if (cTecla='-') and ((np>1) or (stxt[1]='-')) then
    begin
     pBeep(100,250);
     nTecla:=TNULL;
    end
   else if (cTecla='.') then
    begin
     if not((pos('.',stxt)=0) or (pos('.',stxt)=np)) then
       begin
        pBeep(100,250);
        nTecla:=TNULL;
       end
     else if (pos('.',stxt)=np) then
       delete(stxt,np,1);
     end;
    end;

 case nTecla of

   TNUMERO, TTEXTO, TSPACE :
     begin
      if (length(stxt) = nmaxtam) then
        begin
         if np = nmaxtam then
          begin
           delete(stxt,nmaxtam,1);
           stxt:=stxt+cTecla;
           if np = njanelatam+ncompensacao then
             ncompensacao:=ncompensacao + 1;
           stempstr:=copy(stxt,ncompensacao,njanelatam);
           pETexto(ntop+1,nesq-1,stempstr,nfg,nbg);
          end
         else
          begin
           if binserton then
             begin
              delete(stxt,nmaxtam,1);
              insert(cTecla,stxt,np);
              if np = njanelatam+ncompensacao then
                 ncompensacao:=ncompensacao+1;
              if np < nmaxtam then
                 np:=np+1;
              stempstr:=copy(stxt,ncompensacao,njanelatam);
              pETexto(ntop+1,nesq-1,stempstr,nfg,nbg);             
             end
           else 
             begin
              delete(stxt,np,1);
              insert(cTecla,stxt,np);
              if np = njanelatam + ncompensacao then
                 ncompensacao:=ncompensacao+1;
              if np < nmaxtam then
                 np:=np+1;
              stempstr:=copy(stxt,ncompensacao,njanelatam);
              pETexto(ntop+1,nesq-1,stempstr,nfg,nbg);
             end;
           end;
          end
        else
          begin
            if binserton then
              begin
               insert(cTecla,stxt,np);
              end
            else
              begin
               delete(stxt,np,1);
               insert(cTecla,stxt,np);
              end;
            if np = njanelatam+ncompensacao then
               ncompensacao:=ncompensacao+1;
            if np < nmaxtam then
               np:=np+1;
            stempstr:=copy(stxt,ncompensacao,njanelatam);
            pETexto(ntop+1,nesq-1,stempstr,nfg,nbg);
          end;
        end;

   TBS:
     begin
      if np>1 then
        begin
         np:=np-1;
         delete(stxt,np,1);
         stxt:=stxt+char(nfundo);
         if ncompensacao > 1 then
           ncompensacao:=ncompensacao - 1;
         stempstr:=copy(stxt,ncompensacao,njanelatam);        
         pETexto(ntop+1,nesq-1,stempstr,nfg,nbg);
         cTecla:=' ';
        end
      else
        begin
         pBeep(100,250);
         cTecla:=' ';
         np:=1;
        end;
      end;

   TLEFT :
     begin
      if np > 1 then
        begin
         np:=np-1;
         if np < ncompensacao then
           begin
             ncompensacao:=ncompensacao - 1;
             stempstr:=copy(stxt,ncompensacao,njanelatam);            
             pETexto(ntop+1,nesq-1,stempstr,nfg,nbg);
           end;
         end
      else
        begin
         pSetaString;
         { exit; }
        end;
      end;

   TRIGHT :
     begin
      if (stxt[np] <> char(nfundo)) and (np < nmaxtam) then
        begin
         np:=np+1;
         if np = (njanelatam+ncompensacao) then
           begin
             ncompensacao:=ncompensacao + 1;
             stempstr:=copy(stxt,ncompensacao,njanelatam);
             pETexto(ntop+1,nesq-1,stempstr,nfg,nbg);
           end;
         end
      else
        begin
         pSetaString;
         { exit; }
        end;
      end;

   TDEL :
     begin
      delete(stxt,np,1);
      stxt:=stxt+char(nfundo);
      if ((Length(stxt)+1)-ncompensacao) >= njanelatam then
        begin
          stempstr:=copy(stxt,ncompensacao,njanelatam);
          pETexto(ntop+1,nesq-1,stempstr,nfg,nbg);         
        end
      else
        begin
          stempstr:=copy(stxt,ncompensacao,njanelatam);
          pETexto(ntop+1,nesq-1,stempstr,nfg,nbg);
        end;
      end;

   TINS :
      begin
        If binserton then
           binserton:=false
        else
           binserton:=true;
        end;

  else if not( nTecla in [TRET, TUP, TDOWN, TPGDN, TPGUP, TNULL, TESC, TTAB,
               TF1, TF2, TF3, TF4, TF5, TF6, TF7, TF8, TF9, TF10]) then
          pBeep(100,250);
  end;

until (nTecla in [TRET,TTAB]) or ((bMousePress=true) and
      (nMouseBotao=1));

pSetaString;
pSetaCursor(nenhum);
fsDigita:=stxt;
end;

{-------------------------------------------}

{
 Nome : pFrm
 Descricao : procedimento que desenha um formulario na tela.
 Parametros :
 stit - titulo do formulario
 ntop - posicao da linha inicial na tela
 nesq - posicao da coluna inicial na tela
 nalt - a altura do formulario
 nlrg - a largura do formulario
 csombra - o caracter que vai ser a sobra do formulario
 nfg - cor do texto
 nbg - cor de fundo
 nsfg - cor do texto da sombra
 nsbg - cor de fundo da sombra
}
procedure pFrm(stit:string;ntop,nesq,nalt,nlrg:integer;
               csombra:char;nfg,nbg,nsfg,nsbg:integer); 
var
 ncont,ncont2:integer;
begin
  pETexto(ntop,nesq,chr(218),nfg,nbg);
  for ncont:=1 to nlrg-1 do
    pETexto(ntop,nesq+ncont,chr(196),nfg,nbg);
  pETexto(ntop,nesq+2,stit,nfg,nbg);
  pETexto(ntop,nesq+nlrg,chr(191),nfg,nbg);
  for ncont:=1 to nalt-1 do
   begin
    pETexto(ntop+ncont,nesq,chr(179),nfg,nbg);
    for ncont2:=1 to nlrg-1 do
      pETexto(ntop+ncont,nesq+ncont2,' ',nfg,nbg);
    pETexto(ntop+ncont,nesq+nlrg,chr(179),nfg,nbg);
    pETexto(ntop+ncont,nesq+nlrg+1,csombra,nsfg,nsbg);
   end;
  pETexto(ntop+nalt,nesq,chr(192),nfg,nbg);
  for ncont:=1 to nlrg-1 do
   begin
     pETexto(ntop+nalt,nesq+ncont,chr(196),nfg,nbg);
     pETexto(ntop+nalt+1,nesq+ncont+1,csombra,nsfg,nsbg);
   end;
  pETexto(ntop+nalt,nesq+nlrg,chr(217),nfg,nbg);
  pETexto(ntop+nalt,nesq+nlrg+1,csombra,nsfg,nsbg);
  pETexto(ntop+nalt+1,nesq+nlrg+1,csombra,nsfg,nsbg);
end;

{-------------------------------------------}

{
 Nome : fnSubMenu
 Descricao : funcao que permite criar um controle de submenu, retornando
 a opcao selecionada.
 Parametros :
 nnum - indica qual e o submenu
 ntop - posicao da linha inicial na tela
 nesq - posicao da coluna inicial na tela
 nqtd - indica a quantidade de linhas do submenu
 nmaxtam - indica a largura maxima do submenu
 nultpos - indica a ultima opcao referenciada pelo usuario
 nlfg - cor do texto selecionado
 nlbg - cor de fundo selecionado
 nfg - cor do texto 
 nbg - cor de fundo 
}
function fnSubMenu(nnum,ntop,nesq,nqtd,nmaxtam,nultpos,nlfg,nlbg,
                   nfg,nbg:integer):integer;
var
 ncont,ncont2:integer;
begin
 for ncont:=0 to nqtd-1 do
  begin
    if copy(msSubMenu[nnum,ncont+1],1,1)=chr(196) then
     begin
      pETexto(ntop+ncont,nesq-2,chr(195),nfg,nbg);
      for ncont2:=1 to nmaxtam+1 do
       pETexto(ntop+ncont,nesq+ncont2-2,msSubMenu[nnum,ncont+1],nfg,nbg);
      pETexto(ntop+ncont,nesq+nmaxtam,chr(180),nfg,nbg);
     end
    else
      pETexto(ntop+ncont,nesq,msSubMenu[nnum,ncont+1]+
      fsRepete(' ',nmaxtam-length(msSubMenu[nnum,ncont+1])),nfg,nbg);
  end;
 pETexto(ntop+nultpos-1,nesq,msSubMenu[nnum,nultpos]+
 fsRepete(' ',nmaxtam-length(msSubMenu[nnum,nultpos])),nlfg,nlbg);

 ncont:=nultpos-2;
 ncont2:=nultpos-1;
 Repeat

   if keypressed=true then
     nTecla:=fnTeclar
   else
     begin
      nTecla:=TNULL;
      pLerMouse;
     end;

   if nTecla=TUP then
     begin
       ncont:=ncont-1;
       ncont2:=ncont2-1;
       if ncont2=-1 then
         begin
          ncont:=-2;
          ncont2:=nqtd-1;
         end;

       if copy(msSubMenu[nnum,ncont2+1],1,1)=chr(196) then
        begin
         pETexto(ntop+ncont+2,nesq,msSubMenu[nnum,ncont+3]+
         fsRepete(' ',nmaxtam-length(msSubMenu[nnum,ncont+3])),nfg,nbg);
         ncont:=ncont-1;
         ncont2:=ncont2-1;
         pETexto(ntop+ncont2,nesq,msSubMenu[nnum,ncont2+1]+
         fsRepete(' ',nmaxtam-length(msSubMenu[nnum,ncont2+1])),nlfg,nlbg);
        end
       else
        begin
         pETexto(ntop+ncont+2,nesq,msSubMenu[nnum,ncont+3]+
         fsRepete(' ',nmaxtam-length(msSubMenu[nnum,ncont+3])),nfg,nbg);
         pETexto(ntop+ncont2,nesq,msSubMenu[nnum,ncont2+1]+
         fsRepete(' ',nmaxtam-length(msSubMenu[nnum,ncont2+1])),nlfg,nlbg);
        end;

       if ncont=-2 then
          ncont:=nqtd-2;

     end;
   if nTecla=TDOWN then
     begin
       ncont:=ncont+1;
       ncont2:=ncont2+1;
       if ncont2=nqtd then
          ncont2:=0;

       if copy(msSubMenu[nnum,ncont2+1],1,1)=chr(196) then
        begin
         pETexto(ntop+ncont,nesq,msSubMenu[nnum,ncont+1]+
         fsRepete(' ',nmaxtam-length(msSubMenu[nnum,ncont+1])),nfg,nbg);
         ncont:=ncont+1;
         ncont2:=ncont2+1;
         pETexto(ntop+ncont2,nesq,msSubMenu[nnum,ncont2+1]+
         fsRepete(' ',nmaxtam-length(msSubMenu[nnum,ncont2+1])),nlfg,nlbg);
        end
       else
        begin
         pETexto(ntop+ncont,nesq,msSubMenu[nnum,ncont+1]+
         fsRepete(' ',nmaxtam-length(msSubMenu[nnum,ncont+1])),nfg,nbg);
         pETexto(ntop+ncont2,nesq,msSubMenu[nnum,ncont2+1]+
         fsRepete(' ',nmaxtam-length(msSubMenu[nnum,ncont2+1])),nlfg,nlbg);
       end;

       if ncont=nqtd-1 then
          ncont:=-1;

     end;

 until (nTecla in [TRET,TLEFT,TRIGHT]) or ((bMousePress=true) and
      (nMouseBotao=1));

 if (nTecla=TLEFT) then
   fnSubMenu:=1
 else if (nTecla=TRIGHT) then
   fnSubMenu:=2
 else if (nTecla=TRET) then
   fnSubMenu:=ncont2+3
 else if (fbVrfMouse(nMouseTop,nesq,nesq+nmaxtam,1)=true)
         and (nMouseTop >= ntop) then
  begin
   if copy(msSubMenu[nnum,(nMouseTop-ntop)+1],1,1)<>chr(196) then
    begin
     pETexto(ntop+ncont2,nesq,msSubMenu[nnum,ncont2+1]+
     fsRepete(' ',nmaxtam-length(msSubMenu[nnum,ncont2+1])),nfg,nbg);
     pETexto(ntop+(nMouseTop-nTop),nesq,msSubMenu[nnum,(nMouseTop-nTop)+1]+
     fsRepete(' ',nmaxtam-length(msSubMenu[nnum,(nMouseTop-nTop)+1])),nlfg,nlbg);
    end;
    fnSubMenu:=(nMouseTop-nTop)+3;
  end
 else if (bMousePress=true) and (nMouseBotao=1) then
   fnSubMenu:=0;

end;

{-------------------------------------------}

{
 Nome : pMenu
 Descricao : procedimento que escreve a linha de opcoes do menu.
 Parametros :
 ntop - posicao da linha inicial na tela
 nqtd - indica a quantidade de opcoes no menu
 nfg - cor do texto
 nbg - cor de fundo
 nlfg - cor do texto do primeiro caracter de cada opcao do menu
 nlbg - cor de fundo do primeiro caracter de cada opcao do menu
 npos - indica a ultima opcao de menu referenciada pelo usuario
 nmfg - cor do texto do selecionado
 nmbg - cor de fundo do selecionado
 ncont - indica a ultima posicao da descricao da opcao de menu
 referenciada pelo usuario
}
procedure pMenu(ntop,nqtd,nfg,nbg,nlfg,nlbg,npos,nmfg,nmbg,ncont:integer);
var
 ncont2,npos2,nentre:integer;
begin
   for ncont2:=1 to 80 do
      pETexto(ntop,ncont2,' ',nfg,nbg);
   npos2:=0;
   nentre:=0;
   for ncont2:=1 to nqtd do
    begin
      pETexto(ntop,npos2+4+nentre,copy(vsMenu[ncont2],1,1),nlfg,nlbg);
      pETexto(ntop,npos2+5+nentre,copy(vsMenu[ncont2],2,
      length(vsMenu[ncont2])),nfg,nbg);
      nentre:=nentre+3;
      npos2:=npos2+length(vsMenu[ncont2]);
    end;
   if npos > 0 then
     begin
      pETexto(ntop,npos+2,' '+copy(vsMenu[ncont],1,1),nlfg,nmbg);
      pETexto(ntop,npos+4,
      copy(vsMenu[ncont],2,length(vsMenu[ncont]))+' ',nmfg,nmbg);
     end;
end;

{-----------------------------------------------------------------}

{
 Nome : pDesBotao
 Descricao : procedimento que desenha um botao na tela
 Parametros :
 ntop - posicao da linha inicial na tela
 nesq - posicao da coluna inicial na tela
 stxt - o texto a ser escrito no botao
 nfg - cor do texto
 nbg - cor de fundo
 nsfg - cor do texto da sombra
 nsbg - cor de fundo da sombra
 bfco - indica se o botao esta focado ou nao
}
procedure pDesBotao(ntop,nesq:integer;stxt:string;
                    nfg,nbg,nsfg,nsbg:integer;bfco:boolean);
var
 ntam,ncont:integer;
begin
ntam:=length(stxt);
if bfco=false then
   pETexto(ntop,nesq,' '+stxt+' ',nfg,nbg);
if bfco=true then
  pETexto(ntop,nesq,chr(16)+stxt+chr(17),nfg,nbg);
pETexto(ntop,nesq+ntam+2,chr(220),nsfg,nsbg);
for ncont:=1 to ntam+2 do
  pETexto(ntop+1,nesq+ncont,chr(223),nsfg,nsbg);
end;

{-------------------------------------------}

{
 Nome : fnBotao
 Descricao : funcao que realiza a acao de apertar o botao.
 Parametros :
 ntop - posicao da linha inicial na tela
 nesq - posicao da coluna inicial na tela
 stxt - o texto a ser escrito no botao
 nfg - cor do texto
 nbg - cor de fundo
 nsfg - cor do texto da sombra
 nsbg - cor de fundo da sombra
 bfco - indica se o botao esta focado ou nao
}
function fnBotao(ntop,nesq:integer;stxt:string;nfg,nbg,nsfg,nsbg:integer;
                 bfco:boolean):integer;
var
 ntam,ncont:integer;
begin
ntam:=length(stxt);
pDesBotao(ntop,nesq,stxt,nfg,nbg,nsfg,nsbg,bfco);

Repeat

if keypressed=true then
   nTecla:=fnTeclar
else
  begin
   nTecla:=TNULL;
   pLerMouse;
  end;

if bfco=true then
 begin
  if (nTecla=TRET) or (fbVrfMouse(ntop,nesq,nesq+ntam,1)=true) then
    begin
      pETexto(ntop,nesq+1,chr(16)+stxt+chr(17),nfg,nbg);
      pETexto(ntop,nesq,' ',nsfg,nsbg);
      for ncont:=1 to ntam+2 do
        pETexto(ntop+1,nesq+ncont,' ',nsfg,nsbg);
      delay(500);
      fnBotao:=2;
      exit;
    end;
 end;

until (nTecla=TTAB) or ((fbPressMouse=true) and (nMouseBotao=1));
 if (nTecla=TTAB) or ((fbPressMouse=true) and (nMouseBotao=1)) then
    fnBotao:=1;

end;

{-------------------------------------------}

{
 Nome : pBarraRolagem
 Descricao : procedimento que desenha uma barra rolavel na tela
 Parametros :
 nnum - indica 1:vertical, 2:horizontal
 nnum2 - indica o tipo de barra 1:total, 2:unica
 ntop - posicao da linha inicial na tela
 nesq - posicao da coluna inicial na tela
 nalt - indica a altura 
 nlrg - indica a largura 
 nrfg - cor do texto da barra de rolagem
 nrbg - cor de fundo da barra de rolagem
 nqtd - indica a quantidade de itens
 nopc - opcao atual
}
procedure pBarraRolagem(nnum,nnum2,ntop,nesq,nalt,nlrg,
                        nrfg,nrbg,nqtd,nopc:integer); 
var
 ncont,nbtam,nbpos,nfator:integer;
begin

if nnum=1 then
 begin
  pETexto(ntop+1,nesq,chr(24),nrfg,nrbg);
  if nnum2=1 then
    begin
      nbtam:=((nalt-3)-trunc(nqtd div (nalt-3)));
      if (nopc >= (nalt-3)) or (nopc<=nqtd) then
        nbpos:=trunc(nopc div (nalt-3));
    end
  else if nnum2=2 then
   begin
    nbtam:=1;
    if nqtd < 0 then
      nbpos:=0
    else
     begin
      if nqtd >= (nalt-3) then
       begin
        nfator:=trunc(nqtd div (nalt-3));
        while nfator > (nalt-3) do
         nfator:=trunc(nfator div (nalt-3));
        if nfator=0 then
         nfator:=1; 
        if (nopc mod nfator)=0 then
          nbpos:=trunc(nopc div nfator)-1
        else
          nbpos:=trunc(nopc div nfator); 
        if nopc > (nfator*(nalt-3)) then
          nbpos:=(nalt-3)-1; 
       end
      else
       begin
        nfator:=trunc((nalt-3) div nqtd);
        while nfator > nqtd do
         nfator:=trunc(nfator div nqtd);
        if nfator=0 then
         nfator:=1;
        if nopc=1 then
          nbpos:=0
        else if trunc((nalt-3) div nfator) >= nopc then
          nbpos:=(nfator*nopc);
       end;
     end;
   end;
  for ncont:=nbpos+1 to (nbtam+nbpos) do
   pETexto(ntop+ncont+1,nesq,chr(219),nrfg,nrbg);

  for ncont:=1 to nbpos do
   pETexto(ntop+ncont+1,nesq,chr(178),nrfg,nrbg);

  for ncont:=nbpos+nbtam+1 to nalt-2 do
   pETexto(ntop+ncont+1,nesq,chr(178),nrfg,nrbg);

  pETexto(ntop+nalt-1,nesq,chr(25),nrfg,nrbg);
 end
else if nnum=2 then
 begin
  pETexto(ntop,nesq+1,chr(27),nrfg,nrbg);
  if nnum2=1 then
   begin
    nbtam:=((nlrg-3)-trunc(nqtd div (nlrg-3)));
    if (nopc >= (nlrg-3)) or (nopc<=nqtd) then
     nbpos:=trunc(nopc div (nlrg-3));
   end
  else if nnum2=2 then
   begin
    if nqtd < 0 then
      nbpos:=0
    else
     begin
      nbtam:=1;
      if nqtd >= (nlrg-3) then
       begin
        nfator:=trunc(nqtd div (nlrg-3));
        while nfator > (nlrg-3) do
         nfator:=trunc(nfator div (nlrg-3));
        if nfator=0 then
         nfator:=1;
        if (nopc mod nfator)=0 then
          nbpos:=trunc(nopc div nfator)-1
        else
          nbpos:=trunc(nopc div nfator);
        if nopc > (nfator*(nlrg-3)) then
          nbpos:=(nlrg-3)-1;
       end
      else
       begin
        nfator:=trunc((nlrg-3) div nqtd);
        while nfator > nqtd do
         nfator:=trunc(nfator div nqtd);
        if nfator=0 then
         nfator:=1;
        if nopc=1 then
          nbpos:=0
        else if trunc((nlrg-3) div nfator) >= nopc then
          nbpos:=(nfator*nopc);
       end;
     end;
   end;

  for ncont:=nbpos+1 to (nbtam+nbpos) do
   pETexto(ntop,nesq+ncont+1,chr(219),nrfg,nrbg);

  for ncont:=1 to nbpos do
   pETexto(ntop,nesq+ncont+1,chr(178),nrfg,nrbg);

  for ncont:=nbpos+nbtam+1 to nlrg-2 do
   pETexto(ntop,nesq+ncont+1,chr(178),nrfg,nrbg);

  pETexto(ntop,nesq+nlrg-1,chr(26),nrfg,nrbg);
 end;
end;

{-----------------------------------------------------}

{
 Nome : pDesOpcaoBotao
 Descricao : procedimento que desenha um botao de opcoes
 Parametros :
 ntop - posicao da linha inicial na tela
 nesq - posicao da coluna inicial na tela
 nqtd - indica a quantidade de opcoes
 nmaxtam - o maior tamanho de texto 
 nopc - indica a opcao referenciada pelo usuario
 nfg - cor do texto
 nbg - cor de fundo
 bfco - indica se o botao esta focado ou nao
}
procedure pDesOpcaoBotao(ntop,nesq,nqtd,nmaxtam,nopc,nfg,nbg:integer;
                         bfco:boolean);
var
 ncont:integer;
begin
for ncont:=1 to nqtd do
begin
 pETexto(ntop+ncont-1,nesq+3,' ',nfg,nbg);
 pETexto(ntop+ncont-1,nesq+nmaxtam+4,' ',nfg,nbg);

 if nopc=ncont then
  begin
   pETexto(ntop+ncont-1,nesq,'('+chr(249)+')',nfg,nbg);
   pETexto(ntop+ncont-1,nesq+4,vsOpcaoBotao[ncont],nfg,nbg);
   if bfco=true then
    begin
     pETexto(ntop+ncont-1,nesq+3,'[',nfg,nbg);
     pETexto(ntop+ncont-1,nesq+nmaxtam+4,']',nfg,nbg);
    end; 
  end
 else
  begin
   pETexto(ntop+ncont-1,nesq,'( )',nfg,nbg);
   pETexto(ntop+ncont-1,nesq+4,vsOpcaoBotao[ncont],nfg,nbg);
  end;

end;

end;

{-------------------------------------------}

{
 Nome : fnOpcaoBotao
 Descricao : funcao que realiza a acao de escolher
 uma opcao do botao de opcoes.
 Parametros :
 ntop - posicao da linha inicial na tela
 nesq - posicao da coluna inicial na tela
 nqtd - indica a quantidade de opcoes
 nmaxtam - o maior tamanho de texto 
 nopc - indica a opcao referenciada pelo usuario
 nfg - cor do texto
 nbg - cor de fundo
 bfco - indica se o botao esta focado ou nao
}
function fnOpcaoBotao(ntop,nesq,nqtd,nmaxtam,nopc,nfg,nbg:integer;
                      bfco:boolean):integer;
var
 nret:integer;
begin
pDesOpcaoBotao(ntop,nesq,nqtd,nmaxtam,nopc,nfg,nbg,bfco);
nret:=nopc;
Repeat

nTecla:=fnTeclar;

if bfco=true then
 begin
  if nTecla=TUP then
    begin
     if nopc>1 then
      begin
       nopc:=nopc-1;
       pDesOpcaoBotao(ntop,nesq,nqtd,nmaxtam,nopc,nfg,nbg,true);
       nret:=nopc;
      end;
    end;
  if nTecla=TDOWN then
    begin
     if nopc<nqtd then
      begin
       nopc:=nopc+1;
       pDesOpcaoBotao(ntop,nesq,nqtd,nmaxtam,nopc,nfg,nbg,true);
       nret:=nopc;
      end;
    end;
 end;

until nTecla=TTAB;
pDesOpcaoBotao(ntop,nesq,nqtd,nmaxtam,nopc,nfg,nbg,false);
fnOpcaoBotao:=nret;
end;

{-------------------------------------------}

{
 Nome : pDesCalendario
 Descricao : procedimento que mostra o calendario na tela.
 Parametros :
 ntop - posicao da linha inicial na tela
 nesq - posicao da coluna inicial na tela
 ndia - dia
 nmes - mes
 nano - ano
 nfg - cor do texto
 nbg - cor de fundo
}
procedure pDesCalendario(ntop,nesq,ndia,nmes,nano,nfg,nbg:integer);
const
 vsds : array [0..6] of string[3] = ('Dom ','Seg ','Ter ',
 'Qua ','Qui ','Sex ','Sab');
 vsds2 : array [0..6] of string[7] = ('Domingo','Segunda','Terca',
 'Quarta','Quinta','Sexta','Sabado');
 vsmeses : array [1..12] of string[9] = ('Janeiro','Fevereiro','Marco',
 'Abril','Maio','Junho','Julho','Agosto','Setembro',
 'Outubro','Novembro','Dezembro');
 vnudiames : array[1..12] of integer = (31,28,31,30,31,30,31,31,30,31,30,31);
var
 ni,nj,nk,nl,ndowum:integer;
 ndow:integer;
 sdia,smes,sano:string;
begin
  ndow:=fnDiaSemana(ndia,nmes,nano);
  str(ndia,sdia);
  str(nmes,smes);
  str(nano,sano);

  pETexto(ntop,nesq,chr(218),nfg,nbg);
  for ni:=1 to 28 do
   pETexto(ntop,nesq+ni,chr(196),nfg,nbg);
  pETexto(ntop,nesq+29,chr(194),nfg,nbg);
  for ni:=30 to 63 do
   pETexto(ntop,nesq+ni,chr(196),nfg,nbg);
  pETexto(ntop,nesq+64,chr(191),nfg,nbg);

  pETexto(ntop+1,nesq,chr(179),nfg,nbg);
  for ni:=0 to 6 do
   pETexto(ntop+1,nesq+(ni*4)+2,vsds[ni],nfg,nbg);
  pETexto(ntop+1,nesq+29,chr(179),nfg,nbg);
  pETexto(ntop+1,nesq+31,fsRepete(' ',33),nfg,nbg);
  pETexto(ntop+1,nesq+31,
  vsds2[ndow]+', '+sdia+' de '+vsmeses[nmes]+' de '+sano,nfg,nbg);
  pETexto(ntop+1,nesq+64,chr(179),nfg,nbg);

  pETexto(ntop+2,nesq,chr(195),nfg,nbg);
  for ni:=1 to 28 do
   pETexto(ntop+2,nesq+ni,chr(196),nfg,nbg);
  pETexto(ntop+2,nesq+29,chr(197),nfg,nbg);
  for ni:=30 to 63 do
   pETexto(ntop+2,nesq+ni,chr(196),nfg,nbg);
  pETexto(ntop+2,nesq+64,chr(180),nfg,nbg);

  pETexto(ntop+3,nesq+31,'Mes :',nfg,nbg);
  pETexto(ntop+5,nesq+31,'Ano :',nfg,nbg);
  pETexto(ntop+7,nesq+31,'Hora :',nfg,nbg);

  pETexto(ntop+9,nesq,chr(192),nfg,nbg);
  for ni:=1 to 28 do
   pETexto(ntop+9,nesq+ni,chr(196),nfg,nbg);
  pETexto(ntop+9,nesq+29,chr(193),nfg,nbg);
  for ni:=30 to 63 do
   pETexto(ntop+9,nesq+ni,chr(196),nfg,nbg);
  pETexto(ntop+9,nesq+64,chr(217),nfg,nbg);

  { ano bissexto }
  if (nano mod 4)=0 then
    vnudiames[2]:=29;

  { retorna o dia um da semana }
  nj:=ndow;
  for ni:=ndia downto 1 do
   begin
     if nj=0 then
      nj:=6
     else
      nj:=nj-1;
   end;
  nj:=nj+1;
  ndowum:=nj;
  if ndowum=7 then
    ndowum:=0;

  { constroi o calendario }
  nj:=0;
  pETexto(ntop+3,nesq+1,fsRepete(' ',29),nfg,nbg);
  pETexto(ntop+8,nesq+1,fsRepete(' ',29),nfg,nbg);
  for nk:=0 to 5 do
   begin
    pETexto(ntop+nk+3,nesq,chr(179),nfg,nbg);
    pETexto(ntop+nk+3,nesq+29,chr(179),nfg,nbg);
    pETexto(ntop+nk+3,nesq+64,chr(179),nfg,nbg);
    for ni:=ndowum to 6 do
     begin
      nj:=nj+1;
      str(nj,sdia);
      if nj < 10 then
        sdia:='0'+sdia;
      if nj <= vnudiames[nmes] then
       begin
        if nj=ndia then
          pETexto(ntop+nk+3,nesq+(ni*4)+1,'['+sdia+']',nfg,nbg)
        else
          pETexto(ntop+nk+3,nesq+(ni*4)+1,' '+sdia+' ',nfg,nbg);
       end
      else
       pETexto(ntop+nk+3,nesq+(ni*4)+2,'  ',nfg,nbg);
     end;
    ndowum:=0;
   end;

end;

{-----------------------------------------------------}

{
 Nome : pCalendario
 Descricao : procedimento que mostra o calendario na tela.
 Parametros :
 nnum - 1: altera mes, 2: altera ano, 3: altera hora
 ntop - posicao da linha inicial na tela
 nesq - posicao da coluna inicial na tela
 ndia - dia
 nmes - mes
 nano - ano
 nhor - horas
 nmin - minutos
 nseg - segundos
 nfg - cor do texto
 nbg - cor de fundo
 ndfg - cor do texto do botao
 ndbg - cor de fundo do botao
 nsfg - cor do texto da sombra do botao
 nsbg - cor de fundo da sombra do botao
 bfco - indica se o calendario esta focada ou nao
}
procedure pCalendario(nnum,ntop,nesq,ndia,nmes,nano,nhor,nmin,nseg,
                     nfg,nbg,ndfg,ndbg,nsfg,nsbg:integer;bfco:boolean);
const
 vsmeses : array [1..12] of String[9] = ('Janeiro','Fevereiro','Marco',
 'Abril','Maio','Junho','Julho','Agosto','Setembro',
 'Outubro','Novembro','Dezembro');
var
 shor,smin,sseg,sano : string;
begin
if bfco=true then
begin
 str(nano,sano);
 pETexto(ntop+3,nesq+43,'            ',nfg,nbg);

 pMiniBotao(ntop+3,nesq+37,chr(17),ndfg,ndbg,nsfg,nsbg,false);
 pETexto(ntop+3,nesq+43,vsmeses[nmes],nfg,nbg);
 pMiniBotao(ntop+3,nesq+54,chr(16),ndfg,ndbg,nsfg,nsbg,false);

 pMiniBotao(ntop+5,nesq+37,chr(17),ndfg,ndbg,nsfg,nsbg,false);
 pETexto(ntop+5,nesq+43,sano,nfg,nbg);
 pMiniBotao(ntop+5,nesq+49,chr(16),ndfg,ndbg,nsfg,nsbg,false);

 str(nhor,shor);
 str(nmin,smin);
 str(nseg,sseg);
 pETexto(ntop+7,nesq+39,
 fsZeros(shor,2)+':'+fsZeros(smin,2)+':'+fsZeros(sseg,2),nfg,nbg);

 if nnum=1 then
  begin
   pETexto(ntop+3,nesq+42,'[',nfg,nbg);
   pETexto(ntop+3,nesq+52,']',nfg,nbg);
  end
 else if nnum=2 then
  begin
   pETexto(ntop+5,nesq+42,'[',nfg,nbg);
   pETexto(ntop+5,nesq+47,']',nfg,nbg);
  end
 else if nnum=3 then
  begin
   pETexto(ntop+7,nesq+38,'[',nfg,nbg);
   pETexto(ntop+7,nesq+47,']',nfg,nbg);
  end;

 pDesCalendario(ntop,nesq,ndia,nmes,nano,nfg,nbg);
end;

Repeat

nTecla:=fnTeclar;

if nnum<>3 then
 begin
  if nTecla=TLEFT then
    begin
     if nnum=1 then
      begin
       if nmes>1 then
        begin
         nmes:=nmes-1;
         pMiniBotao(ntop+3,nesq+37,chr(17),ndfg,ndbg,nsfg,nsbg,true);
         pETexto(ntop+3,nesq+43,'         ',nfg,nbg);
         pETexto(ntop+3,nesq+43,vsmeses[nmes],nfg,nbg);
         pDesCalendario(ntop,nesq,ndia,nmes,nano,nfg,nbg);
        end;
      end
     else
      begin
       if nano>1980 then
        begin
         nano:=nano-1;
         str(nano,sano);
         pMiniBotao(ntop+5,nesq+37,chr(17),ndfg,ndbg,nsfg,nsbg,true);
         pETexto(ntop+5,nesq+43,sano,nfg,nbg);
         pDesCalendario(ntop,nesq,ndia,nmes,nano,nfg,nbg);
        end;
      end;
    end;

  if nTecla=TRIGHT then
    begin
     if nnum=1 then
      begin
       if nmes<12 then
        begin
         nmes:=nmes+1;
         pMiniBotao(ntop+3,nesq+54,chr(16),ndfg,ndbg,nsfg,nsbg,true);
         pETexto(ntop+3,nesq+43,'         ',nfg,nbg);
         pETexto(ntop+3,nesq+43,vsmeses[nmes],nfg,nbg);
         pDesCalendario(ntop,nesq,ndia,nmes,nano,nfg,nbg);
        end;
      end
     else
      begin
       if nano<2099 then
        begin
         nano:=nano+1;
         str(nano,sano);
         pMiniBotao(ntop+5,nesq+49,chr(16),ndfg,ndbg,nsfg,nsbg,true);
         pETexto(ntop+5,nesq+43,sano,nfg,nbg);
         pDesCalendario(ntop,nesq,ndia,nmes,nano,nfg,nbg);
        end;
      end;
    end;
 end;

  if nTecla=TUP then
    begin
     if nnum=2 then     
       begin
        pETexto(ntop+3,nesq+42,'[',nfg,nbg);
        pETexto(ntop+3,nesq+52,']',nfg,nbg);
        pETexto(ntop+5,nesq+42,' ',nfg,nbg);
        pETexto(ntop+5,nesq+47,' ',nfg,nbg);
        nnum:=1;
       end;
     if nnum=3 then     
       begin
        pETexto(ntop+5,nesq+42,'[',nfg,nbg);
        pETexto(ntop+5,nesq+47,']',nfg,nbg);
        pETexto(ntop+7,nesq+38,' ',nfg,nbg);
        pETexto(ntop+7,nesq+47,' ',nfg,nbg);
        nnum:=2;
       end;
    end;

  if nTecla=TDOWN then
    begin
     if nnum=2 then
       begin
        pETexto(ntop+5,nesq+42,' ',nfg,nbg);
        pETexto(ntop+5,nesq+47,' ',nfg,nbg);
        pETexto(ntop+7,nesq+38,'[',nfg,nbg);
        pETexto(ntop+7,nesq+47,']',nfg,nbg);
        nnum:=3;
        pHoraSistema(ntop+7,nesq+39,nfg,nbg);
       end;
     if nnum=1 then
       begin
        pETexto(ntop+3,nesq+42,' ',nfg,nbg);
        pETexto(ntop+3,nesq+52,' ',nfg,nbg);
        pETexto(ntop+5,nesq+42,'[',nfg,nbg);
        pETexto(ntop+5,nesq+47,']',nfg,nbg);
        nnum:=2;
       end;
    end;
until nTecla=TTAB;
pETexto(ntop+3,nesq+42,' ',nfg,nbg);
pETexto(ntop+3,nesq+52,' ',nfg,nbg);
pETexto(ntop+5,nesq+42,' ',nfg,nbg);
pETexto(ntop+5,nesq+47,' ',nfg,nbg);
pETexto(ntop+7,nesq+38,' ',nfg,nbg);
pETexto(ntop+7,nesq+47,' ',nfg,nbg);
end;

{-----------------------------------------------------------------}

{
 Nome : pMiniBotao
 Descricao : procedimento que desenha um mini botao na tela
 Parametros :
 ntop - posicao da linha inicial na tela
 nesq - posicao da coluna inicial na tela
 nfg - cor do texto
 nbg - cor de fundo
 nsfg - cor do texto da sombra
 nsbg - cor de fundo da sombra
 stxt - o texto a ser escrito no botao
 bfco - indica se o botao tem o foco
}
procedure pMiniBotao(ntop,nesq:integer;stxt:string;
                     nfg,nbg,nsfg,nsbg:integer;bfco:boolean);
var
 ntam,ncont:integer;
begin
ntam:=length(stxt);
if bfco=false then
begin
 pETexto(ntop,nesq,' '+stxt+' ',nfg,nbg);
 pETexto(ntop,nesq+ntam+2,chr(220),nsfg,nsbg);
 for ncont:=1 to ntam+2 do
  pETexto(ntop+1,nesq+ncont,chr(223),nsfg,nsbg);
end
else
begin
 pETexto(ntop,nesq+1,' '+stxt+' ',nfg,nbg);
 pETexto(ntop,nesq,' ',nsfg,nsbg);
 for ncont:=1 to ntam+2 do
  pETexto(ntop+1,nesq+ncont,' ',nsfg,nsbg);
 delay(300);
 pETexto(ntop,nesq,' '+stxt+' ',nfg,nbg);
 pETexto(ntop,nesq+ntam+2,chr(220),nsfg,nsbg);
 for ncont:=1 to ntam+2 do
  pETexto(ntop+1,nesq+ncont,chr(223),nsfg,nsbg);
end;

end;

{-------------------------------------------}

{
 Nome : pDesTabAscii
 Descricao : procedimento que desenha toda a tabela Ascii.
 Parametros :
 ntop - posicao da linha inicial na tela
 nesq - posicao da coluna inicial na tela
 nfg - cor do texto
 nbg - cor de fundo
 nsfg - cor do texto do selecionado
 nsbg - cor de fundo do selecionado
 bfco - indica se a tabela esta focada ou nao
}
procedure pDesTabAscii(ntop,nesq,
          nfg,nbg,nsfg,nsbg:integer;bfco:boolean);
const
 vsalfa : array[1..32] of string[1] = ('0','1','2','3','4','5','6','7','8','9',
 'A','B','C','D','E','F','G','H','I','J','K','L','M','N','O','P','Q','R',
 'S','T','U','V');
var
 ncont,ncont2,ncont3,nalt,nlrg:integer;
 scont : string;
begin
nalt:=10;
nlrg:=34;
pETexto(ntop,nesq,chr(218),nfg,nbg);
for ncont:=1 to nlrg+31 do
  pETexto(ntop,nesq+ncont,chr(196),nfg,nbg);
pETexto(ntop,nesq+nlrg,chr(194),nfg,nbg);
pETexto(ntop,nesq+nlrg+32,chr(191),nfg,nbg);

pETexto(ntop+1,nesq+1,'\',nfg,nbg);
if bfco=true then
 pETexto(ntop+1,nesq+2,'0',nsfg,nsbg)
else
 pETexto(ntop+1,nesq+2,'0',nfg,nbg);

for ncont:=2 to nlrg-2 do
 pETexto(ntop+1,nesq+ncont+1,vsalfa[ncont],nfg,nbg);

 pETexto(ntop+1,nesq,chr(179),nfg,nbg);
 pETexto(ntop+1,nesq+nlrg,chr(179),nfg,nbg);
 ncont3:=-1;
 for ncont:=1 to nalt-2 do
  for ncont2:=1 to nlrg-2 do
   begin
    ncont3:=ncont3+1;
    pETexto(ntop+ncont+1,nesq,chr(179),nfg,nbg);
    pETexto(ntop+ncont+1,nesq+1,vsalfa[ncont],nfg,nbg);
    if ncont3<>32 then
     pETexto(ntop+ncont+1,nesq+ncont2+1,chr(ncont3),nfg,nbg);
    pETexto(ntop+ncont+1,nesq+nlrg,chr(179),nfg,nbg);
   end;

if bfco=true then
begin
 pETexto(ntop+2,nesq+1,'0',nsfg,nsbg);
 pETexto(ntop+2,nesq+2,chr(0),nsfg,nsbg);
end
else
 pETexto(ntop+2,nesq+1,'0',nfg,nbg);

pETexto(ntop+nalt,nesq,chr(192),nfg,nbg);
for ncont:=1 to nlrg-1 do
 pETexto(ntop+nalt,nesq+ncont,chr(196),nfg,nbg);
pETexto(ntop+nalt,nesq+nlrg,chr(193),nfg,nbg);

pETexto(ntop+1,nesq+nlrg+4,'Informacoes da tabela',nfg,nbg);
for ncont2:=1 to 4 do
 begin
  pETexto(ntop+(ncont2*2),nesq+nlrg,chr(195),nfg,nbg);
  for ncont:=nlrg+1 to nlrg+32 do
   pETexto(ntop+(ncont2*2),nesq+ncont,chr(196),nfg,nbg);
  pETexto(ntop+(ncont2*2)-1,nesq+nlrg+32,chr(179),nfg,nbg);
  pETexto(ntop+(ncont2*2),nesq+nlrg+32,chr(180),nfg,nbg);
 end;
pETexto(ntop+nalt-1,nesq+nlrg+32,chr(179),nfg,nbg);
for ncont:=nlrg+1 to nlrg+32 do
 pETexto(ntop+nalt,nesq+ncont,chr(196),nfg,nbg);
pETexto(ntop+nalt,nesq+nlrg+32,chr(217),nfg,nbg);

pETexto(ntop+3,nesq+nlrg+2,'Caractere   : nulo            ',nfg,nbg);
pETexto(ntop+5,nesq+nlrg+2,'Decimal     : 0  ',nfg,nbg);
pETexto(ntop+7,nesq+nlrg+2,'Hexadecimal : 0  ',nfg,nbg);
pETexto(ntop+9,nesq+nlrg+2,'Posicao     : 00 ',nfg,nbg);
end;

{-------------------------------------------}

{
 Nome : pTabAscii
 Descricao : procedimento que realiza o manuseio da tabela ascii.
 Parametros :
 ntop - posicao da linha inicial na tela
 nesq - posicao da coluna inicial na tela
 nfg - cor do texto
 nbg - cor de fundo
 nsfg - cor do texto do selecionado
 nsbg - cor de fundo do selecionado
 bfco - indica se a tabela esta focada ou nao
}

procedure pTabAscii(ntop,nesq,nfg,nbg,nsfg,nsbg:integer;bfco:boolean);
const
 vsalfa : array[1..32] of string[1] = ('0','1','2','3','4','5','6','7','8',
 '9','A','B','C','D','E','F','G','H','I','J','K','L','M','N','O','P','Q','R',
 'S','T','U','V');
var
 nix,niy,ncont:integer;
 mnnum : array[1..8,1..32] of integer;
 snum : string;
begin
ncont:=0;
for niy:=1 to 8 do
 for nix:=1 to 32 do
  begin
   mnnum[niy,nix]:=ncont;
   ncont:=ncont+1;
  end;
pDesTabAscii(ntop,nesq,nfg,nbg,nsfg,nsbg,bfco);
nix:=1;
niy:=1;
Repeat

nTecla:=fnTeclar;

if bfco=true then
 begin
  if nTecla=TUP then
    begin
     if niy>1 then
      begin
       pETexto(ntop+1+niy,nesq+1,vsalfa[niy],nfg,nbg);
       pETexto(ntop+1+niy,nesq+1+nix,chr(mnnum[niy,nix]),nfg,nbg);
       niy:=niy-1;
       pETexto(ntop+1+niy,nesq+1,vsalfa[niy],nsfg,nsbg);
       pETexto(ntop+1+niy,nesq+1+nix,chr(mnnum[niy,nix]),nsfg,nsbg);
      end;
    end;
  if nTecla=TDOWN then
    begin
     if niy<8 then
      begin
       pETexto(ntop+1+niy,nesq+1,vsalfa[niy],nfg,nbg);
       pETexto(ntop+1+niy,nesq+1+nix,chr(mnnum[niy,nix]),nfg,nbg);
       niy:=niy+1;
       pETexto(ntop+1+niy,nesq+1,vsalfa[niy],nsfg,nsbg);
       pETexto(ntop+1+niy,nesq+1+nix,chr(mnnum[niy,nix]),nsfg,nsbg);
      end;
    end;
  if nTecla=TLEFT then
    begin
     if nix>1 then
      begin
       pETexto(ntop+1,nesq+1+nix,vsalfa[nix],nfg,nbg);
       pETexto(ntop+1+niy,nesq+1+nix,chr(mnnum[niy,nix]),nfg,nbg);
       nix:=nix-1;
       pETexto(ntop+1,nesq+1+nix,vsalfa[nix],nsfg,nsbg);
       pETexto(ntop+1+niy,nesq+1+nix,chr(mnnum[niy,nix]),nsfg,nsbg);
      end;
    end;
  if nTecla=TRIGHT then
    begin
     if nix<32 then
      begin
       pETexto(ntop+1,nesq+1+nix,vsalfa[nix],nfg,nbg);
       pETexto(ntop+1+niy,nesq+1+nix,chr(mnnum[niy,nix]),nfg,nbg);
       nix:=nix+1;
       pETexto(ntop+1,nesq+1+nix,vsalfa[nix],nsfg,nsbg);
       pETexto(ntop+1+niy,nesq+1+nix,chr(mnnum[niy,nix]),nsfg,nsbg);
      end;
    end;

  pETexto(ntop+3,nesq+36,'Caractere   :                 ',nfg,nbg);
  case mnnum[niy,nix] of
   0 : pETexto(ntop+3,nesq+36,'Caractere   : nulo',nfg,nbg);
   7 : pETexto(ntop+3,nesq+36,'Caractere   : bipe',nfg,nbg);
   10 : pETexto(ntop+3,nesq+36,'Caractere   : avanco de linha',nfg,nbg);
   13 : pETexto(ntop+3,nesq+36,'Caractere   : retorno de carro',nfg,nbg);
   32 : pETexto(ntop+3,nesq+36,'Caractere   : espaco',nfg,nbg);
   255 : pETexto(ntop+3,nesq+36,'Caractere   : branco',nfg,nbg);
   else
    pETexto(ntop+3,nesq+36,'Caractere   : '+chr(mnnum[niy,nix]),nfg,nbg);
  end;
  str(mnnum[niy,nix],snum);
  pETexto(ntop+5,nesq+36,'Decimal     :     ',nfg,nbg);
  pETexto(ntop+5,nesq+36,'Decimal     : '+snum,nfg,nbg);
  pETexto(ntop+7,nesq+36,'Hexadecimal :     ',nfg,nbg);
  pETexto(ntop+7,nesq+36,'Hexadecimal : '+fsDecHex(mnnum[niy,nix]),nfg,nbg);
  pETexto(ntop+9,nesq+36,'Posicao     : '+vsalfa[niy]+vsalfa[nix],nfg,nbg);
 end;
until nTecla=TTAB;
pDesTabAscii(ntop,nesq,nfg,nbg,nsfg,nsbg,false);
pETexto(ntop+1,nesq+1+nix,vsalfa[nix],nfg,nbg);
pETexto(ntop+1+niy,nesq+1,vsalfa[niy],nfg,nbg);
pETexto(ntop+1+niy,nesq+1+nix,chr(mnnum[nix,niy]),nfg,nbg);
end;

{-------------------------------------------}

{
 Nome : pDesQuebraCabeca
 Descricao : procedimento que desenha o quebra-cabeca.
 Parametros :
 ntop - posicao da linha inicial na tela
 nesq - posicao da coluna inicial na tela
 nfg - cor do texto
 nbg - cor de fundo
 nsfg - cor do texto do selecionado
 nsbg - cor de fundo do selecionado
 bfco - indica se o objeto esta focado ou nao
}

procedure pDesQuebraCabeca(ntop,nesq,
          nfg,nbg,nsfg,nsbg:integer;bfco:boolean);
const
 msalfa : array[1..4,1..4] of string[2] = (('K0','C0','D1','H0'),('J1',
 'E1','G1',' 0'),('A0','O1','B1','N0'),('I0','M1','L1','F0'));
var
 ncont,ncont2:integer;
begin
pETexto(ntop,nesq,chr(218),nfg,nbg);
for ncont:=1 to 12 do
 pETexto(ntop,nesq+ncont,chr(196),nfg,nbg);
pETexto(ntop,nesq+13,chr(191),nfg,nbg);

for ncont:=1 to 4 do
 for ncont2:=0 to 3 do
  begin
   pETexto(ntop+ncont,nesq,chr(179),nfg,nbg);
   pETexto(ntop+ncont,nesq+13,chr(179),nfg,nbg);
   if copy(msalfa[ncont,ncont2+1],2,1)='1' then
    pETexto(ntop+ncont,nesq+(ncont2*3)+1,' '+
    copy(msalfa[ncont,ncont2+1],1,1)+' ',nsfg,nsbg)
   else
    pETexto(ntop+ncont,nesq+(ncont2*3)+1,' '+
    copy(msalfa[ncont,ncont2+1],1,1)+' ',nfg,nbg);
  end;

pETexto(ntop+5,nesq,chr(192),nfg,nbg);
for ncont:=1 to 12 do
 pETexto(ntop+5,nesq+ncont,chr(196),nfg,nbg);
pETexto(ntop+5,nesq+13,chr(217),nfg,nbg);
end;

{-------------------------------------------}

{
 Nome : pQuebraCabeca
 Descricao : procedimento que realiza o manuseio do quebra-cabeca.
 Parametros :
 ntop - posicao da linha inicial na tela
 nesq - posicao da coluna inicial na tela
 nfg - cor do texto
 nbg - cor de fundo
 nsfg - cor do texto do selecionado
 nsbg - cor de fundo do selecionado
 bfco - indica se a tabela esta focada ou nao
}

procedure pQuebraCabeca(ntop,nesq,nfg,nbg,nsfg,nsbg:integer;bfco:boolean);
const
 vsalfa : array[1..16] of string[2] = ('K0','C0','D1','H0','J1',
 'E1','G1',' 0','A0','O1','B1','N0','I0','M1','L1','F0');
var
 num,nvazio,ncont,ncont2,nx2,ny2:integer;
 vnx,vny: array[1..16] of integer;
 vnpos:array[1..16] of integer; {0:nada,1:acima,2:abaixo,3:esquerda,4:direita}
begin
pDesQuebraCabeca(ntop,nesq,nfg,nbg,nsfg,nsbg,bfco);
for ncont:=1 to 16 do
 vnpos[ncont]:=0;

ncont2:=1;
for ncont:=1 to 16 do
begin
 if ncont2=13 then
  ncont2:=1;

 vnx[ncont]:=ncont2;
 ncont2:=ncont2+3;
end;

ncont2:=1;
for ncont:=1 to 16 do
begin
 vny[ncont]:=ncont2;
 if (ncont mod 4)=0 then
  ncont2:=ncont2+1;
end;


nvazio:=0;
num:=8;
Repeat

nTecla:=fnTeclar;

if bfco=true then
 begin
    ncont:=nvazio;
    nvazio:=num;
    num:=ncont;


  case cTecla of
   'K','k':begin
            num:=1;
           end;
   'C','c':begin
            num:=2;
           end;
   'D','d':begin
            num:=3;
           end;
   'H','h':begin
            num:=4;
           end;
   'J','j':begin
            num:=5;
           end;
   'E','e':begin
            num:=6;
           end;
   'G','g':begin
            num:=7;
           end;
   'A','a':begin
            num:=9;
           end;
   'O','o':begin
            num:=10;
           end;
   'B','b':begin
            num:=11;
           end;
   'N','n':begin
            num:=12;
           end;
   'I','i':begin
            num:=13;
           end;
   'M','m':begin
            num:=14;
           end;
   'L','l':begin
            num:=15;
           end;
   'F','f':begin
            num:=16;
           end;
  end;

  if (num+4)=nvazio then
    vnpos[num]:=2
  else if (num-4)=nvazio then
    vnpos[num]:=1
  else if (num+1)=nvazio then
    vnpos[num]:=4
  else if (num-1)=nvazio then
    vnpos[num]:=3
  else
    vnpos[num]:=0;


  if vnpos[num]<>0 then
   begin
    pETexto(ntop+vny[num],nesq+vnx[num],'   ',nfg,nbg);
    case vnpos[num] of
      1:begin
         vnpos[num]:=2;
         nx2:=0;
         ny2:=-1;
         vny[num]:=vny[num]-1;
        end;
      2:begin
         vnpos[num]:=1;
         nx2:=0;
         ny2:=1;
         vny[num]:=vny[num]+1;
        end;
      3:begin
         vnpos[num]:=4;
         nx2:=-3;
         ny2:=0;
         vnx[num]:=vnx[num]-3;
        end;
      4:begin
         vnpos[num]:=3;
         nx2:=3;
         ny2:=0;
         vnx[num]:=vnx[num]+3;
        end;
    end;

    if copy(vsalfa[num],2,1)='1' then
      pETexto(ntop+vny[num],nesq+vnx[num],' '+
      copy(vsalfa[num],1,1)+' ',nsfg,nsbg)
    else
      pETexto(ntop+vny[num],nesq+vnx[num],' '+
      copy(vsalfa[num],1,1)+' ',nfg,nbg);

   end;
 end;
until nTecla=TTAB;
pDesQuebraCabeca(ntop,nesq,nfg,nbg,nsfg,nsbg,false);
end;

{-----------------------------------------------------}

{
 Nome : pDesCalculadora
 Descricao : procedimento que mostra o calendario na tela.
 Parametros :
 ntop - posicao da linha inicial na tela
 nesq - posicao da coluna inicial na tela
 nfg - cor do texto
 nbg - cor de fundo
 ndfg - cor do texto do botao
 ndbg - cor de fundo do botao
 nsfg - cor do texto da sombra do botao
 nsbg - cor de fundo da sombra do botao
}
procedure pDesCalculadora(ntop,nesq,nfg,nbg,ndfg,ndbg,nsfg,nsbg:integer);
const
 vsnum: array[1..16] of string = ('7','8','9','/','4','5','6','*',
                                 '1','2','3','-','0','.','=','+');
var
 ni,nj,nk:integer;
begin
  pETexto(ntop,nesq,chr(218),nfg,nbg);
  for ni:=1 to 18 do
   pETexto(ntop,nesq+ni,chr(196),nfg,nbg);
  pETexto(ntop,nesq+19,chr(194),nfg,nbg);
  for ni:=20 to 38 do
   pETexto(ntop,nesq+ni,chr(196),nfg,nbg);
  pETexto(ntop,nesq+39,chr(191),nfg,nbg);

  pETexto(ntop+1,nesq+1,chr(218),nfg,nbg);
  pETexto(ntop+1,nesq+18,chr(191),nfg,nbg);
  pETexto(ntop+5,nesq+1,chr(192),nfg,nbg);
  pETexto(ntop+5,nesq+18,chr(217),nfg,nbg);

  for ni:=1 to 5 do
   begin
    pETexto(ntop+ni,nesq,chr(179),nfg,nbg);
    pETexto(ntop+ni,nesq+19,chr(179),nfg,nbg);
   end;

  pETexto(ntop+6,nesq,chr(195),nfg,nbg);
  for ni:=1 to 18 do
   pETexto(ntop+6,nesq+ni,chr(196),nfg,nbg);
  pETexto(ntop+6,nesq+19,chr(180),nfg,nbg);

  nk:=0;
  pETexto(ntop+7,nesq,chr(179),nfg,nbg);
  pETexto(ntop+8,nesq,chr(179),nfg,nbg);
  pMiniBotao(ntop+7,nesq+2,'Limpa',ndfg,ndbg,nsfg,nsbg,false);
  pMiniBotao(ntop+7,nesq+10,'Raiz2',ndfg,ndbg,nsfg,nsbg,false);
  pETexto(ntop+7,nesq+19,chr(179),nfg,nbg);
  pETexto(ntop+8,nesq+19,chr(179),nfg,nbg);
  for ni:=0 to 3 do
   begin
    for nj:=0 to 3 do
     begin
      nk:=nk+1;
      pMiniBotao(ntop+1+(ni*2),nesq+21+(nj*4),vsnum[nk],
      ndfg,ndbg,nsfg,nsbg,false);
     end;
   end;

  pETexto(ntop+9,nesq,chr(192),nfg,nbg);
  for ni:=1 to 18 do
   pETexto(ntop+9,nesq+ni,chr(196),nfg,nbg);
  pETexto(ntop+9,nesq+19,chr(193),nfg,nbg);
  for ni:=20 to 38 do
   pETexto(ntop+9,nesq+ni,chr(196),nfg,nbg);
  for ni:=1 to 8 do
    pETexto(ntop+ni,nesq+39,chr(179),nfg,nbg);
  pETexto(ntop+9,nesq+39,chr(217),nfg,nbg);

end;

{-----------------------------------------------------}

{
 Nome : pCalculadora
 Descricao : procedimento que mostra a calculadora na tela.
 Parametros :
 ntop - posicao da linha inicial na tela
 nesq - posicao da coluna inicial na tela
 nfg - cor do texto
 nbg - cor de fundo
 ndfg - cor do texto do botao
 ndbg - cor de fundo do botao
 nsfg - cor do texto da sombra do botao
 nsbg - cor de fundo da sombra do botao
 bfco - indica se a calculadora esta focada ou nao
}
procedure pCalculadora(ntop,nesq,nfg,nbg,
                       ndfg,ndbg,nsfg,nsbg:integer;bfco:boolean);
var
 svis:string;
 cmbot:char;
 pvis,pres:real;
 ncode, nres, ntnum, ntdec, ncont, ni:integer;
 bnum:boolean;
begin
 pDesCalculadora(ntop,nesq,nfg,nbg,ndfg,ndbg,nsfg,nsbg);
 ncont:=1;
 nres:=0;
 pvis:=0;
 ntdec:=0;
 ntnum:=10;
 svis:='';
 bnum:=true;
Repeat

nTecla:=fnTeclar;

 case cTecla of
  'L','l':
      begin
       pMiniBotao(ntop+7,nesq+2,'Limpa',ndfg,ndbg,nsfg,nsbg,true);
       cmbot:='l';
       bnum:=true;
       ncont:=1;
       pres:=0;
       pvis:=0;
       ntdec:=0;
       ntnum:=10;
       svis:='';
      end;
  'R','r':
      begin
       pMiniBotao(ntop+7,nesq+10,'Raiz2',ndfg,ndbg,nsfg,nsbg,true);
       cmbot:='r';
       bnum:=false;
      end;
  '7':begin
       pMiniBotao(ntop+1,nesq+21,'7',ndfg,ndbg,nsfg,nsbg,true);
       bnum:=true;
       if length(svis)<=9 then
         svis:=svis+'7';
      end;
  '8':begin
       pMiniBotao(ntop+1,nesq+25,'8',ndfg,ndbg,nsfg,nsbg,true);
       bnum:=true;
       if length(svis)<=9 then
         svis:=svis+'8';
      end;
  '9':begin
       pMiniBotao(ntop+1,nesq+29,'9',ndfg,ndbg,nsfg,nsbg,true);
       bnum:=true;
       if length(svis)<=9 then
         svis:=svis+'9';
      end;
  '/':begin
       pMiniBotao(ntop+1,nesq+33,'/',ndfg,ndbg,nsfg,nsbg,true);
       cmbot:='/';
       bnum:=false;
       Val(svis,pvis,ncode);
       if pvis=0 then
          svis:='Erro:divisao por zero'
       else
          if cmbot='.' then
           begin
            pres:=pres/pvis;
            str(pres:ntnum:ntdec,svis);
           end
          else
           begin
            nres:=(round(pres) div round(pvis));
            str(nres,svis);
           end;
       svis:='';
       pvis:=0;
      end;
  '4':begin
       pMiniBotao(ntop+3,nesq+21,'4',ndfg,ndbg,nsfg,nsbg,true);
       bnum:=true;
       if length(svis)<=9 then
         svis:=svis+'4';
      end;
  '5':begin
       pMiniBotao(ntop+3,nesq+25,'5',ndfg,ndbg,nsfg,nsbg,true);
       bnum:=true;
       if length(svis)<=9 then
         svis:=svis+'5';
      end;
  '6':begin
       pMiniBotao(ntop+3,nesq+29,'6',ndfg,ndbg,nsfg,nsbg,true);
       bnum:=true;
       if length(svis)<=9 then
         svis:=svis+'6';
      end;
  '*':begin
       pMiniBotao(ntop+3,nesq+33,'*',ndfg,ndbg,nsfg,nsbg,true);
       cmbot:='*';
       bnum:=false;
       Val(svis,pvis,ncode);
       pres:=pres*pvis;
       svis:='';
       pvis:=0;
      end;
  '1':begin
       pMiniBotao(ntop+5,nesq+21,'1',ndfg,ndbg,nsfg,nsbg,true);
       bnum:=true;
       if length(svis)<=9 then
         svis:=svis+'1';
      end;
  '2':begin
       pMiniBotao(ntop+5,nesq+25,'2',ndfg,ndbg,nsfg,nsbg,true);
       bnum:=true;
       if length(svis)<=9 then
         svis:=svis+'2';
      end;
  '3':begin
       pMiniBotao(ntop+5,nesq+29,'3',ndfg,ndbg,nsfg,nsbg,true);
       bnum:=true;
       if length(svis)<=9 then
         svis:=svis+'3';
      end;
  '-':begin
       pMiniBotao(ntop+5,nesq+33,'-',ndfg,ndbg,nsfg,nsbg,true);
       cmbot:='-';
       bnum:=false;
       Val(svis,pvis,ncode);
       pres:=pres-pvis;
       {if pres < pvis then}
       svis:='';
       pvis:=0;
      end;
  '0':begin
       pMiniBotao(ntop+7,nesq+21,'0',ndfg,ndbg,nsfg,nsbg,true);
       bnum:=true;
       if length(svis)<=9 then
         svis:=svis+'0';
      end;
  '.':begin
       pMiniBotao(ntop+7,nesq+25,'.',ndfg,ndbg,nsfg,nsbg,true);
       cmbot:='.';
       bnum:=true;
       if length(svis)<=9 then
          svis:=svis+'.';
      end;
  '=':begin
       pMiniBotao(ntop+7,nesq+29,'=',ndfg,ndbg,nsfg,nsbg,true);
       Val(svis,pvis,ncode);
       case cmbot of
        '+':begin
             pres:=pres+pvis;
             svis:='';
             str(pres:ntnum:ntdec,svis);
            end;
        '-':begin
             pres:=pres-pvis;
             str(pres:ntnum:ntdec,svis);
            end;
        '*':begin
             pres:=pres*pvis;
             str(pres:ntnum:ntdec,svis);
            end;
        '/':begin
             if pvis=0 then
              svis:='Erro:divisao por zero'
             else
              begin
                if cmbot='.' then
                 begin
                  pres:=pres/pvis;
                  str(pres:ntnum:ntdec,svis);
                 end
                else
                 begin
                  nres:=(round(pres) div round(pvis));
                  str(pres,svis);
                 end;
              end;
            end;
        'r':begin
             pres:=pres+pvis;
             str(pres:ntnum:ntdec,svis);
            end;
       end;
       pvis:=0;
       cmbot:='=';
      { svis:='';}
      end;
  '+':begin
       pMiniBotao(ntop+7,nesq+33,'+',ndfg,ndbg,nsfg,nsbg,true);
       cmbot:='+';
       bnum:=false;
       Val(svis,pvis,ncode);
       pres:=pres+pvis;
       svis:='+';
       pvis:=0;
      end;
 end;
 if cmbot='l' then
   begin
     pETexto(ntop+5,nesq+2,'               0',nfg,nbg);
   end
 else
   begin
     if bnum=true then
        pETexto(ntop+5,nesq+2+(16-length(svis)),svis,nfg,nbg);
     {else
       for ni:= to   do
        pETexto(ntop+5+ncont,nesq+2+(16-length(svis)),svis,nfg,nbg);}

   end;

until nTecla=TTAB;
pETexto(ntop+1,nesq+1,' ',nfg,nbg);
pETexto(ntop+1,nesq+18,' ',nfg,nbg);
pETexto(ntop+5,nesq+1,' ',nfg,nbg);
pETexto(ntop+5,nesq+18,' ',nfg,nbg);

end;

end.
