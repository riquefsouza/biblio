program funcasm;

uses crt {, rotinas1};

var
s,sMouseBotao,sMouseTop,sMouseEsq : string;

{ variaveis de Mouse }

nMouseBotao,nMouseTop,nMouseEsq : integer;

{ variaveis de cursor }

nCurTop, nCurEsq, nCurTipo : byte;

asmTextAttr : byte;
mTela : array[1..5,1..50,1..80] of char;
mAtrib : array[1..5,1..50,1..80] of byte;

{ servicos do mouse }

function asmIniMouse:integer; forward;
function asmPressMouse:boolean; forward;
procedure asmCursorMouse(ntip:integer); forward;
procedure asmMoveMouse(ntop,nesq:integer); forward;
procedure asmLerMouse; forward;

{ servicos do dos }

function asmKeyPressed:boolean; forward;
function asmAuxReadKey:integer; forward;
function asmReadKey:integer; forward;
procedure asmWriteChar(ctxt:char;ncor1,ncor2:byte); forward;
procedure asmWrite(stxt:string;ncor1,ncor2:byte); forward;
function asmReadChar:char; forward;

{ servicos de video }

procedure asmClrScr; forward;
procedure asmScrollUp(ntop,nesq,nalt,nlrg,nlin:byte); forward;
procedure asmScrollDown(ntop,nesq,nalt,nlrg,nlin:byte); forward;
procedure asmSetaCursor(ntip:integer); forward;
procedure asmLerCursor; forward;
procedure asmGotoXY(ntop,nesq:byte); forward;

function fnBinDec(sbin:string):integer; forward;
function fsDecBin(ndec,nbit:integer):string; forward;
procedure pSlvTela(nnum,ntop,nesq,nalt,nlrg:integer); forward;
procedure pRstTela(nnum,ntop,nesq,nalt,nlrg:integer); forward;

{------------------------- servicos do mouse ------------------------}
{
 Nome : asmIniMouse
 Descricao : funcao que inicializa o mouse.
}
function asmIniMouse:integer;
var
 nret:integer;
begin
 asm
   mov ax,00h
   mov bx,00h
   mov cx,00h
   mov dx,00h
   mov si,00h
   mov di,00h
   int 33h
   mov nret,ax
 end;
if nret=0 then
 asmIniMouse:=0
else
 asmIniMouse:=1;
end;

{---------------------------------------------------------------------}

{
 Nome : asmPressMouse
 Descricao : funcao que indica se o mouse foi pressionada.
}
function asmPressMouse:boolean;
var
 nret:integer;
begin
 asm
   mov ax,05h
   mov bx,00h
   int 33h
   mov nret,ax
 end;
if nret=0 then
   asmPressMouse:=false
else
 begin
   asmPressMouse:=true;
   delay(200);
 end;
end;

{---------------------------------------------------------------------}

{
 Nome : asmCursorMouse
 Descricao : procedimento que liga e desliga o cursor do mouse.
 Parametros :
 ntip - indica se vai ligar ou desligar o cursor do mouse.
}
procedure asmCursorMouse(ntip:integer);
begin
if ntip=1 then
 begin
  asm
    mov ax,01h
    mov bx,00h
    mov cx,00h
    mov dx,00h
    mov si,00h
    mov di,00h
    int 33h
  end;
 end
else if ntip=0 then
 begin
  asm
    mov ax,02h
    mov bx,00h
    mov cx,00h
    mov dx,00h
    mov si,00h
    mov di,00h
    int 33h
  end;
 end;
end;

{---------------------------------------------------------------------}

{
 Nome : asmMoveMouse
 Descricao : procedimento que move o cursor do mouse para uma determinada
 posicao.
 Parametros :
 ntop - indica a posicao do topo.
 nesq - indica a posicao da esquerda.
}
procedure asmMoveMouse(ntop,nesq:integer);
begin
 ntop:=(ntop-1)*8;
 nesq:=(nesq-1)*8;
 asm
   mov ax,04h
   mov bx,00h
   mov cx,nesq
   mov dx,ntop
   mov si,00h
   mov di,00h
   int 33h
 end;
