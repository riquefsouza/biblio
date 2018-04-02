unit URotinas;

interface

uses crt, dos;

{ Declaracao de tipos }

type

 ModoCursor = (nenhum,normal,solido);

 Keys = ( NullKey, F1, F2, F3, F4, F5, F6, F7, F8, F9, F10,
          CarriageReturn, Tab, ShiftTab, Bksp, UpArrow,
          DownArrow, RightArrow, LeftArrow, DeleteKey,
          InsertKey, HomeKey, Esc, EndKey, TextKey,
          NumberKey, SpaceKey, PgUp, PgDn, CtrlA, AltA,
          AltE, AltU, AltS, AltO);

 TRotinas = object

   { variaveis gerais }

   Key:Keys;

   { Declaracao de funcoes }

   function Zeros(s:string;tam:integer):String;
   function Repete(St:string;Tam:integer):String;
   function RetDataAtual:string;
   function ConverteData(dt:string):integer;
   function SomaDias(dt1:string;qtddias:integer):string;
   function SubtraiDatas(dt1:string;dt2:string):integer;

   { Declaracao de Procedimentos }

   procedure EscreveRapido(x,y:integer;
                        var S:String;fg,bg:Integer);
   procedure SetaCursor(tipo:ModoCursor);
   procedure center(y:integer;s:string;fg,bg:integer);
   procedure beep(freq,time:integer);
   procedure InKey(var chavefuncional:boolean;
                var ch:char;cursorinicio,cursorfim:char);
   procedure Etexto(c,l,fg,bg:integer;texto:string);
   procedure TeladeFundo(tipo:char;fg,bg:integer);
   procedure cabecalho(texto:string;tipo:char;fg,bg:integer);
   procedure rodape(texto:string;tipo:char;fg,bg:integer);
   procedure DatadoSistema(l,c,fg,bg:integer);
   procedure HoradoSistema(l,c,fg,bg:integer);
 end;

implementation

{ Rotinas Fundamentais }

{
 Nome : EscreveRapido
 Descricao : Procedimento que permite ter um controle do posicionamento
 do cursor, sem piscadas ou erros de repeticao de visualizacao.
 Parametros :
 x - posicao de coluna na tela
 y - posicao de linha na tela
 S - o resultado do que foi digitado
 fg - cor do texto
 bg - cor de fundo
}
procedure TRotinas.EscreveRapido(x,y:integer;var S:String;fg,bg:Integer);
begin
 textcolor(fg);
 textbackground(bg);
 gotoxy(x-1,y+1);
 write(S);

{
inline ($50/         (* PUSH AX       *)
        $53/         (* PUSH BX       *)
        $51/         (* PUSH CX       *)
        $52/         (* PUSH DX       *)
        $1E/         (* PUSH DS       *)
        $06/         (* PUSH ES       *)
        $57/         (* PUSH DI       *)
        $56/         (* PUSH SI       *)
        $8B/$5E/<x/  (* MOV  BX,x     *)
        $8B/$46/<y/  (* MOV  AX,y     *)
        $4B/         (* DEC  BX       *)
        $4B/         (* DEC  AX       *)
        $B9/$50/$00/ (* MOV  CX,0050  *)
        $F7/$E1/     (* MUL  CX       *)
        $03/$C3/     (* ADD  AX,BX    *)
        $B9/$02/$00/ (* MOV  CX,0002  *)
        $F7/$E1/     (* MUL  CX       *)
        $8B/$F8/     (* MUL  DI,AX    *)
        $8B/$5E/<bg/ (* MOV  BX,bg    *)
        $8B/$46/<fg/ (* MOV  AX,fg    *)
        $B9/$04/$00/ (* MOV  CX,0004  *)
        $D3/$E3/     (* SHL  BX,CL    *)
        $03/$D8/     (* ADD  BX,AX    *)
        $86/$DF/     (* XCHG BL,BH    *)
        $BA/$DA/$03/ (* MOV  DX,03DA  *)
        $B8/$00/$B8/ (* MOV  AX,B800  *)
        $8E/$C0/     (* MOV  ES,AX    *)
        $C5/$76/<s/  (* LDS  SI,s     *)
        $8A/$0C/     (* MOV  CL,[SI]  *)
        $80/$F9/$00/ (* CMP  CL,00    *)
        $74/$15/     (* JZ   2E06     *)
        $FC/         (* CLD           *)
        $46/         (* INC  SI       *)
        $8A/$1C/     (* MOV  BL,[SI]  *)
        $EC/         (* IN   AL,DX    *)
        $A8/$01/     (* TEST AL,01    *)
        $75/$FB/     (* JNZ  2DF5     *)
        $FA/         (* CLI           *)
        $EC/         (* IN   AL,DX    *)
        $A8/$01/     (* TEST AL,01    *)
        $74/$FB/     (* JZ   2DBF     *)
        $8B/$C3/     (* MOV  AX,BX    *)
        $AB/         (* STOSW         *)
        $FB/         (* STI           *)
        $E2/$EC/     (* LOOP 2DF2     *)
        $5E/         (* POP  SI       *)
        $5F/         (* POP  DI       *)
        $07/         (* POP  ES       *)
        $1F/         (* POP  DS       *)
        $5A/         (* POP  DX       *)
        $59/         (* POP  CX       *)
        $5B/         (* POP  BX       *)
        $58/         (* POP  AX       *)
        $E9/$00/$00/ (* JMP  2E11     *)
        $8B/$E5/     (* MOV  SP,BP    *)
        $5D/         (* POP  BP       *)
        $C2/$0E/$00);(* RET  000E     *)
        }
