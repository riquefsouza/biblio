program mouse;

uses crt, dos, rotinas1;

type

  tModCurMouse = (desliga,liga);

var
sMouseBotao,sMouseTop,sMouseEsq : string;
{ variaveis de Mouse }
  nMouseBotao,nMouseTop,nMouseEsq : integer;

function fnIniMouse:integer; forward;
function fbPressMouse:boolean; forward;

function fbPressTecla:boolean; forward;

procedure pCursorMouse(ntip:tModCurMouse); forward;
procedure pMoveMouse(ntop,nesq:integer); forward;
procedure pLerMouse; forward;

{---------------------------------------------------------------------}

{
 Nome : fnIniMouse
 Descricao : funcao que inicializa o mouse.
}
function fnIniMouse:integer;
var
 nregs : registers;
begin
  with nregs do
   begin
    ax:=0;
    bx:=0;
    cx:=0;
    dx:=0;
    si:=0;
    di:=0;
    flags:=0;
   end;
intr($33,nregs);
{ mouse nao instalado }
if nregs.ax=0 then
 fnIniMouse:=0;
{ hardware e software do mouse instalados }
if nregs.ax=$ffff then { 65535 }
 fnIniMouse:=1;
end;

{---------------------------------------------------------------------}

{
 Nome : fbPressMouse
 Descricao : funcao que indica se o mouse foi pressionada.
}
function fbPressMouse:boolean;
var
 nregs : registers;
begin
  with nregs do
   begin
    ax:=$5;
    bx:=0;
   end;
intr($33,nregs);
{ indica qual botao foi pressionado,
  0=nenhum, 1=direito, 2=esquerdo, 3=os dois }
if nregs.ax=0 then
   fbPressMouse:=false
else
 begin
   fbPressMouse:=true;
   delay(200);
 end;
end;

{---------------------------------------------------------------------}

{
 Nome : pCursorMouse
 Descricao : procedimento que liga e desliga o cursor do mouse.
 Parametros :
 ntip - indica se vai ligar ou desligar o cursor do mouse.
}
procedure pCursorMouse(ntip:tModCurMouse);
var
 nregs : registers;
begin
if ntip=liga then
 begin
  with nregs do
   begin
    ax:=1;
    bx:=0;
    cx:=0;
    dx:=0;
    si:=0;
    di:=0;
    flags:=0;
   end;
 end
else if ntip=desliga then
 begin
  with nregs do
   begin
    ax:=2;
    bx:=0;
    cx:=0;
    dx:=0;
    si:=0;
    di:=0;
    flags:=0;
   end;
 end;
intr($33,nregs);
end;

{---------------------------------------------------------------------}

{
 Nome : pMoveMouse
 Descricao : procedimento que move o cursor do mouse para uma determinada
 posicao.
 Parametros :
 ntop - indica a posicao do topo.
 nesq - indica a posicao da esquerda.
}
procedure pMoveMouse(ntop,nesq:integer);
var
 nregs : registers;
begin
 ntop:=ntop-1;
 nesq:=nesq-1;
 with nregs do
  begin
    ax:=4;
    bx:=0;
    cx:=nesq*8;
    dx:=ntop*8;
    si:=0;
    di:=0;
    flags:=0;
  end;
intr($33,nregs);
end;

{---------------------------------------------------------------------}

{
 Nome : pLerMouse
 Descricao : funcao que le o status do mouse.
}
procedure pLerMouse;
var
 nregs : registers;
begin
 with nregs do
  begin
    ax:=3;
    bx:=0;
    cx:=0;
    dx:=0;
    si:=0;
    di:=0;
    flags:=0;
  end;
intr($33,nregs);
{ indica qual botao foi pressionado,
  0=nenhum, 1=direito, 2=esquerdo, 3=os dois }
nMouseBotao:=nregs.bx;
nMouseTop:=(nregs.dx div 8)+1;
nMouseEsq:=(nregs.cx div 8)+1;
end;

{---------------------------------------------------------------------}

{
 Nome : fbPressTecla
 Descricao : funcao que indica se a tecla foi pressionada.
}
function fbPressTecla:boolean;
var
 nregs : registers;
begin
nregs.ah:=$0B;
intr($21,nregs);
if nregs.al=0 then
   fbPressTecla:=false
else
   fbPressTecla:=true;
end;

begin
clrscr;
if fnIniMouse=0 then
 write('mouse nao instalado')
else
 begin
  pCursorMouse(liga);
  pMoveMouse(1,1);
 end;

repeat
 if fbPressTecla=true then
    nTecla:=fnTeclar
 else
    pLerMouse;

if fbPressMouse=true then
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
pCursorMouse(desliga);
end.