end;

{---------------------------------------------------------------------}

{
 Nome : asmLerMouse
 Descricao : funcao que le o status do mouse.
}
procedure asmLerMouse;
var
 ntop, nesq : integer;
begin
{ indica qual botao foi pressionado,
  0=nenhum, 1=direito, 2=esquerdo, 3=os dois }
 asm
   mov ax,03h
   mov bx,00h
   mov cx,00h
   mov dx,00h
   mov si,00h
   mov di,00h
   int 33h
   mov nMouseBotao,bx
   mov ntop,dx
   mov nesq,cx
 end;
nMouseTop:=(ntop div 8)+1;
nMouseEsq:=(nesq div 8)+1;
end;

{------------------------- servicos do dos ------------------------}
{
 Nome : asmKeyPressed
 Descricao : funcao que indica se a tecla foi pressionada.
}
function asmKeyPressed:boolean;
var
 nret:byte;
begin
 asm
   mov ah,0Bh
   int 21h
   mov nret,al
 end;
if nret=0 then
   asmKeyPressed:=false
else
   asmKeyPressed:=true;
end;

{--------------------------------------------------------------------}
{
 Nome : asmAuxReadKey
 Descricao : funcao que auxilia no retorno da tecla digitada.
}
function asmAuxReadKey:integer;
label
  semchar;
begin
 asm
   push dx
   mov ah, 6
   mov dl, 255
   int 21h
   pop dx
   jz semchar
   xor ah,ah
   ret
 end;
semchar:
 asm
   mov ax,-1
   ret
 end;
end;

{--------------------------------------------------------------------}
{
 Nome : asmReadKey
 Descricao : funcao que retorna a tecla digitada.
}
function asmReadKey:integer;
label
  esperaloop;
begin
esperaloop:
 asm
   call asmAuxReadKey
   cmp ax, -1
   je esperaloop
   ret
 end;
end;

{--------------------------------------------------------------------}
{
 Nome : asmWriteChar
 Descricao : procedimento que escreve um caractere na tela.
}
procedure asmWriteChar(ctxt:char;ncor1,ncor2:byte);
begin
 asmTextAttr:=fnBinDec(fsDecBin(ncor2,4)+fsDecBin(ncor1,4));
 asm
  mov ah,09h
  mov al,ctxt
  mov bh,00h
  mov bl,asmTextAttr
  mov cx,1  { numero de caracteres para repetir }
  int 10h
 end;
end;

{--------------------------------------------------------------------}
{
 Nome : asmWrite
 Descricao : procedimento que escreve uma string na tela.
}
procedure asmWrite(stxt:string;ncor1,ncor2:byte);
var
 ncont:integer;
begin
 for ncont:=1 to length(stxt) do
  asmWriteChar(stxt[ncont],ncor1,ncor2);
end;

{--------------------------------------------------------------------}
{
 Nome : asmReadChar
 Descricao : procedimento que le um caractere na tela.
}
function asmReadChar:char;
var
 cret:char;
begin
 asm
  mov ah,08h
  mov bh,00h
  int 10h
  mov asmTextAttr,ah
  mov cret,al
 end;
asmReadChar:=cret;
end;

{--------------------------------------------------------------------}
{
 Nome : pSlvTela
 Descricao : procedimento que salva a tela.
}
procedure pSlvTela(nnum,ntop,nesq,nalt,nlrg:integer);
var
 nlin,ncol:byte;
begin
for nlin:=ntop to nalt do
 begin
  for ncol:=nesq to nlrg do
   begin
    gotoxy(ncol,nlin);
    mTela[nnum,nlin,ncol]:=asmReadChar;
    mAtrib[nnum,nlin,ncol]:=asmTextAttr;
   end;
 end;
end;

{--------------------------------------------------------------------}
{
 Nome : pRstTela
 Descricao : procedimento que restaura a tela.
}
procedure pRstTela(nnum,ntop,nesq,nalt,nlrg:integer);
var
 nlin,ncol,nfg,nbg:byte;
 scor:string;