end;

{--------------------------------------------------------------------}

{
 Nome : SetaCursor
 Descricao : Procedimento que muda o modo do cursor na tela.
 Parametros :
 tipo - indica o tipo de cursor
}
Procedure TRotinas.SetaCursor(tipo:ModoCursor);
var
 Regs:Registers;
begin
if tipo=nenhum then 
 begin
  with regs do
   begin
    AH:=$01;
    CH:=$20;
    CL:=$20;
   end;
 end
else if tipo=normal then 
 begin
  with regs do
   begin
    AH:=$01;
    CH:=6;
    CL:=7;
   end;
 end
else if tipo=solido then
 begin
  with regs do
   begin
    AH:=$01;
    CH:=0;
    CL:=7;
   end;
 end;
intr($10,regs);
end;

{------------------------------------------------------------------}

{
 Nome : Beep
 Descricao : Procedimento que gera um beep.
 Parametros :
 freq - frequencia do beep.
 time - duracao do beep.
}
procedure TRotinas.beep(freq,time:integer);
begin
 sound(freq);
 delay(time);
 nosound;
end;

{-------------------------------------------}

{
 Nome : Inkey
 Descricao : Procedimento que identifica uma tecla do teclado.
 Parametros :
 chavefuncional - variavel que indica se e uma tecla funcional
 ch - indica o caracter pressionado
 cursorinicio - indica o estado do cursor inicial
 cursorfim - indica o estado do cursor final
}
procedure TRotinas.InKey(var chavefuncional:boolean;
                var ch:char;cursorinicio,cursorfim:char);
begin

 case cursorinicio of
  'B':setacursor(solido);
  'S':setacursor(normal);
  'O':setacursor(nenhum);
 end;

