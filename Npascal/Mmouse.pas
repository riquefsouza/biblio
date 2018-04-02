{ Modulo de Mouse }
unit mmouse;

interface

uses crt, dos;

type
  tModCurMouse = (desliga,liga);

var
  nMouseBotao,nMouseTop,nMouseEsq : integer;
  nMouseRodTop, nMouseRodEsq : integer;
  bMousePress : boolean;

{ Declaracao de funcoes de mmouse }

function fnIniMouse:integer;
function fbPressMouse:boolean;
function fbVrfMouse(ntop,nesq1,nesq2,nbot:integer):boolean;

{ Declaracao de Procedimentos de mmouse }

procedure pCursorMouse(ntip:tModCurMouse);
procedure pMoveMouse(ntop,nesq:integer); 
procedure pLerMouse; 

implementation

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
  0=nenhum, 1=esquerdo, 2=direito, 3=os dois }
if nregs.ax=0 then
   fbPressMouse:=false
else
   fbPressMouse:=true;
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
bMousePress:=false;
bMousePress:=fbPressMouse;
if bMousePress=true then
 delay(200);
end;

{---------------------------------------------------------------------}

{
 Nome : fbVrfMouse
 Descricao : funcao que verifica como e onde esta o mouse.
}
function fbVrfMouse(ntop,nesq1,nesq2,nbot:integer):boolean;
begin
 if (bMousePress=true) and (nMouseBotao=nbot) and (nMouseTop=ntop) and
    (nMouseEsq >=nesq1) and (nMouseEsq <=nesq2) then
    fbVrfMouse:=true
 else
    fbVrfMouse:=false;
end;

end.

{---------------------------------------------------------------------}

{
 Nome : pLerRodaMouse
 Descricao : funcao que le a taxa de rolamento do mouse.
}
procedure pLerRodaMouse;
var
 nregs : registers;
begin
 with nregs do
  begin
    ax:=0B;
    bx:=0;
    cx:=0;
    dx:=0;
    si:=0;
    di:=0;
    flags:=0;
  end;
intr($33,nregs);
nMouseRodTop:=(nregs.dx div 8)+1;
nMouseRodEsq:=(nregs.cx div 8)+1;
end;