begin
for nlin:=ntop to nalt do
 begin
  for ncol:=nesq to nlrg do
   begin
    scor:=fsDecBin(mAtrib[nnum,nlin,ncol],8);
    nbg:=fnBinDec(copy(scor,1,4));
    nfg:=fnBinDec(copy(scor,5,4));
    {pEtexto(nlin,ncol,mTela[nnum,nlin,ncol],nfg,nbg); }
   end;
 end;
end;

{------------------------- servicos de video ------------------------}
{
 Nome : asmClrScr
 Descricao : procedimento limpa a tela.
}
procedure asmClrScr;
var
 nalt, nlrg:byte;
begin
 {nalt:=nMaxalt-1;}
{ nlrg:=nMaxlrg-1;}
 asm
  xor al,al
  xor cx,cx
  mov dh,nalt
  mov dl,nlrg
  mov bh,7
  mov ah,06h
  int 10h
 end;
end;

{-----------------------------------------------------------------}
{
 Nome : asmScrollUp
 Descricao : procedimento que rola a tela para cima.
 Parametros :
 ntop - posicao do topo
 nesq - posicao da esquerda
 nalt - altura da tela
 nlrg - largura da tela
 nlin - numero de linhas para rolar
}
procedure asmScrollUp(ntop,nesq,nalt,nlrg,nlin:byte);
begin
 asm
  mov al,nlin
  mov bh,7
  mov ch,ntop
  mov cl,nesq
  mov dh,nalt
  mov dl,nlrg
  mov ah,06h
  int 10h
 end;
end;

{-----------------------------------------------------------------}
{
 Nome : asmScrollDown
 Descricao : procedimento que rola a tela para cima.
 Parametros :
 ntop - posicao do topo
 nesq - posicao da esquerda
 nalt - altura da tela
 nlrg - largura da tela
 nlin - numero de linhas para rolar
}
procedure asmScrollDown(ntop,nesq,nalt,nlrg,nlin:byte);
begin
 asm
  mov al,nlin
  mov bh,7
  mov ch,ntop
  mov cl,nesq
  mov dh,nalt
  mov dl,nlrg
  mov ah,07h
  int 10h
 end;
end;

{-----------------------------------------------------------------}
{
 Nome : asmSetaCursor
 Descricao : Procedimento que muda o modo do cursor na tela.
 Parametros :
 ntip - indica o tipo de cursor, 0=nenhum, 1=normal, 2=solido
}
procedure asmSetaCursor(ntip:integer);
begin
if ntip=0 then
 begin
  asm
    mov ah,01h
    mov ch,20h
    mov cl,20h
    int 10h
  end;
 end
else if ntip=1 then 
 begin
  asm
    mov ah,01h
    mov ch,06h
    mov cl,07h
    int 10h
  end;
 end
else if ntip=2 then
 begin
  asm
    mov ah,01h
    mov ch,00h
    mov cl,07h
    int 10h
  end;
 end;
end;

{-----------------------------------------------------------------}
{
 Nome : asmLerCursor
 Descricao : Procedimento que le a posicao do cursor na tela.
}
procedure asmLerCursor;
var
 ntip1,ntip2:byte;
begin
  asm
    mov ah,03h
    mov bh,01h
    int 10h
    mov nCurTop,dh
    mov nCurEsq,dl
    mov ntip1,ch
    mov ntip2,cl
  end;
 nCurTop:=nCurTop+1;
 nCurEsq:=nCurEsq+1;
 { tipo de cursor, 0=nenhum, 1=normal, 2=solido }
 if (ntip1=32) and (ntip2=32) then
   nCurTipo:=0;
 if (ntip1=6) and (ntip2=7) then
   nCurTipo:=1;
 if (ntip1=0) and (ntip2=7) then
   nCurTipo:=2;

end;

{-----------------------------------------------------------------}
{
 Nome : asmGotoXY
 Descricao : Procedimento que posiciona o cursor na tela.
}
procedure asmGotoXY(ntop,nesq:byte);
begin
  asm
    mov ah,02h
    mov bh,00h
    mov dh,ntop
    dec dh
    mov dl,nesq
    dec dl
    int 10h
  end;