chavefuncional:=false;
ch:=readkey;
if (ch=#0) then
 begin
  chavefuncional:=true;
  ch:=readkey;
 end;

if chavefuncional then
   case ord(ch) of
    15: key := ShiftTab;
    18: key := AltE;
    22: key := AltU;
    24: key := AltO;
    30: key := AltA;
    31: key := AltS;
    72: key := UpArrow;
    80: key := DownArrow;
    75: key := LeftArrow;
    77: key := RightArrow;
    73: key := PgUp;
    81: key := PgDn;
    71: key := HomeKey;
    79: key := EndKey;
    83: key := DeleteKey;
    82: key := InsertKey;
    59: key := F1;
    60: key := F2;
    61: key := F3;
    62: key := F4;
    63: key := F5;
    64: key := F6;
    65: key := F7;
    66: key := F8;
    67: key := F9;
    68: key := F10;
   end
else
   Case Ord(ch) of
     1: Key := CtrlA;
     8: key := Bksp;
     9: key := Tab;
    13: key := CarriageReturn;
    27: key := Esc;
    32: key := SpaceKey;
    33..44, 47, 58..254: key := TextKey;
    45..46, 48..57: key := NumberKey;
   end;

   case cursorfim of
    'B':setacursor(solido);
    'S':setacursor(normal);
    'O':setacursor(nenhum);
   end;

end;

{-----------------------------------------------------------}

{
 Nome : Center
 Descricao : Procedimento que centraliza um texto na tela.
 Parametros :
 y - posicao de linha na tela
 s - texto a ser centralizado
 fg - cor do texto
 bg - cod de fundo
}
procedure TRotinas.center(y:integer;s:string;fg,bg:integer);
var
 x:integer;
begin
 x:=40-(length(s) div 2);
 etexto(x,y,fg,bg,s);
end;

{------------------------------------------}

{
 Nome : Repete
 Descricao : funcao que retorna um texto repetido n vezes.
 Parametros :
 St - indica o texto a ser repetido
 Tam - quantas vezes o texto se repetira
}
function TRotinas.Repete(St:string;Tam:integer):String;
var
 cont:integer;
 Esp:String;
begin
 cont:=1;
 Esp:='';
 while (cont <= Tam) do
  begin
    Esp:=Esp+St;
    cont:=cont+1;
  end;
  Repete:=Esp;
end;

{-------------------------------------------}

{
 Nome : Etexto
 Descricao : procedimento que escreve o texto na tela com determinada cor.
 Parametros :
 c - posicao de coluna do texto
 l - posicao de linha do texto
 fg - cor do texto
 bg - cor de fundo
 texto - o texto a ser escrito
}
procedure TRotinas.Etexto(c,l,fg,bg:integer;texto:string);
begin
 textcolor(fg);
 textbackground(bg);
 gotoxy(c,l);
 write(texto);
end;

{-------------------------------------------}

{
 Nome : Teladefundo
 Descricao : procedimento que desenha os caracteres do fundo da tela.
 Parametros :
 tipo - o caracter a ser escrito no fundo
 fg - cor do texto
 bg - cor de fundo
}
procedure TRotinas.TeladeFundo(tipo:char;fg,bg:integer);
var
 l,c:integer;
begin
for l:=3 to 24 do
  for c:=1 to 80 do
    Etexto(c,l,fg,bg,tipo);
end;

{-------------------------------------------}

{
 Nome : cabecalho
 Descricao : procedimento que escreve o texto de cabecalho do sistema.
 Parametros :
 texto - o texto a ser escrito
 tipo - o caracter de fundo.
 fg - cor do texto
 bg - cor de fundo
}
procedure TRotinas.cabecalho(texto:string;tipo:char;fg,bg:integer);
var
 c:integer;
begin
for c:=1 to 80 do
  Etexto(c,1,fg,bg,tipo);
center(1,texto,fg,bg);
end;

{-------------------------------------------}

{
 Nome : rodape
 Descricao : procedimento que escreve o texto no rodape da tela.
 Parametros :
 texto - o texto a ser escrito
 tipo - o caracter de fundo.
 fg - cor do texto
 bg - cor de fundo
}
procedure TRotinas.rodape(texto:string;tipo:char;fg,bg:integer);
var
 c:integer;
begin
for c:=1 to 79 do
  Etexto(c,25,fg,bg,tipo);
center(25,texto,fg,bg);
end;

{-------------------------------------------}

{
 Nome : DatadoSistema
 Descricao : procedimento que escreve a data do sistema na tela.
 Parametros :
 l - posicao da linha na tela
 c - posicao da coluna na tela
 fg - cor do texto
 bg - cor de fundo
}
procedure TRotinas.DatadoSistema(l,c,fg,bg:integer);
const
  dias : array [0..6] of String[9] = ('Domingo','Segunda','Terca',
     'Quarta','Quinta','Sexta','Sabado');
var
  y, m, d, dow : Word;
  dia,mes,ano:string;
begin
  GetDate(y,m,d,dow);
  str(d,dia);
  str(m,mes);
  str(y,ano);
  Etexto(c,l,fg,bg, dias[dow] + ', '+ zeros(dia,2) + '/'+
  zeros(mes,2) + '/'+ ano);
end;

{-------------------------------------------}

{
 Nome : HoradoSistema
 Descricao : procedimento que escreve a Hora do sistema na tela.
 Parametros :
 l - posicao da linha na tela
 c - posicao da coluna na tela
 fg - cor do texto
 bg - cor de fundo
}
procedure TRotinas.HoradoSistema(l,c,fg,bg:integer);
var
  h, m, s, ms : Word;
  hora,minuto,segundo : string;
begin
  GetTime(h,m,s,ms);
  str(h,hora);
  str(m,minuto);
  str(s,segundo);
  Etexto(c,l,fg,bg,Zeros(hora,2)+':'+Zeros(minuto,2)+':'+Zeros(segundo,2));
end;

{-------------------------------------------}

{
 Nome : Zeros
 Descricao : funcao que escreve zeros na frente de uma string.
 Parametros :
 s - a string a receber zeros a frente
 tam - o tamanho da string
}
function TRotinas.Zeros(s:string;tam:integer) : String;
var
 cont : integer;
 aux : string;
begin
  aux:='';
  if tam<>length(s) then
    begin
      for cont:=1 to tam-length(s) do
        aux:=aux + '0';
    end;
  zeros:=aux+s;
end;

{-------------------------------------------}

{
 Nome : RetDataAtual
 Descricao : funcao que retorna a data atual do sistema
}
function TRotinas.RetDataAtual:string;
var
  y, m, d, dow : Word;
  dia,mes,ano:string;
begin
  GetDate(y,m,d,dow);
  str(d,dia);
  str(m,mes);
  str(y,ano);
  RetDataAtual:=zeros(dia,2)+'/'+zeros(mes,2)+'/'+zeros(ano,4);
end;

{--------------------------------------------------------}

{
 Nome : ConverteData
 Descricao : funcao que converte a data em string para numero.
 Parametros :
 dt - data a ser convertida
}
function TRotinas.ConverteData(dt:string):integer;
var
  sAux:string;
  nAux:integer;
  C:integer;
begin
 sAux:=copy(dt,7,4)+copy(dt,4,2)+copy(dt,1,2);
 Val(sAux,nAux,C);
 ConverteData:=nAux;
end;

{--------------------------------------------------------}

{
 Nome : SubtraiDatas
 Descricao : funcao que subtrai duas datas e retorna o numero de dias
 Parametros :
 dt1 - data inicial
 dt2 - data final
}
function TRotinas.SubtraiDatas(dt1:string;dt2:string):integer;
var
 dia,mes,ano,dia1,mes1,ano1,dia2,mes2,ano2:integer;
 i,c,dias:integer;
 udiames:array[1..12] of integer;
begin
 dias:=0;
 udiames[1]:=31;
 udiames[2]:=28;
 udiames[3]:=31;
 udiames[4]:=30;
 udiames[5]:=31;
 udiames[6]:=30;
 udiames[7]:=31;
 udiames[8]:=31;
 udiames[9]:=30;
 udiames[10]:=31;
 udiames[11]:=30;
 udiames[12]:=31;

 val(copy(dt1,1,2),i,c);
 dia1:=i;
 val(copy(dt1,4,2),i,c);
 mes1:=i;
 val(copy(dt1,7,4),i,c);
 ano1:=i;

 val(copy(dt2,1,2),i,c);
 dia2:=i;
 val(copy(dt2,4,2),i,c);
 mes2:=i;
 val(copy(dt2,7,4),i,c);
 ano2:=i;

 for ano:=ano1 to ano2 do
  begin
    for mes:=mes1 to 12 do
     begin
       { ano bissexto }
       if (ano mod 4)=0 then
         udiames[2]:=29;
       { data final }
       if (ano=ano2) and (mes=mes2) then
         udiames[mes2]:=dia2;
       for dia:=dia1 to udiames[mes] do
          dias:=dias+1;
       if (ano=ano2) and (mes=mes2) then
         begin
           SubtraiDatas:=dias-1;
           exit;
         end;
       dia1:=1;
     end;
    mes1:=1;
  end;
  
end;

{--------------------------------------------------------}

{
 Nome : SomaDias
 Descricao : funcao que soma um determinado numero de dias a uma data.
 Parametros :
 dt1 - a data a ser somada
 qtddias - numero de dias a serem somados
}
function TRotinas.SomaDias(dt1:string;qtddias:integer):string;
var
 dia,mes,ano,dia1,mes1,ano1,ano2:integer;
 i,c,dias:integer;
 sAux,sAux2:string;
 udiames:array[1..12] of integer;
begin
 dias:=0;
 udiames[1]:=31;
 udiames[2]:=28;
 udiames[3]:=31;
 udiames[4]:=30;
 udiames[5]:=31;
 udiames[6]:=30;
 udiames[7]:=31;
 udiames[8]:=31;
 udiames[9]:=30;
 udiames[10]:=31;
 udiames[11]:=30;
 udiames[12]:=31;

 val(copy(dt1,1,2),i,c);
 dia1:=i;
 val(copy(dt1,4,2),i,c);
 mes1:=i;
 val(copy(dt1,7,4),i,c);
 ano1:=i;

 ano2:=ano1 + (qtddias div 365);

 for ano:=ano1 to ano2 do
  begin
    for mes:=mes1 to 12 do
     begin
       { ano bissexto }
       if (ano mod 4)=0 then
         udiames[2]:=29;
       for dia:=dia1 to udiames[mes] do
          begin
            dias:=dias+1;
            if dias=qtddias+1 then
              begin
                str(dia,sAux);
                sAux2:=zeros(sAux,2)+'/';
                str(mes,sAux);
                sAux2:=sAux2+zeros(sAux,2)+'/';
                str(ano,sAux);
                sAux2:=sAux2+zeros(sAux,4);
                SomaDias:=sAux2;
                exit;
            end;
          end;
       dia1:=1;
     end;
    mes1:=1;
  end;

end;

{--------------------------------------------------------}

end.