end;

{-----------------------------------------------------------------}
{
 Nome : asmTextBackGround
 Descricao : Procedimento que muda a cor de fundo do texto.
}
{procedure asmTextBackGround(ncor1:byte);
begin
 asmTextAttr:=
end;

procedure asmTextColor(ncor2:byte);
begin
 asmTextAttr:=fnBinDec(fsDecBin(ncor1)+fsDecBin(ncor2));
end;

{-----------------------------------------------------------------}
{
 Nome : fnPotencia
 Descricao : Funcao que eleva um numero a potencia indicada.
 Parametros :
 nnum - indica o numero.
 npot - indica a potencia.
}
function fnPotencia(nnum,npot:integer):integer;
var
 nret,ncont:integer;
begin
if npot=0 then
 nret:=1
else if npot=1 then
 nret:=nnum
else
 begin
  nret:=1;
  for ncont:=1 to npot do
   nret:=nret*nnum;
 end;
fnPotencia:=nret;
end;

{-----------------------------------------------------------------}
{
 Nome : fnBinDec
 Descricao : Funcao que transforma de binario para decimal.
 Parametros :
 sbin - indica o numero binario a ser convertido.
}
function fnBinDec(sbin:string):integer;
var
 ncont,ntam,nret,nbin,ncode,npot:integer;
begin
nret:=0;
ntam:=length(sbin);
npot:=ntam;
for ncont:=1 to ntam do
 begin
  val(copy(sbin,ncont,1),nbin,ncode);
  npot:=npot-1;
  nret:=nret+(nbin*fnPotencia(2,npot));
 end;
fnBinDec:=nret;
end;

{-----------------------------------------------------}
{
 Nome : fsDecBin
 Descricao : funcao que converte de decimal para binario.
 Parametros :
 ndec : o numero decimal
}
function fsDecBin(ndec,nbit:integer):string;
var
 nresto,ndiv,ncont : integer;
 sret,sresto,sdiv : string;
begin
sret:='';
if ndec<=1 then
begin
 str(ndec,sdiv);
 for ncont:=1 to nbit do
  sret:=sret+sdiv;
end
else
begin
 ndiv:=trunc(ndec div 2);
 nresto:=(ndec mod 2);
 while (nresto <= 2) and (ndiv >= 2) do
  begin
    str(nresto,sresto);
    sret:=sresto+sret;

    nresto:=(ndiv mod 2);
    ndiv:=trunc(ndiv div 2);
  end;
 str(nresto,sresto);
 str(ndiv,sdiv);
 sret:=sdiv+sresto+sret;
 if length(sret) < nbit then
  begin
   sresto:='';
   for ncont:=1 to (nbit-length(sret)) do
    sresto:=sresto+'0';
   sret:=sresto+sret;
  end;
end;
 fsDecBin:=sret;
end;


{ inicia sistema }
begin
asmWritechar('E',7,6);
asmWritechar('S',7,6);
asmWritechar('C',7,6);
asmWritechar('[',7,6);
asmWritechar('2',7,6);
asmWritechar('J',7,6);
{ClrScr;
pEtexto(1,1,'merda',0,15);
pSlvTela(1,1,1,1,5);
pEtexto(1,1,'bosta',15,0);
pRstTela(1,1,1,1,5);}
{if asmIniMouse=0 then
 write('mouse nao instalado')
else
 begin
  asmCursorMouse(1);
  asmMoveMouse(1,1);
 end;

repeat
 if asmKeyPressed=true then
    nTecla:=fnTeclar
 else
    asmLerMouse;

if asmPressMouse=true then
 begin

 str(nMouseBotao,sMouseBotao);
 gotoxy(1,1);
 write('Botao : '+sMouseBotao);

 str(nMouseTop,sMouseTop);
 gotoxy(1,2);
 write('Top : '+sMouseTop);

 str(nMouseEsq,sMouseEsq);
 gotoxy(1,3);
 write('Esq : '+sMouseEsq);

 end;

until nTecla=TESC;
asmCursorMouse(0);}
end.
